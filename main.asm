; Provisorische main
main:
	CALL queue_init
	MOV 20H,#0x00
	MOV R0,@QUEUE_HEAD
	MOV P0,R0
loop:	
	NOP
	sjmp loop

INCLUDE "queue.inc"

END