.data
  v: .word 2, 3, 5, 7, 8
  n: .word 5

.text
  ldr r0, =v
  ldr r1, =n
  ldr r1, [r1]
  mov r2, #0
  bl loop
  swi 0x11

loop:
  ldr r3, [r0, r2, lsl #2]
  mov r4, r3, lsl #31
  cmp r4, #0
  moveq r3, #0
  str r3, [r0, r2, lsl #2]
  add r2, r2, #1
  cmp r2, r1
  ble loop
  mov pc, lr
