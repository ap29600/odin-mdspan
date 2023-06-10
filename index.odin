package mdspan

index :: proc {
	index_element,
	index_rank_0_major_cell,
	index_rank_1_major_cell,
	index_rank_2_major_cell,
	index_rank_3_major_cell,
	index_rank_4_major_cell,
	index_rank_1_subarray,
	index_rank_2_subarray,
	index_rank_3_subarray,
	index_rank_4_subarray,
	index_subarray_by_rank,
}

index_element :: proc (span: $S/Span($E,$R), idx: [R]int) -> (result: ^E, ok: bool) where R > 0 #optional_ok {
	offset := 0
	for i in 0 ..< R {
		if uint(idx[i]) >= uint(span.shape[i]) { return }
		offset *= span.shape[i]
		offset += idx[i]
	}
	return span.ravel[offset:], true
}

index_rank_0_major_cell :: proc (span: $S/Span($E,1), idx: int) -> (result: ^E, ok: bool) #optional_ok {
	if uint(idx) >= uint(span.shape[0]) { return }
	return &result.ravel[idx], true
}

index_rank_1_major_cell :: proc (span: $S/Span($E,2), idx: int) -> (result: Span(E, 1), ok: bool) #optional_ok {
	if uint(idx) >= uint(span.shape[0]) { return }
	result.ravel = span.ravel[idx * span.shape[1]:]
	result.shape = { span.shape[1] }
	return result, true
}

index_rank_2_major_cell :: proc (span: $S/Span($E,3), idx: int) -> (result: Span(E, 2), ok: bool) #optional_ok {
	if uint(idx) >= uint(span.shape[0]) { return }
	result.ravel = span.ravel[idx * span.shape[1] * span.shape[2]:]
	result.shape = { span.shape[1], span.shape[2] }	
	return result, true
}

index_rank_3_major_cell :: proc (span: $S/Span($E, 4), idx: int) -> (result: Span(E, 3), ok: bool) #optional_ok {
	if uint(idx) >= uint(span.shape[0]) { return }
	result.ravel = span.ravel[idx * span.shape[1] * span.shape[2] * span.shape[3]:]
	result.shape = { span.shape[1], span.shape[2], span.shape[3] }
	return result, true
}

index_rank_4_major_cell :: proc (span: $S/Span($E, 5), idx: int) -> (result: Span(E, 4), ok: bool) #optional_ok {
	if uint(idx) >= uint(span.shape[0]) { return }
	result.ravel = span.ravel[idx * span.shape[1] * span.shape[2] * span.shape[3] * span.shape[4]:]
	result.shape = { span.shape[1], span.shape[2], span.shape[3], span.shape[4] }
	return result, true
}

index_rank_1_subarray :: proc (span: $S/Span($E, $R), idx: [$L]int) -> (result: Span(E, 1), ok: bool) where R - L == 1 #optional_ok {
	return index_subarray_by_rank(span, idx, 1)
}

index_rank_2_subarray :: proc (span: $S/Span($E, $R), idx: [$L]int) -> (result: Span(E, 2), ok: bool) where R - L == 2 #optional_ok {
	return index_subarray_by_rank(span, idx, 2)
}

index_rank_3_subarray :: proc (span: $S/Span($E, $R), idx: [$L]int) -> (result: Span(E, 3), ok: bool) where R - L == 3 #optional_ok {
	return index_subarray_by_rank(span, idx, 3)
}

index_rank_4_subarray :: proc (span: $S/Span($E, $R), idx: [$L]int) -> (result: Span(E, 4), ok: bool) where R - L == 4 #optional_ok {
	return index_subarray_by_rank(span, idx, 4)
}

index_subarray_by_rank :: proc (span: $S/Span($E, $R), idx: [$L]int, $M: int) -> (result: Span(E, M), ok: bool) where R - L == M #optional_ok {
	offset := 0
	for i in 0 ..< L {
		if uint(idx[i]) >= uint(span.shape[i]) { return }
		offset *= span.shape[i]
		offset += idx[i]
	}
	for i in L ..< R {
		offset *= span.shape[i]
		result.shape[i - L] = span.shape[i]
	}
	result.ravel = span.ravel[offset:]

	return result, true
}
