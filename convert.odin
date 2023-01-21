package mdspan

import test "core:testing"

scalar :: proc(value: $P/^$E) -> Span(E,0) {
	return transmute(Span(E,0)) value
}

@private
@test
test_scalar_construction :: proc (t: ^test.T) {
	foo := 10
	s := scalar(&foo)
	test.expect_value(t, typeid_of(type_of(s)), typeid_of(Span(int, 0)))
	test.expect_value(t, s.ravel, &foo)
}

array :: proc(values: $P/[]$E) -> Span(E,1) {
	return transmute(Span(E,1)) values
}

@private
@test
test_array_construction :: proc (t: ^test.T) {
	foos := []int{1, 2, 3, 4, 5}
	s := array(foos)
	test.expect_value(t, typeid_of(type_of(s)), typeid_of(Span(int, 1)))
	test.expect_value(t, s.shape, [1]int{5})
	test.expect_value(t, s.ravel, raw_data(foos))
}

from_slice :: proc(data: $P/[]$E, shape: [$R]int) -> (result: Span(E,R), ok: bool) where R > 0 #optional_ok {
	shape := shape

	found_fill := false
	fill_position := 0
	for i in 0 ..< R {
		if shape[i] < 0 {
			if found_fill { return }
			found_fill = true
			fill_position = i
		}
	}

	if found_fill {
		shape[fill_position] = len(data)
		for i in 0 ..< R {
			if i != fill_position {
				if shape[fill_position] % shape[i] != 0 { return }
				shape[fill_position] /= shape[i]
			}
		}
	} else {
		size := 1
		for i in 0 ..<R { size *= shape[i] }
		if size != len(data) { return }
	}

	result = { raw_data(data), shape }
	return
}

@private
@test
test_create_span_from_slice_exact :: proc(t: ^test.T) {
	data := [30]int{}
	s := from_slice(data[:], [?]int{2, 3, 5})
	test.expect_value(t, s.ravel, raw_data(data[:]))
	test.expect_value(t, s.shape, [3]int{2, 3, 5})
}

@private
@test
test_create_span_from_slice_with_fill :: proc(t: ^test.T) {
	data := [30]int{}
	s := from_slice(data[:], [?]int{2, -1, 5})
	test.expect_value(t, s.ravel, raw_data(data[:]))
	test.expect_value(t, s.shape, [3]int{2, 3, 5})
}

to_slice :: proc (span: $S/Span($E,$R)) -> []E {
	size := 1; for i in 0 ..< R { size *= span.shape[i] }
	return span.ravel[:size]
}

@private
@test
test_to_slice_is_inverse_of_from_slice :: proc(t: ^test.T) {
	data := [30]int{}
	s := from_slice(data[:], [?]int{2, -1, 5})
	recovered := to_slice(s)
	test.expect_value(t, raw_data(recovered), raw_data(data[:]))
	test.expect_value(t, len(recovered), len(data[:]))
}
