	.arch armv8-a
	.text
	.align	2
	.global	popcount
	.type	popcount, %function

/*
int popcount_c(long long x) {
	int sum = 0;
	while (x != 0) {
		sum = sum + (x & 1);
		x = x >> 1;
	}
	return sum;
}
*/


popcount:
    // x0 contain integer we are counting the 1s of
    mov x1, 0   // x1 will be our counter
popcount_while:
    cbz x0, popcount_endloop
    and x2, x0, 1
    add x1, x1, x2
    lsr x0, x0, 1
    b popcount_while

popcount_endloop:
    mov x0, x1
    ret
