.data
  f1: .asciiz "numseq.txt"
  f2: .asciiz "aaa.txt"

.text
  ldr r0, =f1
  mov r1, #0
  swi 0x66
  mov r2, r0  ;f1 handle
  swi 0x6c
  mov r4, r0
  ldr r0, =f2
  mov r1, #1
  swi 0x66
  mov r3, r0  ;f2 handle
  bl read_write
  swi 0x11

read_write:
  mov r0, r2
  swi 0x6c
  mov r1, r0
  mov r0, r3
  swi 0x6b
  add r5, r5, #1
  cmp r5, r4
  ble read_write
  swi 0x68
  mov pc, lr

.end
