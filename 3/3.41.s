.data
  v: .word 2, 5, 8, 22, 67, 4, 9, 39, 7, 1
  l: .word 10
  p: .word 3

.text
  ldr r0, =v
  ldr r1, =l
  ldr r1, [r1]
  ldr r2, =p
  ldr r2, [r2]

  bl procedura
  swi 0x11

procedura:
  add r3, r2, #1
  mov r4, r3

loop:
  sub r3, r3, r2
  cmp r3, #0
  bgt loop
  streq r3, [r0, r4, lsl #2]
  cmp r4, r1
  addlt r3, r4, #1
  blt loop
  mov pc, lr

.end
