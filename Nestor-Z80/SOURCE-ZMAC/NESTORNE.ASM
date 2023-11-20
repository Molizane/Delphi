;****************************************
;        PROGRAMA MONITOR NESTOR
;            NOVA ELETRÔNICA
;     SAO PAULO S.P. 01/84 MSCS/JRP
;****************************************

PDIG	equ $03 ; saída coluna teclado e display
PSEG	equ $01 ; saída caracter para o display
PTEC	equ $01 ; entrada linha teclado

ATRASO	equ $0001
TOPSP	equ $0be4
MENCON	equ $0be5
FLAG	equ $0be6
BUFDISP	equ $0be7
BYTES	equ $0beb
ENDISP	equ $0bed
PBE	equ $0bee
PAE	equ $0bef
ROT	equ $0bf0
ROTNMI	equ $0bf2
MENI	equ $0bf7
MENF	equ $0bf8
MENA	equ $0bf9
MENL	equ $0bfa
MENH	equ $0bfb
MENE	equ $0bfc
MEND	equ $0bfd
MENC	equ $0bfe
MENB	equ $0bff
SPPOS	equ $0c00

	org $0000
	ld sp,SPPOS
	push bc
	push de
	push hl
	push af
	ld hl,FLAG
	ld (hl),$19
	ld hl,MENS
	ld de,BUFDISP
	ld bc,$0006
	ldir

INICIO	ld sp,TOPSP
	ld hl,BUFDISP
	ld b,$00
	ld e,$06
	ld a,$01
NE1	call VARR
	ld a,c
	add a,a
	dec e
	jp nz,NE1
	ld a,b
	cp $00
	jp z,INICIO
NE2	ld hl,BUFDISP
	call REST
	ld a,d
	out (PDIG),a
	in a,(PTEC)
	cp $00
	jp nz,NE2
	call AJCOL
	call AJTEC
	cp $13
	jp z,NE3
	cp $10
	jp c,NE4
NE5	call ALTCOM
NE6	ld hl,FLAG
	ld a,(hl)
	jp RECCOM

;****************************************
;  MENSAGEM INICIAL
;****************************************

MENS	db $c8	; N
	db $86	; E
	db $92	; S
	db $87	; T
	db $c0	; O
	db $ce	; R
	db $00
	db $00
	db $00
	db $00

;****************************************
;  ponto de entrada de interrupção nmi
;****************************************

NMINT	jp RIV

;****************************************
;  ROTINA DE RECONHECIMENTO DE COMANDOS
;****************************************

RECCOM	ld hl,TABCOM + 1
	add a,l
	ld l,a
	ld a,(hl)
	ld c,a
	ld a,$0a
	add a,l
	ld l,a
	ld l,(hl)
	ld h,c
	jp (hl)

NE3	ld hl,FLAG
	ld a,(hl)
	cp $15
	jp z,SELREG
	jp NE5

NE4	ld hl,FLAG
	ld a,(hl)
	cp $15
	jp z,ALTREG
	nop
	jp NE6

;****************************************
;  rotina de varredura
;****************************************

VARR	ld c,a
	call TEMPO
	in a,(PTEC)
	cp $00
	ret z
	ld b,a
	ld d,c
	ret

;****************************************
;  rotina de restauração
;****************************************

REST	ld c,$06
	ld a,$01
NE7	call TEMPO
	add a,a
	dec c
	ret z
	jp NE7

;****************************************
;  rotina de tempo
;****************************************

TEMPO	push af
	out (PDIG),a
	ld a,(hl)
	out (PSEG),a
	exx
	ld de,ATRASO
LOOP1	dec de
	ld a,d
	or e
	jp nz,LOOP1
	exx
	inc hl
	pop af
	ret

;****************************************
;  rotina de ajuste de coluna
;****************************************

AJCOL	ld c,$00
	ld a,$01
	cp d
	jp z,NE8
	add a,a
	ld c,$08
	cp d
	jp z,NE8
	add a,a
	ld c,$10
	cp d
	jp z,NE8
	jp INICIO

NE8	ld d,c
	ret

;****************************************
;  rotina de ajuste de tecla
;****************************************

AJTEC	ld e,$08
	ld c,$00
	ld a,$01
NE10	cp b
	jp z,NE9
	inc c
	add a,a
	dec e
	jp nz,NE10
	jp INICIO

NE9	ld a,c
	add a,d
	ld b,a
	nop
	ret

;****************************************
;  rotina de alterar comando
;****************************************

ALTCOM	ld hl,FLAG
	ld (hl),b
	ret

;****************************************
;  rotina de permissão
;****************************************

ROTPER	ld c,$06
	ld hl,FLAG
	ld (hl),$17	; executando a rotina "Permissão"
	inc hl
NE11	ld (hl),$FF
	inc hl
	dec c
	jp nz,NE11
	ld (hl),$00
	inc hl
	ld (hl),$00
	inc hl
	ld (hl),$00
	jp INICIO

;****************************************
;  rotina de campo de endereços
;****************************************

ROTCP	ld hl,PBE
	ld a,b
	rld ; A(LSB)->(HL)(LSB)->(HL)(LSB)->(HL)(MSB)->(HL)(MSB)->A(LSB)
	inc hl
	rld ; A(LSB)->(HL)(LSB)->(HL)(LSB)->(HL)(MSB)->(HL)(MSB)->A(LSB)
	call DECOD
	jp INICIO

;****************************************
;  rotina de leitura
;****************************************

ROTLT	call ATUAL
	ld hl,FLAG
	ld (hl),$18
	ld hl,PAE
	call DECOD
	jp INICIO

;****************************************
;  rotina de campo de dados
;****************************************

ROTCD	call ATUAL
	ld a,b
	rld ; A(LSB)->(HL)(LSB)->(HL)(LSB)->(HL)(MSB)->(HL)(MSB)->A(LSB)
	ld a,(hl)
	ld (de),a
	ld hl,PAE
	call DECOD
	jp INICIO

;****************************************
;  rotina de atualização
;****************************************

ATUAL	ld hl,PBE
	ld e,(hl)
	inc hl
	ld d,(hl)
	ld a,(de)
	dec hl
	dec hl
	ld (hl),a
	push hl
	ld hl,FLAG
	ld (hl),$18
	pop hl
	ret

;****************************************
;  rotina de decodificação
;****************************************

DECOD	ld bc,BUFDISP
	call DISPLAY
	dec hl
	call DISPLAY
	dec hl
	call DISPLAY
	ret

;****************************************
;  rotina de ajuste memória de endereço
;****************************************

RAME	ld hl,PBE
	ld (hl),e
	inc hl
	ld (hl),d
	dec hl
	dec hl
	ld a,(de)
	ld (hl),a
	ret
	dw $ffff

;****************************************
;  rotina de display
;****************************************

DISPLAY	ld a,(hl)
	push hl
	ld hl,ROT
	ld (hl),a
	xor a
	rld ; A(LSB)->(HL)(LSB)->(HL)(LSB)->(HL)(MSB)->(HL)(MSB)->A(LSB)
	call FORMAT
	ld (bc),a
	inc bc
	xor a
	rld ; A(LSB)->(HL)(LSB)->(HL)(LSB)->(HL)(MSB)->(HL)(MSB)->A(LSB)
	call FORMAT
	ld (bc),a
	inc bc
	pop hl
	ret

;****************************************
;  rotina de formatação
;****************************************

FORMAT	push de
	ld de,INTD
	add a,e
	ld e,a
	ld a,(de)
	pop de
	ret

;****************************************
;  tabela de formatos alfa (números)
;****************************************

INTD	db $c0
	db $f9
	db $a4
	db $b0
	db $99
	db $92
	db $82
	db $f8
	db $80
	db $90
	db $88
	db $83
	db $c6
	db $a1
	db $86
	db $8e

;****************************************
;  rotina de próximo
;****************************************

ROTPR	call ATUAL
	inc de
	call RAME
	ld hl,PAE
	call DECOD
	jp INICIO

;****************************************
;  rotina de último
;****************************************

ROTUL	call ATUAL
	dec de
	call RAME
	ld hl,PAE
	call DECOD
	jp INICIO

;****************************************
;  rotina de rodar
;****************************************

	org $01c8

ROTRD	ld a,$FF
	out (PDIG),a
	ld a,$7f
	out (PSEG),a
	ld hl,ENDISP	; antes estava "MEND"
	ld (hl),$c3	; $c3 = "jp"
	ld sp,MENF	; antes estava "MENI"
	push af
	push hl
	push de
	push bc
	ld sp,TOPSP
	jp ENDISP

;****************************************
;  rotina de exame de registradores
;****************************************

ROTER	ld hl,MENCON
	ld (hl),$FE
	jp SELREG

;****************************************
;  rotina de inicialização
;****************************************

INICIAL	ld hl,BUFDISP
	ld (hl),$FF
	inc hl
	ld (hl),$FF
	inc hl
	ret

;****************************************
;  rotina de seleção de registradores
;****************************************

SELREG	ld de,TABREG
	ld hl,MENCON
	inc (hl)
	inc (hl)
	ld a,e
	add a,(hl)
NE12	ld e,a
	ld a,(de)
	ld l,a
	inc de
	ld a,(de)
	ld h,a
	jp (hl)

;****************************************
;  rotina de alteração de registradores
;****************************************

ALTREG	ld hl,MENCON
	ld de,TABALT
	ld a,e
	add a,(hl)
	jp NE12

;****************************************
;  registrador a
;****************************************

REGA	call INICIAL
	ld (hl),$88
	inc hl
	ld (hl),$b7
	ld hl,MENA
	jp ROTSA

;****************************************
;  rotina de saída
;****************************************

ROTSA	ld bc,BYTES
	call DISPLAY
	jp INICIO

;****************************************
;  altera registrador a
;****************************************

ALTA	ld hl,MENA
	ld a,b
	rld ; A(LSB)->(HL)(LSB)->(HL)(LSB)->(HL)(MSB)->(HL)(MSB)->A(LSB)
	jp ROTSA

;****************************************
;  registrador b
;****************************************

REGB	call INICIAL
	ld (hl),$83
	inc hl
	ld (hl),$b7
	ld hl,MENB
	jp ROTSA

;****************************************
;  altera registrador b
;****************************************

ALTB	ld hl,MENB
	ld a,b
	rld ; A(LSB)->(HL)(LSB)->(HL)(LSB)->(HL)(MSB)->(HL)(MSB)->A(LSB)
	jp ROTSA

;****************************************
;  registrador c
;****************************************

REGC	call INICIAL
	ld (hl),$c6
	inc hl
	ld (hl),$b7
	ld hl,MENC
	jp ROTSA

;****************************************
;  altera registrador c
;****************************************

ALTC	ld hl,MENC
	ld a,b
	rld ; A(LSB)->(HL)(LSB)->(HL)(LSB)->(HL)(MSB)->(HL)(MSB)->A(LSB)
	jp ROTSA

;****************************************
;  registrador d
;****************************************

REGD	call INICIAL
	ld (hl),$a1
	inc hl
	ld (hl),$b7
	ld hl,MEND
	jp ROTSA

;****************************************
;  altera registrador d
;****************************************

ALTD	ld hl,MEND
	ld a,b
	rld ; A(LSB)->(HL)(LSB)->(HL)(LSB)->(HL)(MSB)->(HL)(MSB)->A(LSB)
	jp ROTSA

;****************************************
;  registrador e
;****************************************

REGE	call INICIAL
	ld (hl),$86
	inc hl
	ld (hl),$b7
	ld hl,MENE
	jp ROTSA

;****************************************
;  altera registrador e
;****************************************

ALTE	ld hl,MENE
	ld a,b
	rld ; A(LSB)->(HL)(LSB)->(HL)(LSB)->(HL)(MSB)->(HL)(MSB)->A(LSB)
	jp ROTSA

;****************************************
;  registrador h
;****************************************

REGH	call INICIAL
	ld (hl),$89
	inc hl
	ld (hl),$b7
	ld hl,MENH
	jp ROTSA

;****************************************
;  altera registrador h
;****************************************

ALTH	ld hl,MENH
	ld a,b
	rld ; A(LSB)->(HL)(LSB)->(HL)(LSB)->(HL)(MSB)->(HL)(MSB)->A(LSB)
	jp ROTSA

;****************************************
;  registrador l
;****************************************

REGL	call INICIAL
	ld (hl),$c7
	inc hl
	ld (hl),$b7
	ld hl,MENL
	jp ROTSA

;****************************************
;  altera registrador l
;****************************************

ALTL	ld hl,MENL
	ld a,b
	rld ; A(LSB)->(HL)(LSB)->(HL)(LSB)->(HL)(MSB)->(HL)(MSB)->A(LSB)
	jp ROTSA

;****************************************
;  registrador f
;****************************************

REGF	call INICIAL
	ld (hl),$8e
	inc hl
	ld (hl),$b7
	ld hl,MENF
	jp ROTSA

;****************************************
;  altera registrador f
;****************************************

ALTF	ld hl,MENF
	ld a,b
	rld ; A(LSB)->(HL)(LSB)->(HL)(LSB)->(HL)(MSB)->(HL)(MSB)->A(LSB)
	jp ROTSA

;****************************************
;  registrador i
;****************************************

REGI	ld a,i
	ld hl,MENI
	ld (hl),a
	call INICIAL
	ld (hl),$f9
	inc hl
	ld (hl),$b7
	ld hl,MENI
	jp ROTSA

;****************************************
;  altera registrador i
;****************************************

ALTI	ld hl,MENI
	ld a,b
	rld ; A(LSB)->(HL)(LSB)->(HL)(LSB)->(HL)(MSB)->(HL)(MSB)->A(LSB)
	ld a,(hl)
	ld i,a
	jp ROTSA

;****************************************
;  rotina para o vetor de interrupção
;****************************************

RIV	ld bc,ROTNMI
	ld a,$c3	; $c3 = "jp"
	ld (bc),a
	inc bc
	ld hl,PBE
	ld a,(hl)
	ld (bc),a
	inc bc
	inc hl
	ld a,(hl)
	ld (bc),a
	jp INICIO

;****************************************
;  tabela de seleção de registradores
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
	db $00
	db $00
	db $00

;****************************************
;  tabela de seleção de comandos
;****************************************

	db (ROTPER >> 8) & $FF ; ROTPER (MSB)
	db (ROTLT  >> 8) & $FF ; ROTLT  (MSB)
	db (ROTUL  >> 8) & $FF ; ROTUL  (MSB)
	db (ROTPR  >> 8) & $FF ; ROTPR  (MSB)
	db (ROTRD  >> 8) & $FF ; ROTRD  (MSB)
	db (ROTER  >> 8) & $FF ; ROTER  (MSB)
	db (RIV    >> 8) & $FF ; RIV    (MSB)
	db (ROTCP  >> 8) & $FF ; ROTCP  (MSB)
	db (ROTCD  >> 8) & $FF ; ROTCD  (MSB)
	db (INICIO >> 8) & $FF ; INICIO (MSB)

	db (ROTPER & $FF) 	; ROTPER (LSB)
	db (ROTLT  & $FF) 	; ROTLT  (LSB)
	db (ROTUL  & $FF) 	; ROTUL  (LSB)
	db (ROTPR  & $FF) 	; ROTPR  (LSB)
	db (ROTRD  & $FF) 	; ROTRD  (LSB)
	db (ROTER  & $FF) 	; ROTER  (LSB)
	db (RIV    & $FF) 	; RIV    (LSB)
	db (ROTCP  & $FF) 	; ROTCP  (LSB)
	db (ROTCD  & $FF) 	; ROTCD  (LSB)
	db (INICIO & $FF) 	; INICIO (LSB)
