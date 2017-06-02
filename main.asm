;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; DEFINITIONS

; R7: Direction Byte set by ISR

ORG 0000h
LJMP init

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; ISRs

; ISR EX0
ORG 0003h
MOV A,P2
ANL A, #0x0F ; Mask the 4 buttons
CJNE A, 0x0F, valid ; The interrupt is invalid when no button is pressed
RETI
valid:
	MOV R7, A
RETI

init:

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; INTERRUPTS

SETB EA ; Global Interrupts
SETB EX0 ; External Interrupt

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; INITIALISATION

; Init Snake
CALL queue_init
MOV A, #0011011b ; Point (3,3)
CALL queue_push
MOV A, #0100011b ; Point (4,3)
CALL queue_push
MOV A, #00101011b ; Point (5,3)
CALL queue_push

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; MAIN

main:
	NOP

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; INCLUDES

LJMP end

INCLUDE "queue.asm"

end:	END