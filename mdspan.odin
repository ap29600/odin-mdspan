package mdspan

import "core:fmt"
import "core:mem"
import "core:os"
import "core:slice"

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

from_slice :: proc(data: $P/[]$E, shape: [$R]int) -> (result: Span(E,R)) {
	shape := shape

	// look for a fill dimension
	p := 0
	ok := false
	for i in 0 ..< R {
		if shape[i] < 0 {
			if ok {
				fmt.println("multiple fill elements in shape")
				os.exit(1)
			}
			ok = true
			p = i
		}
	}

	if ok {
		shape[p] = len(data)
		for i in 0 ..< R {
			if i != p {
				// TODO: error handling
				if shape[p] % shape[i] != 0 {
					fmt.println("shape is not compatible with length")
					os.exit(1)
				}
				shape[p] /= shape[i]
			}
		}
	} else {
		size := 1
		for i in 0 ..<R { size *= shape[i] }
		if size != len(data) {
			fmt.println("shape is not compatible with length")
			os.exit(1)
		}
	}

	result.ravel = raw_data(data)
	result.shape = shape
	return
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
