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
	RET
