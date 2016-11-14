	.arch armv8-a

	.section	.rodata
	.align 3
fmt: .string "Da integer is %lld\n"

	.text
	.align	2
	.global	example1
	.type	example1, %function
example1:

	//	x = -39;
	//	y = 77;
	//  return x/3 + 7*y;

    //sub sp, sp, 8
    //str x30, [sp]

    // x29 is the frame pointer
    // x30 is the procedure link register
    stp x29, x30, [sp, -16]!

    mov x0, -39
    mov x1, 77
    mov x2, 3
    mov x3, 7
    sdiv x0, x0, x2
    mul x1, x3, x1
    add x0, x0, x1
    mov x1, x0
    //adrp x0, fmt
    //add  x0, x0, :lo12:fmt
    ldr x0, =fmt  // load address of fmt into x0
    bl printf
    ldp x29, x30, [sp], 16

    //ldr x30, [sp]
    //add sp, sp, 8
    ret

    // register x31 is the zero register
