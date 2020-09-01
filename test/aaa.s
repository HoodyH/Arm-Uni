.data
	a: .word 0, 0, 0, 0
.text
	ldr r6, =a
	mov r0, #1
	bl aaa
	swi 0x11
aaa:
	cmp r0, #4
  mov r2, r1, lsl #2
	strle r0, [r6, r2]
	add r1, r1, #1
	add r0, r0, #1
	blt aaa

  .end
