; Queue Tests
; Expected string in memory
; from address 0x20: 26 25 FF FF FF BE EF
; R3 = AD
; R2 = DE

main:
	CALL queue_init
	MOV A, #0xDE
	CALL queue_push
	MOV A, #0xAD
	CALL queue_push
	MOV A, #0xBE
	CALL queue_push
	MOV A, #0xEF
	CALL queue_push
	CALL queue_pop
	MOV R2, A
	CALL queue_pop
	MOV R3, A

LJMP end

INCLUDE "queue.asm"

end:
	END