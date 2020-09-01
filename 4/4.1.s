.data
	f0: .asciiz "num.txt"

	.equ read, 0x6c
	.equ open, 0x66
	.equ close, 0x68

.text
	ldr r0, =f0
	mov r1, #0
	bl read_number_one

	swi 0x11

read_number_one:
	stmfd sp!, {r4-r14}
	
	swi open
	mov r4, r0
	swi read
	mov r1, r0
	ldr r5, =f0
  
read_numbers_loop:
	mov r0, r4
	swi read
	str r0, [r5], #4

	add r6, r6, #1
	cmp r6, r1
	blt read_numbers_loop

	mov r0, r5

	ldmfd sp!, {r4-r14}
	swi close
	mov pc, lr
