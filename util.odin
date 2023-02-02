package mdspan

@private
@(optimization_mode="speed")
ptr_swap_non_overlapping :: proc (a, b: rawptr, size: int) {
	a := cast([^]u8)a
	b := cast([^]u8)b
	size := size

	Block :: [32]u8 // size of vector register
	block := Block{}
	for size >= size_of(block) {
		block = (cast(^Block)a)^
		(cast(^Block)a)^ = (cast(^Block)b)^
		(cast(^Block)b)^ = block
		a = a[size_of(Block):]
		b = b[size_of(Block):]
		size -= size_of(Block)
	}

	Word :: [8]u8 // size of qword register
	word := Word{}
	for size >= size_of(word) {
		word = (cast(^Word)a)^
		(cast(^Word)a)^ = (cast(^Word)b)^
		(cast(^Word)b)^ = word
		a = a[size_of(Word):]
		b = b[size_of(Word):]
		size -= size_of(Word)
	}

	for size > 0 {
		byte := a[0]
		a[0] = b[0]
		b[0] = byte
		a = a[1:]
		b = b[1:]
		size -= 1
	}
}

@private
@(optimization_mode="speed")
ptr_copy_non_overlapping :: proc (a, b: rawptr, size: int) {
	a := cast([^]u8)a
	b := cast([^]u8)b
	size := size

	Block :: [32]u8 // size of vector register
	for size >= size_of(Block) {
		(cast(^Block)a)^ = (cast(^Block)b)^
		a = a[size_of(Block):]
		b = b[size_of(Block):]
		size -= size_of(Block)
	}

	Word :: [8]u8 // size of qword register
	for size >= size_of(Word) {
		(cast(^Word)a)^ = (cast(^Word)b)^
		a = a[size_of(Word):]
		b = b[size_of(Word):]
		size -= size_of(Word)
	}

	for size > 0 {
		a[0] = b[0]
		a = a[1:]
		b = b[1:]
		size -= 1
	}
}

@private
collapse_dimensions_exclusive :: proc (dims: [$N]int, axis: int) -> (leading, middle, trailing: int) {
	leading = 1
	middle = axis < N ? dims[axis] : 1
	trailing = 1
	#unroll for i in 0 ..< N {
		leading  *= i < axis ? dims[i] : 1
		trailing *= i > axis ? dims[i] : 1
	}
	return
}

@private
collapse_dimensions_inclusive :: proc (dims: [$N]int, axis: int) -> (leading, trailing: int) {
	leading = 1
	trailing = 1
	when N > 0 {
		#unroll for i in 0 ..< N {
			leading *= i < axis ? dims[i] : 1
			trailing *= i >= axis ? dims[i] : 1
		}
	}
	return
}

@private
@(optimization_mode="speed")
ptr_swap_strided :: proc (a, b: rawptr, count, size, stride: int) {
	a := cast([^]u8)a
	b := cast([^]u8)b
	for i in 0 ..< count {
		ptr_swap_non_overlapping(a[i*stride:], b[i*stride:], size)
	}
}

@private
@(optimization_mode="speed")
ptr_rotate_strided :: proc (mid: rawptr, left, right: int, size, stride: int) {
	mid := cast([^]u8)mid
	left, right := left, right
	for left > 0 && right > 0 {
		if left > right {
			ptr_swap_strided(mid[-right*stride:], mid, right, size, stride)
			left -= right
			mid = mid[-right*stride:]
		} else {
			ptr_swap_strided(mid[-left*stride:], mid, left, size, stride)
			right -= left
			mid = mid[left*stride:]
		}
	}
}

@private
@(optimization_mode="speed")
ptr_rotate :: proc (mid: rawptr, left, right: int) {
	mid := cast([^]u8)mid
	left, right := left, right
	for left > 0 && right > 0 {
		if left > right {
			ptr_swap_non_overlapping(mid[-right:], mid, right)
			left -= right
			mid = mid[-right:]
		} else {
			ptr_swap_non_overlapping(mid[-left:], mid, left)
			right -= left
			mid = mid[left:]
		}
	}
}
