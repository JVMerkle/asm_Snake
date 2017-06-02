; Initialize snake
CALL queue_init
MOV A, #0011011b ; Point (3,3)
CALL queue_push
MOV A, #0100011b ; Point (4,3)
CALL queue_push
MOV A, #00101011b ; Point (5,3)
CALL queue_push

main:
	NOP
	sjmp main

INCLUDE "queue.asm"

END