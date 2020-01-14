;****************************************
;        PROGRAMA MONITOR NESTOR
;            NOVA ELETRÔNICA
;     SAO PAULO S.P. 01/84 MSCS/JRP
;****************************************

		.equ PDIG,	h'03	; saída coluna teclado e display
		.equ PSEG,	h'01	; saída caracter para o display
		.equ PTEC,	h'01	; entrada linha teclado
		.equ ATRASO,	h'0001
		.equ TOPSP,	h'0BE4
		.equ MENCON,	h'0BE5
		.equ FLAG,	h'0BE6
		.equ BUFDSP,	h'0BE7
		.equ BYTES,	h'0BEB
		.equ ENDISP,	h'0BED
		.equ PBE,	h'0BEE
		.equ PAE,	h'0BEF
		.equ ROT,	h'0BF0
		.equ ROTNMI,	h'0BF2
		.equ MENI,	h'0BF7
		.equ MENF,	h'0BF8
		.equ MENA,	h'0BF9
		.equ MENL,	h'0BFA
		.equ MENH,	h'0BFB
		.equ MENE,	h'0BFC
		.equ MEND,	h'0BFD
		.equ MENC,	h'0BFE
		.equ MENB,	h'0BFF
		.equ CURMSG,	h'0C00

		.org h'0000
		ld sp,	CURMSG	;$0C00
		push bc
		push de
		push hl
		push af
		ld hl,	FLAG
		ld (hl),	h'19
		ld hl,	MENS
		ld de,	BUFDSP
		ld bc,	h'0006
		ldir
INICIO:	ld sp,	TOPSP
		ld hl,	BUFDSP
		ld b,	h'00
		ld e,	h'06
		ld a,	h'01
NE1:	call VARR
		ld a,	c
		add a,	a
		dec e
		jp nz,	NE1
		ld a,	b
		cp h'00
		jp z,	INICIO
NE2:	ld hl,	BUFDSP
		call REST
		ld a,	d
		out (PDIG),	a
		in a,	(PTEC)
		cp h'00
		jp nz,	NE2
		call AJCOL
		call AJTEC
		cp h'13
		jp z,	NE3
		cp h'10
		jp c,	NE4
NE5:	call ALTCOM
NE6:	ld hl,	FLAG
		ld a,	(hl)
		jp RECCOM

MENS:	.db h'C8	; N
	.db h'86	; E
	.db h'92	; S
	.db h'87	; T
	.db h'C0	; O
	.db h'CE	; R
	.db h'00
	.db h'00
	.db h'00
	.db h'00

;****************************************
;  ponto de entrada de interrupção nmi
;****************************************

	;org $0066
NMINT:	jp ROTNMI

;****************************************
;  ROTINA DE RECONHECIMENTO DE COMANDOS
;****************************************

RECCOM:	ld hl,	TABCOM + 1
		add a,	l
		ld l,	a
		ld a,	(hl)
		ld c,	a
		ld a,	h'0A
		add a,	l
		ld l,	a
		ld l,	(hl)
		ld h,	c
		jp (hl)
NE3:	ld hl,	FLAG
		ld a,	(hl)
		cp h'15
		jp z,	SELREG
		jp NE5
NE4:	ld hl,	FLAG
		ld a,	(hl)
		cp h'15
		jp z,	ALTREG
		nop
		jp NE6

;****************************************
;  rotina de varredura
;****************************************

VARR:	ld c,	a
		call TEMPO
		in a,	(PTEC)
		cp h'00
		ret z
		ld b,	a
		ld d,	c
		ret

;****************************************
;  rotina de restauração
;****************************************

REST:	ld c,	h'06
		ld a,	h'01
NE7:	call TEMPO
		add a,	a
		dec c
		ret z
		jp NE7

;****************************************
;  rotina de tempo
;****************************************

TEMPO:	push af
		out (PDIG),	a
		ld a,	(hl)
		out (PSEG),	a
		exx
		ld de,	ATRASO
LOOP1:	dec de
		ld a,	d
		or e
		jp nz,	LOOP1
		exx
		inc hl
		pop af
		ret

;****************************************
;  rotina de ajuste de coluna
;****************************************

AJCOL:	ld c,	h'00
		ld a,	h'01
		cp d
		jp z,	NE8
		add a,	a
		ld c,	h'08
		cp d
		jp z,	NE8
		add a,	a
		ld c,	h'10
		cp d
		jp z,	NE8
		jp INICIO
NE8:	ld d,	c
		ret

;****************************************
;  rotina de ajuste de tecla
;****************************************

AJTEC:	ld e,	h'08
		ld c,	h'00
		ld a,	h'01
NE10:	cp b
		jp z,	NE9
		inc c
		add a,	a
		dec e
		jp nz,	NE10
		jp INICIO
NE9:	ld a,	c
		add a,	d
		ld b,	a
		nop
		ret

;****************************************
;  rotina de alterar comando
;****************************************

ALTCOM:	ld hl,	FLAG
		ld (hl),	b
		ret

;****************************************
;  rotina de permissão
;****************************************

ROTPER:	ld c,	h'06
		ld hl,	FLAG
		ld (hl),	h'17	; executando a rotina "Permissão"
		inc hl
NE11:	ld (hl),	h'C0	; h'FF
		inc hl
		dec c
		jp nz,	NE11
		ld (hl),	h'00
		inc hl
		ld (hl),	h'00
		inc hl
		ld (hl),	h'00
		jp INICIO

;****************************************
;  rotina de campo de endereços
;****************************************

ROTCP:	ld hl,	PBE
		ld a,	b
		rld
		inc hl
		rld
		call DECOD
		jp INICIO

;****************************************
;  rotina de leitura
;****************************************

ROTLT:	call ATUAL
		ld hl,	FLAG
		ld (hl),	h'18
		ld hl,	PAE
		call DECOD
		jp INICIO

;****************************************
;  rotina de campo de dados
;****************************************

ROTCD:	call ATUAL
		ld a,	b
		rld
		ld a,	(hl)
		ld (de),	a
		ld hl,	PAE
		call DECOD
		jp INICIO

;****************************************
;  rotina de atualização
;****************************************

ATUAL:	ld hl,	PBE
		ld e,	(hl)
		inc hl
		ld d,	(hl)
		ld a,	(de)
		dec hl
		dec hl
		ld (hl),	a
		push hl
		ld hl,	FLAG
		ld (hl),	h'18
		pop hl
		ret

;****************************************
;  rotina de decodificação
;****************************************

DECOD:	ld bc,	BUFDSP
		call DISPLY
		dec hl
		call DISPLY
		dec hl
		call DISPLY
		ret

;****************************************
;  rotina de ajuste memória de endereço
;****************************************

RAME:	ld hl,	PBE
		ld (hl),	e
		inc hl
		ld (hl),	d
		dec hl
		dec hl
		ld a,	(de)
		ld (hl),	a
		ret
		.dw h'FFFF

;****************************************
;  rotina de display
;****************************************

DISPLY:	ld a,	(hl)
		push hl
		ld hl,	ROT
		ld (hl),	a
		xor a
		rld
		call FORMAT
		ld (bc),	a
		inc bc
		xor a
		rld
		call FORMAT
		ld (bc),	a
		inc bc
		pop hl
		ret

;****************************************
;  rotina de formatação
;****************************************

FORMAT:	push de
		ld de,	INTD
		add a,	e
		ld e,	a
		ld a,	(de)
		pop de
		ret

;****************************************
;  tabela de formatos alfa (números)
;****************************************

INTD:	.db h'C0
		.db h'F9
		.db h'A4
		.db h'B0
		.db h'99
		.db h'92
		.db h'82
		.db h'F8
		.db h'80
		.db h'90
		.db h'88
		.db h'83
		.db h'C6
		.db h'A1
		.db h'86
		.db h'8E

;****************************************
;  rotina de próximo
;****************************************

ROTPR:	call ATUAL
		inc de
		call RAME
		ld hl,	PAE
		call DECOD
		jp INICIO

;****************************************
;  rotina de último
;****************************************

ROTUL:	call ATUAL
		dec de
		call RAME
		ld hl,	PAE
		call DECOD
		jp INICIO

;****************************************
;  rotina de rodar
;****************************************

		.org h'01C8
ROTRD:	ld a,	h'FF
		out (PDIG),	a
		ld a,	h'7F
		out (PSEG),	a
		ld hl,	ENDISP
		ld (hl),	h'C3	; h'C3 = "jp"
		ld sp,	MENF
		push af
		push hl
		push de
		push bc
		ld sp,	TOPSP
		jp ENDISP

;****************************************
;  rotina de exame de registradores
;****************************************

ROTER:	ld hl,	MENCON
		ld (hl),	h'FE
		jp SELREG

;****************************************
;  rotina de INICIALização
;****************************************

INIT:	ld hl,	BUFDSP
		ld (hl),	h'FF
		inc hl
		ld (hl),	h'FF
		inc hl
		ret

;****************************************
;  rotina de seleção de registradores
;****************************************

SELREG:	ld de,	TABREG
		ld hl,	MENCON
		inc (hl)
		inc (hl)
		ld a,	e
		add a,	(hl)
NE12:	ld e,	a
		ld a,	(de)
		ld l,	a
		inc de
		ld a,	(de)
		ld h,	a
		jp (hl)

;****************************************
;  rotina de alteração de registradores
;****************************************

ALTREG:	ld hl,	MENCON
		ld de,	TABALT
		ld a,	e
		add a,	(hl)
		jp NE12

;****************************************
;  registrador a
;****************************************

REGA:	call INIT
		ld (hl),	h'88
		inc hl
		ld (hl),	h'B7
		ld hl,	MENA
		jp ROTSA

;****************************************
;  rotina de saída
;****************************************

ROTSA:	ld bc,	BYTES
		call DISPLY
		jp INICIO

;****************************************
;  altera registrador a
;****************************************

ALTA:	ld hl,	MENA
		ld a,	b
		rld
		jp ROTSA

;****************************************
;  registrador b
;****************************************

REGB:	call INIT
		ld (hl),	h'83
		inc hl
		ld (hl),	h'B7
		ld hl,	MENB
		jp ROTSA

;****************************************
;  altera registrador b
;****************************************

ALTB:	ld hl,	MENB
		ld a,	b
		rld
		jp ROTSA

;****************************************
;  registrador c
;****************************************

REGC:	call INIT
		ld (hl),	h'C6
		inc hl
		ld (hl),	h'B7
		ld hl,	MENC
		jp ROTSA

;****************************************
;  altera registrador c
;****************************************

ALTC:	ld hl,	MENC
		ld a,	b
		rld
		jp ROTSA

;****************************************
;  registrador d
;****************************************

REGD:	call INIT
		ld (hl),	h'A1
		inc hl
		ld (hl),	h'B7
		ld hl,	MEND
		jp ROTSA

;****************************************
;  altera registrador d
;****************************************

ALTD:	ld hl,	MEND
		ld a,	b
		rld
		jp ROTSA

;****************************************
;  registrador e
;****************************************

REGE:	call INIT
		ld (hl),	h'86
		inc hl
		ld (hl),	h'B7
		ld hl,	MENE
		jp ROTSA

;****************************************
;  altera registrador e
;****************************************

ALTE:	ld hl,	MENE
		ld a,	b
		rld
		jp ROTSA

;****************************************
;  registrador h
;****************************************

REGH:	call INIT
		ld (hl),	h'89
		inc hl
		ld (hl),	h'B7
		ld hl,	MENH
		jp ROTSA

;****************************************
;  altera registrador h
;****************************************

ALTH:	ld hl,	MENH
		ld a,	b
		rld
		jp ROTSA

;****************************************
;  registrador l
;****************************************

REGL:	call INIT
		ld (hl),	h'C7
		inc hl
		ld (hl),	h'B7
		ld hl,	MENL
		jp ROTSA

;****************************************
;  altera registrador l
;****************************************

ALTL:	ld hl,	MENL
		ld a,	b
		rld
		jp ROTSA

;****************************************
;  registrador f
;****************************************

REGF:	call INIT
		ld (hl),	h'8E
		inc hl
		ld (hl),	h'B7
		ld hl,	MENF
		jp ROTSA

;****************************************
;  altera registrador f
;****************************************

ALTF:	ld hl,	MENF
		ld a,	b
		rld
		jp ROTSA

;****************************************
;  registrador i
;****************************************

REGI:	ld a,	i
		ld hl,	MENI
		ld (hl),	a
		call INIT
		ld (hl),	h'F9
		inc hl
		ld (hl),	h'B7
		ld hl,	MENI
		jp ROTSA

;****************************************
;  altera registrador i
;****************************************

ALTI:	ld hl,	MENI
		ld a,	b
		rld
		ld a,	(hl)
		ld i,	a
		jp ROTSA

;****************************************
;  rotina para o vetor de interrupção
;****************************************

RIV:	ld bc,	ROTNMI
		ld a,	h'C3		; h'C3 = "jp"
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
;  tabela de seleção de registradores
;****************************************

TABREG:	.dw REGA
		.dw REGB
		.dw REGC
		.dw REGD
		.dw REGE
		.dw REGH
		.dw REGL
		.dw REGF
		.dw REGI
		.dw $ + 2
		jp ROTER

;****************************************
;  tabela de alteração de registradores
;****************************************

TABALT:	.dw ALTA
		.dw ALTB
TABCOM:	.dw ALTC
		.dw ALTD
		.dw ALTE
		.dw ALTH
		.dw ALTL
		.dw ALTF
		.dw ALTI
		.dw h'00
		.db h'00

;****************************************
;  tabela de seleção de comandos
;****************************************

		.db h'00	; ROTPER (MSB)
		.db h'01	; ROTLT (MSB)
		.db h'01	; ROTUL (MSB)
		.db h'01	; ROTPR (MSB)
		.db h'01	; ROTRD (MSB)
		.db h'01	; ROTER (MSB)
		.db h'02	; RIV (MSB)
		.db h'01	; ROTCP (MSB)
		.db h'01	; ROTCD (MSB)
		.db h'00	; INICIO (MSB)
		.db h'F5	; ROTPER (LSB)
		.db h'1E	; ROTLT (LSB)
		.db h'AF	; ROTUL (LSB)
		.db h'9F	; ROTPR (LSB)
		.db h'C8	; ROTRD (LSB)
		.db h'E2	; ROTER (LSB)
		.db h'F1	; RIV (LSB)
		.db h'0F	; ROTCP (LSB)
		.db h'2F	; ROTCD (LSB)
		.db h'17	; INICIO (LSB)

DELAY:	ld (CURMSG),	hl
		push bc		; save BC
		call DELAY1
		pop bc		; restore BC
		ret
DELAY1:	ld c,	h'05		; fill c too with max delay
DELAY2:	ld hl,	(CURMSG)
		push bc
		call REST
		pop bc
		dec c
		jp nz,	DELAY2
		ret 		; retorna
INVALID:	ld a,	h'FF		; todos os LEDs
		out (h'04),	a		; acende LEDs
		out (h'05),	a
		ld hl,	INVMSG
		call DELAY
		ld a,	h'00
		out (h'04),	a
		out (h'05),	a
		jp INICIO
OK:		ld hl,	OKMSG
		call DELAY
		jp INICIO

INVMSG:	.db h'F9,	h'C8,	h'C1,	h'88,	h'C7,	h'FF
OKMSG:	.db h'C0,	h'8A,	h'FF,	h'FF,	h'FF,	h'FF

