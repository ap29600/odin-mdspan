package mdspan

import "core:mem"
import "core:runtime"
import "core:intrinsics"
import "core:simd"


reduce_add_rank_1 :: proc (span: $S/Span($E, 1)) -> (result: E) {
	_reduce_add_trailing_with_cast(&result, span.ravel, 1, span.shape[0])
	return
}

reduce_add_rank_2 :: proc (span: $S/Span($E, 2), axis := 0, allocator := context.allocator) -> (result: Span(E, 1)) {
	reduce_add_dispatch(2, &result, span, axis, allocator)
	return
}

reduce_add_rank_3 :: proc (span: $S/Span($E, 3), axis := 0, allocator := context.allocator) -> (result: Span(E, 2)) {
	reduce_add_dispatch(3, &result, span, axis, allocator)
	return
}

reduce_add_rank_4 :: proc (span: $S/Span($E, 4), axis := 0, allocator := context.allocator) -> (result: Span(E, 3)) {
	reduce_add_dispatch(4, &result, span, axis, allocator)
	return
}

reduce_add_poly :: proc ($RANK: int, span: $S/Span($E, RANK), axis := 0, allocator := context.allocator) -> (result: Span(E, RANK-1)) {
	reduce_add_dispatch(4, &result, span, axis, allocator)
	return
}

reduce_add_rank_1_with_cast :: proc (span: $S/Span($E, 1), $T: typeid) -> (result: T) {
	_reduce_add_trailing_with_cast(&result, span.ravel, 1, span.shape[0])
	return
}

reduce_add_rank_2_with_cast :: proc (span: $S/Span($E, 2), $T: typeid, axis := 0, allocator := context.allocator) -> (result: Span(T, 1)) {
	reduce_add_dispatch(2, &result, span, axis, allocator)
	return
}

reduce_add_rank_3_with_cast :: proc (span: $S/Span($E, 3), $T: typeid, axis := 0, allocator := context.allocator) -> (result: Span(T, 2)) {
	reduce_add_dispatch(3, &result, span, axis, allocator)
	return
}

reduce_add_rank_4_with_cast :: proc (span: $S/Span($E, 4), $T: typeid, axis := 0, allocator := context.allocator) -> (result: Span(T, 3)) {
	reduce_add_dispatch(4, &result, span, axis, allocator)
	return
}

reduce_add_poly_with_cast :: proc ($RANK: int, span: $S/Span($E, RANK), $T: typeid, axis := 0, allocator := context.allocator) -> (result: Span(T, RANK-1)) {
	reduce_add_dispatch(4, &result, span, axis, allocator)
	return
}

@(private="file")
reduce_add_dispatch :: #force_inline proc (
	$Rank:     int,
	dest:      ^Span($T,Rank-1),
	source:    Span($E, Rank),
	axis:      int,
	allocator: mem.Allocator,
) #no_bounds_check {
	axis := axis %% Rank

	leading  := 1
	for i in 0 ..< axis {
		leading *= source.shape[i]
		dest.shape[i] = source.shape[i]
	}
	reducing := source.shape[axis]
	trailing := 1
	for i in axis+1 ..< Rank {
		trailing *= source.shape[i]
		dest.shape[i-1] = source.shape[i]
	}

	if (leading * trailing > 0) {
		dest.ravel = raw_data(make([]T, leading * trailing, allocator))
		if trailing == 1 {
			_reduce_add_trailing_with_cast(dest.ravel, source.ravel, leading, reducing)
		} else {
			_reduce_add_middle_with_cast(dest.ravel, source.ravel, leading, reducing, trailing)
		}
	}
}

reduce_add :: proc {
	reduce_add_rank_1,
	reduce_add_rank_2,
	reduce_add_rank_3,
	reduce_add_rank_4,
	reduce_add_rank_1_with_cast,
	reduce_add_rank_2_with_cast,
	reduce_add_rank_3_with_cast,
	reduce_add_rank_4_with_cast,
}

reduce_add_high_rank :: proc {
	reduce_add_poly,
	reduce_add_poly_with_cast,
}

@(private="file") loadu  :: intrinsics.unaligned_load
@(private="file") storeu :: intrinsics.unaligned_store

@(private="file")
@(optimization_mode="size")
_reduce_add_middle_with_cast :: #force_no_inline proc "contextless" (
	dest:     [^]$T,
	source:   [^]$E,
	leading:  int,
	middle:   int,
	trailing: int,
) #no_bounds_check {
	Prefer_Vector_Bytes :: 64
	Max_Vector_Bytes :: 128

	Step :: min(
		Max_Vector_Bytes / size_of(E),
		Max_Vector_Bytes / size_of(T),
		max(
			Prefer_Vector_Bytes / size_of(E),
			Prefer_Vector_Bytes / size_of(T),
		),
	)

	Block :: #simd[Step]E
	PBlock :: #simd[Step]T

	if trailing >= Step {
		columns := trailing / Step
		discard := trailing % Step

		for i in 0 ..< leading {
			plane_dest := dest[i * trailing:]
			for j in 0 ..< middle {
				row_source := source[i * middle * trailing + j * trailing:]
				for k in 0 ..< columns {
					d := (^PBlock)(plane_dest[Step * k:])
					s := (^Block)(row_source[Step * k:])
					storeu(d, loadu(d) + (PBlock)(loadu(s)))
				}
				for k in 0 ..< discard {
					plane_dest[columns*Step+k] += T(row_source[columns*Step+k])
				}
			}
		}
	} else {
		rows_at_a_time := Step / trailing
		rows    := middle / rows_at_a_time
		discard := middle % rows_at_a_time

		for i in 0 ..< leading {
			acc := PBlock{}
			plane_source := source[i*middle*trailing:]
			for j in 0 ..< rows {
				s := (^Block)(plane_source[j*trailing*rows_at_a_time:])
				acc += cast(PBlock)loadu(s)
			}

			remainder_source := plane_source[rows*rows_at_a_time*trailing:]
			for k in 0 ..< trailing {
				val := T{}
				for j in 0 ..< rows_at_a_time {
					val += simd.extract(acc, j * trailing + k)
				}
				for j in 0 ..< discard {
					val += cast(T)remainder_source[j*trailing + k]
				}
				dest[i*trailing + k] = val
			}
		}
	}
}

simd_iota :: proc "contextless" ($T: typeid/#simd[$N]$E) -> T {
	backing := [N]E{}
	#unroll for k in 0 ..< N {backing[k] = E(k)}
	return simd.from_array(backing)
}

aligned_down :: proc "contextless" (p: $P/[^]$T, $Align: uintptr) -> P {
	return P(uintptr(p) &~ (Align - 1))
}

@(private="file")
@(optimization_mode = "size")
_reduce_add_trailing_with_cast :: #force_no_inline proc "contextless" (
	dest:     [^]$T,
	source:   [^]$E,
	leading:  int,
	trailing: int,
) #no_bounds_check {
	Prefer_Vector_Bytes :: 64
	Max_Vector_Bytes :: 128

	Step :: min(
		Max_Vector_Bytes / size_of(E),
		Max_Vector_Bytes / size_of(T),
		max(
			Prefer_Vector_Bytes / size_of(E),
			Prefer_Vector_Bytes / size_of(T),
		),
	)

	Block :: #simd[Step]E
	PBlock :: #simd[Step]T

	if trailing >= 16 * Step {

		for i in 0 ..< leading {
			val := T{}
			cursor   := source[i * trailing:]
			row_end  := source[(i+1) * trailing:]
			vrow_end := aligned_down(row_end, size_of(Block))

			for uintptr(cursor) % size_of(Block) > 0 {
				val += T(cursor[0])
				cursor = cursor[1:]
			}

			acc := PBlock{}
			for cursor < vrow_end {
				acc += PBlock((^Block)(cursor)^)
				cursor = cursor[Step:]
			}
			val += simd.reduce_add_ordered(acc)

			for cursor < row_end {
				val += T(cursor[0])
				cursor = cursor[1:]
			}

			dest[i] = val
		}
	} else {
		for i in 0 ..< leading {
			acc := T{}
			for j in 0 ..< trailing{
				acc += cast(T)source[i * trailing + j]
			}
			dest[i] = acc
		}
	}
}
