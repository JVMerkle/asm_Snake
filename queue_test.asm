; Queue Tests
; Expected string in memory
; from address 0x20: 22 25 EF FF FF BE

main:
	CALL queue_init
	MOV A,#0xDE
	CALL queue_push
	MOV A,#0xAD
	CALL queue_push
	MOV A,#0xBE
	CALL queue_push
	MOV A,#0xEF
	CALL queue_push
	CALL queue_pop
	CALL queue_pop
	NOP
loop:	
	NOP
	sjmp loop

INCLUDE "queue.asm"

END