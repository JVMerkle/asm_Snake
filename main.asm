; Provisorische main
main:
	CALL queue_init
	MOV A, #0xDE
	CALL queue_push
	CALL queue_pop
loop:	
	NOP
	sjmp loop

INCLUDE "queue.asm"

END