
;***************************************
;
;       PROGRAMA MONITOR NESTOR
;           NOVA ELETRONICA
;    SAO PAULO SP 01/84 MSCS/JRP
;            Digitado por
;          Fábio Belavenuto
;            em 27/11/2012
;
;***************************************

;***************************************
;
; Variáveis, constantes e endereços da
; RAM usados pelo monitor e rotinas do
; K7 Podem ser utilizados em softwares
; utilitários incluindo este arquivo
;
;***************************************

; Portas I/O
PTEC		= 1
PSEG		= 1
PPE			= 2
PDIG		= 3
PPS			= 4

; Constantes
; Códigos das teclas (AJCOL e AJTEC)
KEY_0		= 0   ; 00h
KEY_1		= 1   ; 01h
KEY_2		= 2   ; 02h
KEY_3		= 3   ; 03h
KEY_4		= 4   ; 04h
KEY_5		= 5   ; 05h
KEY_6		= 6   ; 06h
KEY_7		= 7   ; 07h
KEY_8		= 8   ; 08h
KEY_9		= 9   ; 09h
KEY_A		= 10  ; 0Ah
KEY_B		= 11  ; 0Bh
KEY_C		= 12  ; 0Ch
KEY_D		= 13  ; 0Dh
KEY_E		= 14  ; 0Eh
KEY_F		= 15  ; 0Fh
KEY_PERM	= 16  ; 10h
KEY_LOAD	= 17  ; 11h
KEY_1M		= 18  ; 12h
KEY_1P		= 19  ; 13h
KEY_RUN		= 20  ; 14h
KEY_ER		= 21  ; 15h
KEY_IV		= 22  ; 16h
KEY_QUAD	= 23  ; 17h

; Caracteres para display 7-seg
DIG_APAG	= 0FFh
DIG_0		= 0C0h
DIG_1		= 0F9h
DIG_2		= 0A4h
DIG_3		= 0B0h
DIG_4		= 99h
DIG_5		= 92h
DIG_6		= 82h
DIG_7		= 0F8h
DIG_8		= 80h
DIG_9		= 90h
DIG_A		= 88h
DIG_B		= 83h
DIG_C		= 0A7h
DIG_D		= 0A1h
DIG_E		= 86h
DIG_F		= 8Eh
DIG_G		= 98h
DIG_H		= 89h
DIG_hm		= 8Bh
DIG_I		= 0CFh
DIG_J		= 0E1h
DIG_L		= 0C7h
DIG_M		= 0C8h
DIG_N		= 0ABh
DIG_O		= 0A3h
DIG_P		= 8Ch
DIG_Q		= 98h
DIG_R		= 0AFh
DIG_S		= 92h
DIG_T		= 87h
DIG_U		= 0E3h
DIG_V		= 0C1h
DIG_W		= 081h
DIG_Y		= 091h
DIG_PONTO	= 7Fh
DIG_IGUAL	= 0B7h
DIG_NUM		= 94h  ; º
DIG_GRAU	= 9Ch
DIG_EXCL	= 79h
DIG_INTER	= 0ACh
DIG_U_INV	= 0DCh
DIG_ASP		= 0DDh
DIG_APO		= 0FDh
DIG_CRASE	= 0DFh
DIG_MEN		= 0EFh
DIG_MAI		= 0BBh
DIG_COLCHE	= 0C6h
DIG_COLCHD	= 0F0h
DIG_DIF		= 0E4h
DIG_CHAVE	= 0B9h
DIG_CHAVD	= 8Fh
DIG_MENOS	= 0BFh
DIG_UNDER	= 0F7h
DIG_UPPER	= 0FEh

