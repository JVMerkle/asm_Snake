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

; R3 (R1, R2)
; Get keyboard input R1 and relating point R2 to
; calculate the new point R3
calc_new_point:

; R3 (R1,R2)
; Takes X axis R1 and Y axis R2 and
; combines them to 1 byte representation R3
encode_axes_to_byte:
	MOV A, R1
	SWAP A
	ORL A, R2
	MOV R3, A
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