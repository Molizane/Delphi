;****************************************
;    TESTE TERMINAL
;****************************************

TEMPOC	EQU $40

		ORG $0C50

INIC	LD A, $0C
		OUT ($60), A
		LD B,0
		LD C,0
CNT		LD A,B
		ADD A,$30
		OUT ($60), A
		CALL DELAY
		INC B
		LD A, B
		CP $0A
		JP NZ, CNT
		LD B,0
		INC C
		LD A,C
		CP $08
		JP Z, CNT2
		JP CNT
CNT2	LD A,13
		OUT ($60), A
		LD A,10
		OUT ($60), A
		LD B,0
		LD C,0
CNT3	LD A,B
		ADD A,$30
		OUT ($60), A
		LD A,13
		OUT ($60), A
		LD A,10
		OUT ($60), A
		CALL DELAY
		INC B
		LD A, B
		CP $0A
		JP NZ, CNT3
		LD B,0
		INC C
		LD A,C
		CP $04
		JP Z, DONE
		JP CNT3
DONE	HALT

DELAY	PUSH BC			; save BC
		LD B,TEMPOC		; start of delay
		CALL DELAY1
		POP BC			; restore BC
		RET

DELAY1	LD C,$FF		; fill c too with max delay
DELAY2	DEC C			; decrement c
		JP NZ,DELAY2
		DEC B			; c is empty...
		JP NZ,DELAY1	; do c again
		RET				; return
