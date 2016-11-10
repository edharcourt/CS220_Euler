	.arch armv8-a
	.text
	.align	2
	.global	euler
	.type	euler, %function

/*

int euler_in_asm_c() {

	int i = 0;
	int sum = 0;
    int x = 0;

loop:
    x = i - 1000;

	if (x == 0)
		goto end_loop;

	x = i % 3;

	if (x != 0)
		goto elseifcheck;

	sum = sum + i;
    goto endif;

elseifcheck:
	x = i % 5;

	if (i % 5 != 0)
		goto endif;

	sum = sum + i;

endif:
	i++;
	goto loop;
end_loop:
    return sum;
}

*/

// sdiv    quot, x, y
// msub    rem, quot, y, x
// ARM does not have a reminader instruction
// sdiv    w2, w0, w1
// msub    w0, w2, w1, w0
// sdiv    quot, x, y
// msub    rem, quot, y, x
//
// minuend - subtrahend = difference
//  To compute x % y
//    quot = x / y
//    rem  = x - quot * y

euler:
    mov x0, 0    // i
    mov x1, 0    // sum
    mov x2, 0    // x
    mov x3, 3
    mov x5, 5

loop:
    sub x2, x0, 1000
    cbz x2, end_loop
    sdiv x6, x0, x3        // compute r = i % 3
    msub x6, x6, x3, x0    // x0 - x6*x3
    cbnz x6, elseifcheck
    add x1, x1, x0
    b endif
elseifcheck:
    sdiv x6, x0, x5        // compute i % 5
    msub x6, x6, x5, x0
    cbnz x6, endif
    add x1, x1, x0

endif:
    add x0, x0, 1
    b loop

end_loop:
    mov x0, x1
    ret
