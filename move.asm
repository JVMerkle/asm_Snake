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
	LCALL calc_new_point
	MOV A, R1
	CALL queue_push
	CALL queue_pop
	RET