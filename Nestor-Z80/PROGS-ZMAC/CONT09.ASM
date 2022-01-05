;****************************************
;    CONTADOR 0 A 9 NO SEXTO DÍGITO
;****************************************

FORMAT	equ $0186
REST	equ $009C

TEMPOC	equ $30	;$10	;$20

		org $8000

INIC	ld hl,MBD
		ld b,6
A1		ld (hl),$FF
		inc	hl
		djnz A1
A2		ld hl,MENCONC
		ld (hl),$FF
A4		ld hl,MENCONC
		inc (hl)
		ld a,(hl)
		cp $0A
		jp z,A2
		call FORMAT
		ld hl,DIG6
		ld (hl),a
		ld d,TEMPOC
A3		ld hl,MBD
		call REST
		dec	d
		jp nz,A3
		jp A4

MBD		db 0, 0, 0, 0, 0
DIG6	db 0
MENCONC	db 0
