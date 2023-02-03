package mdspan

import "core:mem"

@private
validate_permutation :: proc(perm: [$R]int) -> bool {
	for k in 0 ..< R {
		if perm[k] >= R || perm[k] < 0 { return false }
		for j in 0 ..< k { if j == k { return false } }
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
	rotate_out_of_place_multi,
	rotate_out_of_place_one,
	rotate_inplace_multi,
	rotate_inplace_one,
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

transpose_dyadic_out_of_place :: proc (span: $S/Span($E,$R), perm: [R]int, alloc := context.allocator) -> (result: Span(E,R), ok: bool) #optional_ok {
	validate_permutation(perm) or_return
	size := 1; for d in span.shape { size *= d }
	result.ravel = cast([^]E)mem.alloc(size = size * size_of(E), allocator = alloc)
	for i in 0 ..< R { result.shape[perm[i]] = span.shape[i] }

	when R > 1 {
		// merge trailing dimensions
		l := R
		for perm[l-1] == l-1 {
			l -= 1
			if l == 1 {
				// permutation was identity
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
			ii := i * inner_size
			k := 0
			for d in 0 ..< R-1 {
				if ii == 0 { break }
				k += ii / src_strides[d] * dst_strides[perm[d]]
				ii %= src_strides[d]
			}
			for j in 0 ..< inner_size {
				ptr_copy_non_overlapping(
					dst[(j * inner_stride + k) * elem_size:],
					src[(i * inner_size   + j) * elem_size:],
					elem_size,
				)
			}
		}

	} else {
		ptr_copy_non_overlapping(result.ravel, span.ravel, size * size_of(E))
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

rotate_out_of_place_multi :: proc (span: $S/Span($E,$R), shifts: $T/Span(int,$L), axis := 0, allocator := context.allocator) -> (result: Span(E,R)) where L < R {
	result = clone(span)
	rotate_inplace(&result, shifts, axis)
	return
}

rotate_inplace_one :: proc (span: $S/^Span($E,$R), shift: int, axis := 0) where R > 0 {
	shift := shift
	rotate_inplace_multi(span, transmute(Span(int, 0))&shift, axis)
}

rotate_out_of_place_one :: proc (span: $S/Span($E,$R), shift: int, axis := 0, allocator := context.allocator) -> (result: Span(E,R)) where R > 0 {
	shift := shift
	return rotate_out_of_place_multi(span, transmute(Span(int, 0))&shift, axis)
}