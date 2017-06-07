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

TMP_VAR equ 0x20
X_AXIS equ 0x21
Y_AXIS equ 0x22

; void ()
; Display all queue elements
display:
	MOV R0, QUEUE_TAIL
	CALL render
	d_iterate:
	; Get element addr after head
		MOV R1, QUEUE_HEAD
		INC R1
	MOV A, R0
	ADD A, #0x01
	MOV TMP_VAR, R1
	CJNE A, TMP_VAR, d_end_not_reached ; Check if reached head
		LCALL render
		RET ; END REACHED
	d_end_not_reached:
	CJNE A, #QUEUE_END + 0x01, d_in_bound ; Check queue bounds
		MOV A, #QUEUE_BEGIN ; Set next element
	d_in_bound:
	MOV R0, A
	CALL render
	SJMP d_iterate

; void (R0)
; Renders Point R0
render:
	MOV A, @R0 ; Get value
	MOV R1, A
	CALL get_axis_x
	CALL get_axis_byte
	MOV X_AXIS, R3
	CALL get_axis_y
	CALL get_axis_byte
	MOV Y_AXIS, R3
	MOV P1, X_AXIS
	MOV P0, Y_AXIS
	RET

; R3 (R2)
; Decode 3 bit axis representation to full byte
get_axis_byte:
	MOV R3, #00000001b
	d_check:
	MOV A, R2
	JNZ d_not_zero
	RET
	d_not_zero:
	; Left-shift R3
		MOV A,R3
		RL A
		MOV R3, A
	DEC R2
	SJMP d_check

; R2 (R1)
; Decode X axis from element R1
get_axis_x:
	MOV A, R1
	ANL A, #0xF0
	SWAP A
	MOV R2, A
	RET

; R2 (R1)
; Decode Y axis from element R1
get_axis_y:
	MOV A, R1
	ANL A, #0x0F
	MOV R2, A
	RET