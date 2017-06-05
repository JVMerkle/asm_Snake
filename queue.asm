QUEUE_HEAD equ 0x30
QUEUE_TAIL equ 0x31
QUEUE_BEGIN equ 0x32
QUEUE_END equ 0x64

; Initialize Queue
queue_init:
	; Init Head and Tail
	MOV QUEUE_HEAD, #QUEUE_BEGIN
	MOV QUEUE_TAIL, #QUEUE_BEGIN + 0x01

	MOV R0, #QUEUE_BEGIN ; Get address of the first element
	q_init_elements:
	MOV @R0, #0xFF ; Initialize element with zero
	; Increase R0
	INC R0 ; Increase element pointer
	CJNE R0, #QUEUE_END + 0x01, q_init_elements ; Loop through all elements
	RET

; void (A)
queue_push:
	PUSH A ; Push the new element value
	MOV A, QUEUE_HEAD
	ADD A, #0x01
	CJNE A, #QUEUE_END + 0x01, q_do_it ; Check queue bounds
		MOV A, #QUEUE_BEGIN ; Set next element
	q_do_it:
	MOV R0, A ; R0 is the pointer to the new element
	POP A ; Pop the element value
	MOV @R0, A ; Write the element value
	MOV QUEUE_HEAD, R0 ; Set the head
	RET

; A ()
queue_pop:
	MOV R0, QUEUE_TAIL
	MOV A, @R0
	MOV @R0, #0xFF ; Clear the element
	MOV R0, A
	MOV A, QUEUE_TAIL
	ADD A, #0x01
	CJNE A, #QUEUE_END + 0x01, q_do_it_2 ; Check queue bounds
		MOV A, #QUEUE_BEGIN ; Set next element
	q_do_it_2:
	MOV QUEUE_TAIL, A ; Set the tail
	MOV A, R0 ; Set return value
	RET