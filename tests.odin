//+private=file
package mdspan

import test "core:testing"
import "core:math/rand"
import "core:slice"
import "core:fmt"

@test
scalar_construction :: proc (t: ^test.T) {
	foo := 10
	s := scalar(&foo)
	test.expect_value(t, typeid_of(type_of(s)), typeid_of(Span(int, 0)))
	test.expect_value(t, s.ravel, &foo)
}

@test
array_construction :: proc (t: ^test.T) {
	foos := []int{1, 2, 3, 4, 5}
	s := array(foos)
	test.expect_value(t, typeid_of(type_of(s)), typeid_of(Span(int, 1)))
	test.expect_value(t, s.shape, [1]int{5})
	test.expect_value(t, s.ravel, raw_data(foos))
}

@test
create_span_from_slice_exact :: proc(t: ^test.T) {
	data := [30]int{}
	s := from_slice(data[:], [?]int{2, 3, 5})
	test.expect_value(t, s.ravel, raw_data(data[:]))
	test.expect_value(t, s.shape, [3]int{2, 3, 5})
}

@test
create_span_from_slice_with_fill :: proc(t: ^test.T) {
	data := [30]int{}
	s := from_slice(data[:], [?]int{2, -1, 5})
	test.expect_value(t, s.ravel, raw_data(data[:]))
	test.expect_value(t, s.shape, [3]int{2, 3, 5})
}

@test
to_slice_is_inverse_of_from_slice :: proc(t: ^test.T) {
	data := [30]int{}
	s := from_slice(data[:], [?]int{2, -1, 5})
	recovered := to_slice(s)
	test.expect_value(t, raw_data(recovered), raw_data(data[:]))
	test.expect_value(t, len(recovered), len(data[:]))
}

@test
out_of_place_transposition_works :: proc (t: ^test.T) {
	data := [4 * 5 * 7]int{}
	for it, i in &data {it = i}
	s := from_slice(data[:], [?]int{4, 5, 7})

	// axis reversal
	f := transpose(s, context.temp_allocator)
	for i in 0 ..< 4 do for j in 0 ..< 5 do for k in 0 ..< 7 {
		idx := [?]int{i, j, k}
		test.expect(
			t,
			index(s, idx)^ == index(f, idx.zyx)^,
		)
	}

	// a custom permutation
	gperm := [?]int{0, 2, 1}
	g := transpose(s, gperm, context.temp_allocator)
	for i in 0 ..< 4 do for j in 0 ..< 5 do for k in 0 ..< 7 {
		idx := [?]int{i, j, k}
		test.expect(
			t,
			index(s, idx)^ == index(
				g,
				[?]int{idx[gperm[0]], idx[gperm[1]], idx[gperm[2]]},
			)^,
		)
	}
}

@test
matrix_product_identity_is_neutral :: proc(t: ^test.T) {
	id_data := [3*3]int{1, 0, 0, 0, 1, 0, 0, 0, 1}
	id := from_slice(id_data[:], [?]int{3, 3})

	{
		r_data := [3*400]int{}
		for it in &r_data { it = rand.int_max(1000) }
		r := from_slice(r_data[:], [?]int{3, -1})
		s := to_slice(matrix_matrix_product(id, r, context.temp_allocator))
		for i in 0 ..< len(s) {
			test.expect_value(t, s[i], r_data[i])
		}
	}

	{
		r_data := [3]int{}
		for it in &r_data { it = rand.int_max(1000) }
		r := from_slice(r_data[:], [?]int{3})
		s := to_slice(matrix_vector_product(id, r, context.temp_allocator))
		for i in 0 ..< len(s) {
			test.expect_value(t, s[i], r_data[i])
		}
	}

	{
		r_data := [3]int{}
		for it in &r_data { it = rand.int_max(1000) }
		r := from_slice(r_data[:], [?]int{3})
		s := to_slice(vector_matrix_product(r, id, context.temp_allocator))
		for i in 0 ..< len(s) {
			test.expect_value(t, s[i], r_data[i])
		}
	}
}

@test
rotations_are_permutations :: proc (t: ^test.T) {
	data := [4 * 7 * 10]int{}
	for it, i in &data { it = i }
	s := from_slice(data[:], [?]int{4, 7, 10})
	rotate(&s, array([]int{1, 2, 3, 4, 5, 6, 7}), 0)
	// test that all elements are still present
	for i in 0 ..< 4 * 7 * 10 {
		_, ok := slice.linear_search(data[:], i)
		test.expect(t, ok)
	}
}

@test
rotate_with_bias :: proc (t: ^test.T) {
	initial_ravel := []int{
		0, 1,
		2, 3,
	// ------
		4, 5,
		6, 7,
	}
	s := from_slice(initial_ravel, [?]int{2, 2, 2})

	{
		// rotates cells (axis = 1), the leading axis of `shifts` is matched to the
		// second free axis (which is the third axis) of `span` (bias = 1)
		f, ok := rotate(span = s, shifts = array([]int{0, 1}), axis = 1, bias = 1)
		test.expect(t, ok)
		defer destroy(f)
		elems := to_slice(f)
		expected_ravel := []int{
			0, 3,
			2, 1,
		// ------
			4, 7,
			6, 5,
		}
		for it, i in elems {
			test.expect_value(t, it, expected_ravel[i])
		}
	}

	{
		// rotates rows (axis = 2), the leading axis of `shifts` is matched to the
		// second free axis (which is the second axis) of `span` (bias = 1)
		f, ok := rotate(span = s, shifts = array([]int{0, 1}), axis = 2, bias = 1)
		test.expect(t, ok)
		defer destroy(f)
		elems := to_slice(f)
		expected_ravel := []int{
			0, 1,
			3, 2,
		// ------
			4, 5,
			7, 6,
		}
		for it, i in elems {
			test.expect_value(t, it, expected_ravel[i])
		}
	}

	{
		// rotates cubes (axis = 0), the leading axis of `shifts` is matched to the
		// first free axis (which is the second axis) of `span` (bias = 0)
		f, ok := rotate(span = s, shifts = array([]int{0, 1}), axis = 0, bias = 0)
		defer destroy(f)
		test.expect(t, ok)
		elems := to_slice(f)
		expected_ravel := []int{
			0, 1,
			6, 7,
		// ------
			4, 5,
			2, 3,
		}
		for it, i in elems {
			test.expect_value(t, it, expected_ravel[i])
		}
	}
}

@test
transpositions_are_permutations :: proc (t: ^test.T) {
	data := [4 * 7 * 10]int{}
	for it, i in &data { it = i }
	s := from_slice(data[:], [?]int{4, 7, 10})
	transpose(&s, [?]int{1, 2, 0})
	// test that all elements are still present
	for i in 0 ..< 4 * 7 * 10 {
		_, ok := slice.linear_search(data[:], i)
		test.expect(t, ok)
	}
}

@test
basic_reshape_functionality :: proc (t: ^test.T) {
	data := [5 * 14] int {}
	for it, i in &data { it = i }
	s := from_slice(data[:], [?]int{5, 14})

	{
		f, ok := reshape(s, [?]int{5, 2, -1}, context.temp_allocator)
		test.expect(t, ok, "out of place reshape should succeed with compatible fill dimension")
		test.expect(t, f.ravel != s.ravel, "out of place reshape makes a new allocation")
		for it, i in to_slice(f) {
			test.expect(t, it == i, "elements should match")
		}
	}

	{
		f, ok := reshape(s, [?]int{5, 3, -1}, context.temp_allocator)
		test.expect(t, !ok, "out of place reshape should fail with incompatible fill dimension")
	}

	{
		f, ok := reshape(s, [?]int{3, 7, 6}, context.temp_allocator)
		test.expect(t, ok, "out of place reshape should always succeed with fixed shape")
		test.expect(t, f.ravel != s.ravel, "out of place reshape makes a new allocation")
		for it, i in to_slice(f) {
			test.expect(t, it == i % (5 * 14), "elements should repeat")
		}
	}

	{
		f, ok := reshape(&s, [?]int{5, 2, -1})
		test.expect(t, ok, "in place reshape should succeed with compatible fill dimension")
		test.expect(t, f.ravel == s.ravel, "in place reshape shares the allocation")
		for it, i in to_slice(f) {
			test.expect(t, it == i, "elements should match")
		}
	}

	{
		f, ok := reshape(&s, [?]int{3, 7, 6})
		test.expect(t, !ok, "in place reshape should fail with larger shape")
	}

	{
		f, ok := reshape(&s, [?]int{3, 7, 3})
		test.expect(t, ok, "in place reshape should succeed with smaller shape")
		test.expect(t, f.ravel == s.ravel, "in place reshape shares the allocation")
		for it, i in to_slice(f) {
			test.expect(t, it == i, "elements should match")
		}
	}

	{
		empty, ok1 := reshape(&s, [?]int{0, 0})
		test.expect(t, ok1, "can reshape into empty array")
		f, ok2 := reshape(empty, [?]int {5, 4}, context.temp_allocator)
		test.expect(t, ok2, "can reshape from empty array")
		for it, i in to_slice(f) {
			test.expect(t, it == 0, "elements are zero-initialized if no prototype is available")
		}
	}
}
