;Number in hl to decimal ASCII
;Thanks to z80 Bits
;inputs:	hl = number to ASCII
;example: hl=300 outputs '00300'
;destroys: af, bc, hl, de used

;***********************************************************************
;	include	"defs.inc"
;***********************************************************************
;	include	"nestor.inc"
;***********************************************************************

REST	equ $009C

TEMPOD	equ	$50

		org	$2290

INIT:	ld hl, 0
LOOP:	push hl
		ld ix, FIM
		call DispHL
		call Timer
		pop hl
		inc hl
		jr LOOP

DispHL:	ld bc, -10000
		call Num1
		ld bc, -1000
		call Num1
		ld bc, -100
		call Num1
		ld bc, -10
		call Num1
		ld bc, -1
Num1:	ld a, '0'- 1
Num2:	inc a
		add hl, bc
		jr c, Num2
		sbc hl, bc
		ld (ix), a
		dec ix
		ret

Timer:	ld d, TEMPOD
Timer1:	ld hl, BUFFER
		call REST
		dec d
		jr nz, Timer1
		ret
;
BUFFER:	db 0, 0, 0, 0, 0, 0
;
FIM:
