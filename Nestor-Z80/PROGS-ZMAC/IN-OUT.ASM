;***************************************************
;  TRANSFERE ENTRADAS PARA AS SAÍDAS
;***************************************************

;***********************************************************************
	include	"defs.inc"
;***********************************************************************

		org	$2240

	; INICIALIZA AS VARIÁVEIS
INIT	xor a
		ld (INP), a
		ld (TIMES), a
		ld (OLDIN), a
		out (PPS), a
	; LOOP PRINCIPAL
LOOP	in a, (PPE)		; LÊ A PORTA DE ENTRADA
		ld c, a			; SALVA EM "C"
		ld a, (INP)		; CARREGA O VALOR LIDO ANTERIORMENTE
		cp c			; COMPARA COM A LEITURA ATUAL
		jr z, SAME		; SE LEITURA ATUAL FOR IGUAL À ANTERIOR, ANALISA QUANTO TEMPO ESTÁ ESTÁVEL

		ld a, c			; SE NÃO FOR IGUAL:
		ld (INP), a		; SALVA O VALOR LIDO ATUAL
		xor a
		ld (TIMES), a	; LIMPA O CONTADOR DE VEZES DE LEITURAS
		ld (OLDIN), a	; LIMPA O BUFFER DE VALOR ANTERIORMENTE LIDO
		jr LOOP			; RETORNA AO INÍCIO DO LOOP

SAME	ld a, (TIMES)	; CARREGA O CONTADOR DE LEITURAS IGUAIS
		inc a			; INCREMENTA
		ld (TIMES), a	; SALVA O CONTADOR DE LEITURAS IGUAIS
		cp 50			; VERIFICA SE CHEGOU A 50 LEITURAS
		jp m, LOOP		; SE NÃO CHEGOU A 50 LEITURAS, RETORNA AO INÍCIO DO LOOP

		ld a, (INP)		; CARREGA O VALOR LIDO ATUAL
		ld c, a			; SALVA EM "C"
		ld a, (OLDIN)	; CARREGA O VALOR LIDO ANTERIOR
		cp c			; VERIFICA SE A LEITURA MUDOU
		jr z, LOOP		; SE NÃO MUDOU, RETORNA AO INÍCIO DO LOOP

		ld a, c			; RECUPERA O VALOR DE "C"
		ld (OLDIN), a	; SALVA NO VALOR ANTERIOR
		out (PPS), a	; ACIONA AS SAÍDAS
		jr LOOP			; RETORNA AO INÍCIO DO LOOP

VARS:
OLDIN	db	0
INP		db	0
OUTP	db	0
TIMES	db	0

FIM:
