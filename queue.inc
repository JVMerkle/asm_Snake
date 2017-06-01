QUEUE_HEAD equ 20H
QUEUE_TAIL equ 21H
QUEUE_BEGIN equ 22H
QUEUE_END equ 30H

; Initialize Queue
queue_init:
	MOV R0,#QUEUE_BEGIN ; Get address of the first element
init_elements:
	MOV @R0,#0xFF ; Initialize element with zero
	; Include R0
		MOV A,R0 ; Load Accu
		ADD A,#0x01 ; Increase element pointer
		MOV R0,A ; Set R0
	CJNE R0,#QUEUE_END + 0x01,init_elements ; Loop through all elements
	RET

queue_head:
	MOV A,@QUEUE_HEAD
	RET

queue_tail:
	MOV A,@QUEUE_TAIL
	RET