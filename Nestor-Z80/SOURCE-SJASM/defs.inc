
/******************************************/
/*  Variáveis, constantes e endereços da  */
/*  RAM usados pelo monitor e rotinas do  */
/*  K7 Podem ser utilizados em softwares  */
/*  utilitários incluindo este arquivo    */
/******************************************/

// Portas I/O
PTEC		= 01 // linha do teclado
PSEG		= 01 // segmento do display
PPE		= 02 // entrada K7
PDIG		= 03 // seletor de dígito
PPS		= 04 // saída K7

// Constantes
// Códigos das teclas (AJCOL e AJTEC)
KEY_0		= 00 ; 00h
KEY_1		= 01 ; 01h
KEY_2		= 02 ; 02h
KEY_3		= 03 ; 03h
KEY_4		= 04 ; 04h
KEY_5		= 05 ; 05h
KEY_6		= 06 ; 06h
KEY_7		= 07 ; 07h
KEY_8		= 08 ; 08h
KEY_9		= 09 ; 09h
KEY_A		= 10 ; 0Ah
KEY_B		= 11 ; 0Bh
KEY_C		= 12 ; 0Ch
KEY_D		= 13 ; 0Dh
KEY_E		= 14 ; 0Eh
KEY_F		= 15 ; 0Fh
KEY_PERM	= 16 ; 10h
KEY_LOAD	= 17 ; 11h
KEY_1M		= 18 ; 12h
KEY_1P		= 19 ; 13h
KEY_RUN		= 20 ; 14h
KEY_ER		= 21 ; 15h
KEY_IV		= 22 ; 16h
KEY_QUAD	= 23 ; 17h

// Caracteres para display 7-seg
CHR_APAG	= 0FFh
CHR_0		= 0C0h
CHR_1		= 0F9h
CHR_2		= 0A4h
CHR_3		= 0B0h
CHR_4		= 099h
CHR_5		= 092h
CHR_6		= 082h
CHR_7		= 0F8h
CHR_8		= 080h
CHR_9		= 090h
CHR_A		= 088h
CHR_B		= 083h
CHR_C		= 0C6h
CHR_cm		= 0A7h
CHR_D		= 0A1h
CHR_E		= 086h
CHR_Em		= 084h
CHR_F		= 08Eh
CHR_G		= 098h
CHR_G2		= 082h
CHR_H		= 089h
CHR_I		= 0CFh
CHR_im		= 0EFh
CHR_J		= 0E1h
CHR_jm		= 0F1h
CHR_L		= 0C7h
CHR_M		= 0C8h
CHR_N		= 0ABh
CHR_O		= 0A3h
CHR_P		= 08Ch
CHR_Q		= 098h
CHR_R		= 0CEh
CHR_Rm		= 0AFh
CHR_S		= 092h
CHR_T		= 087h
CHR_U		= 0E3h
CHR_V		= 0C1h
CHR_W		= 081h
CHR_X		= 089h
CHR_Y		= 091h

CHR_ARROBA	= 084h
CHR_PONTO	= 07Fh
CHR_IGUAL	= 0B7h
CHR_NUM		= 094h  // º
CHR_GRAU	= 09Ch
CHR_EXCL	= 079h
CHR_INTER	= 0ACh
CHR_U_INV	= 0DCh
CHR_ASP		= 0DDh
CHR_APO		= 0FDh
CHR_CRASE	= 0DFh
CHR_MEN		= 0EFh
CHR_MAI		= 0BBh
CHR_COLCHE	= 0C6h
CHR_COLCHD	= 0F0h
CHR_DIF		= 0E4h
CHR_CHAVE	= 0B9h
CHR_CHAVD	= 08Fh
CHR_MENOS	= 0BFh
CHR_UNDER	= 0F7h
CHR_UPPER	= 0FEh
CHR_UPDOWN	= 09Dh
