
;es 2.1

.data
	a: .word 0, 0, 0, 0

.text
	ldr r6, =a
	add r0, r0, #1
	str r0, [r6] 
	add r0, r0, #1
	str r0, [r6, #4] 
	add r0, r0, #1
	str r0, [r6, #8]
	add r0, r0, #1
	str r0, [r6, #12]

	mov r0, #1
	bl aaa
	swi 0x11
	aaa:
	cmp r0, #4
	strle r0, [r6, r1]
	add r1, r1, #1
	add r0, r0, #1
	blt aaa


	ldr r6, =a
	ldr r0, [r6]
	mov r0, r0, lsl #2
	str r0, [r6]
	ldr r0, [r6, #4]
	mov r0, r0, lsl #2
	str r0, [r6, #4]
	ldr r0, [r6, #8]
	mov r0, r0, lsl #2
	str r0, [r6, #8]


	ldr r6, =a
	ldr r7, [r6]
	ldr r8, [r6, #4]
	ldr r9, [r6, #8]
	mov r0, r9
	mov r1, r7
	mov r2, r8
	str r0, [r6]
	str r1, [r6, #4]
	str r2, [r6, #8]





swi 0x11
.end