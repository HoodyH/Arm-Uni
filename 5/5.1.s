.data
  n: .word 5, 7, 2, 8
  l: .word 4

.text
  ldr r0, =n
  ldr r1, =l
  ldr r1, [r1]

  bl create_list
  swi 0x11

create_list:
  stmfd sp!, {r4-r9}

  mov r4, r0

  mov r0, #8
  swi 0x12
  mov r5, #0x0000
  str r5, [r0]
  sub r1, r1, #1
  ldr r6, [r4, r1, lsl #2]
  str r6, [r0, #4]

add_in_list:
  mov r5, r0
  mov r0, #8
  swi 0x12
  str r5, [r0]
  sub r1, r1, #1
  ldr r6, [r4, r1, lsl #2]
  str r6, [r0, #4]

  cmp r1, #0
  bgt add_in_list

  ldmfd sp!, {r4-r9}
  mov pc, lr

.end
































list:
  stmfd sp!, {r4-r8}
  mov r4, r0
  mov r0, #8
  swi 0x12
  mov r5, r0
  mov r6, r0

  list_loop:
  sub r1, r1, #1
  cmp r1, #0
  movgt r0, #8
  swigt 0x12
  strgt r0, [r6], #4
  streq r8, [r6], #4
  ldr r7, [r4], #4
  str r7, [r6]
  movgt r6, r0
  bgt list_loop

  mov r0, r5
  ldmfd sp!, {r4-r8}
output:
  stmfd sp!, {r4-r8}
  cmp r0, #0
  moveq pc, lr
  ldr r4, [r0], #4   ;address list
  ldr r5, [r0]       ;integer
  mov r0, #1
  mov r1, r5
  swi 0x6b
  mov r0, #10
  swi 0x00
  mov r0, r4
  cmp r4, #0
  b output

  mov pc, lr

.end
