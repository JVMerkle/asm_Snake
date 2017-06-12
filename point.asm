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
; along with asm_Snake.  If not, see <http://www.gnu.org/licenses/>.

; R1 (R1)
; Get relating point R1 to
; calculate the next point R1
calc_new_point:
	CALL get_axis_x
	INC R2
	MOV A, R2
	MOV R3, A
	CALL get_axis_y
	INC R2
	CALL encode_axes_to_byte
	RET

; R1 (R3,R2)
; Takes X axis R3 and Y axis R2 and
; combines them to 1 byte representation R3
encode_axes_to_byte:
	; Handle Y
	MOV A, R3
	ANL A, #0111b ; Mask 3 lowest bits
	SWAP A
	MOV R1, A
	; Handle X
	MOV A, R2
	ANL A, #0111b ; Mask 3 lowest bits
	ORL A, R1 ; Combine X and Y
	MOV R1, A
	RET

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