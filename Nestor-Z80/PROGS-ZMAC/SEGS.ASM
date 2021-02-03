;****************************************
;    LEDS
;****************************************

;***********************************************************************
	include	"defs.inc"
;***********************************************************************

TEMPOC	equ	$FF

		org $0AE0

LOOP	ld a, $FE
		call LIGHT
		ld a, $FD
		call LIGHT
		ld a, $FB
		call LIGHT
		ld a, $F7
		call LIGHT
		ld a, $EF
		call LIGHT
		ld a, $DF
		call LIGHT
		jr LOOP

LIGHT	out (PPS), a
		out (PPS + 1), a
		jr DELAY


DELAY	push bc			; save BC
		ld b, TEMPOC	; start of delay
		call DLAY1
		pop bc			; restore BC
		ret

DLAY1 	ld c, $ff		; fill c too with max delay
DLAY2 	dec c			; decrement c
		jr nz, DLAY2
		dec b			; c is empty...
		jr nz, DLAY1	; do c again
		ret				; retorna

DELAY2	push hl
		ld l, 5
DLY2	ld b, $ff		; start of delay
		call DLAY1
		dec l
		jr nz, DLY2
		pop hl
		ret

FIM:
