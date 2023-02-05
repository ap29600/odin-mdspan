package mdspan

import "core:mem"

unary_proc_out_of_place :: proc (span: $S/Span($E,$R), op: proc(E)->$F, allocator := context.allocator) -> (result: Span(F,R)) {
	view := ravel_view(span)
	result.ravel = cast([^]F)mem.alloc(size_of(F)*len(view))
	result.shape = span.shape
	for it, i in view { result.ravel[i] = op(it) }
	return
}

unary_proc_in_place :: proc (span: $S/^Span($E,$R), op: proc(E)->E) {
	view := ravel_view(span^)
	for it in &view { it = op(it) }
}

unary_proc :: proc {unary_proc_in_place, unary_proc_out_of_place}

binary_proc_norank :: proc ($L, $R: int, left: $S/Span($E,L), right: $T/Span($F,R), op: proc(a: E, b: F) -> $G, allocator := context.temp_allocator) -> (result: Span(G, max(R,L))) {
	// TODO: validate shape compatibility
	vleft, vright := ravel_view(left), ravel_view(right)
	when R < L {
		result.ravel = mem.alloc(size = sizeof(G)*len(vleft), allocator = allocator)
		result.shape = left.shape
		for i in 0 ..< len(vleft) / len(vright) {
			for j in 0 ..< len(vright) {
				result.ravel[i*len(vright)+j] = op(vleft[i*len(vright)+j], vright[i])
			}
		}
	} else when L < R {
		result.ravel = mem.alloc(size = sizeof(G)*len(vright), allocator = allocator)
		result.shape = right.shape
		for i in 0 ..< len(vright) / len(vleft) {
			for j in 0 ..< len(vleft) {
				result.ravel[i*len(vleft)+j] = op(vleft[i], vright[i*len(vleft)+j])
			}
		}
	} else {
		result.ravel = mem.alloc(size = sizeof(G)*len(vright), allocator = allocator)
		result.shape = right.shape
		for i in 0 ..< len(vleft) { result.ravel[i] = op(vleft[i], vright[i]) }
	}
	return
}

binary_proc :: proc {binary_proc_norank}

add :: proc ($L, $R: int, left: $S/Span($E,L), right: $T/Span(E,R), allocator := context.temp_allocator) -> (result: Span(E,max(L,R))) {
	return binary_proc_norank(
		L, R,
		left, right,
		proc(a, b: E) -> E {return a + b},
		allocator,
	)
}
