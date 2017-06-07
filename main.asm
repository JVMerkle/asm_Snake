; Copyright 2017 Julian Merkle

; This file is part of asm_Snake.

; asm_Snake is free software: you can redistribute it and/or modify
; it under the terms of the GNU General Public License as published by
; the Free Software Foundation, either version 3 of the License, or
; (at your option) any later version.

; asm_Snake is distributed in the hope that it will be useful,
; but WITHOUT ANY WARRANTY; without even the implied warranty of
; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
; GNU General Public License for more details.

; You should have received a copy of the GNU General Public License
; along with mMio.  If not, see <http://www.gnu.org/licenses/>.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; DEFINITIONS

T0_COUNT equ 16d ; ET0 runs T0_COUNT times to reach a one second interrupt
DIR equ R7 ; Direction Byte set by ISR
TCR equ R6 ; Timer count register used by ET0

ONE_SECOND_FLAG equ 28h ; 0x00 = Set

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
	MOV DIR, P2
	RET

isr_et0:
	DJNZ TCR, ret_isr_et0 ; Check if R6 is null
	MOV TCR, #T0_COUNT ; Re-init timer count register
	MOV ONE_SECOND_FLAG, #0x00
	ret_isr_et0:
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; INCLUDES

INCLUDE "queue.asm"
INCLUDE "display.asm"
INCLUDE "point.asm"
INCLUDE "move.asm"

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; SUBROUTINES

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; INITIALISATION

init:

SETB EA ; Global Interrupts
SETB EX0 ; External 0 Interrupt
SETB ET0 ; Timer 0 Interrupt
ORL TMOD, #00000001b ; Set ET0 to 16-bit mode
MOV TCR, #T0_COUNT ; Init timer count register

MOV ONE_SECOND_FLAG, #0xFF ; Unset flag

; Clear 8x8 Matrix
MOV P0, #0x00
MOV P1, #0x00

; Init queue
; Valid points: p(0,0) to p(7,7)
CALL queue_init

MOV A, #00110011b ; Point (3,3)
CALL queue_push
MOV A, #01000011b ; Point (4,3)
CALL queue_push
MOV A, #01010011b ; Point (5,3)
CALL queue_push

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; MAIN

SETB TR0 ; Start Timer 0

main:
	LCALL display
	MOV A, ONE_SECOND_FLAG
	JNZ main ; Jump when ONE_SECOND_FLAG != 0x00
	MOV ONE_SECOND_FLAG, #0xFF ; Unset flag
	LCALL move
	SJMP main

END