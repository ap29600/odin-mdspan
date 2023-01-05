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

fmt_wrapped_span :: proc (using info: ^fmt.Info, v: any, verb: rune) -> bool {
	wrapped := v.(Wrapped) or_return
	io.write_string(info.writer, "Span(", &info.n)
	fmt.fmt_value(info, wrapped.elem_type, 'T')
	io.write_rune(info.writer, ',', &info.n)
	io.write_int(info.writer, len(wrapped.shape), 10, &info.n)
	io.write_rune(info.writer, ')', &info.n)
	io.write_rune(info.writer, '[', &info.n)
	defer io.write_rune(info.writer, ']', &info.n)
	if info.hash { io.write_rune(info.writer, '\n', &info.n) }
	defer if info.hash { io.write_string(info.writer, ",\n", &info.n) }
	for i in 0 ..< len(wrapped.shape) - 1 { io.write_rune(info.writer, '[') }
	defer for i in 0 ..< len(wrapped.shape) - 1 { io.write_rune(info.writer, ']') }
	
	// TODO(Andrea): precalculate the longest value on each column for alignment
	// TODO(Andrea): introduce ellipsis for big arrays

	for i := 0; ; {
		trail := 1
		j := len(wrapped.shape) - 1
		for ; j >= 0; j -= 1 {
			trail *= wrapped.shape[j]
			if i % trail != 0 { break }
		}
		if j != -1 {
			for _ in 0 ..< len(wrapped.shape) - j - 1 {
				io.write_rune(info.writer, ']', &info.n)
			}
			io.write_rune(info.writer, ',', &info.n)
			if info.hash {
				io.write_rune(info.writer, '\n', &info.n)
				for k in 0 ..< len(wrapped.shape) - 1{
					io.write_rune(info.writer, ' ' if k < j else '[', &info.n)
				}
			} else {
				for _ in 0 ..< len(wrapped.shape) - j - 1 {
					io.write_rune(info.writer, '[', &info.n)
				}
			}
		} else if i != 0 {
			break
		}
		for {
			if i % wrapped.shape[len(wrapped.shape) - 1] > 0 {
				io.write_string(info.writer, ",", &info.n)
			}
			data := uintptr(wrapped.ravel) + uintptr(i * wrapped.elem_size)
			fmt.fmt_arg(info, any{rawptr(data), wrapped.elem_type}, verb)
			i += 1
			if i % wrapped.shape[len(wrapped.shape) - 1] == 0 {
				break
			}
		}
	}

	return true
}
