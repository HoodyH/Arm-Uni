.data
  n: .asciiz "aaa.txt"
  v: .word 7, 4, 8
  l: .word 3

.text
  ldr r0, =n
  mov r1, #1
  swi 0x66
  ldr r1, =v
  ldr r2, =l
  ldr r2, [r2]
  bl write_numbers
  swi 0x11

write_numbers:
  mov r3, #0
  mov r10, r1
  mov r1, r2
  swi 0x6b
write_numbers_loop:
  ldr r1, [r10], #4
  swi 0x6b
  add r3, r3, #1
  cmp r3, r2
  blt write_numbers_loop
  swi 0x68
  mov pc, lr

.end
