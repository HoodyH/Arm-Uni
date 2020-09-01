.data
	n: .word 12
	v: .skip 48

.text
	ldr r0, =v
	ldr r1, =n
	ldr r1, [r1]

	bl enumera
  bl procedura2

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

procedura2:
  str r3, [r0, #4]
  mov r4, #2

loop2:
  ldr r3, [r0, r4, lsl #2]
  add r6, r4, #1
  cmp r3, #0
  addeq r4, r4, #1
  beq loop2
loop3:
  ldr r5, [r0, r6, lsl #2]
loop4:
  sub r5, r5, r3
  cmp r5, #0
  bgt loop4
  streq r5, [r0, r6, lsl #2]
  add r6, r6, #1
  cmp r6, r1
  blt loop3
  add r4, r4, #1
  cmp r4, r1
  blt loop2
  mov pc, lr

.end



.end
