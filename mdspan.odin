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
	ptr_copy_non_overlapping(result.ravel, span.ravel, size)
	return
}

reshape_in_place :: proc(span: ^$S/Span($E,$R), shape: [$L]int) -> (result: Span(E, L), ok: bool) #optional_ok {
	elems := to_slice(span^)
	// handle fill dimension
	result.shape = shape
	for it, i in &result.shape {
		if it < 0 {
			it = len(elems)
			for dim, j in &result.shape do if j != i {
				if dim <= 0 || it % dim != 0 { return {}, false }
				it /= dim
			}
			break
		}
	}

	old_size := len(elems) * size_of(E)
	new_size := size_of(E)
	for dim in result.shape { new_size *= dim }

	if new_size > old_size { return {}, false }
	result.ravel = span.ravel
	return result, true
}

reshape_out_of_place :: proc (span: $S/Span($E,$R), shape: [$L]int, allocator := context.allocator) -> (result: Span(E,L), ok: bool) #optional_ok {
	elems := to_slice(span)
	// handle fill dimension
	result.shape = shape
	for it, i in &result.shape {
		if it < 0 {
			it = len(elems)
			for dim, j in &result.shape do if j != i {
				if dim <= 0 || it % dim != 0 { return {}, false }
				it /= dim
			}
			break
		}
	}

	old_size := len(elems) * size_of(E)
	new_size := size_of(E)
	for dim in result.shape { new_size *= dim }
	result.ravel = cast([^]E)mem.alloc(size = new_size, allocator = allocator)
	if result.ravel == nil { return {}, false }

	// if there are no elements to copy, leave the array zeroed out
	if old_size == 0 { return result, true }

	ptr_copy_non_overlapping(result.ravel, raw_data(elems), min(old_size, new_size))
	copied := min(old_size, new_size)
	dst := cast([^]u8)result.ravel
	for copied < new_size {
		copy_size := min(copied, new_size - copied)
		ptr_copy_non_overlapping(dst[copied:], dst, copy_size)
		copied += copy_size
	}
	return result, true
}

reshape :: proc { reshape_in_place, reshape_out_of_place }
