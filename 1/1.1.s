.data

   n: .word -1, 2, 3, 4 ;etichetta, parola a 32bit, numeri

.text

;addizione tra membri
   ldr r5, = n ;carico indirizzo di memori di n
   ldr r0, [r5] ;carico il primo numero quindi il numero 18 in r0
   ldr r6, [r5, #4] ;carico il secondo numero in r6
   add r0, r0, r6 ;destinazione, addendo, addendo
   ldr r6, [r5, #8] ;carico il terzo numero in r6
   add r0, r0, r6 ; rifaccio la somma
   ldr r6, [r5, #12]
   add r0, r0, r6 ;in r1 cè il risulato

;media
   mov r1, r0, lsr #2  ;serve per fare la media ma è da capire il perche carica il risultato in r1

;elevamento
   mov r2, #1
   mov r2, r2, lsl #10
   add r2, r2, #1
   ldr r7, [r5]
   mul r2, r7, r2

;resto della divisione
   mov r3, r7, lsr #4 ;shift a destra inteso come 4*4 essendo un elevamento
   mov r3, r3, lsl #4 ;shift a sinistra	quindi elevamento	
   sub r3, r7, r3

;positivo negativo
   cmp r7, #0
   movmi r4, #1

;poblema 1.2
   mov r0, #0x1000
   add r0, r0, #0x10
   ldr r1, [r0]
   str r1, [r0, #8]

   ;mov r0, #0
   ;mov r0, #1
   ;mov r0, #2

 ;exit
   swi 0x11
 .end