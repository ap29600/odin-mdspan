package mdspan
import "core:fmt"
import "core:io"

Wrapped :: struct{
	ravel: rawptr,
	shape: []int,
	elem_type: typeid,
	elem_size: int,
}

wrap :: proc (span: $P/^Span($E,$R)) -> (result: Wrapped) {
	return Wrapped {
		ravel = span.ravel,
		shape = span.shape[:],
		elem_type = E,
		elem_size = size_of(E),
	}
}

@private
fmt_wrapped_span_nohash :: proc (using info: ^fmt.Info, w: Wrapped, verb: rune) {
	for i := 0; ; {
		trail := 1
		j := len(w.shape) - 1
		for ; j >= 0; j -= 1 {
			trail *= w.shape[j]
			if i % trail != 0 { break }
		}
		if j != -1 {
			for _ in 0 ..< len(w.shape) - j - 1 {
				io.write_rune(info.writer, ';', &info.n)
			}
			io.write_rune(info.writer, ' ', &info.n)
		} else if i != 0 {
			break
		}
		for {
			data := uintptr(w.ravel) + uintptr(i * w.elem_size)
			fmt.fmt_arg(info, any{rawptr(data), w.elem_type}, verb)
			i += 1
			if i % w.shape[len(w.shape) - 1] > 0 {
				io.write_string(info.writer, ", ", &info.n)
			} else {
				break
			}
		}
	}
}

@private
fmt_wrapped_span_hash :: proc (using info: ^fmt.Info, w: Wrapped, verb: rune) {
	for i := 0; ; {
		trail := 1
		j := len(w.shape) - 1
		for ; j >= 0; j -= 1 {
			trail *= w.shape[j]
			if i % trail != 0 { break }
		}
		if j != -1 {
			for _ in 0 ..< len(w.shape) - j - 1 {
				io.write_rune(info.writer, '\n', &info.n)
			}
		} else if i != 0 {
			break
		}
		fmt.fmt_write_indent(info)
		for {
			data := uintptr(w.ravel) + uintptr(i * w.elem_size)
			fmt.fmt_arg(info, any{rawptr(data), w.elem_type}, verb)
			i += 1
			io.write_string(info.writer, ", ", &info.n)
			if i % w.shape[len(w.shape) - 1] == 0 {
				break
			}
		}
	}
}

fmt_wrapped_span :: proc (using info: ^fmt.Info, v: any, verb: rune) -> bool {
	wrapped := v.(Wrapped) or_return
	io.write_string(info.writer, "Span(", &info.n)
	fmt.fmt_value(info, wrapped.elem_type, 'T')
	io.write_rune(info.writer, ',', &info.n)
	io.write_int(info.writer, len(wrapped.shape), 10, &info.n)
	io.write_string(info.writer, ")[", &info.n)
	rec_level := info.record_level
	info.record_level += 1
	defer {
		info.record_level = rec_level
		fmt.fmt_write_indent(info)
		io.write_rune(info.writer, ']', &info.n)
	}

	// TODO(Andrea): precalculate the longest value on each column for alignment
	// TODO(Andrea): introduce ellipsis for big arrays
	if info.hash {
		io.write_rune(info.writer, '\n', &info.n)
		indent := info.indent
		info.indent += 1
		defer info.indent = indent
		fmt_wrapped_span_hash(info, wrapped, verb)
		io.write_rune(info.writer, '\n', &info.n)
	} else {
		fmt_wrapped_span_nohash(info, wrapped, verb)
	}
	return true
}
