package mdspan

//TODO: remove dependency on "core:os"
import "core:os"
import "core:mem"
//TODO: remove dependency on "core:slice"
import "core:slice"

transpose_monadic :: proc(span:$S/Span($E,$R),allocator:=context.allocator) -> Span(E,R) {
	perm := [R]int{}
	for it, i in &perm {it = R - i - 1}
	return transpose_dyadic(span, perm, allocator)
}

transpose_dyadic :: proc (span: $S/Span($E,$R), perm: [R]int, alloc := context.allocator) -> (result: Span(E,R)) {
	result = clone(span, alloc)
	when R > 1 { transpose_inplace(&result, perm, alloc) }
	return
}

transpose :: proc {transpose_monadic, transpose_dyadic}

// TODO: do this without allocations
transpose_inplace :: proc (span: ^$S/Span($E, $R), perm: [R]int, alloc := context.allocator) {
	bits := [dynamic]u64{}
	defer delete_dynamic_array(bits)
	perm := perm
	for k in 0 ..< R-1 {
		i := -1
		for d in k ..< R {
			if perm[d] == k {
				i = d
				break
			}
		}
		if i == -1 { os.exit(1) }
		if i == k { continue }

		lead  := 1; for j in 0 ..< k { lead *= span.shape[j] }
		m     := 1; for j in k ..< i { m *= span.shape[j] }
		n     := span.shape[i]
		trail := 1; for j in i+1 ..< R {trail *= span.shape[j] }

		resize(&bits, n*m/64+1)
		transpose_once_inplace(span.ravel, lead, m, n, trail, bits[:])
		for j in 0 ..< i-k {
			span.shape[i-j] = span.shape[i-j-1]
			perm[i-j] = perm[i-j-1]
		}
		span.shape[k] = n
		perm[k] = k
	}
}

transpose_once_inplace :: proc (data: $S/[^]$E, lead, m, n, trail: int, bits: []u64) {
	pred :: proc (i, m, n: int) -> int { return (i%m)*n+i/m }
	slice.fill(bits[:(n*m)/64+1], 0)
	assert(len(bits) * 64 >= n * m)
	s1 := m*n*trail
	for i in 0 ..< n*m {
		if (bits[i/64] >> u8(i%64)) & 1 == 1 { continue }
		bits[i/64] |= 1 << u8(i%64)
		j, k := i, pred(i, m, n)
		for k != i {
			bits[k/64] |= 1 << u8(k%64)
			for l in 0 ..< lead {
				slice.ptr_swap_non_overlapping(
					data[l*s1+j*trail:],
					data[l*s1+k*trail:],
					trail * size_of(E),
				)
			}
			j, k = k, pred(k, m, n)
		}
	}
}
