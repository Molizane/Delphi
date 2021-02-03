;************************************************
;    CONTADOR 0 A 99 NOS QUINTO E SEXTO D͐GITOS
;************************************************

FORMAT	equ $0186
REST	equ $009C

TEMPOC	equ $30	;$10	;$20

		org $08D0

INIC	ld hl,MBD
		ld b,6
A1		ld (hl),$FF
		inc	hl
		djnz A1
A2		ld hl,CNTD
		ld (hl),$00
		ld hl,CNTU
		ld (hl),$FF
A3		ld hl,CNTU
		inc (hl)
		ld a,(hl)
		cp $0A
		jp nz,A4
		ld a, $00
		ld (hl), a
		push af
		ld hl,CNTD
		inc (hl)
		ld a,(hl)
		cp $0A
		jp z,INIC
		call FORMAT
		ld hl,DIG5
		ld (hl),a
		pop af
A4		call FORMAT
		ld hl,DIG6
		ld (hl),a
		ld d,TEMPOC
A5		ld hl,MBD
		call REST
		dec	d
		jp nz,A5
		jp A3

MBD		db 0, 0, 0, 0
DIG5	db 0
DIG6	db 0
CNTD	db 0
CNTU	db 0
