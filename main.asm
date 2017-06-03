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
	MOV TH0, #0xFF
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
MOV TH0, #0xFF
SETB TR0 ; Start Timer 0

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
	SJMP main

END