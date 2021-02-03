;***************************************************
;  CONTADOR 0 A 999999 NOS QUINTO E SEXTO DÍGITOS
;***************************************************

FORMAT	equ $0186
REST	equ $009C

PPS		equ	4

TEMPOC	equ $1F	;$30	;$10	;$20
TEMPOD	equ $50

		org $0880

INIC	ld hl,MBD
		ld b,6
A1		ld (hl),$FF
		inc	hl
		djnz A1
A2		ld hl,CNTC
		ld (hl),$00
		ld hl,CNTD
		ld (hl),$00
		ld hl,CNTU
		ld (hl),$FF
A3		ld hl,CNTU
		inc (hl)
		ld a,(hl)
		cp $0A
		jp nz,A6
		ld a, $00
		ld (hl), a
		push af
		ld hl,CNTD
		inc (hl)
		ld a,(hl)
		cp $0A
		jp nz,A5
		ld a, $00
		ld (hl), a
		push af
		ld hl,CNTC
		inc (hl)
		ld a,(hl)
		cp $0A
		jp nz,A4
		pop af
		pop af
		jp A9
A4		call FORMAT
		ld hl,DIG4
		ld (hl),a
		pop af
A5		call FORMAT
		ld hl,DIG5
		ld (hl),a
		pop af
A6		call FORMAT
		ld hl,DIG6
		ld (hl),a
		ld d,TEMPOC
A7		ld hl,MBD
		call REST
		dec	d
		jp nz,A7
		jp A3
A8		ld d,TEMPOD
A9		ld hl,MBD
		call REST
		dec	d
		jp nz,A9
		jp INIC

MBD		db 0, 0
DIG3	db 0
DIG4	db 0
DIG5	db 0
DIG6	db 0

CNTM	db 0
CNTC	db 0
CNTD	db 0
CNTU	db 0

FIM:
