;****************************************
;      PROGRAMA MONITOR NESTOR
;          NOVA ELETRÔNICA
;   SAO PAULO S.P. 01/84 MSCS/JRP
;****************************************

PDIG	equ $03	; saída coluna teclado e display
PSEG	equ $01	; saída caracter para o display
PTEC	equ $01	; entrada linha teclado
ATRASO	equ $0001

	org $0000
	ld sp,CURMSG
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

MENS	db $C8	; N
	db $86	; E
	db $92	; S
	db $87	; T
	db $C0	; O
	db $CE	; R

;****************************************
;  PONTO DE ENTRADA DE INTERRUPÇÃO NMI
;****************************************

	org $0066
NMINT	jp RVI

;****************************************
;  ROTINA DE RECONHECIMENTO DE COMANDOS
;****************************************

RECCOM	ld hl,TABCOM + 1
	add a,l
	ld l,a
	ld a,(hl)
	ld c,a
	ld a,$0A
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
	;nop
	jp NE6

;****************************************
;   ROTINA DE VARREDURA
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
;   ROTINA DE RESTAURAÇÃO
;****************************************

REST	ld c,$06
	ld a,$01
NE7	call TEMPO
	add a,a
	dec c
	ret z
	jp NE7

;****************************************
;   ROTINA DE TEMPO
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
;   ROTINA DE AJUSTE DE COLUNA
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
;   ROTINA DE AJUSTE DE TECLA
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
;   ROTINA DE ALTERAR COMANDO
;****************************************

ALTCOM	ld hl,FLAG
	ld (hl),b
	ret

;****************************************
;   ROTINA DE PERMISSÃO
;****************************************

ROTPER	ld c,$06
	ld hl,FLAG
	ld (hl),$17	; executando a rotina "Permissão"
	inc hl
NE11	ld (hl),$C0	; $FF
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
;   ROTINA DE CAMPO DE ENDEREÇOS
;****************************************

ROTcp ld hl,PBE
	ld a,b
	rld ; A(LSB)->(HL)(LSB)->(HL)(LSB)->(HL)(MSB)->(HL)(MSB)->A(LSB)
	inc hl
	rld ; A(LSB)->(HL)(LSB)->(HL)(LSB)->(HL)(MSB)->(HL)(MSB)->A(LSB)
	call DECOD
	jp INICIO

;****************************************
;   ROTINA DE LEITURA
;****************************************

ROTLT	call ATUAL
	ld hl,FLAG
	ld (hl),$18
	ld hl,PAE
	call DECOD
	jp INICIO

;****************************************
;   ROTINA DE CAMPO DE DADOS
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
;   ROTINA DE ATUALIZAÇÃO
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
;   ROTINA DE decodificação
;****************************************

DECOD	ld bc,BUFDISP
	call DISPLY
	dec hl
	call DISPLY
	dec hl
	call DISPLY
	ret

;****************************************
;  ROTINA DE AJUSTE MEMÓRIA DE ENDEREÇO
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

;****************************************
;   ROTINA DE DISPLAY
;****************************************

DISPLY	ld a,(hl)
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
;   ROTINA DE FORMATAÇÃO
;****************************************

FORMAT	push de
	ld de,INTD
	add a,e
	ld e,a
	ld a,(de)
	pop de
	ret

;****************************************
;   TABELA DE FORMATOS ALFA (NÚMEROS)
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
;   ROTINA DE PRÓXIMO
;****************************************

ROTPR	call ATUAL
	inc de
	call RAME
	ld hl,PAE
	call DECOD
	jp INICIO

;****************************************
;   ROTINA DE ÚLTIMO
;****************************************

ROTUL	call ATUAL
	dec de
	call RAME
	ld hl,PAE
	call DECOD
	jp INICIO

;****************************************
;   ROTINA DE RODAR
;****************************************

; para ajustar a posição das rotinas de exame de registradores
	dw 0,0,0,0

ROTRD	ld a,$FF
	out (PDIG),a
	ld a,$7F
	out (PSEG),a
	ld hl,ENDISP
	ld (hl),$C3	; $C3 = "jp"
	ld sp,MENF
	push af
	push hl
	push de
	push bc
	ld sp,TOPSP
	jp ENDISP

;****************************************
;    ROTINA DE EXAME DE REGISTRADORES
;****************************************

ROTER	ld hl,MENCON
	ld (hl),$FE
	jp SELREG

;****************************************
;   ROTINA DE inicialização
;****************************************

INICIAL	ld hl,BUFDISP
	ld (hl),$FF
	inc hl
	ld (hl),$FF
	inc hl
	ret

;****************************************
;   ROTINA DE SELEÇÃO DE REGISTRADORES
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
;  ROTINA DE ALTERAÇÃO DE REGISTRADORES
;****************************************

ALTREG	ld hl,MENCON
	ld de,TABALT
	ld a,e
	add a,(hl)
	jp NE12

;****************************************
;   REGISTRADOR A
;****************************************

REGA	call INICIAL
	ld (hl),$88
	inc hl
	ld (hl),$B7
	ld hl,MENA
	jp ROTSA

;****************************************
;   ROTINA DE SAÍDA
;****************************************

ROTSA	ld bc,BYTES
	call DISPLY
	jp INICIO

;****************************************
;   ALTERA REGISTRADOR A
;****************************************

ALTA	ld hl,MENA
	ld a,b
	rld ; A(LSB)->(HL)(LSB)->(HL)(LSB)->(HL)(MSB)->(HL)(MSB)->A(LSB)
	jp ROTSA

;****************************************
;   REGISTRADOR B
;****************************************

REGB	call INICIAL
	ld (hl),$83
	inc hl
	ld (hl),$B7
	ld hl,MENB
	jp ROTSA

;****************************************
;   ALTERA REGISTRADOR B
;****************************************

ALTB	ld hl,MENB
	ld a,b
	rld ; A(LSB)->(HL)(LSB)->(HL)(LSB)->(HL)(MSB)->(HL)(MSB)->A(LSB)
	jp ROTSA

;****************************************
;   REGISTRADOR C
;****************************************

REGC	call INICIAL
	ld (hl),$C6
	inc hl
	ld (hl),$B7
	ld hl,MENC
	jp ROTSA

;****************************************
;   ALTERA REGISTRADOR C
;****************************************

ALTC	ld hl,MENC
	ld a,b
	rld ; A(LSB)->(HL)(LSB)->(HL)(LSB)->(HL)(MSB)->(HL)(MSB)->A(LSB)
	jp ROTSA

;****************************************
;   REGISTRADOR D
;****************************************

REGD	call INICIAL
	ld (hl),$A1
	inc hl
	ld (hl),$B7
	ld hl,MEND
	jp ROTSA

;****************************************
;   ALTERA REGISTRADOR D
;****************************************

ALTD	ld hl,MEND
	ld a,b
	rld ; A(LSB)->(HL)(LSB)->(HL)(LSB)->(HL)(MSB)->(HL)(MSB)->A(LSB)
	jp ROTSA

;****************************************
;   REGISTRADOR E
;****************************************

REGE	call INICIAL
	ld (hl),$86
	inc hl
	ld (hl),$B7
	ld hl,MENE
	jp ROTSA

;****************************************
;   ALTERA REGISTRADOR E
;****************************************

ALTE	ld hl,MENE
	ld a,b
	rld ; A(LSB)->(HL)(LSB)->(HL)(LSB)->(HL)(MSB)->(HL)(MSB)->A(LSB)
	jp ROTSA

;****************************************
;   REGISTRADOR H
;****************************************

REGH	call INICIAL
	ld (hl),$89
	inc hl
	ld (hl),$B7
	ld hl,MENH
	jp ROTSA

;****************************************
;   ALTERA REGISTRADOR H
;****************************************

ALTH	ld hl,MENH
	ld a,b
	rld ; A(LSB)->(HL)(LSB)->(HL)(LSB)->(HL)(MSB)->(HL)(MSB)->A(LSB)
	jp ROTSA

;****************************************
;   REGISTRADOR L
;****************************************

REGL	call INICIAL
	ld (hl),$C7
	inc hl
	ld (hl),$B7
	ld hl,MENL
	jp ROTSA

;****************************************
;   ALTERA REGISTRADOR L
;****************************************

ALTL	ld hl,MENL
	ld a,b
	rld ; A(LSB)->(HL)(LSB)->(HL)(LSB)->(HL)(MSB)->(HL)(MSB)->A(LSB)
	jp ROTSA

;****************************************
;   REGISTRADOR F
;****************************************

REGF	call INICIAL
	ld (hl),$8E
	inc hl
	ld (hl),$B7
	ld hl,MENF
	jp ROTSA

;****************************************
;   ALTERA REGISTRADOR F
;****************************************

ALTF	ld hl,MENF
	ld a,b
	rld ; A(LSB)->(HL)(LSB)->(HL)(LSB)->(HL)(MSB)->(HL)(MSB)->A(LSB)
	jp ROTSA

;****************************************
;   REGISTRADOR I
;****************************************

REGI	ld a,i
	ld hl,MENI
	ld (hl),a
	call INICIAL
	ld (hl),$F9
	inc hl
	ld (hl),$B7
	ld hl,MENI
	jp ROTSA

;****************************************
;   ALTERA REGISTRADOR I
;****************************************

ALTI	ld hl,MENI
	ld a,b
	rld ; A(LSB)->(HL)(LSB)->(HL)(LSB)->(HL)(MSB)->(HL)(MSB)->A(LSB)
	ld a,(hl)
	ld i,a
	jp ROTSA

;****************************************
;   ROTINA PARA O VETOR DE INTERRUPÇÃO
;****************************************

RIV	ld bc,ROTNMI
	ld a,$C3		; $C3 = "jp"
	ld (bc),a
	inc bc
	ld hl,PBE
	ld a,(hl)
	ld (bc),a
	inc bc
	inc hl
	ld a,(hl)
	ld (bc),a
	jp OK ; INICIO

;****************************************
;   TABELA DE SELEÇÃO DE REGISTRADORES
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
;  TABELA DE ALTERAÇÃO DE REGISTRADORES
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
;   TABELA DE SELEÇÃO DE COMANDOS
;****************************************

	db (ROTPER >> 8) & $FF	; ROTPER (MSB)
	db (ROTLT >> 8) & $FF	; ROTLT (MSB)
	db (ROTUL >> 8) & $FF	; ROTUL (MSB)
	db (ROTPR >> 8) & $FF	; ROTPR (MSB)
	db (ROTRD >> 8) & $FF	; ROTRD (MSB)
	db (ROTER >> 8) & $FF	; ROTER (MSB)
	db (RIV >> 8) & $FF	; RIV (MSB)
	db (ROTCP >> 8) & $FF	; ROTCP (MSB)
	db (ROTCD >> 8) & $FF	; ROTCD (MSB)
	db (INICIO >> 8) & $FF	; INICIO (MSB)

	db ROTPER & $FF		; ROTPER (LSB)
	db ROTLT & $FF		; ROTLT (LSB)
	db ROTUL & $FF		; ROTUL (LSB)
	db ROTPR & $FF		; ROTPR (LSB)
	db ROTRD & $FF		; ROTRD (LSB)
	db ROTER & $FF		; ROTER (LSB)
	db RIV & $FF		; RIV (LSB)
	db ROTCP & $FF		; ROTCP (LSB)
	db ROTCD & $FF		; ROTCD (LSB)
	db INICIO & $FF		; INICIO (LSB)

DELAY	ld (CURMSG),hl
	push bc		; save BC
	call DELAY1
	pop bc		; restore BC
	ret
DELAY1	ld c,$05		; fill c too with max delay
DELAY2	ld hl,(CURMSG)
	push bc
	call REST
	pop bc
	dec c
	jp nz,DELAY2
	ret 		; retorna
INVALID	ld a,$FF		; todos os LED's
	out ($04),a		; acende LED's
	out ($05),a
	ld hl,INVMSG
	call DELAY
	ld a,$00
	out ($04),a
	out ($05),a
	jp INICIO
OK	ld hl,OKMSG
	call DELAY
	jp INICIO
INVMSG	db $F9,$C8,$C1,$88,$C7,$FF
OKMSG	db $C0,$8A,$FF,$FF,$FF,$FF

	org $0BE4
TOPSP	db 0	;equ $0BE4
MENCON	db 0	;equ $0BE5
FLAG	db 0	;equ $0BE6
BUFDISP	dw 0,0	;equ $0BE7
BYTES	dw 0	;equ $0BEB
ENDISP	db 0	;equ $0BED
PBE	db 0	;equ $0BEE
PAE	db 0	;equ $0BEF
ROT	dw 0	;equ $0BF0
ROTNMI	jp 0	;equ $0BF2
	dw 0
MENI	db 0	;equ $0BF7
MENF	db 0	;equ $0BF8
MENA	db 0	;equ $0BF9
MENL	db 0	;equ $0BFA
MENH	db 0	;equ $0BFB
MENE	db 0	;equ $0BFC
MEND	db 0	;equ $0BFD
MENC	db 0	;equ $0BFE
MENB	db 0	;equ $0BFF
CURMSG	db 0	;equ MENB+1
