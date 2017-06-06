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

; Queue Tests
; Expected string in memory
; from address 0x20: 26 25 FF FF FF BE EF
; R3 = AD
; R2 = DE

main:
	CALL queue_init
	MOV A, #0xDE
	CALL queue_push
	MOV A, #0xAD
	CALL queue_push
	MOV A, #0xBE
	CALL queue_push
	MOV A, #0xEF
	CALL queue_push
	CALL queue_pop
	MOV R2, A
	CALL queue_pop
	MOV R3, A

LJMP end

INCLUDE "queue.asm"

end:
	END