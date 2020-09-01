.data
  f: .asciiz "inputlista.txt"
  v: .skip 4

.text
main:
  ldr r0, =f
  mov r1, #0
  swi 0x66
  mov r5, r0     ;r5 handle
  swi 0x6c
  mov r6, r0     ;r6 first number
  ldr r2, =v
  mov r0, r5
  swi 0x6c
  mov r7, r0
  mov r8, #1
  bl loop
  swi 0x11


loop:
  mov r0, r5
  swi 0x6c
  cmp r0, r7
  movgt r7, r0
  add r8, r8, #1
  movgt r9, r8
  sub r6, r6, #1
  cmp r6, #0
  bgt loop
  mov r0, r5
  swi 0x68
  str r9, [r2]
  mov pc, lr

.end
