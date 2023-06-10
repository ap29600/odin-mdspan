package mdspan

import "core:intrinsics"
import "core:math"

fourier_transform :: proc(span: ^$S/Span($E, $R), axis := 0, inverse := false, normalize := true) where intrinsics.type_is_complex(E) {
	Re :: type_of(real(E{}))
	#assert(size_of(Re) == size_of(E) / 2)

	// if axis is negative, it is indexed backwards from the trailing axis.
	axis := axis %% R

	leading  := 1; for i in 0 ..< axis { leading *= span.shape[i] }
	axis_len := span.shape[axis]
	trailing := 1; for i in axis+1 ..< R { trailing *= span.shape[i] }

	if axis_len == 0 { return }
	assert(math.is_power_of_two(axis_len), "Fast Fourier Transform requires that the data size be a power of 2.")

	{ // data reordering by bit reversal
		bits := intrinsics.count_trailing_zeros(uint(axis_len))
		j    := 1 << (bits - 1)
		for i in 1 ..< axis_len {
			if j > i {
				ptr_swap_strided(
					span.ravel[i * trailing:],
					span.ravel[j * trailing:],
					leading,
					trailing * size_of(E),
					axis_len * trailing * size_of(E),
				)
			}

			// next value in reverse bit order.
			flips := intrinsics.count_trailing_zeros(~uint(i))
			mask  := int((1 << bits) - (1 << (bits - flips - 1)))
			j = j ~ mask
		}
	}

	if trailing > 1 {
		for lead in 0 ..< leading {
			rm := Re(1.0)
			expt := inverse ? Re(math.TAU) : Re(-math.TAU)
			for step := 2; step <= axis_len; step *= 2 {
				rm *= 0.5
				wm := complex(math.cos(expt * rm), math.sin(expt * rm))
				for k in 0 ..< axis_len / step {
					w := E(1.0)
					for j in 0 ..< step/2 {
						off1 := (k * step + j + step/2) * trailing
						off2 := (k * step + j) * trailing
						// TODO: maybe explicitly use SIMD for long trailing axes
						for trail in 0 ..< trailing {
							t := w * span.ravel[lead * axis_len * trailing + off1 + trail]
							u :=     span.ravel[lead * axis_len * trailing + off2 + trail]
							span.ravel[lead * axis_len * trailing + off1 + trail] = u - t
							span.ravel[lead * axis_len * trailing + off2 + trail] = u + t
						}
						w *= wm
					}
				}
			}
		}
	} else {
		for lead in 0 ..< leading {
			rm := Re(1.0)
			expt := inverse ? Re(math.TAU) : Re(-math.TAU)
			for step := 2; step <= axis_len; step *= 2 {
				rm *= 0.5
				wm := complex(math.cos(expt * rm), math.sin(expt * rm))
				for k in 0 ..< axis_len / step {
					w := E(1.0)
					for j in 0 ..< step/2 {
						off1 := (k * step + j + step/2) * trailing
						off2 := (k * step + j) * trailing
						t := w * span.ravel[lead * axis_len + off1]
						u :=     span.ravel[lead * axis_len + off2]
						span.ravel[lead * axis_len + off1] = u - t
						span.ravel[lead * axis_len + off2] = u + t
						w *= wm
					}
				}
			}
		}
	}

	if normalize {
		normc := 1.0 / complex(math.sqrt(Re(axis_len)), 0.0)
		data := span.ravel[:leading * axis_len * trailing]
		for elem in &data { elem *= normc }
	}

	return
}
