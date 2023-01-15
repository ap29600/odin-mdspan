package mdspan

import "core:mem"

unary_proc_alloc :: proc (
	span: $S/Span($E,$R),
	op: proc(E)->$F,
	allocator := context.allocator,
) -> (result: Span(F,R)) {
		view := ravel_view(span)
		result.ravel = cast([^]F)mem.alloc(size_of(F)*len(view))
		result.shape = span.shape
		for it, i in view { result.ravel[i] = op(it) }
		return
	}

unary_proc_inplace :: proc (span: $S/^Span($E,$R), op: proc(E)->E) {
	view := ravel_view(span^)
	for it in &view { it = op(it) }
}

unary_proc :: proc {unary_proc_inplace, unary_proc_alloc}
