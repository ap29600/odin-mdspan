package mdspan

import "core:mem"
import "core:slice"

@private
collapse_dimensions_exclusive :: proc (dims: [$N]int, axis: int) -> (leading, middle, trailing: int) #no_bounds_check {
	leading = 1
	middle = axis < N ? dims[axis] : 1
	trailing = 1
	for i in 0 ..< N {
		leading  *= i < axis ? dims[i] : 1
		trailing *= i > axis ? dims[i] : 1
	}
	return
}

@private
collapse_dimensions_inclusive :: proc (dims: [$N]int, axis: int) -> (leading, trailing: int) #no_bounds_check {
	leading = 1
	trailing = 1
	when N > 0 {
		for i in 0 ..< N {
			leading  *= i < axis ? dims[i] : 1
			trailing *= i >= axis ? dims[i] : 1
		}
	}
	return
}

@private
ptr_swap_strided :: proc (a, b: rawptr, count, size, stride: uintptr) {
	for i in 0 ..< count {
		slice.ptr_swap_non_overlapping(
			rawptr(uintptr(a) + i * stride),
			rawptr(uintptr(b) + i * stride),
			int(size),
		)
	}
}

// TODO: don't use pointer arithmetic
@private
ptr_rotate_strided :: proc (mid: rawptr, left, right: int, size, stride: int) {
	mid := mid
	left, right := uintptr(left), uintptr(right)
	size, stride := uintptr(size), uintptr(stride)
	for left > 0 && right > 0 {
		if left > right {
			ptr_swap_strided(rawptr(uintptr(mid) - right * stride), mid, right, size, stride)
			left -= right
			mid  = rawptr(uintptr(mid) - right * stride)
		} else {
			ptr_swap_strided(rawptr(uintptr(mid) - left * stride), mid, left, size, stride)
			right -= left
			mid  = rawptr(uintptr(mid) + left * stride)
		}
	}
}

// TODO: don't use pointer arithmetic
@private
ptr_rotate :: proc (mid: rawptr, left, right: int) {
	mid := mid
	left, right := uintptr(left), uintptr(right)
	for left > 0 && right > 0 {
		if left > right {
			slice.ptr_swap_non_overlapping(rawptr(uintptr(mid) - right), mid, int(right))
			left -= right
			mid  = rawptr(uintptr(mid) - right)
		} else {
			slice.ptr_swap_non_overlapping(rawptr(uintptr(mid) - left), mid, int(left))
			right -= left
			mid  = rawptr(uintptr(mid) + left)
		}
	}
}


rotate_inplace_multi :: proc (span: $S/^Span($E,$R), shifts: $T/Span(int,$L), axis := 0) where L < R #no_bounds_check {
	axis := axis %% R

	// TODO: validate that the shapes are compatible
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

rotate :: proc { rotate_multi, rotate_one }
rotate_inplace :: proc { rotate_inplace_multi, rotate_inplace_one }
