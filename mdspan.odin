package mdspan

import "core:fmt"
import "core:mem"
import "core:os"
import "core:slice"

Span :: struct ($E: typeid, $R: int) {
	ravel: [^]E,
	shape: [R]int,
}

create :: proc ($E: typeid, shape: [$R]int, allocator := context.allocator) -> (result: Span(E, R)) {
	size := size_of(E)
	for d in shape { size *= d }
	result.shape = shape
	result.ravel = cast([^]E)mem.alloc(size = size, allocator = allocator)
	return
}

destroy :: proc (span: $S/Span($E,$R), allocator := context.allocator) {
	mem.free(span.ravel, allocator)
}

clone :: proc ( span: $S/Span($E,$R), allocator := context.allocator,) -> (result: Span(E, R)) {
	size := size_of(E); for i in span.shape { size *= i }
	result.ravel = cast([^]E)mem.alloc(size = size, allocator = allocator)
	result.shape = span.shape
	mem.copy_non_overlapping(result.ravel, span.ravel, size)
	return
}

index :: proc (span: $S/Span($E,$R), idx: [R]int) -> ^E {
	when R == 0 {
		return span.ravel, true
	} else {
		flat_index := 0
		stride := 1
		
		when R > 0 {
			when ODIN_DEBUG {
				for i in 0 ..< R {
					if idx[i] < 0 || idx[i] > span.shape[i] {
						os.exit(1);
					}
				}
			}

			for i in 1 ..= R {
				flat_index += stride * idx[R - i]
				stride *= span.shape[R - i]
			}
		}

		return span.ravel[flat_index:]
	}
}

reshape :: proc (span: $S/Span($E,$R), shape: [$L]int, allocator := context.allocator) -> Span(E,L) {
	old_size := 1; when R > 0 { for i in 0 ..< R {old_size *= span.shape[i]} }
	new_size := 1; when L > 0 { for i in 0 ..< L {new_size *= shape[i]} }
	assert(old_size > 0)

	result := Span(E,L){
		cast([^]E) mem.alloc(size = new_size * size_of(E), allocator = allocator),
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
