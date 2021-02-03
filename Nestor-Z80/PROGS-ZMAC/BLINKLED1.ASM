;**************************************************************
;  ACIONA AS PORTAS DE SAÍDA, ALTERNANDO O VALOR ENTRE 0 E 255
;**************************************************************

;***********************************************************************
;	include	"defs.inc"
;***********************************************************************
;	include	"nestor.inc"
;***********************************************************************

		org	$2000

PPS		equ	4

INIT:	ld a, $FF
		out (PPS), a
		call TIMER
		xor a
		out (PPS), a
		call TIMER
		jr INIT
;
TIMER:	ld de, $FF
TIMER1:	dec de
		ld a, d
		or e
		ret z
		jr TIMER1
;
FIM:
