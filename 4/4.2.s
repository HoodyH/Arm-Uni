.data
	f0: .asciiz "numu.txt"
	v: .word 4, 6, 2
	l: .word 3

	.equ print, 0x6b
	.equ open, 0x66
	.equ close, 0x68

.text
	ldr r0, =f0
	ldr r1, =v
	ldr r2, =l
	ldr r2, [r2]

	bl write_first
	bl write_others
	swi 0x11
	

write_first:
	stmfd sp!, {r0-r1}

	mov r1, #1
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




