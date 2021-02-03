;****************************************
;	   PROGRAMA MONITOR NESTOR
;	       NOVA ELETRÔNICA
;	SAO PAULO S.P. 01/84 MSCS/JRP
;****************************************

PDIG	equ $03	; saída coluna teclado e display
PSEG	equ $01	; saída caracter para o display
PTEC	equ $01	; entrada linha teclado
ATRASO	equ $0001
TOPSP	equ $0BE4
MENCON	equ $0BE5
FLAG	equ $0BE6
BUFDSP	equ $0BE7
BYTES	equ $0BEB
ENDISP	equ $0BED
PBE	equ $0BEE
PAE	equ $0BEF
ROT	equ $0BF0
ROTNMI	equ $0BF2
MENI	equ $0BF7
MENF	equ $0BF8
MENA	equ $0BF9
MENL	equ $0BFA
MENH	equ $0BFB
MENE	equ $0BFC
MEND	equ $0BFD
MENC	equ $0BFE
MENB	equ $0BFF
CURMSG	equ $0C00

	org $0000
	ld sp,	CURMSG	;$0C00
	push bc
	push de
	push hl
	push af
	ld hl,	FLAG
	ld (hl),	$19
	ld hl,	MENS
	ld de,	BUFDSP
	ld bc,	$0006
	ldir
INICIO	ld sp,	TOPSP
	ld hl,	BUFDSP
	ld b,	$00
	ld e,	$06
	ld a,	$01
NE1	call VARR
	ld a,	c
	add a,	a
	dec e
	jp nz,	NE1
	ld a,	b
	cp $00
	jp z,	INICIO
NE2	ld hl,	BUFDSP
	call REST
	ld a,	d
	out (PDIG),	a
	in a,	(PTEC)
	cp $00
	jp nz,	NE2
	call AJCOL
	call AJTEC
	cp $13
	jp z,	NE3
	cp $10
	jp c,	NE4
NE5	call ALTCOM
NE6	ld hl,	FLAG
	ld a,	(hl)
	jp RECCOM

;****************************************
;  MENSAGEM INICIAL
;****************************************

MENS	db $C8	; N
	db $86	; E
	db $92	; S
	db $87	; T
	db $C0	; O
	db $CE	; R
	db $00
	db $00
	db $00
	db $00

;****************************************
;  ponto de entrada de interrupção nmi
;****************************************

	;org $0066
NMINT	jp RVI

;****************************************
;  ROTINA DE RECONHECIMENTO DE COMANDOS
;****************************************

RECCOM	ld hl,	TABCOM+1
	add a,	l
	ld l,	a
	ld a,	(hl)
	ld c,	a
	ld a,	$0A
	add a,	l
	ld l,	a
	ld l,	(hl)
	ld h,	c
	jp (hl)
NE3	ld hl,	FLAG
	ld a,	(hl)
	cp $15
	jp z,	SELREG
	jp NE5
NE4	ld hl,	FLAG
	ld a,	(hl)
	cp $15
	jp z,	ALTREG
	nop
	jp NE6

;****************************************
;	rotina de varredura
;****************************************

VARR	ld c,	a
	call TEMPO
	in a,	(PTEC)
	cp $00
	ret z
	ld b,	a
	ld d,	c
	ret

;****************************************
;	rotina de restauração
;****************************************

REST	ld c,	$06
	ld a,	$01
NE7	call TEMPO
	add a,	a
	dec c
	ret z
	jp NE7

;****************************************
;	rotina de tempo
;****************************************

TEMPO	push af
	out (PDIG),	a
	ld a,	(hl)
	out (PSEG),	a
	exx
	ld de,	ATRASO
LOOP1	dec de
	ld a,	d
	or e
	jp nz,	LOOP1
	exx
	inc hl
	pop af
	ret

;****************************************
;	rotina de ajuste de coluna
;****************************************

AJCOL	ld c,	$00
	ld a,	$01
	cp d
	jp z,	NE8
	add a,	a
	ld c,	$08
	cp d
	jp z,	NE8
	add a,	a
	ld c,	$10
	cp d
	jp z,	NE8
	jp INICIO
NE8	ld d,	c
	ret

;****************************************
;	rotina de ajuste de tecla
;****************************************

AJTEC	ld e,	$08
	ld c,	$00
	ld a,	$01
NE10	cp b
	jp z,	NE9
	inc c
	add a,	a
	dec e
	jp nz,	NE10
	jp INICIO
NE9	ld a,	c
	add a,	d
	ld b,	a
	nop
	ret

;****************************************
;	rotina de alterar comando
;****************************************

ALTCOM	ld hl,	FLAG
	ld (hl),	b
	ret

;****************************************
;	rotina de permissão
;****************************************

ROTPER	ld c,	$06
	ld hl,	FLAG
	ld (hl),	$17	; executando a rotina "Permissão"
	inc hl
NE11	ld (hl),	$C0	; $FF
	inc hl
	dec c
	jp nz,	NE11
	ld (hl),	$00
	inc hl
	ld (hl),	$00
	inc hl
	ld (hl),	$00
	jp INICIO

;****************************************
;	rotina de campo de endereços
;****************************************

ROTcp ld hl,	PBE
	ld a,	b
	rld ; A(LSB)->(HL)(LSB)->(HL)(LSB)->(HL)(MSB)->(HL)(MSB)->A(LSB)
	inc hl
	rld ; A(LSB)->(HL)(LSB)->(HL)(LSB)->(HL)(MSB)->(HL)(MSB)->A(LSB)
	call DECOD
	jp INICIO

;****************************************
;	rotina de leitura
;****************************************

ROTLT	call ATUAL
	ld hl,	FLAG
	ld (hl),	$18
	ld hl,	PAE
	call DECOD
	jp INICIO

;****************************************
;	rotina de campo de dados
;****************************************

ROTCD	call ATUAL
	ld a,	b
	rld ; A(LSB)->(HL)(LSB)->(HL)(LSB)->(HL)(MSB)->(HL)(MSB)->A(LSB)
	ld a,	(hl)
	ld (de),	a
	ld hl,	PAE
	call DECOD
	jp INICIO

;****************************************
;	rotina de atualização
;****************************************

ATUAL	ld hl,	PBE
	ld e,	(hl)
	inc hl
	ld d,	(hl)
	ld a,	(de)
	dec hl
	dec hl
	ld (hl),	a
	push hl
	ld hl,	FLAG
	ld (hl),	$18
	pop hl
	ret

;****************************************
;	rotina de decodificação
;****************************************

DECOD	ld bc,	BUFDSP
	call DISPLY
	dec hl
	call DISPLY
	dec hl
	call DISPLY
	ret

;****************************************
;  rotina de ajuste memória de endereço
;****************************************

RAME	ld hl,	PBE
	ld (hl),	e
	inc hl
	ld (hl),	d
	dec hl
	dec hl
	ld a,	(de)
	ld (hl),	a
	ret
	;dw $FFFF

;****************************************
;	rotina de display
;****************************************

DISPLY	ld a,	(hl)
	push hl
	ld hl,	ROT
	ld (hl),	a
	xor a
	rld ; A(LSB)->(HL)(LSB)->(HL)(LSB)->(HL)(MSB)->(HL)(MSB)->A(LSB)
	call FORMAT
	ld (bc),	a
	inc bc
	xor a
	rld ; A(LSB)->(HL)(LSB)->(HL)(LSB)->(HL)(MSB)->(HL)(MSB)->A(LSB)
	call FORMAT
	ld (bc),	a
	inc bc
	pop hl
	ret

;****************************************
;	rotina de formatação
;****************************************

FORMAT	push de
	ld de,	INTD
	add a,	e
	ld e,	a
	ld a,	(de)
	pop de
	ret

;****************************************
;	tabela de formatos alfa (números)
;****************************************

INTD	db $C0
	db $F9
	db $A4
	db $B0
	db $99
	db $92
	db $82
	db $F8
	db $80
	db $90
	db $88
	db $83
	db $C6
	db $A1
	db $86
	db $8E

;****************************************
;	rotina de próximo
;****************************************

ROTPR	call ATUAL
	inc de
	call RAME
	ld hl,	PAE
	call DECOD
	jp INICIO

;****************************************
;	rotina de último
;****************************************

ROTUL	call ATUAL
	dec de
	call RAME
	ld hl,	PAE
	call DECOD
	jp INICIO

;****************************************
;	rotina de rodar
;****************************************

	org $01C8
ROTRD	ld a,	$FF
	out (PDIG),	a
	ld a,	$7F
	out (PSEG),	a
	ld hl,	ENDISP
	ld (hl),	$C3	; $C3 = "jp"
	ld sp,	MENF
	push af
	push hl
	push de
	push bc
	ld sp,	TOPSP
	jp ENDISP

;****************************************
;    rotina de exame de registradores
;****************************************

ROTER	ld hl,	MENCON
	ld (hl),	$FE
	jp SELREG

;****************************************
;	rotina de inicialização
;****************************************

INIT	ld hl,	BUFDSP
	ld (hl),	$FF
	inc hl
	ld (hl),	$FF
	inc hl
	ret

;****************************************
;   rotina de seleção de registradores
;****************************************

SELREG	ld de,	TABREG
	ld hl,	MENCON
	inc (hl)
	inc (hl)
	ld a,	e
	add a,	(hl)
NE12	ld e,	a
	ld a,	(de)
	ld l,	a
	inc de
	ld a,	(de)
	ld h,	a
	jp (hl)

;****************************************
;  rotina de alteração de registradores
;****************************************

ALTREG	ld hl,	MENCON
	ld de,	TABALT
	ld a,	e
	add a,	(hl)
	jp NE12

;****************************************
;	registrador a
;****************************************

REGA	call INIT
	ld (hl),	$88
	inc hl
	ld (hl),	$B7
	ld hl,	MENA
	jp ROTSA

;****************************************
;	rotina de saída
;****************************************

ROTSA	ld bc,	BYTES
	call DISPLY
	jp INICIO

;****************************************
;	altera registrador a
;****************************************

ALTA	ld hl,	MENA
	ld a,	b
	rld
	jp ROTSA

;****************************************
;	registrador b
;****************************************

REGB	call INIT
	ld (hl),	$83
	inc hl
	ld (hl),	$B7
	ld hl,	MENB
	jp ROTSA

;****************************************
;	altera registrador b
;****************************************

ALTB	ld hl,	MENB
	ld a,	b
	rld
	jp ROTSA

;****************************************
;	registrador c
;****************************************

REGC	call INIT
	ld (hl),	$C6
	inc hl
	ld (hl),	$B7
	ld hl,	MENC
	jp ROTSA

;****************************************
;	altera registrador c
;****************************************

ALTC	ld hl,	MENC
	ld a,	b
	rld ; A(LSB)->(HL)(LSB)->(HL)(LSB)->(HL)(MSB)->(HL)(MSB)->A(LSB)
	jp ROTSA

;****************************************
;	registrador d
;****************************************

REGD	call INIT
	ld (hl),	$A1
	inc hl
	ld (hl),	$B7
	ld hl,	MEND
	jp ROTSA

;****************************************
;	altera registrador d
;****************************************

ALTD	ld hl,	MEND
	ld a,	b
	rld ; A(LSB)->(HL)(LSB)->(HL)(LSB)->(HL)(MSB)->(HL)(MSB)->A(LSB)
	jp ROTSA

;****************************************
;	registrador e
;****************************************

REGE	call INIT
	ld (hl),	$86
	inc hl
	ld (hl),	$B7
	ld hl,	MENE
	jp ROTSA

;****************************************
;	altera registrador e
;****************************************

ALTE	ld hl,	MENE
	ld a,	b
	rld ; A(LSB)->(HL)(LSB)->(HL)(LSB)->(HL)(MSB)->(HL)(MSB)->A(LSB)
	jp ROTSA

;****************************************
;	registrador h
;****************************************

REGH	call INIT
	ld (hl),	$89
	inc hl
	ld (hl),	$B7
	ld hl,	MENH
	jp ROTSA

;****************************************
;	altera registrador h
;****************************************

ALTH	ld hl,	MENH
	ld a,	b
	rld ; A(LSB)->(HL)(LSB)->(HL)(LSB)->(HL)(MSB)->(HL)(MSB)->A(LSB)
	jp ROTSA

;****************************************
;	registrador l
;****************************************

REGL	call INIT
	ld (hl),	$C7
	inc hl
	ld (hl),	$B7
	ld hl,	MENL
	jp ROTSA

;****************************************
;	altera registrador l
;****************************************

ALTL	ld hl,	MENL
	ld a,	b
	rld ; A(LSB)->(HL)(LSB)->(HL)(LSB)->(HL)(MSB)->(HL)(MSB)->A(LSB)
	jp ROTSA

;****************************************
;	registrador f
;****************************************

REGF	call INIT
	ld (hl),	$8E
	inc hl
	ld (hl),	$B7
	ld hl,	MENF
	jp ROTSA

;****************************************
;	altera registrador f
;****************************************

ALTF	ld hl,	MENF
	ld a,	b
	rld ; A(LSB)->(HL)(LSB)->(HL)(LSB)->(HL)(MSB)->(HL)(MSB)->A(LSB)
	jp ROTSA

;****************************************
;	registrador i
;****************************************

REGI	ld a,	i
	ld hl,	MENI
	ld (hl),	a
	call INIT
	ld (hl),	$F9
	inc hl
	ld (hl),	$B7
	ld hl,	MENI
	jp ROTSA

;****************************************
;	altera registrador i
;****************************************

ALTI	ld hl,	MENI
	ld a,	b
	rld ; A(LSB)->(HL)(LSB)->(HL)(LSB)->(HL)(MSB)->(HL)(MSB)->A(LSB)
	ld a,	(hl)
	ld i,	a
	jp ROTSA

;****************************************
;   rotina para o vetor de interrupção
;****************************************

RIV	ld bc,	ROTNMI
	ld a,	$C3		; $C3 = "jp"
	ld (bc),	a
	inc bc
	ld hl,	PBE
	ld a,	(hl)
	ld (bc),	a
	inc bc
	inc hl
	ld a,	(hl)
	ld (bc),	a
	jp OK	; INICIO

;****************************************
;   tabela de seleção de registradores
;****************************************

TABREG	dw REGA
	dw REGB
	dw REGC
	dw REGD
	dw REGE
	dw REGH
	dw REGL
	dw REGF
	dw REGI
	dw $ + 2
	jp ROTER

;****************************************
;  tabela de alteração de registradores
;****************************************

TABALT	dw ALTA
	dw ALTB
TABCOM	dw ALTC
	dw ALTD
	dw ALTE
	dw ALTH
	dw ALTL
	dw ALTF
	dw ALTI
	dw $00
	db $00

;****************************************
;   tabela de seleção de comandos
;****************************************

	db $00	; ROTPER (MSB)
	db $01	; ROTLT (MSB)
	db $01	; ROTUL (MSB)
	db $01	; ROTPR (MSB)
	db $01	; ROTRD (MSB)
	db $01	; ROTER (MSB)
	db $02	; RIV (MSB)
	db $01	; ROTCP (MSB)
	db $01	; ROTCD (MSB)
	db $00	; INICIO (MSB)
	db $F5	; ROTPER (LSB)
	db $1E	; ROTLT (LSB)
	db $AF	; ROTUL (LSB)
	db $9F	; ROTPR (LSB)
	db $C8	; ROTRD (LSB)
	db $E2	; ROTER (LSB)
	db $F1	; RIV (LSB)
	db $0F	; ROTCP (LSB)
	db $2F	; ROTCD (LSB)
	db $17	; INICIO (LSB)

DELAY	ld (CURMSG),	hl
	push bc		; save BC
	call DELAY1
	pop bc		; restore BC
	ret
DELAY1	ld c,	$05		; fill c too with max delay
DELAY2	ld hl,	(CURMSG)
	push bc
	call REST
	pop bc
	dec c
	jp nz,	DELAY2
	ret 		; retorna
INVALID	ld a,	$FF		; todos os LEDs
	out ($04),	a		; acende LEDs
	out ($05),	a
	ld hl,	INVMSG
	call DELAY
	ld a,	$00
	out ($04),	a
	out ($05),	a
	jp INICIO
OK	ld hl,	OKMSG
	call DELAY
	jp INICIO

INVMSG	db $F9,	$C8,	$C1,	$88,	$C7,	$FF
OKMSG	db $C0,	$8A,	$FF,	$FF,	$FF,	$FF
