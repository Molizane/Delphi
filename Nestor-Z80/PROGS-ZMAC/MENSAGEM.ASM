;****************************************
;    MENSAGEM
;****************************************

TEMPOC	equ	$20	;$50	;$10	;$02
REST	equ	$009C

		org	$0AA0

INIC	ld	bc,BMD
L2		ld	d,TEMPOC
		inc	bc
		ld	a,c
		cp	$30
		jp	z,INIC
L1		ld	h,b
		ld	l,c
		push	bc
		call	REST
		pop	bc
		dec	d
		jp	nz,L1
		jp	L2
;
BMD	db	$FF ; spc
	db	$FF ; spc
	db	$FF ; spc
	db	$FF ; spc
	db	$FF ; spc
	db	$FF ; spc
	db	$86 ; E
	db	$C1 ; U
	db	$FF ; spc
	db	$92 ; S
	db	$C0 ; O
	db	$C1 ; U
	db	$FF ; spc
	db	$C0 ; O
	db	$FF ; spc
	db	$C8 ; N
	db	$86 ; E
	db	$92 ; S
	db	$87 ; T
	db	$C0 ; O
	db	$4E ; R
FIM	db	$FF ; spc
	db	$FF ; spc
	db	$FF ; spc
	db	$FF ; spc
	db	$FF ; spc
	db	$FF ; spc
	db	$FF ; spc
	db	$FF ; spc
