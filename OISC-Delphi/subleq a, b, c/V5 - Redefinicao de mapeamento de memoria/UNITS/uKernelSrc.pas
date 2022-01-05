unit uKernelSrc;

interface

const
  NL = #13#10;

  KernelSrc: string =
  ' ' +
    '		DC	MemTop	THE_END' + NL +
    '' + NL +
    '		ORG	0' + NL +
    '		subleq	0 0 COLD		// Cold Boot' + NL +
    '		subleq	0 0 0			// Gancho para simular um return' + NL +
    'TEMP:		DD	0			// Espaço reservado para dados temporários' + NL +
    '' + NL +
    '		ORG	10' + NL +
    'rgAdd_Hard_IRQ_0:	DD	0	// Endereço de manipulação da Hard IRQ 0' + NL +
    'rgAdd_Hard_IRQ_1:	DD	0	// Endereço de manipulação da Hard IRQ 1' + NL +
    'rgAdd_Hard_IRQ_2:	DD	0	// Endereço de manipulação da Hard IRQ 2' + NL +
    'rgAdd_Hard_IRQ_3:	DD	0	// Endereço de manipulação da Hard IRQ 3' + NL +
    'rgAdd_Hard_IRQ_4:	DD	0	// Endereço de manipulação da Hard IRQ 4' + NL +
    'rgAdd_Hard_IRQ_5:	DD	0	// Endereço de manipulação da Hard IRQ 5' + NL +
    'rgAdd_Hard_IRQ_6:	DD	0	// Endereço de manipulação da Hard IRQ 6' + NL +
    'rgAdd_Hard_IRQ_7:	DD	0	// Endereço de manipulação da Hard IRQ 7' + NL +
    'rgAdd_Hard_IRQ_8:	DD	0	// Endereço de manipulação da Hard IRQ 8' + NL +
    'rgAdd_Hard_IRQ_9:	DD	0	// Endereço de manipulação da Hard IRQ 9' + NL +
    'rgAdd_Hard_IRQ_10:	DD	0	// Endereço de manipulação da Hard IRQ 10' + NL +
    'rgAdd_Hard_IRQ_11:	DD	0	// Endereço de manipulação da Hard IRQ 11' + NL +
    'rgAdd_Hard_IRQ_12:	DD	0	// Endereço de manipulação da Hard IRQ 12' + NL +
    'rgAdd_Hard_IRQ_13:	DD	0	// Endereço de manipulação da Hard IRQ 13' + NL +
    'rgAdd_Hard_IRQ_14:	DD	0	// Endereço de manipulação da Hard IRQ 14' + NL +
    'rgAdd_Hard_IRQ_15:	DD	0	// Endereço de manipulação da Hard IRQ 15' + NL +
    '' + NL +
    'rgRet_Hard_IRQ_0:	DD	0	// Retorno da Hard IRQ 0' + NL +
    'rgRet_Hard_IRQ_1:	DD	0	// Retorno da Hard IRQ 1' + NL +
    'rgRet_Hard_IRQ_2:	DD	0	// Retorno da Hard IRQ 2' + NL +
    'rgRet_Hard_IRQ_3:	DD	0	// Retorno da Hard IRQ 3' + NL +
    'rgRet_Hard_IRQ_4:	DD	0	// Retorno da Hard IRQ 4' + NL +
    'rgRet_Hard_IRQ_5:	DD	0	// Retorno da Hard IRQ 5' + NL +
    'rgRet_Hard_IRQ_6:	DD	0	// Retorno da Hard IRQ 6' + NL +
    'rgRet_Hard_IRQ_7:	DD	0	// Retorno da Hard IRQ 7' + NL +
    'rgRet_Hard_IRQ_8:	DD	0	// Retorno da Hard IRQ 8' + NL +
    'rgRet_Hard_IRQ_9:	DD	0	// Retorno da Hard IRQ 9' + NL +
    'rgRet_Hard_IRQ_10:	DD	0	// Retorno da Hard IRQ 10' + NL +
    'rgRet_Hard_IRQ_11:	DD	0	// Retorno da Hard IRQ 11' + NL +
    'rgRet_Hard_IRQ_12:	DD	0	// Retorno da Hard IRQ 12' + NL +
    'rgRet_Hard_IRQ_13:	DD	0	// Retorno da Hard IRQ 13' + NL +
    'rgRet_Hard_IRQ_14:	DD	0	// Retorno da Hard IRQ 14' + NL +
    'rgRet_Hard_IRQ_15:	DD	0	// Retorno da Hard IRQ 15' + NL +
    '' + NL +
    'rgAdd_Soft_IRQ_0:	DD	0	// Endereço de manipulação da Soft IRQ 0' + NL +
    'rgAdd_Soft_IRQ_1:	DD	0	// Endereço de manipulação da Soft IRQ 1' + NL +
    'rgAdd_Soft_IRQ_2:	DD	0	// Endereço de manipulação da Soft IRQ 2' + NL +
    'rgAdd_Soft_IRQ_3:	DD	0	// Endereço de manipulação da Soft IRQ 3' + NL +
    'rgAdd_Soft_IRQ_4:	DD	0	// Endereço de manipulação da Soft IRQ 4' + NL +
    'rgAdd_Soft_IRQ_5:	DD	0	// Endereço de manipulação da Soft IRQ 5' + NL +
    'rgAdd_Soft_IRQ_6:	DD	0	// Endereço de manipulação da Soft IRQ 6' + NL +
    'rgAdd_Soft_IRQ_7:	DD	0	// Endereço de manipulação da Soft IRQ 7' + NL +
    'rgAdd_Soft_IRQ_8:	DD	0	// Endereço de manipulação da Soft IRQ 8' + NL +
    'rgAdd_Soft_IRQ_9:	DD	0	// Endereço de manipulação da Soft IRQ 9' + NL +
    'rgAdd_Soft_IRQ_10:	DD	0	// Endereço de manipulação da Soft IRQ 10' + NL +
    'rgAdd_Soft_IRQ_11:	DD	0	// Endereço de manipulação da Soft IRQ 11' + NL +
    'rgAdd_Soft_IRQ_12:	DD	0	// Endereço de manipulação da Soft IRQ 12' + NL +
    'rgAdd_Soft_IRQ_13:	DD	0	// Endereço de manipulação da Soft IRQ 13' + NL +
    'rgAdd_Soft_IRQ_14:	DD	0	// Endereço de manipulação da Soft IRQ 14' + NL +
    'rgAdd_Soft_IRQ_15:	DD	0	// Endereço de manipulação da Soft IRQ 15' + NL +
    '' + NL +
    'rgRet_Soft_IRQ_0:	DD	0	// Retorno da Soft IRQ 0' + NL +
    'rgRet_Soft_IRQ_1:	DD	0	// Retorno da Soft IRQ 1' + NL +
    'rgRet_Soft_IRQ_2:	DD	0	// Retorno da Soft IRQ 2' + NL +
    'rgRet_Soft_IRQ_3:	DD	0	// Retorno da Soft IRQ 3' + NL +
    'rgRet_Soft_IRQ_4:	DD	0	// Retorno da Soft IRQ 4' + NL +
    'rgRet_Soft_IRQ_5:	DD	0	// Retorno da Soft IRQ 5' + NL +
    'rgRet_Soft_IRQ_6:	DD	0	// Retorno da Soft IRQ 6' + NL +
    'rgRet_Soft_IRQ_7:	DD	0	// Retorno da Soft IRQ 7' + NL +
    'rgRet_Soft_IRQ_8:	DD	0	// Retorno da Soft IRQ 8' + NL +
    'rgRet_Soft_IRQ_9:	DD	0	// Retorno da Soft IRQ 9' + NL +
    'rgRet_Soft_IRQ_10:	DD	0	// Retorno da Soft IRQ 10' + NL +
    'rgRet_Soft_IRQ_11:	DD	0	// Retorno da Soft IRQ 11' + NL +
    'rgRet_Soft_IRQ_12:	DD	0	// Retorno da Soft IRQ 12' + NL +
    'rgRet_Soft_IRQ_13:	DD	0	// Retorno da Soft IRQ 13' + NL +
    'rgRet_Soft_IRQ_14:	DD	0	// Retorno da Soft IRQ 14' + NL +
    'rgRet_Soft_IRQ_15:	DD	0	// Retorno da Soft IRQ 15' + NL +
    '' + NL +
    'rgError_Line:		DD	0	// Linha onde ocorreu o erro' + NL +
    'rgError_Code:		DD	0	// Código do erro' + NL +
    'rgError_Handler:	DD	0	// Endereço da rotina de manipulação de erro' + NL +
    '' + NL +
    '' + NL +
    '		// Área de início de programa' + NL +
    '		ORG	257' + NL +
    '' + NL +
    'START_:' + NL +
    'CSINI_:	DD	PROGR_' + NL +
    'CSEND_:	DD	END_' + NL +
    'DSINI_:	DD	PARS_' + NL +
    'DSEND_:	DD	END_' + NL +
    '' + NL +
    '// CODE SEGMENT' + NL +
    'PROGR_:	subleq  PNT_  PNT_         // if {PNT_ = PNT_ - PNT_) <= 0 goto next    // Limpa PNT_' + NL +
    '' + NL +
    'LOOP_:	subleq  CHR_  CHR_         // if {CHR_ = CHR_ - CHR_) <= 0 goto next    // Limpa CHR_' + NL +
    '	subleq  INI_  PNT_         // if {PNT_ = PNT_ - INI_) <= 0 goto next    // Obtém posição do caracter (-PNT_)' + NL +
    '	subleq  PNT_  CHR_         // if {CHR_ = CHR_ - PNT_) <= 0 goto next    // Coloca o caracter em CHR_' + NL +
    '	subleq  PNT_  PNT_         // if {PNT_ = PNT_ - PNT_) <= 0 goto next     // Limpa PNT_' + NL +
    '' + NL +
    'PRT_:	subleq  CHR_  rgIO_2       // Print CHR_ (INITXT_ ~ FIMTXT_); goto next' + NL +
    '	subleq  NEG_   INI_        // if {INI_ = INI_ - NEG_) <= 0 goto next    // Incrementa INI_' + NL +
    '	subleq  CHR_  CHR_         // if {CHR_ = CHR_ - CHR_) <= 0 goto next    // Limpa CHR_' + NL +
    '	subleq  FIM_  PNT_         // if {PNT_ = PNT_ - FIMTXT_) <= 0 goto next // PNT_ = -FIMTXT_ = -FIM_' + NL +
    '	subleq  PNT_  CHR_         // if {CHR_ = CHR_ - PNT_) <= 0 goto next' + NL +
    '	subleq  PNT_  PNT_         // if {PNT_ = PNT_ - PNT_) <= 0 goto next' + NL +
    '	subleq  INI_  CHR_  HALT   // if (CHR_ = CHR_ - INI_) <= 0 goto HALT' + NL +
    '	subleq  PNT_  PNT_  LOOP_  // if {PNT_ = PNT_ - PNT_) <= 0 goto 0' + NL +
    '' + NL +
    'NEG_:	DD  -1' + NL +
    'INI_:	DD  INITXT_' + NL +
    'FIM_:	DD  FIMTXT_' + NL +
    '' + NL +
    'INITXT_:' + NL +
    '	DD  12		// CLS' + NL +
    '	DD  79		// O' + NL +
    '	DD  73		// I' + NL +
    '	DD  83		// S' + NL +
    '	DD  67		// C' + NL +
    '	DD  32		// SPC' + NL +
    '	DD  69		// E' + NL +
    '	DD  109		// m' + NL +
    '	DD  117		// u' + NL +
    '	DD  108		// l' + NL +
    '	DD  97		// a' + NL +
    '	DD  116		// t' + NL +
    '	DD  111		// o' + NL +
    '	DD  114		// r' + NL +
    '	DD  10		// LF' + NL +
    'FIMTXT_:' + NL +
    'END_:' + NL +
    '' + NL +
    '// DATA SEGMENT' + NL +
    'PARS_: DD  0  0  0' + NL +
    '	      DD  0  0  0' + NL +
    '	      DD  0  0  0' + NL +
    '' + NL +
    'CHR_: DD  0' + NL +
    'PNT_: DD  0' + NL +
    '' + NL +
    '' + NL +
    '' + NL +
    '		ORG	$FFFF000				// 16776960' + NL +
    'COLD:		subleq	ZRO	rgHALT				// Limpa sinal de HALT (16777215)' + NL +
    '		subleq	NR	rgNMI				// Habilita NMI' + NL +
    '		subleq	NR	rgHard_IRQ			// Habilita Hard IRQ' + NL +
    '		subleq	NR	rgSoft_IRQ			// Habilta Soft IRQ' + NL +
    '' + NL +
    '		// EXECUTA O PROGRAMA ATUAL' + NL +
    '		// Salva o espaço de código' + NL +
    '		subleq	TEMP	TEMP' + NL +
    '		subleq	rgCS_Start	rgCS_Start' + NL +
    '		subleq	CSINI_	TEMP' + NL +
    '		subleq	TEMP	rgCS_Start' + NL +
    '' + NL +
    '		subleq	TEMP	TEMP' + NL +
    '		subleq	rgCS_End	rgCS_End' + NL +
    '		subleq	CSEND_	TEMP' + NL +
    '		subleq	TEMP	rgCS_End' + NL +
    '' + NL +
    '		// Salva o espaço de dados' + NL +
    '		subleq	TEMP	TEMP' + NL +
    '		subleq	rgDS_Start	rgDS_Start' + NL +
    '		subleq	DSINI_	TEMP' + NL +
    '		subleq	TEMP	rgDS_Start' + NL +
    '' + NL +
    '		// Executa o programa' + NL +
    '		subleq	TEMP	TEMP' + NL +
    '		subleq	rgDS_End	rgDS_End' + NL +
    '		subleq	DSEND_	TEMP' + NL +
    '		subleq	TEMP	rgDS_End' + NL +
    '		subleq	TEMP	TEMP	rgCS_Start' + NL +
    '' + NL +
    'HALT:		subleq	NR	rgHALT				// Seta sinal de HALT (16777215)' + NL +
    'HLT1:		subleq	TEMP	TEMP	HLT1			// Loop eterno até RESET' + NL +
    '' + NL +
    'KBDSTS:		subleq	TEMP	TEMP				// Limpa TEMP' + NL +
    '		subleq	rgIO_0	TEMP				// TEMP = -(Status do teclado)' + NL +
    '		subleq	rgDS_Start	rgDS_Start		// Limpa a primeira posição da região de dados do program atual' + NL +
    '		subleq	TEMP	rgDS_Start			// rgDS_Start = -(-TEMP)			//' + NL +
    '		subleq	TEMP	TEMP	rgRet_Soft_IRQ_0	// Volta à rotina que o chamou' + NL +
    '' + NL +
    'INKEY:		subleq	TEMP	TEMP				// Limpa TEMP' + NL +
    '		subleq	rgIO_1	TEMP				// TEMP = -(Tecla)' + NL +
    '		subleq	rgDS_Start	rgDS_Start		// Limpa a primeira posição da região de dados do program atual' + NL +
    '		subleq	TEMP	rgDS_Start			// rgDS_Start = Tecla			//' + NL +
    '		subleq	TEMP	TEMP	rgRet_Soft_IRQ_0	// Volta à rotina que o chamou' + NL +
    '' + NL +
    'OUTCHAR:	subleq	TEMP	TEMP				// Limpa TEMP' + NL +
    '		subleq  rgDS_Start	TEMP			// Recupera o caracter a ser impresso (-char em TEMP)' + NL +
    '		subleq  TEMP		rgIO_1			// Envia o caracter a ser impresso à porta' + NL +
    '		subleq  TEMP	TEMP	rgRet_Soft_IRQ_0' + NL +
    '' + NL +
    'NR		DD	-1' + NL +
    'ONE:		DD	1' + NL +
    'ZRO:		DD	0		// Zero' + NL +
    'THE_END:' + NL +
    '' + NL +
    '		// Definições dos registros internos da CPU' + NL +
    '		DC	rgHALT		$FFFFFF93		// Sinal HALT' + NL +
    '' + NL +
    '		DC	rgNMI		$FFFFFF94		// Habilita NMI' + NL +
    '		DC	rgHard_IRQ	$FFFFFF95		// Habilita Hard IRQ' + NL +
    '		DC	rgSoft_IRQ	$FFFFFF96		// Habilta Soft IRQ' + NL +
    '' + NL +
    '		DC	rgMemTop	$FFFFFF97		// Ponteiro de topo de memória' + NL +
    '' + NL +
    '		DC	rgProtected	$FFFFFF98		// Flag de modo protegido' + NL +
    '' + NL +
    '		// Se modo protegido habilitado, esses endereços também indicam os limites da programa' + NL +
    '		// ESTAS ÁREAS NÃO PODEM ENCAVALAR' + NL +
    '		DC	rgCS_Start	$FFFFFF99		// Início da área de código -+' + NL +
    '		DC	rgCS_End	$FFFFFF9A		// Fim da área de código ----+---> Área apenas para leitura e execução' + NL +
    '		DC	rgDS_Start	$FFFFFF9B		// Início da área de dados -+' + NL +
    '		DC	rgDS_End	$FFFFFF9C		// Fim da área de dados ----+----> Área apenas para leitura/escrita' + NL +
    '		//' + NL +
    '' + NL +
    '		DC	rgIO_0		$FFFFFFE0		// Status teclado' + NL +
    '		DC	rgIO_1		$FFFFFFE1		// Inkey' + NL +
    '		DC	rgIO_2		$FFFFFFE2		// OutChar' + NL +
    '		DC	rgIO_3		$FFFFFFE3' + NL +
    '		DC	rgIO_4		$FFFFFFE4' + NL +
    '		DC	rgIO_5		$FFFFFFE5' + NL +
    '		DC	rgIO_6		$FFFFFFE6' + NL +
    '		DC	rgIO_7		$FFFFFFE7' + NL +
    '		DC	rgIO_8		$FFFFFFE8' + NL +
    '		DC	rgIO_9		$FFFFFFE9' + NL +
    '		DC	rgIO_10		$FFFFFFEA' + NL +
    '		DC	rgIO_11		$FFFFFFEB' + NL +
    '		DC	rgIO_12		$FFFFFFEC' + NL +
    '		DC	rgIO_13		$FFFFFFED' + NL +
    '		DC	rgIO_14		$FFFFFFEE' + NL +
    '		DC	rgIO_15		$FFFFFFEF' + NL +
    '		DC	rgIO_16		$FFFFFFF0' + NL +
    '		DC	rgIO_17		$FFFFFFF1' + NL +
    '		DC	rgIO_18		$FFFFFFF2' + NL +
    '		DC	rgIO_19		$FFFFFFF3' + NL +
    '		DC	rgIO_20		$FFFFFFF4' + NL +
    '		DC	rgIO_21		$FFFFFFF5' + NL +
    '		DC	rgIO_22		$FFFFFFF6' + NL +
    '		DC	rgIO_23		$FFFFFFF7' + NL +
    '		DC	rgIO_24		$FFFFFFF8' + NL +
    '		DC	rgIO_25		$FFFFFFF9' + NL +
    '		DC	rgIO_26		$FFFFFFFA' + NL +
    '		DC	rgIO_27		$FFFFFFFB' + NL +
    '		DC	rgIO_28		$FFFFFFFC' + NL +
    '		DC	rgIO_29		$FFFFFFFD' + NL +
    '		DC	rgIO_30		$FFFFFFFE' + NL +
    '' + NL +
    '		DC	rgCallIRQ	$FFFFFFFF		// gancho para chamada de IRQ (Mem[A] contém o número da rotina';

implementation

end.

