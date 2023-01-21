package mdspan

transpose_monadic :: proc(span:$S/Span($E,$R),allocator:=context.allocator) -> (result: Span(E,R), ok: bool) #optional_ok {
	perm := [R]int{}
	for it, i in &perm {it = R - i - 1}
	return transpose_dyadic(span, perm, allocator)
}

// TODO: try out-of-place transposition and compare performance
transpose_dyadic :: proc (span: $S/Span($E,$R), perm: [R]int, alloc := context.allocator) -> (result: Span(E,R), ok: bool) #optional_ok {
	result = clone(span, alloc)
	when R > 1 { transpose_inplace(&result, perm) or_return }
	return result, true
}

transpose :: proc {transpose_monadic, transpose_dyadic, transpose_inplace}

transpose_inplace :: proc (span: ^$S/Span($E, $R), perm: [R]int) -> (ok: bool) {
	perm := perm

	// validate that the permutation is legal
	for k in 0 ..< R {
		if perm[k] >= R || perm[k] < 0 { return false }
		for j in 0 ..< k { if j == k { return false } }
	}

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

		lead  := 1; for j in 0 ..< i { lead *= span.shape[j] }
		m     := span.shape[i]
		n     := 1; for j in i+1 ..= k { n *= span.shape[j] }
		trail := 1; for j in k+1 ..< R { trail *= span.shape[j] }

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
transpose_once_inplace :: proc (data: $S/[^]$E, lead, m, n, trail: int) {
	pred :: proc (i, m, n: int) -> int { return (i%m)*n+i/m }
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
					trail * size_of(E),
				)
			}
			j, k = k, pred(k, m, n)
		}
	}
}

@private
@(optimization_mode="speed")
ptr_swap_non_overlapping :: proc (a, b: rawptr, size: int) {
	a := uintptr(a)
	b := uintptr(b)
	size := size

	Block :: [32]u8 // size of vector register
	block := Block{}
	for size >= size_of(block) {
		block = (cast(^Block)a)^
		(cast(^Block)a)^ = (cast(^Block)b)^
		(cast(^Block)b)^ = block
		a += uintptr(size_of(Block))
		b += uintptr(size_of(Block))
		size -= size_of(Block)
	}

	Word :: [8]u8 // size of qword register
	word := Word{}
	for size >= size_of(word) {
		word = (cast(^Word)a)^
		(cast(^Word)a)^ = (cast(^Word)b)^
		(cast(^Word)b)^ = word
		a += uintptr(size_of(Word))
		b += uintptr(size_of(Word))
		size -= size_of(Word)
	}

	for size > 0 {
		byte := (cast(^u8)a)^
		(cast(^u8)a)^ = (cast(^u8)b)^
		(cast(^u8)b)^ = byte
		a += 1
		b += 1
		size -= 1
	}
}
