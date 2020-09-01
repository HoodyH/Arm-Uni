;es 2.1
.data
	a: .word 0, 0, 0, 0
	b: .word 2, 3, 4
.text

;programma 2.1
	ldr r6, =a

	add r0, r0, #1
	str r0, [r6] , r0, lsl #2 
	add r0, r0, #1
	str r0, [r6] , r0, lsl #2 
	add r0, r0, #1
	str r0, [r6] , r0, lsl #2
	add r0, r0, #1
	str r0, [r6] , r0, lsl #2 

;programma 2.2
	ldr r7, =b

	ldr r1, [r7]
	mov r1, r1, lsl #2
	str r1, [r7]

	ldr r1, [r7, #4]
	mov r1, r1, lsl #2
	str r1, [r7, #4]

	ldr r1, [r7, #8]
	mov r1, r1, lsl #2
	str r1, [r7, #8]

;programma 2.3

	ldr r2, [r7]
	ldr r3, [r7, #4]
	str r3, [r7]
	ldr r3, [r7, #8]
	str r3, [r7, #4]
	str r2, [r7, #8]

;programma 2.4
	
	mov r8, #11 ;questo numero è il dividendo

	do:
	subpls r8, r8, #2 ;questo numero è il divisore
	addpl r9, r9, #1
	bpl do

	swi 0x11
.end