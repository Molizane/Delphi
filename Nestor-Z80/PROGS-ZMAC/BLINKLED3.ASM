;*************************************************************
; ACIONA AS PORTAS DE SAÍDA, ALTERNANDO O VALOR ENTRE 0 E 255
;*************************************************************

;***********************************************************************
	include	"defs.inc"
;***********************************************************************

		org	$2050

INIT:	ld a, 1
		ld (DIGIT), a
		xor a
FRS:	ld hl, FRASE
LOOP1:	out (PPS), a
		inc a
		push af
		ld a, (DIGIT)
		call TIMER
		rla ; add a, a
		cp 64
		jr nz, LOOP2
		ld a, 1
LOOP2:	ld (DIGIT), a
		ld a, (hl)
		cp 0 ;and a
		jr nz, LOOP3
		pop af
		jr FRS
LOOP3:	pop af
		jr LOOP1

TIMER:	push af
		out (PDIG), a
		ld a, (hl)
		out (PTEC), a
		exx
		ld de, DELAY
TIMER1:	dec de
		ld a, d
		or e
		jr nz, TIMER1
		exx
		inc hl
		pop af
		ret

DIGIT:	db	0
DELAY:	dw	$FF18
FRASE:	db	DIG_1, DIG_2, DIG_3, DIG_4, DIG_5, DIG_6, 0

FIM:
