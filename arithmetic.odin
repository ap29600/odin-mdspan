package mdspan

import "core:mem"
import "core:intrinsics"

alternating_sum :: proc (
	$Rank: int,
	span: $S/Span($E,Rank),
	axis := 0,
	allocator := context.allocator,
) -> (result: Span(E, Rank - 1))
	where Rank > 0, intrinsics.type_is_numeric(E) {
		return reduce_proc(
			Rank,
			span,
			E(0),
			proc(a, b: E) -> E { return a-b },
			axis,
			allocator,
		)
}

sum_reduce :: proc (
	$Rank: int,
	span: $S/Span($E,Rank),
	axis := 0,
	allocator := context.allocator,
) -> (result: Span(E,Rank-1))
	where Rank > 0, intrinsics.type_is_numeric(E) {
		return reduce_proc(
			Rank,
			span,
			E(0),
			proc(a, b:E) -> E { return a+b },
			axis,
			allocator,
		)
	}

product_reduce :: proc (
	$Rank: int,
	span: $S/Span($E,Rank),
	axis := 0,
	allocator := context.allocator,
) -> (result: Span(E,Rank-1))
	where Rank > 0, intrinsics.type_is_numeric(E) {
		return reduce_proc(
			Rank,
			span,
			E(1),
			proc(a, b:E) -> E { return a*b },
			axis,
			allocator,
		)
	}

reduce_proc :: proc (
	$Rank: int,
	span: $S/Span($E,Rank),
	init: $A,
	p: proc(_:A, _: E) -> A,
	axis := 0,
	allocator := context.allocator,
) -> (result: Span(E,Rank-1))
	where Rank > 0 #no_bounds_check {
		axis := axis %% Rank
		leading  := 1;
		for i in 0 ..< axis {
			result.shape[i] = span.shape[i]
			leading *= span.shape[i]
		}
		reducing := span.shape[axis];
		trailing := 1;
		for i in axis ..< Rank-1 {
			result.shape[i] = span.shape[i+1]
			trailing *= span.shape[i+1]
		}
		result.ravel = raw_data(make([]A, leading*trailing, allocator))
		for i in 0 ..< leading*trailing {result.ravel[i] = init}
		assert(leading >= 1 && reducing >= 1 && trailing >= 1)
		for i in 0 ..< leading {
			for k in 0 ..< reducing {
				k := reducing-k-1
				from := span.ravel[(i*reducing+k)*trailing:]
				to   := result.ravel[i*trailing:]
				for j in 0 ..< trailing {
					to[j] = p(from[j], to[j])
				}
			}
		}
		return
	}
