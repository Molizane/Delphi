;******************************************************************************
; ACIONA AS PORTAS DE SAÍDA, ALTERNANDO O VALOR ENTRE 0 E 255 E EXIBINDO TEXTO
;******************************************************************************

;***********************************************************************
	include	"defs.inc"
;***********************************************************************

TEMPOC	equ $2F

REST	equ	$009C

		org	$20A0

INIT:	xor a
LOOP:	out (PPS), a
		inc a
		push af
		ld d, TEMPOC
L2		ld hl, (FRASE)
		call REST
		dec d
		jr nz, L2
LOOP2:	pop af
		jr LOOP

DIGIT:	db	0
DELAY:	dw	$FF18

FRASE:	db	DIG_1, DIG_2, DIG_3, DIG_4, DIG_5, DIG_6, 0

FIM:
