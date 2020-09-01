.data
	n: .word 7
	v: .word 4, 2, 7, 8, 3, 9, 4
	p: .word 2

.text
	ldr r0, =v
	ldr r1, =n
	ldr r1, [r1]
	ldr r2, =p
	ldr r2, [r2]

	bl procedura

	swi 0x11

procedura:
	;stmfd sp!, {lr, r4-r9}
	add r3, r2, #1

procedura2:
	mov r4, r3

loop:
	sub r3, r3, r2
	cmp r3, #0
	bgt loop
	streq r3, [r0, r4, lsl #2]
	add r3, r4, #1
	cmp r3, r1
	ble procedura2

 ;ldmfd sp!, {lr, r4-r9}
	mov pc, lr

.end
