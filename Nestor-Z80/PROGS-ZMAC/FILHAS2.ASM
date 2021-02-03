;***************************************************
;  EXIBE AMANDA E BIANCA
;***************************************************

;***********************************************************************
	include	"defs.inc"
;***********************************************************************

TEMPOC	equ	$2F
TEMPOD	equ	$50

REST	equ $009C

		org	$09F0

INIT:	ld bc, FIM - MENS
		push bc
		ld hl, MENS
L1:		ld (PNT), hl
		ld d, TEMPOC
L2:		ld hl, (PNT)
		call REST
		dec d
		jr nz, L2
		pop bc
		dec c
		jr z, AGAIN
		push bc
		ld hl, (PNT)
		inc hl
		jr L1
AGAIN:	ld bc, FIM - MENS - 1
		push bc
		ld hl, MENS + 1
		jr L1
;
PNT:	dw	0000
;
MENS:	db	DIG_APAG, DIG_APAG, DIG_APAG, DIG_APAG, DIG_APAG, DIG_APAG ; seis espaços
		db	DIG_A, DIG_M, DIG_A, DIG_N, DIG_D, DIG_A ; Amanda
		db	DIG_APAG, DIG_E, DIG_APAG                ; e
		db	DIG_B, DIG_I, DIG_A, DIG_N, DIG_C, DIG_A and 7Fh ; Bianca (com ponto final)
;
FIM:	db	DIG_APAG, DIG_APAG, DIG_APAG, DIG_APAG, DIG_APAG, DIG_APAG ; seis espaços
		db	0
