	.arch armv8-a
	.text
	.align	2
	.global	array_sum
	.type	array_sum, %function

array_sum:
    // x0 contains address of the array
    // x1 contains the number of items in the array
    mov x2, 0  // sum
    mov x3, 0  // i

array_sum_while:
    cmp x3, x1
    b.eq array_sum_end_while
    ldr x4, [x0,#0]
    add x4, x4, #8
    add x2, x2, x4
    add x3, x3, 1
    b array_sum_while
array_sum_end_while:
    mov x0, x2
    ret
