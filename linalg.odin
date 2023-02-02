package mdspan

import "core:mem"

matrix_product :: proc {vector_matrix_product, matrix_vector_product, matrix_matrix_product }

// TODO: implement the asymptotically faster algorithm
matrix_matrix_product :: proc(s: Span($E, 2), g: Span(E, 2), allocator := context.allocator) -> (result: Span(E, 2)) {
	assert(s.shape[1] == g.shape[0])

	result.shape = {s.shape[0], g.shape[1]}
	result.ravel = cast([^]E)mem.alloc(
		size = s.shape[0] * g.shape[1] * size_of(E),
		allocator = allocator,
	)

	for i in 0 ..< s.shape[0] {
		for j in 0 ..< g.shape[1] {
			for k in 0 ..< s.shape[1] {
				result.ravel[ i * result.shape[1] + j] +=
					s.ravel[i * s.shape[1] + k] * g.ravel[k * g.shape[1] + j]
			}
		}
	}
	return
}

vector_matrix_product :: proc(s: Span($E, 1), g: Span(E, 2), allocator := context.allocator) -> (result: Span(E, 1)) {
	s := Span(E,2){ravel = s.ravel, shape = {1, s.shape[0]}}
	m := matrix_matrix_product(s, g, allocator)
	result = {ravel = m.ravel, shape = {m.shape[1]}}
	return
}

matrix_vector_product :: proc(s: Span($E, 2), g: Span(E, 1), allocator := context.allocator) -> (result: Span(E, 1)) {
	g := Span(E,2){ravel = g.ravel, shape = {g.shape[0], 1}}
	m := matrix_matrix_product(s, g, allocator)
	result = {ravel = m.ravel, shape = {m.shape[0]}}
	return
}
