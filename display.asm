X_AXIS equ 21H
Y_AXIS equ 22H

; ()
display:
	MOV R0, QUEUE_TAIL
	CALL add_to_display
	d_iterate:
	; Get element addr after head
		MOV R1, QUEUE_HEAD
		INC R1
	MOV A, R0
	ADD A, #0x01
	MOV 20H, R1
	CJNE A, 20H, d_end_not_reached ; Check if reached head
		LCALL render
		RET ; END REACHED
	d_end_not_reached:
	CJNE A, #QUEUE_END + 0x01, d_in_bound ; Check queue bounds
		MOV A, #QUEUE_BEGIN ; Set next element
	d_in_bound:
	MOV R0, A
	CALL add_to_display
	SJMP d_iterate

; (R0)
add_to_display:
	MOV A, @R0 ; Get value
	MOV R1, A
	CALL get_axis_x
	CALL get_axis_byte
	MOV X_AXIS, R3
	CALL get_axis_y
	CALL get_axis_byte
	MOV Y_AXIS, R3
	LCALL RENDER
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
get_axis_x:
	MOV A, R1
	ANL A, #0xF0
	SWAP A
	MOV R2, A
	RET

; R2 (R1)
get_axis_y:
	MOV A, R1
	ANL A, #0x0F
	MOV R2, A
	RET

; ()
; Displays calulated axises on the matrix
render:
	MOV P1, X_AXIS
	MOV P0, Y_AXIS
	RET