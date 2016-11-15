	.arch armv8-a
	.text
	.align	2
	.global	int2bin_s
	.type	int2bin_s, %function

int2bin_s_fmt: .string "%lld"

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
    str x29, [sp, 0]   // push the frame pointer
    sub sp, sp, 8
    str x30, [sp, 0]   // push the link register (return address)

    sub sp, sp, 8
    str x19, [sp, 0]   // push x19 so we can use it across printf call
    mov x19, x0

    cbnz x19, int2bin_s_endif
    ldr x0, =int2bin_s_fmt
    mov x1, 0
    bl printf
    b int2bin_s_endif
    mov x0, x19
    lsr x0, x0, 1
    bl int2bin_s
    // left off here on call to printf

    ldr x0, =int2bin_s_fmt
    mov x2, 2



int2bin_s_endif:

    ldr x19, [sp, 0]    // pop x19
    add sp, sp, 8

    ldr x30, [sp, 0]    // pop x30
    add sp, sp, 8

    ldr x29, [sp, 0]    // pop x29
    add sp, sp, 8

    ret
