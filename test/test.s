.data
  n: .word 2

.text
  ldr r0, =n
  ldr r0, [r0]

  bl procedura
  swi 0x11

procedura:
  mov r3, #7

again:
  sub r3, r3, r0
  cmp r3, #0
  bgt again

  mov pc, lr

.end
