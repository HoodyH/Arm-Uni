.skip 64

.text

mov r0, #8				;dimensione array
ldr r1, =0x1060			;carico manualmente la locazione di memoria
add r1, r1, r0, lsl #2


do:
str r0, [r1] , #-4
subs r0, r0, #1
bpl do
swi 0x11
.end