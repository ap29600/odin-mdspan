package mdspan

import "core:mem"
import "core:fmt"

@private
validate_permutation :: proc(perm: [$R]int) -> bool {
	for k in 0 ..< R {
		if perm[k] >= R || perm[k] < 0 { return false }
		for j in 0 ..< k { if perm[j] == perm[k] { return false } }
	}
	return true
}

transpose :: proc {
	transpose_dyadic_in_place,
	transpose_dyadic_out_of_place,
	transpose_monadic_in_place,
	transpose_monadic_out_of_place,
}

rotate :: proc {
	rotate_multi_out_of_place,
	rotate_one_out_of_place,
	rotate_multi_in_place,
	rotate_one_in_place,
}

transpose_monadic_in_place :: proc(span:^$S/Span($E,$R)) -> (ok: bool) {
	perm := [R]int{}
	for it, i in &perm {it = R - i - 1}
	return transpose_dyadic_in_place(span, perm)
}

transpose_monadic_out_of_place :: proc(span:$S/Span($E,$R), allocator:=context.allocator) -> (result: Span(E,R), ok: bool) #optional_ok {
	perm := [R]int{}
	for it, i in &perm {it = R - i - 1}
	return transpose_dyadic_out_of_place(span, perm, allocator)
}

transpose_dyadic_out_of_place :: proc (span: $S/Span($E,$R), perm: [R]int, alloc := context.allocator) -> (result: Span(E,R), ok: bool) where R > 1 #optional_ok {
	validate_permutation(perm) or_return
	size := 1; for d in span.shape { size *= d }
	result.ravel = cast([^]E)mem.alloc(size = size * size_of(E), allocator = alloc)
	for i in 0 ..< R { result.shape[perm[i]] = span.shape[i] }

	// merge trailing dimensions: a permutation that ends in [l, l+1 ... R-1]
	// on a rank R span is equivalent to the prefix of length l of that
	// permutation, on a rank l span whose elements are the rank R-l cells of
	// the original.
	l := R
	for perm[l-1] == l-1 {
		l -= 1
		if l == 1 {
			// the permutation was identity, so we just copy the data as is.
			ptr_copy_non_overlapping(result.ravel, span.ravel, size * size_of(E))
			return result, true
		}
	}
	assert(l >= 2, "[BUG]: permutation was valid, was not detected as identity, and has at most one misplaced element")

	elem_size := size_of(E)
	for i in l ..< R {elem_size *= span.shape[i]}

	dst_strides := [R]int{ 0 ..< R = 1 }
	for i in 1 ..< l { dst_strides[l - i - 1] = dst_strides[l - i] * result.shape[l - i] }
	src_strides := [R]int{ 0 ..< R = 1 }
	for i in 1 ..< l { src_strides[l - i - 1] = src_strides[l - i] * span.shape[l - i] }

	outer_size := 1
	for i in 0 ..< l - 1 { outer_size *= span.shape[i] }
	inner_size := span.shape[l - 1]
	inner_stride := dst_strides[perm[l - 1]]

	src := cast([^]u8)span.ravel
	dst := cast([^]u8)result.ravel

	for i in 0 ..< outer_size {
		// calculate the starting offset of the corresponding slice of dst.
		ii := i * inner_size
		offset := 0
		for d in 0 ..< R-1 {
			if ii == 0 { break }
			offset += ii / src_strides[d] * dst_strides[perm[d]]
			ii %= src_strides[d]
		}

		// relatively tight inner loop to copy the elements.

		// should probably work on square blocks in order to get better cache
		// locality:
		// find the axis of src corresponding to the last axis of dst,
		// iterate by blocks of cache_line_size*(cache_size/cache_line_size).
		for j in 0 ..< inner_size {
			ptr_copy_non_overlapping(
				dst[(j * inner_stride + offset) * elem_size:],
				src[(i * inner_size   + j) * elem_size:],
				elem_size,
			)
		}
	}

	return result, true
}

transpose_dyadic_in_place :: proc (span: ^$S/Span($E, $R), perm: [R]int) -> (ok: bool) {
	perm := perm
	validate_permutation(perm) or_return

	for k in 1 ..< R {
		k := R - k
		i := -1
		for d in 0 ..= k {
			if perm[d] == k {
				i = d
				break
			}
		}
		assert(i >= 0, "BUG: axis permutation got mangled during the algorithm.")
		if i == k { continue }

		lead  := 1
		for j in 0 ..< i { lead *= span.shape[j] }
		m := span.shape[i]
		n := 1
		for j in i+1 ..= k { n *= span.shape[j] }
		trail := size_of(E)
		for j in k+1 ..< R { trail *= span.shape[j] }

		transpose_once_inplace(span.ravel, lead, m, n, trail)
		for j in i ..< k {
			span.shape[j] = span.shape[j + 1]
			perm[j] = perm[j + 1]
		}
		span.shape[k] = m
		perm[k] = k
	}
	return true
}

@private
transpose_once_inplace :: proc (data: rawptr, lead, m, n, trail: int) {
	pred :: proc (i, m, n: int) -> int { return (i%m)*n+i/m }
	data := cast([^]u8)data
	s1 := m*n*trail
	outer: for i in 0 ..< n*m {
		j, k := i, pred(i, m, n)

		for l := k; l != i; l = pred(l, m, n) {
			if l < i { continue outer }
		}

		for k != i {
			for l in 0 ..< lead {
				ptr_swap_non_overlapping(
					data[l*s1+j*trail:],
					data[l*s1+k*trail:],
					trail,
				)
			}
			j, k = k, pred(k, m, n)
		}
	}
}

/*
	bias is used to determine what axis the leading axis of `shifts` should be
	matched to: for example if s is a [2 x 2 x 2] span, and you want to rotate the
	elements from:

	0 1
	2 3
	---
	4 5
	6 7

	to:

	0 5
	2 7
	---
	4 1
	6 3

	you can achieve this by telling rotate to skip one axis in matching shifts to
	the shape of s:

	rotate(span = s, shifts = array([]int{0, 1}), bias = 1, axis = 0)

	instead of defining shifts to have the repeated values for each leading
	dimension:

	rotate(span = s, shifts = from_slice([]int{0, 1, 0, 1}, [?]int{2, 2}), axis = 0)
*/
rotate_multi_in_place :: proc (span: $S/^Span($E,$R), shifts: $T/Span(int,$L), axis := 0, bias := 0) -> (ok: bool) where L < R {
	axis := axis %% R

	if L + bias >= R  { return false }

	when L > 0 {
		// check that `shifts` has the right shape
		for i in 0 ..< L {
			if span.shape[i + bias + int(axis <= i + bias)] != shifts.shape[i] {
				return false
			}
		}
	}

	// The overall strategy is to precalculate a set of strides and sizes that is
	// independent of the array's rank, and then dispatch to a generic byte
	// rotation.

	// The case of axis >= bias is expected to be the fastest, as the rotations
	// can be performed on contiguous memory and more trailing dimensions can be
	// merged. The most common cases of rotating along a selected axis with a
	// uniform scalar value all fall into this fast case.

	if axis >= bias + L {
		shifts_lead  := 1; for i in 0      ..< bias   { shifts_lead  *= span.shape[i] }
		shifts_count := 1; for i in bias   ..< L+bias { shifts_count *= span.shape[i] }
		shifts_trail := 1; for i in L+bias ..< axis   { shifts_trail *= span.shape[i] }
		trailing := size_of(E); for i in axis+1 ..< R { trailing *= span.shape[i] }
		middle := span.shape[axis]

		trail_stride := trailing     * middle
		mid_stride   := trail_stride * shifts_trail
		lead_stride  := mid_stride   * shifts_count

		data := cast([^]u8)span.ravel
		for i in 0 ..< shifts_count {
			left := (shifts.ravel[i] %% middle) * trailing
			right := middle * trailing - left
			base := data[i * mid_stride:]
			for j in 0 ..< shifts_lead {
				for k in 0 ..< shifts_trail {
					ptr_rotate(
						base[j * lead_stride + k * trail_stride + left:],
						left,
						right,
					)
				}
			}
		}
	} else if axis >= bias {
		shifts_lead  := 1; for i in 0        ..< bias     { shifts_lead  *= span.shape[i] }
		shifts_pre   := 1; for i in bias     ..< axis     { shifts_pre   *= span.shape[i] }
		shifts_post  := 1; for i in axis+1   ..< bias+L+1 { shifts_post  *= span.shape[i] }
		trailing := size_of(E); for i in bias+L+1 ..< R   { trailing *= span.shape[i] }
		middle := span.shape[axis]

		rot_stride  := trailing   * shifts_post
		pre_stride  := rot_stride * middle
		lead_stride := pre_stride * shifts_pre
		
		data := cast([^]u8)span.ravel
		for i in 0 ..< shifts_pre {
			for h in 0 ..< shifts_post {
				left := shifts.ravel[i * shifts_post + h] %% middle
				right := middle - left
				base := data[i * pre_stride + h * trailing:]
				for j in 0 ..< shifts_lead {
					ptr_rotate_strided(
						base[j * lead_stride + left * rot_stride :],
						left,
						right,
						trailing,
						rot_stride,
					)
				}
			}
		}
	} else /* axis < bias */ {
		shifts_pre   := 1; for i in 0        ..< axis     { shifts_pre   *= span.shape[i] }
		shifts_post  := 1; for i in axis+1   ..< bias+1   { shifts_post  *= span.shape[i] }
		shifts_count := 1; for i in bias+1   ..< bias+L+1 { shifts_count *= span.shape[i] }
		trailing := size_of(E); for i in bias+L+1 ..< R   { trailing *= span.shape[i] }
		middle := span.shape[axis]

		post_stride := trailing    * shifts_count
		rot_stride  := post_stride * shifts_post
		pre_stride  := rot_stride  * middle

		data := cast([^]u8)span.ravel
		for i in 0 ..< shifts_count {
			left  := shifts.ravel[i] %% middle
			right := middle - left
			base := data[i * trailing:]

			for j in 0 ..< shifts_pre {
				for k in 0 ..< shifts_post {
					ptr_rotate_strided(
						base[j * pre_stride + k * post_stride + left * rot_stride :],
						left,
						right,
						trailing,
						rot_stride,
					)
				}
			}
		}
	}

	return true
}

// TODO: implement proper out-of-place rotation and compare performance
rotate_multi_out_of_place :: proc (span: $S/Span($E,$R), shifts: $T/Span(int,$L), axis := 0, bias := 0, allocator := context.allocator) -> (result: Span(E,R), ok: bool) where L < R #optional_ok {
	result = clone(span, allocator)
	ok = rotate_multi_in_place(&result, shifts, axis, bias)
	return
}

rotate_one_in_place :: proc (span: $S/^Span($E,$R), shift: int, axis := 0, bias := 0) -> (ok: bool) where R > 0 {
	shift := shift
	return rotate_multi_in_place(span = span, shifts = transmute(Span(int, 0))&shift, axis = axis, bias = bias)
}

rotate_one_out_of_place :: proc (span: $S/Span($E,$R), shift: int, axis := 0, bias := 0, allocator := context.allocator) -> (result: Span(E,R), ok: bool) where R > 0 #optional_ok {
	shift := shift
	return rotate_multi_out_of_place(span = span, shifts = transmute(Span(int, 0))&shift, axis = axis, bias = bias, allocator = allocator)
}
