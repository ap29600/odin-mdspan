package mdspan
import "core:fmt"

display :: proc (span: $S/Span($E, $R)) {
	fmt.printf("Span({}, {}) {} {{\n", typeid_of(E), R, span.shape)
	when R == 0 {
		fmt.printf("{:v}\n", span.ravel[0])
	} else {
		c := [R]int{}
		i := 0
		outer: for {
			fmt.printf("{: 4v}", span.ravel[i])
			i += 1
			c[R-1] += 1
			fmt.print(',')
			count := 0
			for j := R-1; c[j] == span.shape[j]; j -=1 {
				if j == 0 {
					fmt.println()
					break outer
				}
				count += 1
				c[j] = 0
				c[j-1] += 1
			}
			for j in 0 ..< count {
				fmt.println()
			}
		}
	}
	fmt.println('}')
}
