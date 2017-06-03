;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; DEFINITIONS

; R7: Direction Byte set by ISR

ORG 0000h
LJMP init

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; ISRs

; ISR EX0
ORG 0003h
CALL isr_ex0
RETI

; ISR ET0
ORG 000Bh
CALL isr_et0
RETI

isr_ex0:
	MOV A,P2
	ANL A, #0x0F ; Mask the 4 buttons
	CJNE A, 0x0F, valid ; The interrupt is invalid when no button is pressed
	RETI
	valid:
		MOV R7, A
	RET

isr_et0:
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; INCLUDES

INCLUDE "queue.asm"

init:

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; INITIALISATION

SETB EA ; Global Interrupts
SETB EX0 ; External 0 Interrupt
SETB ET0 ; Timer 0 Interrupt
MOV TMOD, #00000001b ; Enable M00

; Init queue
CALL queue_init
MOV A, #00110011b ; Point (3,3)
CALL queue_push
MOV A, #01000011b ; Point (4,3)
CALL queue_push
MOV A, #00101011b ; Point (5,3)
CALL queue_push

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; MAIN

SETB TR0 ; Start Timer 0

main:
	NOP
	SJMP main

END