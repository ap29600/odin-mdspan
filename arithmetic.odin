package mdspan

import "core:mem"
import "core:fmt"
import "core:intrinsics"
import "core:simd"
import "core:time"

@(private="file") loadu  :: intrinsics.unaligned_load
@(private="file") storeu :: intrinsics.unaligned_store

reduce_add_rank_1 :: proc (span: $S/Span($E, 1)) -> (result: E) #no_bounds_check {
	_reduce_add_trailing(&result, span.ravel, 1, span.shape[0])
	return
}

reduce_add_rank_2 :: proc (span: $S/Span($E, 2), axis := 0, allocator := context.allocator) -> (result: Span(E, 1)) #no_bounds_check {
	axis := axis %% 2
	result.shape[0] = span.shape[1 - axis];

	if (span.shape[0] * span.shape[1] > 0) {
		result.ravel = raw_data(make([]E, span.shape[1 - axis], allocator))
		switch axis {
		case 0: _reduce_add_middle(result.ravel, span.ravel, 1, span.shape[0], span.shape[1])
		case 1: _reduce_add_trailing(result.ravel, span.ravel, span.shape[0], span.shape[1])
		}
	}
	
	return
}

reduce_add_rank_3 :: proc (span: $S/Span($E, 3), axis := 0, allocator := context.allocator) -> (result: Span(E, 2)) #no_bounds_check {
	axis := axis %% 3
	switch axis {
	case 0: result.shape = span.shape.yz
	case 1: result.shape = span.shape.xz
	case 2: result.shape = span.shape.xy
	}
	
	if size := result.shape[0] * result.shape[1]; size > 0 {
		result.ravel = raw_data(make([]E, size, allocator))
		switch axis {
		case 0: _reduce_add_middle  (result.ravel, span.ravel, 1,             span.shape[0], size)
		case 1: _reduce_add_middle  (result.ravel, span.ravel, span.shape[0], span.shape[1], span.shape[2])
		case 2: _reduce_add_trailing(result.ravel, span.ravel, size,          result.shape[2])
		}
	}

	return
}

reduce_add :: proc {reduce_add_rank_1, reduce_add_rank_2}

@private
@(optimization_mode = "size")
_reduce_add_trailing :: proc "contextless" (dest: [^]$E, source: [^]E, leading: int, trailing: int) #no_bounds_check {
	Vector_Bytes :: 32
	Step :: Vector_Bytes / size_of(E)
	Block :: #simd[Step]E

	#assert(Vector_Bytes % size_of(E) == 0)

	columns := trailing / Step
	discard := trailing % Step

	for i in 0 ..< leading {
		row_source := source[trailing * i:]
		for j in 0 ..< discard {
			dest[i] += row_source[j]
		}
		acc := Block{}
		for j in 0 ..< columns {
			s := (^Block)(row_source[discard + j * Step:])
			acc += loadu(s)
		}
		dest[i] += simd.reduce_add_ordered(acc)
	}
}

@private
@(optimization_mode="size")
_reduce_add_middle :: proc "contextless" (dest: [^]$E, source: [^]E, leading: int, middle, trailing: int) #no_bounds_check {
	Vector_Bytes :: 32
	Block :: #simd[Step]E
	Step  :: Vector_Bytes / size_of(E)

	#assert(Vector_Bytes % size_of(E) == 0)

	columns := trailing / Step
	discard := trailing % Step

	for i in 0 ..< leading {
		plane_dest := dest[i * trailing:]
		for j in 0 ..< middle {
			row_source := source[i * middle * trailing + j:]
			for k in 0 ..< discard {
				plane_dest[k] += row_source[k]
			}
			for k in 0 ..< columns {
				d := (^Block)(plane_dest[discard + Step * k:])
				s := (^Block)(row_source[discard + Step * k:])
				storeu(d, loadu(d) + loadu(s))
			}
		}
	}
}
