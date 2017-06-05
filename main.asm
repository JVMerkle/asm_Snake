;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; DEFINITIONS

T0_COUNT equ 16d ; ET0 runs T0_COUNT times to reach a one second interrupt
DIR equ R7 ; Direction Byte set by ISR
TCR equ R6 ; Timer count register used by ET0

ONE_SECOND_FLAG equ 28H ; 0x00 = Set

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
		MOV DIR, A
	RET

isr_et0:
	DJNZ TCR, ret_isr_et0 ; Check if R6 is null
	MOV TCR, #T0_COUNT ; Re-init timer count register
	MOV ONE_SECOND_FLAG, #0x00
	RET

ret_isr_et0:
	RET


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; INCLUDES

INCLUDE "queue.asm"
INCLUDE "display.asm"

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; SUBROUTINES

; Move Snake
snake_next:
	NOP
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; INITIALISATION

init:

SETB EA ; Global Interrupts
SETB EX0 ; External 0 Interrupt
SETB ET0 ; Timer 0 Interrupt
ORL TMOD, #00000001b ; Set ET0 to 16-bit mode
MOV TCR, #T0_COUNT ; Init timer count register

MOV ONE_SECOND_FLAG, #0xFF ; Unset flag

; Init queue
; Valid points: p(0,0) to p(7,7)
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
	LCALL display
	MOV A, ONE_SECOND_FLAG
	JNZ main ; Jump when ONE_SECOND_FLAG != 0x00
	MOV ONE_SECOND_FLAG, #0xFF ; Unset flag
	LCALL snake_next
	SJMP main

END