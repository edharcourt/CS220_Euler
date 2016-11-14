	.arch armv8-a
	.text
	.align	2
	.global	int2bin_s
	.type	int2bin_s, %function

/*
static void int2bin(unsigned long long x) {
    if (x == 0)
    	printf("0");
    else {
        int2bin(x/2);
        printf("%lld", x % 2);
    }
    return;
}
*/


int2bin_s:
    sub sp, sp, 8
    str x29, [sp, 0]   // save the frame pointer
    sub sp, sp, 8
    str x30, [sp, 0]   // save the link register (return address)



    ret
