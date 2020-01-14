;****************************************
;    LEDS
;****************************************

;	include "NESTORNE.INC"

TEMPOC	equ	$FF

	org	$0A00

LOOP	ld	a,$80
	out	($04),a		; acende LED 7
	out	($05),a
	ld	a,$07		; posição do display
	call	DELAY
	ld	a,$40
	out	($04),a		; acende LED 6
	out	($05),a
	call	DELAY
	ld	a,$20
	out	($04),a		; acende LED 5
	out	($05),a
	call	DELAY
	ld	a,$10
	out	($04),a		; acende LED 4
	out	($05),a
	call	DELAY
	ld	a,$08
	out	($04),a		; acende LED 3
	out	($05),a
	call	DELAY
	ld	a,$04
	out	($04),a		; acende LED 2
	out	($05),a
	call	DELAY
	ld	a,$02
	out	($04),a		; acende LED 1
	out	($05),a
	call	DELAY
	ld	a,$01
	out	($04),a		; acende LED 0
	out	($05),a
	call	DELAY
	;ld	a,$00
	;out	($04),a		; apaga todos os LED's
	;out	($05),a
	;call	MOREDELAY
	jp	LOOP

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

MOREDELAY
	push	hl
	ld	l,5
MOREDELAY1
	ld	b,$ff		; start of delay
	call	DELAY1
	dec	l
	jp	nz,MOREDELAY1
	pop	hl
	ret
