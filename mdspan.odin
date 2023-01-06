package mdspan

import "core:mem"
import "core:os"

/*
	A R-dimensional array of elements of type E.
	Note that:
	 - `MDSpan(E, 0)` may be transmuted to and from `^E`
	 - `MDSpan(E, 1)` may be transmuted to and from `[]E`
*/
Span :: struct ($E: typeid, $R: int) {
	ravel: [^]E,
	shape: [R]int,
}

scalar :: proc(value: $P/^$E) -> Span(E,0) {
	return transmute(Span(E,0))value
}

array :: proc(values: $P/[]$E) -> Span(E,1) {
	return transmute(Span(E,1))values
}

delete :: proc (span: $S/Span($E,$R), allocator := context.allocator) {
	mem.free(span.ravel, allocator)
}

clone :: proc ( span: $S/Span($E,$R), allocator := context.allocator,) -> (result: Span(E, R)) {
	size := size_of(E); for i in span.shape { size *= i }
	result.ravel = cast([^]E)mem.alloc(size = size, allocator = allocator)
	result.shape = span.shape
	mem.copy_non_overlapping(result.ravel, span.ravel, size)
	return
}

index :: proc (span: $S/Span($E,$R), index: [R]int) -> (elem: ^E,  ok: bool) {
	when R == 0 {
		return span.ravel, true
	} else {
		flat_index := 0
		stride := 1
		for i in 1 ..= R {
			if index[R - i] < 0 || index[R - i] >= span.shape[R - i] {
				return nil, false
			}
			flat_index += stride * index[R - i]
			stride *= span.shape[R - i]
		}
		return span.ravel[flat_index:], true
	}
}

reshape :: proc (span: $S/Span($E,$R), shape: [$L]int, allocator := context.allocator) -> Span(E,L) {
	old_size := 1; when R > 0 { for i in 0 ..< R {old_size *= span.shape[i]} }
	new_size := 1; when L > 0 { for i in 0 ..< L {new_size *= shape[i]} }
	assert(old_size > 0)

	result := Span(E,L){
		auto_cast mem.alloc(size = new_size * size_of(E), allocator = allocator),
		shape,
	}
	mem.copy_non_overlapping(result.ravel, span.ravel, min(old_size, new_size) * size_of(E))

	for old_size < new_size {
		mem.copy_non_overlapping(
			result.ravel[old_size:],
			result.ravel[:],
			min(old_size, new_size - old_size) * size_of(E),
		)
		old_size += min(old_size, new_size - old_size)
	}
	return result
}

ravel_view :: proc (span: $S/Span($E,$R)) -> []E {
	size := 1; for i in 0 ..< R {size *= span.shape[i]}
	return span.ravel[:size]
}
