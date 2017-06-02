QUEUE_HEAD equ 20H
QUEUE_TAIL equ 21H
QUEUE_BEGIN equ 22H
QUEUE_END equ 25H

; Initialize Queue
queue_init:
	; Init Head and Tail
	MOV QUEUE_HEAD,#QUEUE_BEGIN
	MOV QUEUE_TAIL,#QUEUE_BEGIN + 0x01
	
	MOV R0,#QUEUE_BEGIN ; Get address of the first element
init_elements:
	MOV @R0,#0xFF ; Initialize element with zero
	; Increase R0
		MOV A,R0 ; Load Accu
		ADD A,#0x01 ; Increase element pointer
		MOV R0,A ; Set R0
	CJNE R0,#QUEUE_END + 0x01,init_elements ; Loop through all elements
	RET

; void (A)
queue_push:
	MOV R0,A ; R0 is the new element
	MOV A,QUEUE_HEAD
	ADD A,#0x01
	CJNE A,#QUEUE_END + 0x01,do_it ; Check queue bounds
		MOV A,#QUEUE_BEGIN ; Set next element
	do_it:
	MOV R1,A ; R1 is the pointer to the new element
	MOV A,R0 ; Set A to the new element
	MOV @R1,A ; Write the new element
	MOV QUEUE_HEAD, R1 ; Set the HEAD
	RET

; A ()
queue_pop:
	MOV R0,QUEUE_TAIL
	MOV R1,A
	MOV @R0,#0xFF ; Clear the element
	MOV A,QUEUE_TAIL
	ADD A,#0x01
	CJNE A,#QUEUE_END + 0x01,do_it_2 ; Check queue bounds
		MOV A,#QUEUE_BEGIN ; Set next element
	do_it_2:
	MOV QUEUE_TAIL, A ; Set the HEAD
	MOV A,R1 ; Set return value
	RET