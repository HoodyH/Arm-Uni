.data
stringa:
.asciiz "input_list.txt"
output:
.skip 4
.text
main:
ldr r0, =stringa ; string address in r0
mov r1, #0 ; read mode
swi 0x66 ; open file in read mode
mov r2, r0 ; save file handler
swi 0x6c ; read number of integers
mov r3, r0 ; save number of integers in r3
mov r5, #0x80000000 ; start with minInt in r5
mov r4, #0 ; current element in r4
mov r6, #0xFFFFFFFF ; min element in r6
loop:
subs r3, r3, #1 ; decrement r3 and set status
blt exit ; exit if negative
add r4, r4, #1 ; increment r4
mov r0, r2 ; load file handler
swi 0x6c ; read integer from file
cmp r5, r0 ; if r0-r5 < 0..
movlt r5, r0 ; ..then update minimum..
movlt r6, r4 ; ..and its index
b loop ; next element
exit:
mov r0, r2 ; load input file handler
swi 0x68 ; close file
ldr r0, =output ; output address in r0
str r6, [r0] ; save min element index
;; end
swi 0x11 ; exit
.end
