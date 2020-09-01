.data
  n: .word 3, 6, 8, 10
  l: .word 4

.text
  ldr r0, =n
  ldr r1, =l
  ldr r1, [r1]
  bl procedura
  swi 0x11

procedura:
  mov r4, r0
  mov r0, #8
  swi 0x12
  mov r5, r0
  mov r6, r0

list:
  sub r1, r1, #1
  cmp r1, #0
  streq r8, [r5], #4
  movgt r0, #8
  swigt 0x12
  strgt r0, [r5], #4
  ldr r3, [r4], #4
  str r3, [r5]
  movgt r5, r0
  bgt list
  mov r0, r6
  mov pc, lr
