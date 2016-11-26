	.arch armv8-a
	.global	int2bin_s
	.type	int2bin_s, %function
    .global EnableCachesEL1

    .section	.rodata
	.align 3

int2bin_s_fmt: .string "%lld"

	.text
	.align	2

    .type EnableCachesEL1, "function"
EnableCachesEL1:

    mrs x0, SCTLR_EL1
    orr x0, x0, (1 << 12)
    orr x0, x0, (1 << 2)
    msr     SCTLR_EL1, x0

    isb
    ret


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
    sub sp, sp, #32     // SP must be quad word aligned;  sp % 16 == 0
    str x29, [sp, #0]   // push the frame pointer
    str x30, [sp, #8]   // push the link register (return address)
    str x19, [sp, #16]   // push arg 0 into x19 so we can use it across printf call
    mov x19, x0

    cmp x19, 0
    b.ne int2bin_s_else
//    cbnz x19, int2bin_s_else
    ldr x0, =int2bin_s_fmt
    mov x1, 0
    bl printf
    b int2bin_s_endif

int2bin_s_else:
    mov x0, x19
    lsr x0, x0, 1
    bl int2bin_s

    // compute x % 2
    lsr x9, x19, 1
    mov x10, 2
    msub x1, x9, x10, x19
    ldr x0, =int2bin_s_fmt
    bl printf

int2bin_s_endif:

    ldr x19, [sp, #16]    // pop x19
    ldr x30, [sp, #8]    // pop x30
    ldr x29, [sp, #0]    // pop x29
    add  sp, sp, #32
    ret
