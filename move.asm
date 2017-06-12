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

move:
	MOV R0, QUEUE_HEAD
	MOV A, @R0
	MOV R1, A
	LCALL move_right
	MOV A, R1
	CALL queue_push
	CALL queue_pop
	RET

; R1 (R1)
; Take point R1 and calculate relatively upper point R1
move_up:
	CALL get_axis_x
	MOV A, R2
	MOV R3, A
	CALL get_axis_y
	DEC R2
	CALL encode_axes_to_byte
	RET

; R1 (R1)
; Take point R1 and calculate relatively lower point R1
move_down:
	CALL get_axis_x
	MOV A, R2
	MOV R3, A
	CALL get_axis_y
	INC R2
	CALL encode_axes_to_byte
	RET

; R1 (R1)
; Take point R1 and calculate relatively left point R1t
move_left:
	CALL get_axis_x
	DEC R2
	MOV A, R2
	MOV R3, A
	CALL get_axis_y
	CALL encode_axes_to_byte
	RET

; R1 (R1)
; Take point R1 and calculate relatively right point R1
move_right:
	CALL get_axis_x
	INC R2
	MOV A, R2
	MOV R3, A
	CALL get_axis_y
	CALL encode_axes_to_byte
	RET