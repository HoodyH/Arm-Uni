.data
	n: .word 12
	v: .skip 48

.text
	ldr r0, =v
	ldr r1, =n
	ldr r1, [r1]

	bl enumera

	swi 0x11

enumera:
	;stmfd sp!, {lr, r4-r9}
	mov r2, #0 ;preparo il contatore

again:
	cmp r2, r1
	strne r2, [r0, r2, lsl #2]
	addne r2, r2, #1
	bne again

	;ldmfd sp!, {lr, r4-r9}
	mov pc, lr

.end
