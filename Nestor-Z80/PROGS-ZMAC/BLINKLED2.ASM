;***************************************************
;  ACIONA AS PORTAS DE SÁIDA, ALTERNANDO O VALOR PARA 0 E 255
;***************************************************

;***********************************************************************
;	include	"defs.inc"
;***********************************************************************
;	include	"nestor.inc"
;***********************************************************************

		org	$2030

PPS		equ	4

INIT:	xor a
LOOP:	out (PPS), a
		push af
		call TIMER
		pop af
		inc a
		jr LOOP
;
TIMER:	ld de, $0AFF
TIMER1:	dec de
		ld a, d
		or e
		ret z
		jr TIMER1
;
FIM:
