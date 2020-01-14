;****************************************
;	   PROGRAMA MONITOR NESTOR
;	       NOVA ELETRÔNICA
;	SAO PAULO S.P. 01/84 MSCS/JRP
;****************************************

	.equ PDIG, 	h'03 ; saída coluna teclado e display
	.equ PSEG, 	h'01 ; saída caracter para o display
	.equ PTEC, 	h'01 ; entrada linha teclado

	.equ ATRASO, 	h'0001
	.equ TOPSP, 	h'0be4
	.equ MENCON, 	h'0be5
	.equ FLAG, 	h'0be6
	.equ BUFDISP, 	h'0be7
	.equ BYTES, 	h'0beb
	.equ ENDISP, 	h'0bed
	.equ PBE, 	h'0bee
	.equ PAE, 	h'0bef
	.equ ROT, 	h'0bf0
	.equ ROTNMI, 	h'0bf2
	.equ MENI, 	h'0bf7
	.equ MENF, 	h'0bf8
	.equ MENA, 	h'0bf9
	.equ MENL, 	h'0bfa
	.equ MENH, 	h'0bfb
	.equ MENE, 	h'0bfc
	.equ MEND, 	h'0bfd
	.equ MENC, 	h'0bfe
	.equ MENB, 	h'0bff

		.org h'0000
		ld sp, h'0c00
		push bc
		push de
		push hl
		push af
		ld hl, FLAG
		ld (hl), h'19
		ld hl, MENS
		ld de, BUFDISP
		ld bc, h'0006
		ldir
INICIO:	ld sp, TOPSP
		ld hl, BUFDISP
		ld b, h'00
		ld e, h'06
		ld a, h'01
NE1:	call VARR
		ld a, c
		add a, a
		dec e
		jp nz, NE1
		ld a, b
		cp h'00
		jp z, INICIO
NE2:	ld hl, BUFDISP
		call REST
		ld a, d
		out (PDIG), a
		in a, (PTEC)
		cp h'00
		jp nz, NE2
		call AJCOL
		call AJTEC
		cp h'13
		jp z, NE3
		cp h'10
		jp c, NE4
NE5:	call ALTCOM
NE6:	ld hl, FLAG
		ld a, (hl)
		jp RECCOM

;****************************************
;  MENSAGEM INICIAL
;****************************************

MENS:	.db h'c8; N
		.db h'86; E
		.db h'92; S
		.db h'87; T
		.db h'c0; O
		.db h'ce; R
		.db h'00
		.db h'00
		.db h'00
		.db h'00

;****************************************
;  ponto de entrada de interrupção nmi
;****************************************

NMINT:	jp ROTNMI	; antes estava "RIV"
;
RECCOM:	ld hl, TABCOM+1
		add a, l
		ld l, a
		ld a, (hl)
		ld c, a
		ld a, h'0a
		add a, l
		ld l, a
		ld l, (hl)
		ld h, c
		jp (hl)
NE3:	ld hl, FLAG
		ld a, (hl)
		cp h'15
		jp z, SELREG
		jp NE5
NE4:	ld hl, FLAG
		ld a, (hl)
		cp h'15
		jp z, ALTREG
		nop
		jp NE6

;****************************************
;	rotina de varredura
;****************************************

VARR:	ld c, a
		call TEMPO
		in a, (PTEC)
		cp h'00
		ret z
		ld b, a
		ld d, c
		ret

;****************************************
;	rotina de restauração
;****************************************

REST:	ld c, h'06
		ld a, h'01
NE7:	call TEMPO
		add a, a
		dec c
		ret z
		jp NE7

;****************************************
;	rotina de tempo
;****************************************

TEMPO:	push af
		out (PDIG), a
		ld a, (hl)
		out (PSEG), a
		exx
		ld de, ATRASO
LOOP1:	dec de
		ld a, d
		or e
		jp nz, LOOP1
		exx
		inc hl
		pop af
		ret

;****************************************
;	rotina de ajuste de coluna
;****************************************

AJCOL:	ld c, h'00
		ld a, h'01
		cp d
		jp z, NE8
		add a, a
		ld c, h'08
		cp d
		jp z, NE8
		add a, a
		ld c, h'10
		cp d
		jp z, NE8
		jp INICIO
NE8:	ld d, c
		ret

;****************************************
;	rotina de ajuste de tecla
;****************************************

AJTEC:	ld e, h'08
		ld c, h'00
		ld a, h'01
NE10:	cp b
		jp z, NE9
		inc c
		add a, a
		dec e
		jp nz, NE10
		jp INICIO
NE9:	ld a, c
		add a, d
		ld b, a
		nop
		ret

;****************************************
;	rotina de alterar comando
;****************************************

ALTCOM:	ld hl, FLAG
		ld (hl), b
		ret

;****************************************
;	rotina de permissão
;****************************************

ROTPER:	ld c, h'06
		ld hl, FLAG
		ld (hl), h'17
		inc hl
NE11:	ld (hl), h'FF
		inc hl
		dec c
		jp nz, NE11
		ld (hl), h'00
		inc hl
		ld (hl), h'00
		inc hl
		ld (hl), h'00
		jp INICIO

;****************************************
;	rotina de campo de endereços
;****************************************

ROTCP:	ld hl, PBE
		ld a, b
		rld
		inc hl
		rld
		call DECOD
		jp INICIO

;****************************************
;	rotina de leitura
;****************************************

ROTLT:	call ATUAL
		ld hl, FLAG
		ld (hl), h'18
		ld hl, PAE
		call DECOD
		jp INICIO

;****************************************
;	rotina de campo de dados
;****************************************

ROTCD:	call ATUAL
		ld a, b
		rld
		ld a, (hl)
		ld (de), a
		ld hl, PAE
		call DECOD
		jp INICIO

;****************************************
;	rotina de atualização
;****************************************

ATUAL:	ld hl, PBE
		ld e, (hl)
		inc hl
		ld d, (hl)
		ld a, (de)
		dec hl
		dec hl
		ld (hl), a
		push hl
		ld hl, FLAG
		ld (hl), h'18
		pop hl
		ret

;****************************************
;	rotina de DECODificação
;****************************************

DECOD:	ld bc, BUFDISP
		call DISPLY
		dec hl
		call DISPLY
		dec hl
		call DISPLY
		ret

;****************************************
;  rotina de ajuste memória de endereço
;****************************************

RAME:	ld hl, PBE
		ld (hl), e
		inc hl
		ld (hl), d
		dec hl
		dec hl
		ld a, (de)
		ld (hl), a
		ret
		.dw h'ffff

;****************************************
;	rotina de DISPLY
;****************************************

DISPLY:	ld a, (hl)
		push hl
		ld hl, ROT
		ld (hl), a
		xor a
		rld
		call FORMAT
		ld (bc), a
		inc bc
		xor a
		rld
		call FORMAT
		ld (bc), a
		inc bc
		pop hl
		ret

;****************************************
;	rotina de formatação
;****************************************

FORMAT:	push de
		ld de, INTD
		add a, e
		ld e, a
		ld a, (de)
		pop de
		ret

;****************************************
;	tabela de formatos alfa (números)
;****************************************

INTD:	.db h'c0
		.db h'f9
		.db h'a4
		.db h'b0
		.db h'99
		.db h'92
		.db h'82
		.db h'f8
		.db h'80
		.db h'90
		.db h'88
		.db h'83
		.db h'c6
		.db h'a1
		.db h'86
		.db h'8e

;****************************************
;	rotina de próximo
;****************************************

ROTPR:	call ATUAL
		inc de
		call RAME
		ld hl, PAE
		call DECOD
		jp INICIO

;****************************************
;	rotina de último
;****************************************

ROTUL:	call ATUAL
		dec de
		call RAME
		ld hl, PAE
		call DECOD
		jp INICIO

;****************************************
;	rotina de rodar
;****************************************

		.org h'01c8
ROTRD:	ld a, h'FF
		out (PDIG), a
		ld a, h'7f
		out (PSEG), a
		ld hl, ENDISP; antes estava "MEND"
		ld (hl), h'c3; h'c3 = "jp"
		ld sp, MENF	; antes estava "MENI"
		push af
		push hl
		push de
		push bc
		ld sp, TOPSP
		jp ENDISP

;****************************************
;    rotina de exame de registradores
;****************************************

ROTER:	ld hl, MENCON
		ld (hl), h'FE
		jp SELREG

;****************************************
;	rotina de inicialização
;****************************************

INIT:	ld hl, BUFDISP
		ld (hl), h'FF
		inc hl
		ld (hl), h'FF
		inc hl
		ret

;****************************************
;   rotina de seleção de registradores
;****************************************

SELREG:	ld de, TABREG
		ld hl, MENCON
		inc (hl)
		inc (hl)
		ld a, e
		add a, (hl)
NE12:	ld e, a
		ld a, (de)
		ld l, a
		inc de
		ld a, (de)
		ld h, a
		jp (hl)

;****************************************
;  rotina de alteração de registradores
;****************************************

ALTREG:	ld hl, MENCON
		ld de, TABALT
		ld a, e
		add a, (hl)
		jp NE12

;****************************************
;	registrador a
;****************************************

REGA:	call INIT
		ld (hl), h'88
		inc hl
		ld (hl), h'b7
		ld hl, MENA
		jp ROTSA

;****************************************
;	rotina de saída
;****************************************

ROTSA:	ld bc, BYTES
		call DISPLY
		jp INICIO

;****************************************
;	altera registrador a
;****************************************

ALTA:	ld hl, MENA
		ld a, b
		rld
		jp ROTSA

;****************************************
;	registrador b
;****************************************

REGB:	call INIT
		ld (hl), h'83
		inc hl
		ld (hl), h'b7
		ld hl, MENB
		jp ROTSA

;****************************************
;	altera registrador b
;****************************************

ALTB:	ld hl, MENB
		ld a, b
		rld
		jp ROTSA

;****************************************
;	registrador c
;****************************************

REGC:	call INIT
		ld (hl), h'c6
		inc hl
		ld (hl), h'b7
		ld hl, MENC
		jp ROTSA

;****************************************
;	altera registrador c
;****************************************

ALTC:	ld hl, MENC
		ld a, b
		rld
		jp ROTSA

;****************************************
;	registrador d
;****************************************

REGD:	call INIT
		ld (hl), h'a1
		inc hl
		ld (hl), h'b7
		ld hl, MEND
		jp ROTSA

;****************************************
;	altera registrador d
;****************************************

ALTD:	ld hl, MEND
		ld a, b
		rld
		jp ROTSA

;****************************************
;	registrador e
;****************************************

REGE:	call INIT
		ld (hl), h'86
		inc hl
		ld (hl), h'b7
		ld hl, MENE
		jp ROTSA

;****************************************
;	altera registrador e
;****************************************

ALTE:	ld hl, MENE
		ld a, b
		rld
		jp ROTSA

;****************************************
;	registrador h
;****************************************

REGH:	call INIT
		ld (hl), h'89
		inc hl
		ld (hl), h'b7
		ld hl, MENH
		jp ROTSA

;****************************************
;	altera registrador h
;****************************************

ALTH:	ld hl, MENH
		ld a, b
		rld
		jp ROTSA

;****************************************
;	registrador l
;****************************************

REGL:	call INIT
		ld (hl), h'c7
		inc hl
		ld (hl), h'b7
		ld hl, MENL
		jp ROTSA

;****************************************
;	altera registrador l
;****************************************

ALTL:	ld hl, MENL
		ld a, b
		rld
		jp ROTSA

;****************************************
;	registrador f
;****************************************

REGF:	call INIT
		ld (hl), h'8e
		inc hl
		ld (hl), h'b7
		ld hl, MENF
		jp ROTSA

;****************************************
;	altera registrador f
;****************************************

ALTF:	ld hl, MENF
		ld a, b
		rld
		jp ROTSA

;****************************************
;	registrador i
;****************************************

REGI:	ld a, i
		ld hl, MENI
		ld (hl), a
		call INIT
		ld (hl), h'f9
		inc hl
		ld (hl), h'b7
		ld hl, MENI
		jp ROTSA

;****************************************
;	altera registrador i
;****************************************

ALTI:	ld hl, MENI
		ld a, b
		rld
		ld a, (hl)
		ld i, a
		jp ROTSA

;****************************************
;   rotina para o vetor de interrupção
;****************************************

RIV:	ld bc, ROTNMI
		ld a, h'c3	; h'c3 = "jp"
		ld (bc), a
		inc bc
		ld hl, PBE
		ld a, (hl)
		ld (bc), a
		inc bc
		inc hl
		ld a, (hl)
		ld (bc), a
		jp INICIO

;****************************************
;   tabela de seleção de registradores
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
		.db h'00
		.db h'00
		.db h'00

;****************************************
;   tabela de seleção de comandos
;****************************************

		.db h'00; ROTPER (MSB)
		.db h'01; ROTLT (MSB)
		.db h'01; ROTUL (MSB)
		.db h'01; ROTPR (MSB)
		.db h'01; ROTRD (MSB)
		.db h'01; ROTER (MSB)
		.db h'02; RIV (MSB)
		.db h'01; ROTCP (MSB)
		.db h'01; ROTCD (MSB)
		.db h'00; INICIO (MSB)
		.db h'f5; ROTPER (LSB)
		.db h'1e; ROTLT (LSB)
		.db h'af; ROTUL (LSB)
		.db h'9f; ROTPR (LSB)
		.db h'c8; ROTRD (LSB)
		.db h'e2; ROTER (LSB)
		.db h'f1; RIV (LSB)
		.db h'0f; ROTCP (LSB)
		.db h'2f; ROTCD (LSB)
		.db h'17; INICIO (LSB)

