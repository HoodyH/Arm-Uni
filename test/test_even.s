.data
  n: .word -5
.text
  ldr r0, =n
  ldr r0, [r0]
  mov r1, r0, lsl #31
  swi 0x11
