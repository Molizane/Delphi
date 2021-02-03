;************************************************
;  CONTADOR 0 A 9999 NOS QUINTO E SEXTO DÍGITOS
;************************************************

;***********************************************************************
	include	"defs.inc"
;***********************************************************************

TEMPOC	equ	$1F ;$30	;$10	;$20
TEMPOD	equ	$50

REST	equ	$009C
FORMAT	equ	$0186

		org	$0800

INIC	ld hl, MBD
		ld b, 6
A1		ld (hl), $FF
		inc hl
		djnz A1
A2		ld hl, CNTC
		ld (hl), $00
		ld hl, CNTD
		ld (hl), $00
		ld hl, CNTU
		ld (hl), $FF
A3		ld hl, CNTU
		inc (hl)
		ld a, (hl)
		cp $0A
		jr nz, A6
		xor a
		ld (hl), a
		push	af
		ld hl, CNTD
		inc (hl)
		ld a, (hl)
		cp $0A
		jr nz, A5
		xor a
		ld (hl), a
		push af
		ld hl, CNTC
		inc (hl)
		ld a, (hl)
		cp $0A
		jr nz, A4
		pop af
		pop af
		jr A9
A4		call FORMAT
		ld hl, DIG4
		ld (hl), a
		pop af
A5		call FORMAT
		ld hl, DIG5
		ld (hl), a
		pop af
A6		call FORMAT
		ld hl, DIG6
		ld (hl), a
		ld d, TEMPOC
A7		ld hl, MBD
		call REST
		dec d
		jr nz, A7
		jr A3
A8		ld d, TEMPOD
A9		ld hl, MBD
		call REST
		dec d
		jr nz, A9
		jr INIC

MBD		dw	0
DIG3	db	0
DIG4	db	0
DIG5	db	0
DIG6	db	0

CNTM	db	0
CNTC	db	0
CNTD	db	0
CNTU	db	0

FIM:
