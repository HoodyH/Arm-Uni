
.text
	mov r1, #10		;argomento	(m)
	mov r0, #10		;base		(a)
	bl do
	mov r0, r2
	swi 0x11

do:
	cmp	r0, r1
	movle	r0, r0, lsl #1
	addle r2, r2, #1
	ble do

	mov pc, lr

.end
