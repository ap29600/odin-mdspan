//+private=file
package mdspan

import test "core:testing"
import "core:math/rand"

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
