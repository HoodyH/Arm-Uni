.data
	
	v: .word 4, 2, 7, 8, 3, 9, 4
	n: .word 7 ;
	p: .word 2 ;valore

.text
	ldr r0, =v
	ldr r1, =n
	ldr r1, [r1]
	ldr r2, =p
	ldr r2, [r2]

	;stmfd sp!, {lr, r4-r9}
	bl procedura

	swi 0x11

procedura:
	sub r1, r1, #1
	ldr r3, [r0, r1, lsl #2]

multiplo:
	sub r3, r3, r2
	cmp r3, #0
	bgt multiplo

	streq r3, [r0, r1, lsl #2]

	cmp r1, #0
	moveq pc, lr
	b procedura


.end
