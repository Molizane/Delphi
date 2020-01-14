;****************************************
;	   PROGRAMA MONITOR NESTOR
;	       NOVA ELETRÔNICA
;	SAO PAULO S.P. 01/84 MSCS/JRP
;****************************************

		.equ PDIG,	h'03	; saída coluna teclado e display
		.equ PSEG,	h'01	; saída caracter para o display
		.equ PTEC,	h'01	; entrada linha teclado
		.equ ATRASO,	h'0001

		.org h'0000
		ld sp, CURMSG
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

MENS:	.db h'C8	; N
			.db h'86	; E
			.db h'92	; S
			.db h'87	; T
			.db h'C0	; O
			.db h'CE	; R

;****************************************
;  PONTO DE ENTRADA DE INTERRUPÇÃO NMI
;****************************************

		.org h'0066
NMINT:	jp ROTNMI

;****************************************
;  ROTINA DE RECONHECIMENTO DE COMANDOS
;****************************************

RECCOM:	ld hl, TABCOM+1
		add a, l
		ld l, a
		ld a, (hl)
		ld c, a
		ld a, h'0A
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
		;nop
		jp NE6

;****************************************
;	ROTINA DE VARREDURA
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
;	ROTINA DE RESTAURAÇÃO
;****************************************

REST:	ld c, h'06
		ld a, h'01
NE7:	call TEMPO
		add a, a
		dec c
		ret z
		jp NE7

;****************************************
;	ROTINA DE TEMPO
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
;	ROTINA DE AJUSTE DE COLUNA
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
;	ROTINA DE AJUSTE DE TECLA
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
;	ROTINA DE ALTERAR COMANDO
;****************************************

ALTCOM:	ld hl, FLAG
		ld (hl), b
		ret

;****************************************
;	ROTINA DE PERMISSÃO
;****************************************

ROTPER:	ld c, h'06
		ld hl, FLAG
		ld (hl), h'17	; executando a rotina "Permissão"
		inc hl
NE11:	ld (hl), h'C0	; h'FF
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
;	ROTINA DE CAMPO DE ENDEREÇOS
;****************************************

ROTCP:	ld hl, PBE
		ld a, b
		rld ; A(LSB)->(HL)(LSB)->(HL)(LSB)->(HL)(MSB)->(HL)(MSB)->A(LSB)
		inc hl
		rld ; A(LSB)->(HL)(LSB)->(HL)(LSB)->(HL)(MSB)->(HL)(MSB)->A(LSB)
		call DECOD
		jp INICIO

;****************************************
;	ROTINA DE LEITURA
;****************************************

ROTLT:	call ATUAL
		ld hl, FLAG
		ld (hl), h'18
		ld hl, PAE
		call DECOD
		jp INICIO

;****************************************
;	ROTINA DE CAMPO DE DADOS
;****************************************

ROTCD:	call ATUAL
		ld a, b
		rld ; A(LSB)->(HL)(LSB)->(HL)(LSB)->(HL)(MSB)->(HL)(MSB)->A(LSB)
		ld a, (hl)
		ld (de), a
		ld hl, PAE
		call DECOD
		jp INICIO

;****************************************
;	ROTINA DE ATUALIZAÇÃO
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
;	ROTINA DE DECODIFICAÇÃO
;****************************************

DECOD:	ld bc, BUFDISP
		call DISPLY
		dec hl
		call DISPLY
		dec hl
		call DISPLY
		ret

;****************************************
;  ROTINA DE AJUSTE MEMÓRIA DE ENDEREÇO
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

;****************************************
;	ROTINA DE DISPLAY
;****************************************

DISPLY:	ld a, (hl)
		push hl
		ld hl, ROT
		ld (hl), a
		xor a
		rld ; A(LSB)->(HL)(LSB)->(HL)(LSB)->(HL)(MSB)->(HL)(MSB)->A(LSB)
		call FORMAT
		ld (bc), a
		inc bc
		xor a
		rld ; A(LSB)->(HL)(LSB)->(HL)(LSB)->(HL)(MSB)->(HL)(MSB)->A(LSB)
		call FORMAT
		ld (bc), a
		inc bc
		pop hl
		ret

;****************************************
;	ROTINA DE FORMATAÇÃO
;****************************************

FORMAT:	push de
		ld de, INTD
		add a, e
		ld e, a
		ld a, (de)
		pop de
		ret

;****************************************
;	TABELA DE FORMATOS ALFA (NÚMEROS)
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
;	ROTINA DE PRÓXIMO
;****************************************

ROTPR:	call ATUAL
		inc de
		call RAME
		ld hl, PAE
		call DECOD
		jp INICIO

;****************************************
;	ROTINA DE ÚLTIMO
;****************************************

ROTUL:	call ATUAL
		dec de
		call RAME
		ld hl, PAE
		call DECOD
		jp INICIO

;****************************************
;	ROTINA DE RODAR
;****************************************

; para ajustar a posição das rotinas de exame de registradores
		.dw 0, 0, 0, 0

ROTRD:	ld a, h'FF
		out (PDIG), a
		ld a, h'7F
		out (PSEG), a
		ld hl, ENDISP
		ld (hl), h'C3	; h'C3 = "jp"
		ld sp, MENF
		push af
		push hl
		push de
		push bc
		ld sp, TOPSP
		jp ENDISP

;****************************************
;    ROTINA DE EXAME DE REGISTRADORES
;****************************************

ROTER:	ld hl, MENCON
		ld (hl), h'FE
		jp SELREG

;****************************************
;	ROTINA DE INICIALIZAÇÃO
;****************************************

INICIAL:	ld hl, BUFDISP
		ld (hl), h'FF
		inc hl
		ld (hl), h'FF
		inc hl
		ret

;****************************************
;   ROTINA DE SELEÇÃO DE REGISTRADORES
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
;  ROTINA DE ALTERAÇÃO DE REGISTRADORES
;****************************************

ALTREG:	ld hl, MENCON
		ld de, TABALT
		ld a, e
		add a, (hl)
		jp NE12

;****************************************
;	REGISTRADOR A
;****************************************

REGA:	call INICIAL
		ld (hl), h'88
		inc hl
		ld (hl), h'B7
		ld hl, MENA
		jp ROTSA

;****************************************
;	ROTINA DE SAÍDA
;****************************************

ROTSA:	ld bc, BYTES
		call DISPLY
		jp INICIO

;****************************************
;	ALTERA REGISTRADOR A
;****************************************

ALTA:	ld hl, MENA
		ld a, b
		rld ; A(LSB)->(HL)(LSB)->(HL)(LSB)->(HL)(MSB)->(HL)(MSB)->A(LSB)
		jp ROTSA

;****************************************
;	REGISTRADOR B
;****************************************

REGB:	call INICIAL
		ld (hl), h'83
		inc hl
		ld (hl), h'B7
		ld hl, MENB
		jp ROTSA

;****************************************
;	ALTERA REGISTRADOR B
;****************************************

ALTB:	ld hl, MENB
		ld a, b
		rld ; A(LSB)->(HL)(LSB)->(HL)(LSB)->(HL)(MSB)->(HL)(MSB)->A(LSB)
		jp ROTSA

;****************************************
;	REGISTRADOR C
;****************************************

REGC:	call INICIAL
		ld (hl), h'C6
		inc hl
		ld (hl), h'B7
		ld hl, MENC
		jp ROTSA

;****************************************
;	ALTERA REGISTRADOR C
;****************************************

ALTC:	ld hl, MENC
		ld a, b
		rld ; A(LSB)->(HL)(LSB)->(HL)(LSB)->(HL)(MSB)->(HL)(MSB)->A(LSB)
		jp ROTSA

;****************************************
;	REGISTRADOR D
;****************************************

REGD:	call INICIAL
		ld (hl), h'A1
		inc hl
		ld (hl), h'B7
		ld hl, MEND
		jp ROTSA

;****************************************
;	ALTERA REGISTRADOR D
;****************************************

ALTD:	ld hl, MEND
		ld a, b
		rld ; A(LSB)->(HL)(LSB)->(HL)(LSB)->(HL)(MSB)->(HL)(MSB)->A(LSB)
		jp ROTSA

;****************************************
;	REGISTRADOR E
;****************************************

REGE:	call INICIAL
		ld (hl), h'86
		inc hl
		ld (hl), h'B7
		ld hl, MENE
		jp ROTSA

;****************************************
;	ALTERA REGISTRADOR E
;****************************************

ALTE:	ld hl, MENE
		ld a, b
		rld ; A(LSB)->(HL)(LSB)->(HL)(LSB)->(HL)(MSB)->(HL)(MSB)->A(LSB)
		jp ROTSA

;****************************************
;	REGISTRADOR H
;****************************************

REGH:	call INICIAL
		ld (hl), h'89
		inc hl
		ld (hl), h'B7
		ld hl, MENH
		jp ROTSA

;****************************************
;	ALTERA REGISTRADOR H
;****************************************

ALTH:	ld hl, MENH
		ld a, b
		rld ; A(LSB)->(HL)(LSB)->(HL)(LSB)->(HL)(MSB)->(HL)(MSB)->A(LSB)
		jp ROTSA

;****************************************
;	REGISTRADOR L
;****************************************

REGL:	call INICIAL
		ld (hl), h'C7
		inc hl
		ld (hl), h'B7
		ld hl, MENL
		jp ROTSA

;****************************************
;	ALTERA REGISTRADOR L
;****************************************

ALTL:	ld hl, MENL
		ld a, b
		rld ; A(LSB)->(HL)(LSB)->(HL)(LSB)->(HL)(MSB)->(HL)(MSB)->A(LSB)
		jp ROTSA

;****************************************
;	REGISTRADOR F
;****************************************

REGF:	call INICIAL
		ld (hl), h'8E
		inc hl
		ld (hl), h'B7
		ld hl, MENF
		jp ROTSA

;****************************************
;	ALTERA REGISTRADOR F
;****************************************

ALTF:	ld hl, MENF
		ld a, b
		rld ; A(LSB)->(HL)(LSB)->(HL)(LSB)->(HL)(MSB)->(HL)(MSB)->A(LSB)
		jp ROTSA

;****************************************
;	REGISTRADOR I
;****************************************

REGI:	ld a, i
		ld hl, MENI
		ld (hl), a
		call INICIAL
		ld (hl), h'F9
		inc hl
		ld (hl), h'B7
		ld hl, MENI
		jp ROTSA

;****************************************
;	ALTERA REGISTRADOR I
;****************************************

ALTI:	ld hl, MENI
		ld a, b
		rld ; A(LSB)->(HL)(LSB)->(HL)(LSB)->(HL)(MSB)->(HL)(MSB)->A(LSB)
		ld a, (hl)
		ld i, a
		jp ROTSA

;****************************************
;   ROTINA PARA O VETOR DE INTERRUPÇÃO
;****************************************

RIV:	ld bc, ROTNMI
		ld a, h'C3		; h'C3 = "jp"
		ld (bc), a
		inc bc
		ld hl, PBE
		ld a, (hl)
		ld (bc), a
		inc bc
		inc hl
		ld a, (hl)
		ld (bc), a
		jp OK ; INICIO

;****************************************
;   TABELA DE SELEÇÃO DE REGISTRADORES
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
;  TABELA DE ALTERAÇÃO DE REGISTRADORES
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
;   TABELA DE SELEÇÃO DE COMANDOS
;****************************************

		.db (ROTPER >> 8) & h'FF	; ROTPER (MSB)
		.db (ROTLT >> 8) & h'FF	; ROTLT (MSB)
		.db (ROTUL >> 8) & h'FF	; ROTUL (MSB)
		.db (ROTPR >> 8) & h'FF	; ROTPR (MSB)
		.db (ROTRD >> 8) & h'FF	; ROTRD (MSB)
		.db (ROTER >> 8) & h'FF	; ROTER (MSB)
		.db (RIV >> 8) & h'FF	; RIV (MSB)
		.db (ROTCP >> 8) & h'FF	; ROTCP (MSB)
		.db (ROTCD >> 8) & h'FF	; ROTCD (MSB)
		.db (INICIO >> 8) & h'FF	; INICIO (MSB)

		.db ROTPER & h'FF		; ROTPER (LSB)
		.db ROTLT & h'FF		; ROTLT (LSB)
		.db ROTUL & h'FF		; ROTUL (LSB)
		.db ROTPR & h'FF		; ROTPR (LSB)
		.db ROTRD & h'FF		; ROTRD (LSB)
		.db ROTER & h'FF		; ROTER (LSB)
		.db RIV & h'FF		; RIV (LSB)
		.db ROTCP & h'FF		; ROTCP (LSB)
		.db ROTCD & h'FF		; ROTCD (LSB)
		.db INICIO & h'FF		; INICIO (LSB)

DELAY:	ld (CURMSG), hl
		push bc		; save BC
		call DELAY1
		pop bc		; restore BC
		ret
DELAY1:	ld c, h'05		; fill c too with max delay
DELAY2:	ld hl, (CURMSG)
		push bc
		call REST
		pop bc
		dec c
		jp nz, DELAY2
		ret 		; retorna
INVALID:	ld a, h'FF		; todos os LED's
		out (h'04), a		; acende LED's
		out (h'05), a
		ld hl, INVMSG
		call DELAY
		ld a, h'00
		out (h'04), a
		out (h'05), a
		jp INICIO
OK:	ld hl, OKMSG
		call DELAY
		jp INICIO

INVMSG:	.db h'F9, h'C8, h'C1, h'88, h'C7, h'FF
OKMSG:		.db h'C0, h'8A, h'FF, h'FF, h'FF, h'FF

		.org h'0BE4
TOPSP:	.db 0	;equ h'0BE4
MENCON:	.db 0	;equ h'0BE5
FLAG:	.db 0	;equ h'0BE6
BUFDISP:	.dw 0, 0	;equ h'0BE7
BYTES:	.dw 0	;equ h'0BEB
ENDISP:	.db 0	;equ h'0BED
PBE:	.db 0	;equ h'0BEE
PAE:	.db 0	;equ h'0BEF
ROT:	.dw 0	;equ h'0BF0
ROTNMI:	jp 0	;equ h'0BF2
		.dw 0
MENI:	.db 0	;equ h'0BF7
MENF:	.db 0	;equ h'0BF8
MENA:	.db 0	;equ h'0BF9
MENL:	.db 0	;equ h'0BFA
MENH:	.db 0	;equ h'0BFB
MENE:	.db 0	;equ h'0BFC
MEND:	.db 0	;equ h'0BFD
MENC:	.db 0	;equ h'0BFE
MENB:	.db 0	;equ h'0BFF
CURMSG:	.db 0	;equ MENB+1

