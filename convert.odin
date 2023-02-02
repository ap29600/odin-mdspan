package mdspan

scalar :: proc(value: $P/^$E) -> Span(E,0) {
	return transmute(Span(E,0)) value
}

array :: proc(values: $P/[]$E) -> Span(E,1) {
	return transmute(Span(E,1)) values
}

from_slice :: proc(data: $P/[]$E, shape: [$R]int) -> (result: Span(E,R), ok: bool) where R > 0 #optional_ok {
	shape := shape

	found_fill := false
	fill_position := 0
	for i in 0 ..< R {
		if shape[i] < 0 {
			if found_fill { return }
			found_fill = true
			fill_position = i
		}
	}

	if found_fill {
		shape[fill_position] = len(data)
		for i in 0 ..< R {
			if i != fill_position {
				if shape[fill_position] % shape[i] != 0 { return }
				shape[fill_position] /= shape[i]
			}
		}
	} else {
		size := 1
		for i in 0 ..<R { size *= shape[i] }
		if size != len(data) { return }
	}

	result = { raw_data(data), shape }
	return
}


to_slice :: proc (span: $S/Span($E,$R)) -> []E {
	size := 1; for i in 0 ..< R { size *= span.shape[i] }
	return span.ravel[:size]
}
