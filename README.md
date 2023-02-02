# Odin-MDSpan
A multi dimensional array library for the Odin programming language

### What's a multi dimensional array?
A collection of elements arranged along an arbitrary number of axes. This number
is the array's `rank`.

For example, a single number can be interpreted as a rank-0 array, the traditional
Odin `[N]T` would be a rank-1 array, and `matrix[N,M]T` is a rank-2 array.
Out of the box, these are the only ranks supported by Odin (with `matrix` being
limited to dimensions lower than `4x4`); this library offers a generalization of
these constructs, as well as implementations for some of the most common operations
you might want to perform on it.

### Why would I want to use multi-dimensional arrays in my code?
It depends on what you look for in your computing experience. Some notable reasons
include:

- Algorithmic exploration: an ergonomic multi-dimensional array library can be a
	powerful tool for data transformation and visualization without resorting to
	explicitly writing loops.
- Code and resource reuse: code for scientific computing is often written in
	languages like `matlab` or through libraries like `numpy`, both of which
	support or encourage the use of multidimensional arrays.
- Mechanical sympathy \*: modern computers are fastest when they are allowed to perform
	vectorized operations on large batches of data. Arranging data in contiguous
	arrays can thus prove faster than chasing pointers in a nested representation.

(\*) This is only applicable if the library implements fast algorithms and takes
vectorization into account. The goal of this particular implementation is to be
ergonomic first, and efficient second.

## Types

### Span
```odin
Span :: struct($T, $R)
```
the primary structure offered by the library is a generic multi dimensional
unstrided slice. It has the following fields:
- `ravel : [^]T`: a pointer to the data.
- `shape : [R]int`: an array containing the length of each axis.

The memory layout is row-major for rank 2 arrays and extends logically to the other
ranks: for example, in a 4-dimensional array of shape `{n, m, o, p}`, the element
at index `{i, j, k, l}` is at an offset of `i*m*o*p + j*o*p + k*p + l` from the base
pointer.

Notable edge-cases:
- `Span(T, 0)` is transmutable to/from `^T`
- `Span(T, 1)` is transmutable to/from `[]T`

### `Wrapped`
a type-erased array. It's currently only used for printing, since a user formatter
in the `fmt` library can only be registered for a fully specialized type.

## Procedures

### scalar
```odin
scalar :: proc (element: ^$T) -> Span(T, 0)
```
Equivalent to `from_slice(slice.from_ptr(element, 1), [0]int{})`

### array
```odin
array :: proc(element: []T) -> Span(T, 1)
```
Equivalent to `from_slice(elements, [1]int{-1})`

### from_slice
```odin
from_slice :: proc (elements: []$T, shape: [$R]int) -> Span(T, R)
```
Makes a `Span` from the elements in the provided slice, with the specified shape.
The following preconditions must hold:
- at most one of the elements of `shape` is negative. If present, this is called a
	fill dimension and is inferred from the length of `elements`.
- if no fill dimension is provided the length of `elements` must be equal to the
	product of the elements of `shape`.
- if a fill dimension is provided the length of `elements` must be divisible by
	the product of the remaining elements of `shape`.

example:
```odin
elements := []int{1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12}
// makes a 4x3 rank 2 array of the elements.
s2 := mdspan.from_slice(elements, [?]int{4, 3})
// the same, but automatically deduce the dimension of the leading axis.
s1 := mdspan.from_slice(elements, [?]int{-1, 3})
```

### index
```odin
index :: proc(span: Span($T,$R), idx: [R]int) -> ^E
```
Produce a pointer to the element at the given index.

### ravel_view
```odin
ravel_view :: proc(span: Span($T, $R)) -> []T
```
Return a view of the elements of the span, discarding shape information.
