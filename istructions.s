
;somma

add r0, r1, r2				;scrive sul registro r0 la somma dei contenuti di r1,r2
add r0, r2, #7				;somma con il decimale 7
add r0, r2,	#0xF			;somma con l'ex F ossia decimale 15

sub  --> sottrazione
rsb  --> reverse sub, ossia somma invertitamente i 2 valori

;moltiplicazione, la moltiplicazione non ammette valori costanti ma solo registri
mul r0, r2, r3
;moltiplicazione estesa a 64bit
;deposita in r1 (cifre pi� significative) e in r0 (cifre meno significative).
umull r0, r1, r2, r4		;prodotto unsigned di r2 e r4; deposita il risultato a 64 bit nei registri r1  e r0.
smull r0, r1, r2, r4		;calcola il prodotto in complemento a due (signed) tra r2 e r4, deposita il risultato a 64 bit nei registri r1 e r0.
;non esistono istruzioni per la divisione di interi a 64 bit
;aritmetica floating-point disponibile attivando la Floating Point Unit (FPU): NEON & VFP programming.

;add with carry
adc r0, r2, r3				;r0 = r2 + r3 + c, somma il bit di riporto c (carry) generato dall�istruzione precedente
							;permettendo somme su 64 bit

;sub with carry
sbc r0, r2, r3				;r0 = r2 - r3 + c - 1,

;reverse sub with carry
rsc r0, r2, r3				;r0 = r3 - r2 + c - 1.

;operazioni logiche
and r0, r2, r3				;and bit a bit tra due registri
and r0, r2, #5				;secondo argomento costante
orr r0, r2, r3				;or
eor r0, r2, #5				;exclusive or
bic r0, r2, r3				;bit clear (r0 = r2 and (not r3))
mov r0, r2					;funzione identit�, move
mvn r0, r2					;not, move negate.

;L�ultimo argomento di ogni operazione aritmetico-logica (esclusa la moltiplicazione) pu� essere una costante numerica
-DECIMALE		#15
-ESADECIMALE	#0xF

;In ogni istruzione aritmetico-logica, se l�ultimo argomento � un registro a questo si pu� applicare un perazione di shift o rotate
add r0, r1, r2, lsl #2		;esegue r0 = r1 + (r2 << 2).
;la costante di shift ammessa � [0,31]
;� possibile specificare il numero di posizioni da traslare anche come registro

;tipi di shift
lsl							;logical shift left
lsr							;logical shift right, si inserisce a sinistra il bit di segno, esegue una divisione per una potenza di 2 in complemento a 2.
asr							;arithmetic shift right,
ror							;rotate right, i bit eliminati a destra rientrano
rrx							;rotate right extended, ruota a destra di una singola posizione coinvolgendo il bit di carry, non ammette argomento

;trasferimenti dalla memoria
ldr r3, [r0]				;copia nel registro r3 4 byte a partire dall�indirizzo contenuto in r0
ldr r3, [r0, #4]			;copia nel registro r3 4 byte a partire dall�indirizzo in r0+4 (base + offset)
ldr r3, [r0, r1, lsl r2]	;copia nel registro r3 4 byte a partire dall�indirizzo in r0 + r1 traslato del numero di bit contenuto in r2 (base + shifted register).

;modalit� di indirizzamento
ldr r3, [r0, #8]!			;pre-incremento r0 = r0 + 8; r3 = [r0]
ldr r3, [r1, r0]!			;pre-incremento da registro r1 = r1 + r0; r3 = [r1]
ldr r3, [r0], #8			;post-incremento r3 = [r0]; r0 = r0 + 8
= [r1]ldr r3, [r1], r0			;post-incremento da registro r3 ; r1 = r1 + r0
ldr r3, [r1, -r0]			;offset da registron r3 = [r1 - r0]
ldr r3, [r1, r0, lsl #2]	;registro traslato r3 = [r1 + 4 * r0].
ldr r1, =0x1060				;carico manualmente la locazione di memoria in r1

;ldr legge una parola (4 byte consecutivi in memoria) legge solo parole allineate
:l�indirizzo del primo byte � un multiplo di 4


;trasferimenti verso la memoria
str r0, [r4,#8]				;modalit� per str sono le stesse per ldr
;un singolo bite
ldrb						;load register byte (logico)
ldrsb						;load register signed byte (aritmetico)
strb						;store byte
;una half-word (2byte)
ldrh						;load register half word
ldrsh						;load register signed half word
strh						;store half word

;array, allocati nella memoria principale in locazioni consecutive
;calcolare la sua posizione in memoria:
;posizione = indirizzo base + offset
;offset = indice  dimensione parola

;-----------------------------------------------------------------
;sintassi del programma, un programma oltre alle istruzioni contiete
;etichette, che permettono di associare un idetificatore a un indirizzo (seguite da :)
;dirtettive, indicazioni all'assemblatore (precedute da un .)
;le direttive principali sono:
.text						;quello che segue � il testo del programma
.data						;quello che segue sono dati da inserire in memoria
.globl						;rende l'etichetta che segue visibile agli altri pezzi di codice
.end						;specifica la fine del modulo sorgente
;direttive di rappresentazione dati
.word						;ogni numero interno dimensione 4byte
.byte						;ogni numero interno dimensione 1byte, 8bit
.ascii						;"testo tra virgolette"
.asciiz						;"altro esempio" si aggiunge un byte 0 per marcare fine stringa
.skip 64					;vengono allocati 64byte, inizializzati a 0. quindi 16 locazioni da 32bit

;pseudo_istrudione
ldr r0, =n					;carica in r0 l�indirizzo di memoria etichettato con n: es.: (n: .word -1, 2, 3, 4)
;L�uso di pseudo-istruzioni semplifica la programmazione senza astrarre dal livello assembly.

;-----------------------------------------------------------------
;controllo di flusso, In assembly i meccanismi di controllo del flusso sono elementari:
-salto incondizionato		;salta all�istruzione etichettata con etichetta

-salto condizionato			;le istruzioni sono eseguite sotto condizione
;le condizioni dipendono da 4 bit contenuti nel	registro di stato cprs
;Inserendo il suffisso s al nome di un�istruzione, il registro di stato viene modificato a seguito della sua esecuzione.
;La condizione pu� essere specificata da un ulteriore suffisso di due lettere. (CD "condition code")
;esempio
subs r0, r1, r2				;modifica il registro cprs
addeq r2, r2, #1			;Se il risultato di subs � uguale a zero viene esuguita dato che � soddisfatta la condizione EQ "equal 0"
beq label					;idem qui, salta alla label se subs = 0

;Condizioni, considerano 4 bit (flag)
Z		;bit di zero
C		;bit di carry
N		;bit negative
V		;bit di overflow

;Suffix		Description								Flags
eq			Equal / equals zero						Z
ne			Not equal								!Z
cs / hs		Carry set / uns. higher or same			C
cc / lo		Carry clear / unsigned lower			!C
mi			Minus / negative						N
pl			Plus / positive or zero					!N
vs			Overflow								V
vc			No overflow								!V
hi			Unsigned higher							C and !Z
ls			Unsigned lower or same					!C or Z
ge			Signed greater than or equal			N == V
lt			Signed less than						N != V
gt			Signed greater than						!Z and(N == V)
le			Signed less than or equal				Z or (N != V)
al			Always (default)						any

;istruzioni di confronto
cmp r0, r1					;confronta r0 con r1 ed aggiorna i flag
cmn r0, r1					;confronta r0 con -r1
tst r0, r1					;aggiorna i flag come ands r r0 r1
teq r0, r1					;aggiorna i flag come eors r r0 r1.

;istruzioni di test
;(if-then-else)
Eval Bool					;cmp r1, r2
b_cond then					;beq then
Com2						;mov r1, r2
b fine						;b fine
then: Com1					;add r1, r1, #1
fine:
;codice alternativo senza salti:
cmp r1, r2
addeq r1, r1, #1
movne r1, r2.

;(ciclo while)
while: cmp r1, #0
beq fine
sub r1, r1, #1				;esempio istruzioni
add r2, r2, #1				;esempio istruzioni
b while
fine:

;Assembly e linguaggio macchina, esiste una corrispondenza 1 a 1 tra assembly e istruzioni macchina
subs r1, r2, r3				;corrisponde:
cond  opcode  S rn	 rd	  shift		2arg
al	  sub	  t r2	 r1	  lsl 0		r3
1110  0000010 1 0010 0001 00000000  0011
In ARM, ogni istruzione macchina utilizza 32 bit.

;Istruzione di salto
beq label					;riserva 24 bit per specificare l'indirizzo di memoria a cui saltare
;il salto � relativo, si specificano quante istruzioni (di 32bit) vanno saltate in avanti o indietro
;quindi al registro r15(program counter) viene sommato un numero intero ("ETICHETTA" 23 bit con segno)
;indirizzi raggiungibili: +-2^23*4 = +-32 MB.

;-----------------------------------------------------------------
;Funzioni, metodi, subroutine
;-necessarie per strutturare e modularizzare il prgramma.
;-permettono il riutilizzo del codice,
;-necessarie per la ricorsione

;procedure
;una chiamata salta alla parte di codice della procedura

bl goto						;salta all'indirizzo memorizzando l'indirizzo di ritorno in LR(r14)

goto:
;esegue quello che deve fare
mov pc, lr					;rientro dalla procedura, copia in PC l'indirizzo contenuto in LR

;Ogni procedura necessita di un�area di memoria per:
;mantenere le variabili locali, salvare i registri, acquisire i parametri e restituire i risultati.
;Tutta l�area � allocata in un frame dello stack. Chiamate innestate generano una pila di frame consecutivi:
;una chiamata di procedura alloca un nuovo frame, un�uscita dalla procedura libera l�ultimo frame.
;LIFO last-in first-out, la procedura chiamata pi� recentemente � la prima a terminare.

;Passaggio di parametri e risultati
r0,r1,r2,r3					;utilizzati per il passaggio di parametri
r0,r1						;vengono utilizzati per restituite i risultati al programma chiamante
;eventuali parametri aggiuntivi devono essere passati attraverso la memoria
;il programma principale e le procedure agiscono sugli stessi registri, bisogna evitare interferenze improprie.

stmfd sp!, {r4-r5}			;salva registri multipli
ldmfd sp!, {r4-r5}			;carica registri multipli
stmfd sp!, {r0, r4-r6, r3}	;salva i registri in locazioni decrescenti di memoria,
							;aggiorna sp (stach pointer) alla locazione contenente l�ultimo valore inserito (r1 = r13 - 5*4)
ldmfd sp!, {r0, r4-r6, r3}	;ripristina il contenuto di tutti i registri (compreso sp).
;Il comando stm � spesso usato per manipolare lo stack.	Il registro r13 punta alla cima dello stack.
stmia r13!, {...} incrementa da sp
stmib r13!, {...} incrementa da sp+4
stmda r13!, {...} decrementa da sp
stmdb r13!, {...} decrementa da sp-4.
;Esistono i suffissi corrispondenti: fd, fu, ed, eu.

;salvataggio dei registri, per convenzione i registri r4-r14 devono essere preservati,
;quindi se una procedura vuole utilizzarili li salva in memoria prima del loro utilizzo
;e ne ripristina il valore originale prima di restituire il controllo al programma chiamante.

Esempio salvataggio dalla procedura
main:
...
add r4, r4, #1
mov r0, #5
bl fattoriale
...

fattoriale:
...
stmfd sp!, {r4-r5}			;salvo nella procedura
...
move r4, r0
...
ldmfd sp!, {r4-r5}
mov pc, lr

;dualmente i resistri r0-r3 sono considerati modificabili dalle procedure,
;se contengono dati utili il programma chiamante li salva in memoria prima di chiamare una procedura
;e li ripristina dopo la chiamata.

Esempio salvataggio dal programma chiamante
main:
...
add r2, r2, #1
mov r0, #5
stmfd sp!, {r2,r3}			;salvo nella procedura
bl fattoriale
ldmfd sp!, {r2-r3}			;ricarico nella procedura
...

fattoriale:
...
move r2, r0
...
mov pc, lr

;utilizzo dello stack
;per convenzione � gestito mediante il registro 13 (SP), che punta alla prima parola libera oltre la cima dello stack.
;1) una procedura salva i registi nel nuovo frame.
;2) la stessa procedura prima di rientrare svuota il frame ripristinando le condizioni iniziali
;per convenzione lo stack cresce verso il basso.

; calcolo di fattoriale(n) = n(n-1)...
.data
valore: .word 4
.text
main:
ldr r4, =valore
ldr r0, [r4]				;carica il dato n in r0
bl fattoriale				;chiamata di funzione
str r0, [r4]				;salva il risultato
swi 0x11					;s.o. ferma il programma
.end

;soluzione iterativa
fattoriale:
mov r1, #1					;iniz. contatore
mov r2, #1					;iniz. risultato parziale

loop:
cmp r1, r0					;inizio ciclo
bge exit
add r1, r1, #1				;agg. contatore
mul r2, r1, r2				;agg. risul. parz.
b loop

exit:
mov r0, r2
mov pc, lr

;stessa soluzione ma ricorsiva
fattoriale:
stmfd sp!, {r4, lr}			;salva registri
mov r4, r0
sub r0, r0, #1
cmp r0, #1					;se r0 == 1 ...
be skip						;svuota lo stack
bl fattoriale				;chiamata ricorsiva

skip:
mul r0, r4, r0				;accumula risultato
ldmfd sp!, {r4, lr}			;ripristina registri
mov pc, lr					;rientra dalla procedura

;uso della memoria in arm sim
;Valori modificabili con opportune direttive di assemblaggio.
0x0000 - 0x0FFF				;riservata al sistema operativo
0x1000 - 0xNNNN				;codice del programma (.text), costanti (.data)
0xNNNN - 0x5400				;stack per chiamate di procedura
0x5400 - 0x11400			;heap per allocazione di strutture dati dinamiche

;Il registro r13, sp viene inizializzato a 0x5400.
;Il registro r15, pc viene inizializzato a 0x1000.


:armsim software interupt
;Chiama una procedura eseguita dal Sistema Operativo identificata dall�argomento 0xCODE.
;Questa chiamata � diversa dalle chiamate standard per garantire i meccanismi di protezione
;modalit� system: esegue qualunque operazione
;modalit� user: esegue solo alcune operazioni
la chiamata system � possibile solo se invocata tamite swi
operazione			cod.	argomento
print_char			0x00	r0 char
print_string		0x02	r0 string address
exit				0x11
allocate			0x12	r0 size --> address
;operazioni di accesso a file
open				0x66	r0 name handle, r1 mode
close				0x68	r0 handle
write str			0x69	r0 handle, r1 string
read str			0x6a	r0 handle, r1 string, r2 size
write int			0x6b	r0 handle, r1 integer
read int			0x6c	r0 handle --> integer

il file pu� essere aperto in 3 modalit�
-input (mode 0) solo lettura
-output (mode 1) lettura e scrittura, sovrascrive il contenuto
-append (mode 2) lettura e scrittura, accoda il contenuto

definire costanti con la direttiva .equ

swi PrintInt

;dare nomi simbolici ai registri definiti tramite .req:
lo .req r0
hi .req r1
adds lo, lo, r2
adcs1 hi, r3, lo
;questo trucchetto migliora la leggibilit�

l'etichetta _start: mov r0..
;forza l'inizio da una determinata istruzione, questa dipende dagli assembler in quanto non � standard

;Le matrici
;vengono linearizzate ovvero ricondotte a strutture tipo array
;in due modalit� coniderando M[i, j], i->[0, m - 1], j->[0, n - 1].
;Linearizzazione per riga (i  n + j)
;Linearizzazione per colonna (j  m + i)

Nella memorizzazione per righe, se l�elemento M[i; j]
occupa l�indirizzo x allora
l�elemento M[i +d; j] occupa l�indirizzo x +n d
l�elemento M[i; j + d] occupa l�indirizzo x + d.

;Strutture dati dinamiche
;i nodi vengono salvati in modo non consecutivo nello stack
;i nodi sono collegati tra di loro attraverso puntatori
;l'ultimo elemento deve avere il puntatore null 0x00000000

;Un nodo è creato con swi 0x12 che alloca uno spazio nello heap che è una regione della memoria allocabile a runtime
;r0= definisce il numero di byte da allocare
;e sempre in r0 viene restituito l'indirizzo iniziale della memoria allorcata
