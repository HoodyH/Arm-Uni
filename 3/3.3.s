.data
	n: .word 5
	v: .word 4, 2, 7, 6

.text
	ldr r0, =n
	ldr r0, [r0]
	ldr r1, =v

	bl pari
	swi 0x11

pari:
	ldr r2, [r1], #4
	movs r2, r2, lsl #31
	streq r3, [r1, #-4]
	subs r0, r0, #1
	bne pari
	mov pc, lr
	
.end
