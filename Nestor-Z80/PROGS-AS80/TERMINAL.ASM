;****************************************
;    TESTE TERMINAL
;****************************************

TEMPOC	equ	$40

	org	$0B00

INIC	LD A, $20
	LD (CHR),A
RESET	LD A, $0C
	OUT ($60), A
	LD B,0
CNT	INC B
	LD A, B
	CP $50
	JP NZ, CN1
	LD B,0
	LD A,$0D
	OUT ($60), A
	LD A,$0A
	OUT ($60), A
CN1	LD A,(CHR)
	OUT ($60), A
	INC A
	CP $FF
	JP Z, INIC
	LD (CHR),A
	CALL DELAY
	JP CNT

DELAY	push	bc		; save BC
	ld	b,TEMPOC	; start of delay
	call	DELAY1
	pop	bc		; restore BC
	ret
DELAY1	ld	c,$ff		; fill c too with max delay
DELAY2	dec	c		; decrement c
	jp	nz,DELAY2
	dec	b		; c is empty...
	jp	nz,DELAY1	; do c again
	ret			; retorna

CHR	DB 0
