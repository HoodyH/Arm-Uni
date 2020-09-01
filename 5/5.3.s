.data
  n: .word 3, 6, -4, -5, 8
  l: .word 5
  v: .skip 20

.text
  ldr r0, =n
  ldr r1, =l
  ldr r1, [r1]
  ldr r3, =v

  bl procedura
  swi 0x11

procedura:
  ldr r2, [r0, r8]
  add r8, r8, #4
  cmp r2, #0
  strlt r2, [r0, r9]
  addlt r9, r9, #4
  strge r2, [r3, r7]
  addge r7, r7, #4
  addge r5, r5, #1
  sub r1, r1, #1
  cmp r1, #0
  bgt procedura
loop2:
  ldr r4, [r3], #4
  str r4, [r0, r9]
  add r9, r9, #4
  sub r5, r5, #1
  cmp r5, #0
  bgt loop2
  mov pc, lr

.end
