.data
	f0: .asciiz "num.txt"
	f1: .asciiz "numu.txt"

	.equ print, 0x6b
	.equ read, 0x6c
	.equ open, 0x66
	.equ close, 0x68

.text

	ldr r0, =f0
	mov r1, #0
	bl read_number_one

	mov r2, r1
	mov r1, r0
	ldr r0, =f1

	bl write_first
	bl write_others

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
	str r0, [r5, r6, lsl #2]

	add r6, r6, #1
	cmp r6, r1
	blt read_numbers_loop

	mov r0, r5

	ldmfd sp!, {r4-r14}
	swi close
	mov pc, lr




write_first:
	stmfd sp!, {r0-r1}

	mov r1, #2
	swi open
	mov r1, r2
	swi print
	swi close
	
	ldmfd sp!, {r0-r1}
	mov pc, lr


write_others:
	mov r3, r1
	mov r1, #2
	swi open
	
loop:
	ldr r1, [r3], #4
	swi print
	sub r2, r2, #1
	cmp r2, #0
	bgt loop
	swi close
	mov pc, lr


.end
