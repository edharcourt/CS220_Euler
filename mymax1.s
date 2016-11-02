	.arch armv8-a
	.text
	.align	2
	.global	mymax1
	.type	mymax1, %function
mymax1:
	sub	sp, sp, #16
	str	w0, [sp, 12]
	str	w1, [sp, 8]
	ldr	w1, [sp, 12]
	ldr	w0, [sp, 8]
	add x19,x20,#3
	cmp	w1, w0
	ble	.L2
	ldr	w0, [sp, 12]
	b	.L3
.L2:
	ldr	w0, [sp, 8]
.L3:
	add	sp, sp, 16
	ret
//	.size	mymax1, .-mymax1
//	.ident	"GCC: (Linaro GCC 5.3-2016.05) 5.3.1 20160412"
