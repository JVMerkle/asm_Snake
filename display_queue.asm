X_AXIS equ 21H
Y_AXIS equ 22H

; ()
display:
	MOV R0, QUEUE_TAIL
	CALL add_to_display
iterate:
	; Get element addr after head
		MOV A, QUEUE_HEAD
		ADD A, #0x01
		MOV R1, A
	MOV A, R0
	ADD A, #0x01
	MOV 20H, R1
	CJNE A, 20H, end_not_reached ; Check if reached head
		LCALL render
		RET ; END REACHED
	end_not_reached:
	CJNE A, #QUEUE_END + 0x01, in_bound ; Check queue bounds
		MOV A, #QUEUE_BEGIN ; Set next element
	in_bound:
	MOV R0, A
	CALL add_to_display
	SJMP iterate

; (R0)
add_to_display:
	MOV A, @R0 ; Get value
	MOV R1, A
	CALL get_axis_x
	MOV A, R2 ; Save x in R2
	MOV R3, A
	CALL get_axis_y
	RET
; R3 (R3)
get_axis_byte:
	
	RET

; R2 (R1)
get_axis_x:
	MOV A, R1
	ANL A, #0xF0
	RR A
	RR A
	RR A
	RR A
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