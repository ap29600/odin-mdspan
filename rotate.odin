package mdspan

import "core:mem"

rotate_inplace_multi :: proc (span: $S/^Span($E,$R), shifts: $T/Span(int,$L), axis := 0) -> (ok: bool) where L < R {
	axis := axis %% R

	when L > 0 {
		// check that `shifts` has the right shape
		for i in 0 ..< L {
			if span.shape[i + int(axis <= i)] != shifts.shape[i] {
				return false
			}
		}
	}

	// TODO: this whole logic is a mess and needs a rationalization
	leading, middle, trailing := collapse_dimensions_exclusive(span.shape, axis)
	leading_shifts, trailing_shifts := collapse_dimensions_inclusive(shifts.shape, axis)

	if trailing_shifts == 1 { // fast path
		for i in 0 ..< leading_shifts {
			left := shifts.ravel[i] %% middle
			if left == 0 {continue}
			right := middle - left
			for j in 0 ..< leading / leading_shifts {
				cell := i*leading/leading_shifts+j
				mid := span.ravel[cell*middle*trailing + left*trailing:]
				ptr_rotate(mid, left*trailing*size_of(E), right*trailing*size_of(E))
			}
		}
	} else { // slow path, use a strided rotate
		stride := trailing * size_of(E)
		size   := trailing / trailing_shifts * size_of(E)
		for i in 0 ..< leading {
			for j in 0 ..< trailing_shifts {
				left := shifts.ravel[i * trailing_shifts + j] %% middle
				if left == 0 {continue}
				right  := middle - left
				// TODO: rationalize index calculation
				base := span.ravel[(i*middle*trailing) + (j*trailing/trailing_shifts) + (left*trailing):]
				ptr_rotate_strided(base, left, right, size, stride)
			}
		}
	}
	return
}

rotate_multi :: proc (
	span: $S/Span($E,$R),
	shifts: $T/Span(int,$L),
	axis := 0,
	allocator := context.allocator,
) -> (result: Span(E,R)) where L < R {
	result = clone(span)
	rotate_inplace(&result, shifts, axis)
	return
}

rotate_inplace_one :: proc (span: $S/^Span($E,$R), shift: int, axis := 0) where R > 0 {
	shift := shift
	rotate_inplace_multi(span, transmute(Span(int, 0))&shift, axis)
}

rotate_one :: proc (
	span: $S/Span($E,$R),
	shift: int,
	axis := 0,
	allocator := context.allocator,
) -> (result: Span(E,R)) where R > 0 {
	shift := shift
	return rotate_multi(span, transmute(Span(int, 0))&shift, axis)
}

rotate :: proc { rotate_multi, rotate_one, rotate_inplace_multi, rotate_inplace_one }
