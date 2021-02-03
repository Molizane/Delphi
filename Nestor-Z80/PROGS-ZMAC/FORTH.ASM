; This is an implementation of FORTH for the Z80 that
; should be easily portable to other Z80 systems.
; It assumes RAM from $9000 to $FFFF and a UART for
; communication with the host or VDU.

DATA_STACK	EQU	$FD80		;Data stack grows down
VOCAB_BASE	EQU	$F000		;Dictionary grows up from here
MASS_STORE	EQU	$FEA0		;Mass storage buffer (default)
DISK_START	EQU	$A000		;Pseudo disk buffer start
DISK_END	EQU	$F000		;Pseudo disk buffer end
BLOCK_SIZE	EQU	$0200		;Pseudo disk block size
BUFFERS		EQU	$0001		;Pseudo disk buffers per block

MONSTART	EQU	$0000		;Monitor entry address

	ORG	$FE00		;Set up system variable addresses

SYSTEM					;Start of scratch pad area
			DS	6		;User bytes
S0			DW	0		;Initial value of the data stack pointer
R0			DW	0		;Initial value of the return stack pointer
TIB			DW	0		;Address of the terminal input buffer
WIDTH		DW	0		;Number of letters saved in names
WARNING		DW	0		;Error message control number
FENCE		DW	0		;Dictionary FORGET protection point
DP			DW	0		;The dictionary pointer
VOC_LINK	DW	0		;Most recently created vocabulary
BLK			DW	0		;Current block number under interpretation
TOIN		DW	0		;Offset in the current input text buffer
OUT_		DW	0		;Offset in the current output text buffer
SCR			DW	0		;Screen number last referenced by LIST
OFFSET		DW	0		;Block offset for disk drives
CONTEXT		DW	0		;Pointer to the vocabulary within which
						;dictionary search will first begin
CURRENT		DW	0		;Pointer to the vocabulary within which
						;new definitions are to be created
STATE		DW	0		;Contains state of compillation
BASE		DW	0		;Current I/O base address
DPL			DW	0		;Number of digits to the right of the
						;decimal point on double integer input
FLD			DW	0		;Field width for formatted number output
CSP			DW	0		;Check stack pointer
RHASH		DW	0		;Location of editor cursor in a text bloxk
HLD			DW	0		;Address of current output
FLAST		DS	6		;FORTH vocabulary data initialised to FORTH
						;vocabulary
ELAST		DS	6		;Editor vocabulary data initialised to
						;EDITOR vocabulary
CRFLAG		DB	0		;Carriage return flag
			DB	0		;User byte
PAT			DS	3		;I/O port fetch routine (input)
PST			DS	3		;I/O port store routine (output)
RPP			DW	0		;Return stack pointer
USE			DW	0		;Mass storage buffer address to use
PREV		DW	0		;Mass storage buffer address just used
INTFLAG		DB	0		;Interrupt flag
			DB	0		;User byte
INTVECT		DW	0		;Interrupt vector
UTERMINAL	DW	0		;Code field address of word ?TERMINAL
UKEY		DW	0		;Code field address of word KEY
UEMIT		DW	0		;Code field address of word EMIT
URW			DW	0		;Code field address of word R/W
UCR			DW	0		;Code field address of word CR
UABORT		DW	0		;Code field address of word ABORT
UCL			DW	0		;Number of characters per input line
UFIRST		DW	0		;Start of pseudo disk buffer
ULIMIT		DW	0		;End of pseudo disk buffer
UBBUF		DW	0		;Number of bytes per block
UBSCR		DW	0		;Number of buffers per block
KEYBUF		DW	0		;Double key buffer
RAF			DW	0		;Register AF
RBC			DW	0		;Register BC
RDE			DW	0		;Register DE
RHL			DW	0		;Register HL
RIX			DW	0		;Register IX
RIY			DW	0		;Register IY
RAF2		DW	0		;Register AF'
RBC2		DW	0		;Register BC'
RDE2		DW	0		;Register DE'
RHL2		DW	0		;Register HL'
			DB	0		;User byte
JPCODE		DB	0		;JMP code (C3) for word CALL
JPVECT		DW	0		;JMP vector for word CALL
			DS	32		;User bytes

;	IO/M Addresses

; This assumes that the uPF IO/M card is fitted.

URTDA		EQU	$60		;8251 UART Data Port
URTCNT		EQU	$61		;8251 UART Control Port

CTC2		EQU	$66		;CTC Channel 2, Baud rate gen for UART

	ORG	$8000			;Start of RAM

;	Setup 8251 9600 baud 8N1	*

; Change this bit to suit your systems port initialisation.

	LD	A,$47				;Counter mode, TC follows, Reset channel
	OUT	(CTC2),A			;CTC2 is baud rate gen for 8251
	LD	A,$03				;Time const for 9600 baud
	OUT	(CTC2),A			;
	LD	HL,RESTAB			;Reset sequence for 8251
	LD	B,TABEND-RESTAB		;Table length
	LD	C,URTCNT			;Point to control port
	OTIR					;OUT and loop until done

	XOR	A					;Clear A
	LD	(KEYBUF),A			;Clear buffered key
	JP	X_COLD

RESTAB
	DB	$00,$00,$00,$40,$4E,$37
TABEND

BACKSPACE
	DW	$0008			;Backspace chr

WORD1
	DW	DATA_STACK
DEF_SYSADDR
	DW	SYSTEM
	DW	DATA_STACK
	DW	$001F			;Word name length (default 31)
	DW	$0000			;Error message control number
	DW	VOCAB_BASE		;FORGET protection
	DW	VOCAB_BASE+$0B		;Dictionary pointer
	DW	E_FORTH			;Most recently created vocab.

START_TABLE
	DB	$81,$A0
	DW	VOCAB_BASE
	DB	$00,$00			;FLAST
	DB	$81,$A0
	DW	W_EDITI
	DW	E_FORTH			;ELAST
	DB	$00			;CRFLAG
	DB	$00			;Free
	IN	A,($00)			;I/O Port input
	RET				;routine
	OUT	($00),A			;I/O Port output
	RET				;routine
	DW	SYSTEM 			;Return stack pointer
	DW	MASS_STORE		;Mass storage buffer to use
	DW	MASS_STORE		;Storage buffer just used
	DB	$00			;Interrupt flag
	DB	$00			;Free
	DW	C_ABORT			;Interrupt vector
	DW	CF_UQTERMINAL		;C field address ?TERMINAL
	DW	CF_UKEY			;C field address KEY
	DW	CF_UEMIT		;C field address EMIT
	DW	CF_UCR			;C field address CR
	DW	CF_URW			;C field address R/W
	DW	CF_UABORT		;C field address ABORT
	DW	$0020			;CHRs per input line
	DW	DISK_START		;Pseudo disk buf start
	DW	DISK_END		;Pseudo disk buf end
	DW	BLOCK_SIZE		;Bytes per block
	DW	BUFFERS			;Buffers per block

NEXTS2
	PUSH	DE
NEXTS1
	PUSH	HL
NEXT
	LD	A,(INTFLAG)		;Interrupt flag
	BIT	7,A				;Check for interrupt
	JR	Z,NOINT			;No interrupt
	BIT	6,A				;Interrupt enabled ?
	JR	NZ,NOINT		;No interrupt
	LD	HL,(INTVECT)	;Get interrupt vector
	LD	A,$40			;Clear flag byte
	LD	(INTFLAG),A		;Interrupt flag into HL
	JR	NEXTADDR		;JP (HL)
NOINT
	LD	A,(BC)			;effectively LD HL,(BC)
	INC	BC				;
	LD	L,A				;
	LD	A,(BC)			;
	INC	BC				;BC now points to next vector
	LD	H,A				;HL has addr vector
NEXTADDR
	LD	E,(HL)			;effectively LD HL,(HL)
	INC	HL				;
	LD	D,(HL) 			;
	EX	DE,HL 			;
	JP	(HL) 			;Jump to it

W_LIT					;Puts next 2 bytes on the stack
	DB	$83,'LI','T'+$80
	DW	$0000			;First word in vocabulary
C_LIT
	DW	2+$				;Vector to code
	LD	A,(BC)			;Gets next word from (BC)
	INC	BC				;then increments BC to point
	LD	L,A				;to the next addr. Pushes the
	LD	A,(BC)			;result onto the stack.
	INC	BC				;
	LD	H,A				;
	JP	NEXTS1			;Save & NEXT


W_EXECUTE	;Jump to address on stack
	DB	$87,'EXECUT','E'+$80
	DW	W_LIT
C_EXECUTE
	DW	2+$			;Vector to code
	POP	HL			;Get addr off data stack
	JP	NEXTADDR		;Basically JP (HL)


W_BRANCH	;Add following offset to BC
	DB	$86,'BRANC','H'+$80
	DW	W_EXECUTE
C_BRANCH
	DW	2+$			;Vector to code
X_BRANCH
	LD	H,B			;Next pointer into HL
	LD	L,C			;
	LD	E,(HL)			;Get word offset LD DE,(HL)
	INC	HL			;Incr to point at next byte
	LD	D,(HL)			;
	DEC	HL 			;Restore HL
	ADD	HL,DE			;Calculate new address
	LD	C,L			;Put it in BC
	LD	B,H			;
	JP	NEXT			;Go do it


W_0BRANCH	;Add offset to BC if stack top = 0
	DB	$87,'0BRANC','H'+$80	;Conditional branch
	DW	W_BRANCH
C_0BRANCH
	DW	2+$			;Vector to code
	POP	HL			;Get value off stack
	LD	A,L			;Set flags
	OR	H			;
	JR	Z,X_BRANCH		;If zero then do the branch
	INC	BC			;Else dump branch address
	INC	BC			;
	JP	NEXT			;Continue execution

W_LLOOP		;Increment loop & branch if not done
	DB	$86,'<LOOP','>'+$80
	DW	W_0BRANCH
C_LLOOP
	DW	2+$			;Vector to code
	LD	DE,0001
C_ILOOP
	LD	HL,(RPP)		;Get return stack pointer
	LD	A,(HL)			;Add DE to value on return stack
	ADD	A,E			;
	LD	(HL),A			;
	LD	E,A			;
	INC	HL			;
	LD	A,(HL)			;
	ADC	A,D			;
	LD	(HL),A			;
	INC	HL			;HL now points to limit value
	INC	D			;Get Ds sign bit
	DEC	D			;
	LD	D,A			;Result now in DE
	JP	M,DECR_LOOP		;Decrement loop so check > limit
					;otherwies check < limit
	LD	A,E			;Low byte back
	SUB	(HL)			;Subtract limit low
	LD	A,D			;High byte back
	INC	HL			;Point to limit high
	SBC	A,(HL)			;Subtract it
	JR	TEST_LIMIT		;
DECR_LOOP
	LD	A,(HL)			;Get limit low
	SUB	E			;Subtract index low
	INC	HL			;Point to limit high
	LD	A,(HL)			;Get it
	SBC	A,D			;Subtract index high
TEST_LIMIT
	JP	M,X_BRANCH		;Not reached limit so jump
	INC	HL			;Drop index & limit from return stack
	LD	(RPP),HL		;Save stack pointer
	INC	BC			;Skip branch offset
	INC	BC			;
	JP	NEXT

W_PLOOP		;Loop + stack & branch if not done
	DB	$87,'<+LOOP','>'+$80
	DW	W_LLOOP
C_PLOOP
	DW	2+$			;Vector to code
	POP	DE			;Get value from stack
	JR	C_ILOOP			;Go do loop increment

W_LDO		;Put start & end loop values on RPP
	DB	$84,'<DO','>'+$80
	DW	 W_PLOOP
C_LDO
	DW	 2+$
	LD	HL,(RPP)		;Get return stack pointer
	DEC	HL			;Add space for two values
	DEC	HL			;
	DEC	HL			;
	DEC	HL			;
	LD	(RPP),HL		;Save new stack pointer
	POP	DE			;Get start value &
	LD	(HL),E			;put on return stack top
	INC	HL			;
	LD	(HL),D			;
	INC	HL			;
	POP	DE			;Get end value &
	LD	(HL),E			;put on return stack - 1
	INC	HL			;
	LD	(HL),D			;
	JP	NEXT

W_I		;Copy LOOP index to data stack
	DB	$81,'I'+$80
	DW	 W_LDO
C_I
	DW	 2+$
X_I
	LD	HL,(RPP)		;Get return stack pointer
X_I2
	LD	E,(HL)			;Get LOOP index off return stack
	INC	HL			;
	LD	D,(HL)			;
	PUSH	DE			;Push onto data stack
	JP	NEXT

W_DIGIT		;Convert digit n2 using base n1
	DB	$85,'DIGI','T'+$80
	DW	 W_I
C_DIGIT
	DW	2+$
	POP	HL			;Get base to use
	POP	DE			;Get char
	LD	A,E			;A = char
	SUB	$30			;Subtract 30h
	JP	M,NDIGIT		;
	CP	$0A			;Greater than 9 ?
	JP	M,LESS10		;If not then skip
	SUB	$07			;Convert 'A' to 10
	CP	$0A			;Is it 10?
	JP	M,NDIGIT		;If not an error occured
LESS10
	CP	L			;L is 1 digit limit
	JP	P,NDIGIT		;Out of range for digit
	LD	E,A			;Result into DE
	LD	HL,0001			;Leave TRUE flag
	JP	NEXTS2			;Save both & NEXT
NDIGIT
	LD	L,H			;Leave FALSE flag
	JP	NEXTS1			;Save & NEXT

W_FIND		;Find word & return vector,byte & flag
	DB	$86,'<FIND','>'+$80
	DW	W_DIGIT
C_FIND
	DW	2+$			;Vector to code
	POP	DE			;Get pointer to next vocabulary word
COMPARE
	POP	HL			;Copy pointer to word we're looking 4
	PUSH	HL			;
	LD	A,(DE)			;Get 1st vocabulary word letter
	XOR	(HL)			;Compare with what we've got
	AND	$3F			;Ignore start flag
	JR	NZ,NOT_END_CHR		;No match so skip to next word
MATCH_NO_END
	INC	HL			;Compare next chr
	INC	DE			;
	LD	A,(DE)			;
	XOR	(HL)			;
	ADD	A,A			;Move bit 7 to C flag
	JR	NZ,NO_MATCH		;No match jump
	JR	NC,MATCH_NO_END		;Match & not last, so next chr
	LD	HL,0005			;Offset to start of code
	ADD	HL,DE			;HL now points to code start for word
	EX	(SP),HL			;Swap with value on stack
NOT_WORD_BYTE
	DEC	DE			;Search back for word type byte
	LD	A,(DE)			;
	OR	A			;
	JP	P,NOT_WORD_BYTE		;Not yet so loop
	LD	E,A			;Byte into DE
	LD	D,$00			;
	LD	HL,0001			;Leave TRUE flag
	JP	NEXTS2			;Save both & NEXT
NO_MATCH
	JR	C,END_CHR		;If last chr then jump
NOT_END_CHR
	INC	DE			;Next chr of this vocab word
	LD	A,(DE)			;Get it
	OR	A			;Set flags
	JP	P,NOT_END_CHR		;Loop if not end chr
END_CHR
	INC	DE			;Now points to next word vector
	EX	DE,HL			;Swap
	LD	E,(HL)			;Vector into DE
	INC	HL			;
	LD	D,(HL)			;
	LD	A,D			;Check it's not last (first) word
	OR	E			;
	JR	NZ,COMPARE		;No error so loop
	POP	HL			;Dump pointer
	LD	HL,0000			;Flag error
	JP	NEXTS1			;Save & NEXT

W_ENCLOSE
	DB	$87,'ENCLOS','E'+$80
	DW	W_FIND
C_ENCLOSE
	DW	2+$			;Vector to code
	POP	DE			; get delimiter character
	POP	HL			; get address 1
	PUSH	HL			; duplicate it
	LD	A,E			; delimiter char into A
	LD	D,A			; copy to D
	LD	E,$FF			; -1 for offset
	DEC	HL			; to allow for first INCR
J21E6
	INC	HL			; point to next chr
	INC	E			; next offset
	CP	(HL)			; compare chr with (address)
	JR	Z,J21E6			; loop if = delimiter chr
	LD	A,$0D			; else set CR
	CP	(HL)			; compare with (address)
	LD	A,D			; restore delimiter chr
	JR	Z,J21E6			; loop if it was = CR
	LD	D,$00			; zero high byte
	PUSH	DE			; save offset
	LD	D,A			; restore delimiter chr
	LD	A,(HL)			; get byte from address
	AND	A			; set the flags
	JR	NZ,J2202		; branch if not null
	LD	D,$00			; clear high byte
	INC	E			; point to next addr
	PUSH	DE			; save address
	DEC	E			; point to end
	PUSH	DE			; push address
	JP	NEXT			; done
J2202
	LD	A,D			; restore delimiter chr
	INC	HL			; increment address
	INC	E			; increment offset
	CP	(HL)			; compare delimiter with (address)
	JR	Z,J2218			; jump if =
	LD	A,$0D			; else get CR
	CP	(HL)			; compare with (address)
	JR	Z,J2218			; jump if =
	LD	A,(HL)			; else get byte
	AND	A			; set the flags
	JR	NZ,J2202		; loop if not null
	LD	D,$00			; clear gigh byte
	PUSH	DE			; save address
	PUSH	DE			; save address
	JP	NEXT			; done
J2218
	LD	D,$00			; clear high byte
	PUSH	DE			; save address
	INC	E			; increment offset
	PUSH	DE			; save address
	JP	NEXT			; done

W_EMIT		;Output CHR from stack
	DB	$84,'EMI','T'+$80
	DW	W_ENCLOSE
C_EMIT
	DW	E_COLON			;Interpret following word sequence
	DW	C_UEMIT			;Put UEMIT addr on stack
	DW	C_FETCH			;Get UEMIT code field address
	DW	C_EXECUTE		;Jump to address on stack
	DW	C_1
	DW	C_OUT
	DW	C_PLUSSTORE
	DW	C_STOP			;Pop BC from return stack (=next)

W_KEY		;Wait for key, value on stack
	DB	$83,'KE','Y'+$80
	DW	W_EMIT
C_KEY
	DW	2+$			;Vector to code
	LD	HL,(UKEY)		;Get the vector
	JP	(HL)			;Jump to it

;	DW	E_COLON			;Interpret following word sequence
;	DW	C_UKEY			;Put UKEY addr on stack
;	DW	C_FETCH			;Get CF_KEY
;	DW	C_EXECUTE		;Jump to CF_KEY
;	DW	C_STOP			;Pop BC from return stack (=next)


W_TERMINAL
	DB	$89,'?TERMINA','L'+$80
	DW	W_KEY
C_TERMINAL
	DW	E_COLON			;Interpret following word sequence
	DW	C_UTERMINAL
	DW	C_FETCH			;Get word from addr on stack
	DW	C_EXECUTE		;Jump to address on stack
	DW	C_STOP			;Pop BC from return stack (=next)

W_CR		;Output [CR][LF]
	DB	$82,'C','R'+$80
	DW	W_TERMINAL
C_CR
	DW	E_COLON			;Interpret following word sequence
	DW	C_UCR			;Push UCR addr
	DW	C_FETCH			;Get UCR code field addr
	DW	C_EXECUTE		;Jump to address on stack
	DW	C_STOP			;Pop BC from return stack (=next)

W_CLS		;Clear screen
	DB	$83,'CL','S'+$80
	DW	W_CR
C_CLS
	DW	E_COLON			;Interpret following word sequence
	DW	C_LIT			;Put clear screen code on stack
	DW	$000C			;
	DW	C_EMIT			;Output it
	DW	C_STOP			;Pop BC from return stack (=next)

W_CMOVE		;Move block
	DB	$85,'CMOV','E'+$80
	DW	W_CLS
C_CMOVE
	DW	2+$			;Vector to code
	LD	L,C			;Save BC for now
	LD	H,B			;
	POP	BC			;Get no. of bytes to move
	POP	DE			;Get destination address
	EX	(SP),HL			;Get source address
	LD	A,B			;Check it's not a 0 length block
	OR	C			;
	JR	Z,NO_BYTES		;If 0 length then do nothing
	LDIR				;Move block
NO_BYTES
	POP	BC			;Get BC back
	JP	NEXT

W_USTAR		;Unsigned multiply
	DB	$82,'U','*'+$80
	DW	W_CMOVE
C_USTAR
	DW	2+$			;Vector to code
	POP	DE			; get n2
	POP	HL			; get n1
	PUSH	BC			; save BC for now
	LD	C,H			; save H
	LD	A,L			; low byte to multiply by
	CALL	HALF_TIMES		; HL = A * DE
	PUSH	HL			; save partial result
	LD	H,A			; clear H
	LD	A,C			; high byte to multiply by
	LD	C,H			; clear B
	CALL	HALF_TIMES		; HL = A * DE
	POP	DE			; get last partial result
	LD	B,C			; add partial results
	LD	C,D			; add partial results
	ADD	HL,BC			;
	ADC	A,$00			;
	LD	D,L			;
	LD	L,H			;
	LD	H,A			;
	POP	BC			; get BC back
	JP	NEXTS2			; save 32 bit result & NEXT

HALF_TIMES				;
	LD	HL,$0000		; clear partial result
	LD	B,$08			; eight bits to do
NEXT_BIT
	ADD	HL,HL			; result * 2
	RLA				; multiply bit into C
	JR	NC,NO_MUL		; branch if no multiply
	ADD	HL,DE			; add multiplicand
	ADC	A,$00			; add in any carry
NO_MUL
	DJNZ	NEXT_BIT		; decr and loop if not done
	RET				;

W_UMOD		;Unsigned divide & MOD
	DB	$85,'U/MO','D'+$80
	DW	W_USTAR
C_UMOD
	DW	2+$			;Vector to code
	LD	HL,0004
	ADD	HL,SP
	LD	E,(HL)
	LD	(HL),C
	INC	HL
	LD	D,(HL)
	LD	(HL),B
	POP	BC
	POP	HL
	LD	A,L
	SUB	C
	LD	A,H
	SBC	A,B
	JR	C,J22DB
	LD	HL,$FFFF
	LD	DE,$FFFF
	JR	J2301
J22DB
	LD	A,$10
J22DD
	ADD	HL,HL
	RLA
	EX	DE,HL
	ADD	HL,HL
	JR	NC,J22E5
	INC	DE
	AND	A
J22E5
	EX	DE,HL
	RRA
	PUSH	AF
	JR	NC,J22F2
	LD	A,L
	SUB	C
	LD	L,A
	LD	A,H
	SBC	A,B
	LD	H,A
	JR	J22FC
J22F2
	LD	A,L
	SUB	C
	LD	L,A
	LD	A,H
	SBC	A,B
	LD	H,A
	JR	NC,J22FC
	ADD	HL,BC
	DEC	DE
J22FC
	INC	DE
	POP	AF
	DEC	A
	JR	NZ,J22DD
J2301
	POP	BC
	PUSH	HL
	PUSH	DE
	JP	NEXT

W_AND		;AND
	DB	$83,'AN','D'+$80
	DW	W_UMOD
C_AND
	DW	2+$			;Vector to code
	POP	DE			;Get n1 off stack
	POP	HL			;Get n2 off stack
	LD	A,E			;AND lo bytes
	AND	L			;
	LD	L,A			;Result in L
	LD	A,D			;AND hi bytes
	AND	H			;
	LD	H,A			;Result in H
	JP	NEXTS1			;Save & next

W_OR		;OR
	DB	$82,'O','R'+$80
	DW	W_AND
C_OR
	DW	2+$			;Vector to code
	POP	DE			;Get n1 off stack
	POP	HL			;Get n2 off stack
	LD	A,E			;OR lo bytes
	OR	L			;
	LD	L,A			;Result in L
	LD	A,D			;OR hi bytes
	OR	H			;
	LD	H,A			;Result in H
	JP	NEXTS1			;Save & next

W_XOR		;XOR
	DB	$83,'XO','R'+$80
	DW	W_OR
C_XOR
	DW	2+$			;Vector to code
	POP	DE			;Get n1 off stack
	POP	HL			;Get n2 off stack
	LD	A,E			;XOR lo bytes
	XOR	L			;
	LD	L,A			;Result in L
	LD	A,D			;XOR hi bytes
	XOR	H			;
	LD	H,A			;Result in H
	JP	NEXTS1			;Save & NEXT

W_SPFETCH	;Stack pointer onto stack
	DB	$83,'SP','@'+$80
	DW	W_XOR
C_SPFETCH
	DW	2+$			;Vector to code
	LD	HL,0000			;No offset
	ADD	HL,SP			;Add SP to HL
	JP	NEXTS1			;Save & NEXT

W_SPSTORE	;Set initial stack pointer value
	DB	$83,'SP','!'+$80
	DW	W_SPFETCH
C_SPSTORE
	DW	2+$			;Vector to code
	LD	HL,(DEF_SYSADDR)	;Get system base addr
	LD	DE,S0-SYSTEM		;Offset to stack pointer value (0006)
	ADD	HL,DE			;Add to base addr
	LD	E,(HL)			;Get SP from ram
	INC	HL			;
	LD	D,(HL)			;
	EX	DE,HL			;Put into HL
	LD	SP,HL			;Set SP
	JP	NEXT

W_RPFETCH	;Get return stack pointer
	DB	$83,'RP','@'+$80
	DW	W_SPSTORE
C_RPFETCH
	DW	2+$			;Vector to code
	LD	HL,(RPP)		;Return stack pointer into HL
	JP	NEXTS1			;Save & NEXT

W_RPSTORE	;Set initial return stack pointer
	DB	$83,'RP','!'+$80
	DW	W_RPFETCH
C_RPSTORE
	DW	2+$			;Vector to code
	LD	HL,(DEF_SYSADDR)	;Get system base addr
	LD	DE,0008			;Offset to return stack pointer value
	ADD	HL,DE			;Add to base addr
	LD	E,(HL)			;Get SP from ram
	INC	HL			;
	LD	D,(HL)			;
	EX	DE,HL			;Put into HL
	LD	(RPP),HL		;Set return SP
	JP	NEXT

W_STOP		;Pop BC from return stack (=next)
	DB	$82,';','S'+$80
	DW	W_RPSTORE
C_STOP
	DW	2+$			;Vector to code
X_STOP
	LD	HL,(RPP)		;Return stack pointer to HL
	LD	C,(HL)			;Get low byte
	INC	HL			;
	LD	B,(HL)			;Get high byte
	INC	HL			;
	LD	(RPP),HL		;Save stack pointer
	JP	NEXT

W_LEAVE		;Quit loop by making index = limit
	DB	$85,'LEAV','E'+$80
	DW	W_STOP
C_LEAVE
	DW	2+$			;Vector to code
	LD	HL,(RPP)		;Get return stack pointer
	LD	E,(HL)			;Get loop limit low
	INC	HL			;
	LD	D,(HL)			;Get loop limit high
	INC	HL			;
	LD	(HL),E			;Set index low to loop limit
	INC	HL			;
	LD	(HL),D			;Set index high to loop limit
	JP	NEXT

W_MOVER		;Move from data to return stack
	DB	$82,'>','R'+$80
	DW	W_LEAVE
C_MOVER
	DW	2+$			;Vector to code
	POP	DE			;Get value
	LD	HL,(RPP)		;Get return stack pointer
	DEC	HL			;Set new value
	DEC	HL			;
	LD	(RPP),HL		;Save it
	LD	(HL),E			;Push low byte onto return stack
	INC	HL			;
	LD	(HL),D			;Push high byte onto return stack
	JP	NEXT

W_RMOVE		;Move word from return to data stack
	DB	$82,'R','>'+$80
	DW	W_MOVER
C_RMOVE
	DW	2+$			;Vector to code
	LD	HL,(RPP)		;Get return stack pointer
	LD	E,(HL)			;Pop word off return stack
	INC	HL			;
	LD	D,(HL)			;
	INC	HL			;
	LD	(RPP),HL		;Save new return stack pointer
	PUSH	DE			;Push on data stack
	JP	NEXT

W_RFETCH	;Return stack top to data stack
	DB	$82,'R','@'+$80
	DW	W_RMOVE
C_RFETCH
	DW	X_I			;Return stack top to data stack


W_0EQUALS	;=0
	DB	$82,'0','='+$80
	DW	W_RFETCH
C_0EQUALS
	DW	2+$			;Vector to code
X_0EQUALS
	POP	HL			;Get value from stack
	LD	A,L			;set flags
	OR	H			;
	LD	HL,0000			;Not = 0 flag
	JR	NZ,NO_ZERO		;
	INC	HL			;= 0 flag
NO_ZERO
	JP	NEXTS1			;Save & NEXT

W_NOT		;Convert flag, same as 0=
	DB	$83,'NO','T'+$80
	DW	W_0EQUALS
C_NOT
	DW	X_0EQUALS

W_0LESS		;Less than 0
	DB	$82,'0','<'+$80
	DW	W_NOT
C_0LESS
	DW	2+$			;Vector to code
	POP	HL			;Get value
	ADD	HL,HL			;S bit into C
	LD	HL,0000			;Wasn't < 0 flag
	JR	NC,NOT_LT0		;
	INC	HL			;Was < 0 flag
NOT_LT0				;
	JP	NEXTS1			;Save & NEXT

W_PLUS			;n1 + n2
	DB	$81,'+'+$80
	DW	W_0LESS
C_PLUS
	DW	2+$			;Vector to code
	POP	DE			;Get n2
	POP	HL			;Get n1
	ADD	HL,DE			;Add them
	JP	NEXTS1			;Save & NEXT

W_DPLUS		;32 bit add
	DB	$82,'D','+'+$80
	DW	W_PLUS
C_DPLUS
	DW	2+$			;Vector to code
	LD	HL,0006			; offset to low word
	ADD	HL,SP			; add stack pointer
	LD	E,(HL)			; get d1 low word low byte
	LD	(HL),C			; save BC low byte
	INC	HL			; point to high byte
	LD	D,(HL)			; get d1 low word high byte
	LD	(HL),B			; save BC high byte
	POP	BC			; get high word d2
	POP	HL			; get low word d2
	ADD	HL,DE			; add low words
	EX	DE,HL			; save result low word in DE
	POP	HL			; get d1 high word
	LD	A,L			; copy d1 high word low byte
	ADC	A,C			; add d2 high word low byte
					; + carry from low word add
	LD	L,A			; result from high word low byte into L
	LD	A,H			; copy d1 high word low byte
	ADC	A,B			; add d2 high word low byte
					; + carry from high word low byte add
	LD	H,A			; result from high word high byte into H
	POP	BC			; restore BC
	JP	NEXTS2			;Save 32 bit result & NEXT

W_NEGATE	;Form 2s complement of n
	DB	$86,'NEGAT','E'+$80
	DW	W_DPLUS
C_NEGATE
	DW	2+$			;Vector to code
	POP	HL			;Get number
	LD	A,L			;Low byte into A
	CPL				;Complement it
	LD	L,A			;Back into L
	LD	A,H			;High byte into A
	CPL				;Complement it
	LD	H,A			;Back into H
	INC	HL			;+1
	JP	NEXTS1			;Save & NEXT

W_DNEGATE	;Form 2s complement of 32 bit n
	DB	$87,'DNEGAT','E'+$80
	DW	W_NEGATE
C_DNEGATE
	DW	2+$			;Vector to code
	POP	HL			; get high word
	POP	DE			; get low word
	SUB	A			; clear A
	SUB	E			; negate low word low byte
	LD	E,A			; copy back to E
	LD	A,$00			; clear A
	SBC	A,D			; negate low word high byte
	LD	D,A			; copy back to D
	LD	A,$00			; clear A
	SBC	A,L			; negate high word low byte
	LD	L,A			; copy back to L
	LD	A,$00			; clear A
	SBC	A,H			; negate high word high byte
	LD	H,A			; copy back to H
	JP	NEXTS2			;Save 32 bit result & NEXT

W_OVER		;Copy 2nd down to top of stack
	DB	$84,'OVE','R'+$80
	DW	W_DNEGATE
C_OVER
	DW	2+$			;Vector to code
	POP	DE			;Get top
	POP	HL			;Get next
	PUSH	HL			;Save it back
	JP	NEXTS2			;Save both & NEXT

W_DROP		;Drop top value from stack
	DB	$84,'DRO','P'+$80
	DW	W_OVER
C_DROP
	DW	2+$			;Vector to code
	POP	HL			;Get top value
	JP	NEXT

W_2DROP		;Drop top two values from stack
	DB	$85,'2DRO','P'+$80
	DW	W_DROP
C_2DROP
	DW	2+$			;Vector to code
	POP	HL			;Get top value
	POP	HL			;Get top value
	JP	NEXT

W_SWAP		;Swap top 2 values on stack
	DB	$84,'SWA','P'+$80
	DW	W_2DROP
C_SWAP
	DW	2+$			;Vector to code
	POP	HL			;Get top value
	EX	(SP),HL			;Exchanhe with next down
	JP	NEXTS1			;Save & NEXT

W_DUP		;Duplicate top value on stack
	DB	$83,'DU','P'+$80
	DW	W_SWAP
C_DUP
	DW	2+$			;Vector to code
	POP	HL			;Get value off stack
	PUSH	HL			;Copy it back
	JP	NEXTS1			;Save & NEXT

W_2DUP		;Dup top 2 values on stack
	DB	$84,'2DU','P'+$80
	DW	W_DUP
C_2DUP
	DW	2+$			;Vector to code
	POP	HL			;Get top two values from stack
	POP	DE			;
	PUSH	DE			;Copy them back
	PUSH	HL			;
	JP	NEXTS2			;Save both & NEXT

W_BOUNDS	;Convert address & n to start & end
	DB	$86,'BOUND','S'+$80
	DW	W_2DUP
C_BOUNDS
	DW	2+$			;Vector to code
	POP	HL			; get n
	POP	DE			; get addr
	ADD	HL,DE			; add addr to n
	EX	DE,HL			; swap them
	JP	NEXTS2			; save both & NEXT

W_PLUSSTORE	;Add n1 to addr
	DB	$82,'+','!'+$80
	DW	W_BOUNDS
C_PLUSSTORE
	DW	2+$			;Vector to code
	POP	HL			;Get addr
	POP	DE			;Get DE
	LD	A,(HL)			;Add low bytes
	ADD	A,E			;
	LD	(HL),A			;Store result
	INC	HL			;Point to high byte
	LD	A,(HL)			;Add high bytes
	ADC	A,D			;
	LD	(HL),A			;Store result
	JP	NEXT

W_TOGGLE	;XOR (addr) with byte
	DB	$86,'TOGGL','E'+$80
	DW	W_PLUSSTORE
C_TOGGLE
	DW	2+$			;Vector to code
	POP	DE			;Get byte
	POP	HL			;Get addr
	LD	A,(HL)			;Get byte from addr
	XOR	E			;Toggle it
	LD	(HL),A			;Save result
	JP	NEXT

W_FETCH		;Get word from addr on stack
	DB	$81,'@'+$80
	DW	W_TOGGLE
C_FETCH
	DW	2+$			;Vector to code
	POP	HL			;Get addr
	LD	E,(HL)			;Get low byte
	INC	HL			;
	LD	D,(HL)			;Get high byte
	PUSH	DE			;Save it
	JP	NEXT

W_CFETCH	;Get byte from addr on stack
	DB	$82,'C','@'+$80
	DW	W_FETCH
C_CFETCH
	DW	2+$			;Vector to code
	POP	HL			;Get addr
	LD	L,(HL)			;Get byte
	LD	H,$00			;Top byte = 0
	JP	NEXTS1			;Save & NEXT

W_2FETCH	;Get word from addr+2 and addr
	DB	$82,'2','@'+$80
	DW	W_CFETCH
C_2FETCH
	DW	2+$			;Vector to code
	POP	HL			;Get addr
	LD	DE,0002			;Plus 2 bytes
	ADD	HL,DE			;Get 2nd word first
	LD	E,(HL)			;Low byte
	INC	HL			;
	LD	D,(HL)			;High byte
	PUSH	DE			;Save it
	LD	DE,$FFFD		;Minus 2 bytes
	ADD	HL,DE			;Get 1st word
	LD	E,(HL)			;Low byte
	INC	HL			;
	LD	D,(HL)			;High byte
	PUSH	DE			;Save it
	JP	NEXT

W_STORE		;Store word at addr
	DB	$81,'!'+$80
	DW	W_2FETCH
C_STORE
	DW	2+$			;Vector to code
	POP	HL			;Get addr
	POP	DE			;Get word
	LD	(HL),E			;Store low byte
	INC	HL			;
	LD	(HL),D			;Store high byte
	JP	NEXT

W_CSTORE	;Store byte at addr
	DB	$82,'C','!'+$80
	DW	W_STORE
C_CSTORE
	DW	2+$			;Vector to code
	POP	HL			;Get addr
	POP	DE			;Get byte
	LD	(HL),E			;Save it
	JP	NEXT

W_2STORE	;Store 2 words at addr (+2)
	DB	$82,'2','!'+$80
	DW	W_CSTORE
C_2STORE
	DW	2+$			;Vector to code
	POP	HL			;Get addr
	POP	DE			;Get word
	LD	(HL),E			;Save low byte
	INC	HL			;
	LD	(HL),D			;Save high byte
	INC	HL			;
	POP	DE			;Get next word
	LD	(HL),E			;Save low byte
	INC	HL			;
	LD	(HL),D			;Save high byte
	JP	NEXT

W_COLON
	DB	$81,$80
	DW	W_2STORE
C_COLON
	DW	E_COLON			;Interpret following word sequence
	DW	C_QEXEC			;Error not if not in execute mode
	DW	C_CSPSTORE		;Set current stack pointer value
	DW	C_CURRENT		;Get CURRENT addr
	DW	C_FETCH			;Get word from addr on stack
	DW	C_CONTEXT		;Make CONTEXT current vocab
	DW	C_STORE			;Store word at addr
	DW	C_XXX1			;Puts name into dictionary
	DW	C_RIGHTBRKT		;Set STATE to compile
	DW	C_CCODE			;Execute following machine code

E_COLON
	LD	HL,(RPP)		;Get return stack pointer
	DEC	HL			;Put BC on return stack
	LD	(HL),B			;
	DEC	HL			;
	LD	(HL),C			;
	LD	(RPP),HL		;Save new pointer
	INC	DE
	LD	C,E
	LD	B,D
	JP	NEXT

W_SEMICOLON	;Terminate compilation
	DB	$C1,';'+$80
	DW	W_COLON
C_SEMICOLON
	DW	E_COLON			;Interpret following word sequence
	DW	C_QCOMP			;Check we're allready compiling
	DW	C_WHATSTACK		;Check stack pointer, error if not ok
	DW	C_COMPILE		;Compile next word into dictionary
	DW	C_STOP			;
	DW	C_SMUDGE		;Smudge bit to O.K.
	DW	C_LEFTBRKT		;Set STATE to execute
	DW	C_STOP			;Pop BC from return stack (=next)

W_CONSTANT
	DB	$88,'CONSTAN','T'+$80
	DW	W_SEMICOLON
C_CONSTANT
	DW	E_COLON			;Interpret following word sequence
	DW	C_XXX1
	DW	C_SMUDGE
	DW	C_COMMA			;Reserve 2 bytes and save n
	DW	C_CCODE			;Execute following machine code

X_CONSTANT				;Put next word on stack
	INC	DE			;Adjust pointer
	EX	DE,HL			;Get next word
	LD	E,(HL)			;
	INC	HL			;
	LD	D,(HL)			;
	PUSH	DE			;Put on stack
	JP	NEXT

W_VARIABLE
	DB	$88,'VARIABL','E'+$80
	DW	W_CONSTANT
C_VARIABLE
	DW	E_COLON			;Interpret following word sequence
	DW	C_ZERO			;Put zero on stack
	DW	C_CONSTANT
	DW	C_CCODE			;Execute following machine code

X_VARIABLE
	INC	DE
	PUSH	DE
	JP	NEXT

W_USER
	DB	$84,'USE','R'+$80
	DW	W_VARIABLE
C_USER
	DW	E_COLON			;Interpret following word sequence
	DW	C_CONSTANT
	DW	C_CCODE			;Execute following machine code

X_USER
	INC	DE			;Adjust to next word
	EX	DE,HL
	LD	E,(HL)
	INC	HL
	LD	D,(HL)
	LD	HL,(DEF_SYSADDR)
	ADD	HL,DE
	JP	NEXTS1			;Save & NEXT

W_ZERO		;Put zero on stack
	DB	$81,'0'+$80
	DW	W_USER
C_ZERO
	DW	X_CONSTANT		;Put next word on stack
	DW	$0000

W_1		;Put 1 on stack
	DB	$81,'1'+$80
	DW	W_ZERO
C_1
	DW	X_CONSTANT		;Put next word on stack
	DW	$0001

W_2
	DB	$81,'2'+$80
	DW	W_1
C_2
	DW	X_CONSTANT		;Put next word on stack
	DW	$0002

W_3
	DB	$81,'3'+$80
	DW	W_2
C_3
	DW	X_CONSTANT		;Put next word on stack
	DW	$0003

W_BL		;Leaves ASCII for blank on stack
	DB	$82,'B','L'+$80
	DW	W_3
C_BL
	DW	X_CONSTANT		;Put next word on stack
	DW	$0020

W_CL
	DB	$83,'C/','L'+$80
	DW	W_BL
C_CL
	DW	E_COLON			;Interpret following word sequence
	DW	C_UCL
	DW	C_FETCH			;Get word from addr on stack
	DW	C_STOP			;Pop BC from return stack (=next)

W_FIRST
	DB	$85,'FIRS','T'+$80
	DW	W_CL
C_FIRST
	DW	E_COLON			;Interpret following word sequence
	DW	C_UFIRST		;Put UFIRST addr on stack
	DW	C_FETCH			;Get word from addr on stack
	DW	C_STOP			;Pop BC from return stack (=next)

W_LIMIT
	DB	$85,'LIMI','T'+$80
	DW	W_FIRST
C_LIMIT
	DW	E_COLON			;Interpret following word sequence
	DW	C_ULIMIT		;Put ULIMIT on stack
	DW	C_FETCH			;Get word from addr on stack
	DW	C_STOP			;Pop BC from return stack (=next)

W_BBUF
	DB	$85,'B/BU','F'+$80
	DW	W_LIMIT
C_BBUF
	DW	E_COLON			;Interpret following word sequence
	DW	C_UBBUF
	DW	C_FETCH			;Get word from addr on stack
	DW	C_STOP			;Pop BC from return stack (=next)

W_BSCR
	DB	$85,'B/SC','R'+$80
	DW	W_BBUF
C_BSCR
	DW	E_COLON			;Interpret following word sequence
	DW	C_UBSCR			;Number of buffers per block
	DW	C_FETCH			;Get word from addr on stack
	DW	C_STOP			;Pop BC from return stack (=next)

W_S0		;Push S0 (initial data stack pointer)
	DB	$82,'S','0'+$80
	DW	W_BSCR
C_S0
	DW	X_USER			;Put next word on stack then do next
	DW	S0-SYSTEM

W_R0
	DB	$82,'R','0'+$80
	DW	W_S0
C_R0
	DW	X_USER			;Put next word on stack then do next
	DW	R0-SYSTEM

W_TIB
	DB	$83,'TI','B'+$80
	DW	W_R0
C_TIB
	DW	X_USER			;Put next word on stack then do next
	DW	TIB-SYSTEM

W_WIDTH
	DB	$85,'WIDT','H'+$80
	DW	W_TIB
C_WIDTH
	DW	X_USER			;Put next word on stack then do next
	DW	WIDTH-SYSTEM

W_WARNING	;Put WARNING addr on stack
	DB	$87,'WARNIN','G'+$80
	DW	W_WIDTH
C_WARNING
	DW	X_USER			;Put next word on stack then do next
	DW	WARNING-SYSTEM

W_FENCE
	DB	$85,'FENC','E'+$80
	  	DW	W_WARNING
C_FENCE
	DW	X_USER			;Put next word on stack then do next
	DW	FENCE-SYSTEM

W_DP		;Dictionary pointer addr on stack
	DB	$82,'D','P'+$80
	DW	W_FENCE
C_DP
	DW	X_USER			;Put next word on stack then do next
	DW	DP-SYSTEM

W_VOC_LINK
	DB	$88,'VOC-LIN','K'+$80
	DW	W_DP
C_VOC_LINK
	DW	X_USER			;Put next word on stack then do next
	DW	VOC_LINK-SYSTEM

W_BLK
	DB	$83,'BL','K'+$80
	DW	W_VOC_LINK
C_BLK
	DW	X_USER			;Put next word on stack then do next
	DW	BLK-SYSTEM

W_TOIN
	DB	$83,'>I','N'+$80
	DW	W_BLK
C_TOIN
	DW	X_USER			;Put next word on stack then do next
	DW	TOIN-SYSTEM

W_OUT		;Put OUT buffer count addr on stack
	DB	$83,'OU','T'+$80
	DW	W_TOIN
C_OUT
	DW	X_USER			;Put next word on stack then do next
	DW	OUT_-SYSTEM

W_SCR
	DB	$83,'SC','R'+$80
	DW	W_OUT
C_SCR
	DW	X_USER			;Put next word on stack then do next
	DW	SCR-SYSTEM

W_OFFSET	;Put disk block offset on stack
	DB	$86,'OFFSE','T'+$80
	DW	W_SCR
C_OFFSET
	DW	X_USER			;Put next word on stack then do next
	DW	OFFSET-SYSTEM

W_CONTEXT
	DB	$87,'CONTEX','T'+$80
	DW	W_OFFSET
C_CONTEXT
	DW	X_USER			;Put next word on stack then do next
	DW	CONTEXT-SYSTEM

W_CURRENT
	DB	$87,'CURREN','T'+$80
	DW	W_CONTEXT
C_CURRENT
	DW	X_USER			;Put next word on stack then do next
	DW	CURRENT-SYSTEM

W_STATE		;Push STATE addr
	DB	$85,'STAT','E'+$80
	DW	W_CURRENT
C_STATE
	DW	X_USER			;Put next word on stack then do next
	DW	STATE-SYSTEM

W_BASE		;Put BASE addr on stack
	DB	$84,'BAS','E'+$80
	DW	W_STATE
C_BASE
	DW	X_USER			;Put next word on stack then do next
	DW	BASE-SYSTEM

W_DPL
	DB	$83,'DP','L'+$80
	DW	W_BASE
C_DPL
	DW	X_USER			;Put next word on stack then do next
	DW	DPL-SYSTEM

W_FLD
	DB	$83,'FL','D'+$80
	DW	W_DPL
C_FLD
	DW	X_USER			;Put next word on stack then do next
	DW	FLD-SYSTEM

W_CSP		;Push check stack pointer addr
	DB	$83,'CS','P'+$80
	DW	W_FLD
C_CSP
	DW	X_USER			;Put next word on stack then do next
	DW	CSP-SYSTEM

W_RHASH
	DB	$82,'R','#'+$80
	DW	W_CSP
C_RHASH
	DW	X_USER			;Put next word on stack then do next
	DW	RHASH-SYSTEM

W_HLD
	DB	$83,'HL','D'+$80
	DW	W_RHASH
C_HLD
	DW	X_USER			;Put next word on stack then do next
	DW	HLD-SYSTEM

W_UCL
	DB	$84,'UC/','L'+$80
	DW	W_HLD
C_UCL
	DW	X_USER			;Put next word on stack then do next
	DW	UCL-SYSTEM

W_UFIRST
	DB	$86,'UFIRS','T'+$80
	DW	W_UCL
C_UFIRST
	DW	X_USER			;Put next word on stack then do next
	DW	UFIRST-SYSTEM

W_ULIMIT
	DB	$86,'ULIMI','T'+$80
	DW	W_UFIRST
C_ULIMIT
	DW	X_USER			;Put next word on stack then do next
	DW	ULIMIT-SYSTEM

W_UBBUF
	DB	$86,'UB/BU','F'+$80
	DW	W_ULIMIT
C_UBBUF
	DW	X_USER			;Put next word on stack then do next
	DW	UBBUF-SYSTEM

W_UBSCR
	DB	$86,'UB/SC','R'+$80
	DW	W_UBBUF
C_UBSCR
	DW	X_USER			;Put next word on stack then do next
	DW	UBSCR-SYSTEM

W_UTERMINAL
	DB	$8A,'U?TERMINA','L'+$80
	DW	W_UBSCR
C_UTERMINAL
	DW	X_USER			;Put next word on stack then do next
	DW	UTERMINAL-SYSTEM

W_UKEY		;Put UKEY addr on stack
	DB	$84,'UKE','Y'+$80
	DW	W_UTERMINAL
C_UKEY
	DW	X_USER			;Put next word on stack then do next
	DW	UKEY-SYSTEM

W_UEMIT		;Put UEMIT addr on stack
	DB	$85,'UEMI','T'+$80
	DW	W_UKEY
C_UEMIT
	DW	X_USER			;Put next word on stack then do next
	DW	UEMIT-SYSTEM

W_UCR		;Push UCR addr
	DB	$83,'UC','R'+$80
	DW	W_UEMIT
C_UCR
	DW	X_USER			;Put next word on stack then do next
	DW	UCR-SYSTEM

W_URW
	DB	$84,'UR/','W'+$80
	DW	W_UCR
C_URW
	DW	X_USER			;Put next word on stack then do next
	DW	URW-SYSTEM

W_UABORT	;Put UABORT on stack
	DB	$86,'UABOR','T'+$80
	DW	W_URW
C_UABORT
	DW	X_USER			;Put next word on stack then do next
	DW	UABORT-SYSTEM

W_RAF
	DB	$83,'RA','F'+$80
	DW	W_UABORT
C_RAF
	DW	X_USER			;Put next word on stack then do next
	DW	RAF-SYSTEM

W_RBC
	DB	$83,'RB','C'+$80
	DW	W_RAF
C_RBC
	DW	X_USER			;Put next word on stack then do next
	DW	RBC-SYSTEM

W_RDE
	DB	$83,'RD','E'+$80
	DW	W_RBC
C_RDE
	DW	X_USER			;Put next word on stack then do next
	DW	RDE-SYSTEM

W_RHL
	DB	$83,'RH','L'+$80
	DW	W_RDE
C_RHL
	DW	X_USER			;Put next word on stack then do next
	DW	RHL-SYSTEM

W_RIX
	DB	$83,'RI','X'+$80
	DW	W_RHL
C_RIX
	DW	X_USER			;Put next word on stack then do next
	DW	RIX-SYSTEM

W_RIY
	DB	$83,'RI','Y'+$80
	DW	W_RIX
C_RIY
	DW	X_USER			;Put next word on stack then do next
	DW	RIY-SYSTEM

W_RAF2
	DB	$84,'RAF',$2C+$80
	DW	W_RIY
C_RAF2
	DW	X_USER			;Put next word on stack then do next
	DW	RAF2-SYSTEM

W_RBC2
	DB	$84,'RBC',$2C+$80
	DW	W_RAF2
C_RBC2
	DW	X_USER			;Put next word on stack then do next
	DW	RBC2-SYSTEM

W_RDE2
	DB	$84,'RDE',$2C+$80
	DW	W_RBC2
C_RDE2
	DW	X_USER			;Put next word on stack then do next
	DW	RDE2-SYSTEM

W_RHL2
	DB	$84,'RHL',$2C+$80
	DW	W_RDE2
C_RHL2
	DW	X_USER			;Put next word on stack then do next
	DW	RHL2-SYSTEM

W_RA
	DB	$82,'R','A'+$80
	DW	W_RHL2
C_RA
	DW	X_USER			;Put next word on stack then do next
	DW	RAF+1-SYSTEM

W_RF
	DB	$82,'R','F'+$80
	DW	W_RA
C_RF
	DW	X_USER			;Put next word on stack then do next
	DW	RAF-SYSTEM

W_RB
	DB	$82,'R','B'+$80
	DW	W_RF
C_RB
	DW	X_USER			;Put next word on stack then do next
	DW	RBC+1-SYSTEM

W_RC
	DB	$82,'R','C'+$80
	DW	W_RB
C_RC
	DW	X_USER			;Put next word on stack then do next
	DW	RBC-SYSTEM

W_RD
	DB	$82,'R','D'+$80
	DW	W_RC
C_RD
	DW	X_USER			;Put next word on stack then do next
	DW	RDE+1-SYSTEM

W_RE
	DB	$82,'R','E'+$80
	DW	W_RD
C_RE
	DW	X_USER			;Put next word on stack then do next
	DW	RDE-SYSTEM

W_RH
	DB	$82,'R','H'+$80
	DW	W_RE
C_RH
	DW	X_USER			;Put next word on stack then do next
	DW	RHL+1-SYSTEM

W_RL
	DB	$82,'R','L'+$80
	DW	W_RH
C_RL
	DW	X_USER			;Put next word on stack then do next
	DW	RHL-SYSTEM

W_CALL
	DB	$84,'CAL','L'+$80
	DW	W_RL
C_CALL
	DW	2+$			;Vector to code
	POP	HL			;Address of routine CALLed
	PUSH	DE			;Save register
	PUSH	BC			;Save register
	LD	A,$C3			;Hex code for JMP
	LD	(JPCODE),A		;Save it
	LD	(JPVECT),HL		;Save jump vector
	LD	HL,(RAF)		;Get register AF
	PUSH	HL			;Onto stack
	POP	AF			;POP into AF
	LD	BC,(RBC)		;Get register BC
	LD	DE,(RDE)		;Get register DE
	LD	HL,(RHL)		;Get register HL
	LD	IX,(RIX)		;Get register IX
	LD	IY,(RIY)		;Get register IY
	CALL	JPCODE			;Call jump to code
	LD	(RIY),IY		;Save register IY
	LD	(RIX),IX		;Save register IX
	LD	(RBC),BC		;Save register BC
	LD	(RDE),DE		;Save register DE
	LD	(RHL),HL		;Save register HL
	PUSH	AF			;Save register AF
	POP	HL			;Into HL
	LD	(RAF),HL		;Into memory
	POP	BC			;Restore BC
	POP	DE			;Restore DE
	JP	NEXT			;

W_1PLUS		;1 plus
	DB	$82,'1','+'+$80
	DW	W_CALL
C_1PLUS
	DW	2+$			;Vector to code
	POP	HL			; get n
	INC	HL			; add 1
	JP	NEXTS1			; save result & NEXT

W_2PLUS		;2 plus
	DB	$82,'2','+'+$80
	DW	W_1PLUS
C_2PLUS
	DW	2+$			;Vector to code
	POP	HL			; get n
	INC	HL			; add 1
	INC	HL			; add 2
	JP	NEXTS1			; save result & NEXT

W_1MINUS	;1 minus
	DB	$82,'1','-'+$80
	DW	W_2PLUS
C_1MINUS
	DW	2+$			;Vector to code
	POP	HL			; get n
	DEC	HL			; add 1
	JP	NEXTS1			; save result & NEXT

W_2MINUS	;2 minus
	DB	$82,'2','-'+$80
	DW	W_1MINUS
C_2MINUS
	DW	2+$			;Vector to code
	POP	HL			; get n
	DEC	HL			; subtract 1
	DEC	HL			; subtract 2
	JP	NEXTS1			; save result & NEXT

W_HERE		;Dictionary pointer onto stack
	DB	$84,'HER','E'+$80
	DW	W_2MINUS
C_HERE
	DW	E_COLON			;Interpret following word sequence
	DW	C_DP			;Dictionary pointer addr on stack
	DW	C_FETCH			;Get word from addr on stack
	DW	C_STOP			;Pop BC from return stack (=next)

W_ALLOT
	DB	$85,'ALLO','T'+$80
	DW	W_HERE
C_ALLOT
	DW	E_COLON			;Interpret following word sequence
	DW	C_DP			;Dictionary pointer addr on stack
	DW	C_PLUSSTORE		;Add n1 to addr
	DW	C_STOP			;Pop BC from return stack (=next)

W_COMMA		;Reserve 2 bytes and save n
	DB	$81,','+$80
	DW	W_ALLOT
C_COMMA
	DW	E_COLON			;Interpret following word sequence
	DW	C_HERE			;Next free dictionary pointer onto stack
	DW	C_STORE			;Store word at addr
	DW	C_2			;
	DW	C_ALLOT			;Move pointer
	DW	C_STOP			;Pop BC from return stack (=next)

W_CCOMMA
	DB	$82,'C',','+$80
	DW	W_COMMA
C_CCOMMA
	DW	E_COLON			;Interpret following word sequence
	DW	C_HERE			;Dictionary pointer onto stack
	DW	C_CSTORE		;Store byte at addr
	DW	C_1			;Put 1 on stack
	DW	C_ALLOT
	DW	C_STOP			;Pop BC from return stack (=next)

W_MINUS
	DB	$81,'-'+$80
	DW	W_CCOMMA
C_MINUS
	DW	2+$			;Vector to code
	POP	DE			; get n1
	POP	HL			; get n2
	CALL	MINUS16			; call subtract routine
	JP	NEXTS1			; save & NEXT

MINUS16
	LD	A,L			; gel low byte
	SUB	E			; subtract low bytes
	LD	L,A			; save low byte result
	LD	A,H			; get high byte
	SBC	A,D			; subtract high bytes
	LD	H,A			; save high byte result
	RET				;

W_EQUALS
	DB	$81,'='+$80
	DW	W_MINUS
C_EQUALS
	DW	E_COLON			;Interpret following word sequence
	DW	C_MINUS
	DW	C_0EQUALS		;=0
	DW	C_STOP			;Pop BC from return stack (=next)

W_LESSTHAN
	DB	$81,'<'+$80
	DW	W_EQUALS
C_LESSTHAN
	DW	2+$			;Vector to code
	POP	DE
	POP	HL
	LD	A,D
	XOR	H
	JP	M,J298C
	CALL	MINUS16
J298C
	INC	H
	DEC	H
	JP	M,J2997
	LD	HL,0000
	JP	NEXTS1			;Save & NEXT
J2997
	LD	HL,0001
	JP	NEXTS1			;Save & NEXT

W_ULESS		;IF stack-1 < stack_top leave true flag
	DB	$82,'U','<'+$80
	DW	W_LESSTHAN
C_ULESS
	DW	E_COLON			;Interpret following word sequence
	DW	C_2DUP			;Dup top 2 values on stack
	DW	C_XOR			;Exclusive OR them
	DW	C_0LESS			;Less than 0
	DW	C_0BRANCH		;Add offset to BC if stack top = 0
	DW	B0000-$			;000Ch
	DW	C_DROP			;Drop top value from stack
	DW	C_0LESS			;Less than 0
	DW	C_0EQUALS		;=0
	DW	C_BRANCH		;Add following offset to BC
	DW	B0001-$			;0006h
B0000
	DW	C_MINUS
	DW	C_0LESS			;Less than 0
B0001
	DW	C_STOP			;Pop BC from return stack (=next)

W_GREATER
	DB	$81,'>'+$80
	DW	W_ULESS
C_GREATER
	DW	E_COLON			;Interpret following word sequence
	DW	C_SWAP			;Swap top 2 values on stack
	DW	C_LESSTHAN
	DW	C_STOP			;Pop BC from return stack (=next)

W_ROT		;3rd valu down to top of stack
	DB	$83,'RO','T'+$80
	DW	W_GREATER
C_ROT
	DW	2+$			;Vector to code
	POP	DE			;Top value
	POP	HL			;Next one down
	EX	(SP),HL			;Exchange with third
	JP	NEXTS2			;Save both & NEXT

W_PICK
	DB	$84,'PIC','K'+$80
	DW	W_ROT
C_PICK
	DW	E_COLON			;Interpret following word sequence
	DW	C_DUP			;Duplicate top value on stack
	DW	C_PLUS			;n1 + n2
	DW	C_SPFETCH		;Stack pointer onto stack
	DW	C_PLUS			;n1 + n2
	DW	C_FETCH			;Get word from addr on stack
	DW	C_STOP			;Pop BC from return stack (=next)

W_SPACE
	DB	$85,'SPAC','E'+$80
	DW	W_PICK
C_SPACE
	DW	E_COLON			;Interpret following word sequence
	DW	C_BL			;Leaves ASCII for space on stack
	DW	C_EMIT			;Output CHR from stack
	DW	C_STOP			;Pop BC from return stack (=next)

W_QUERYDUP
	DB	$84,'?DU','P'+$80
	DW	W_SPACE
C_QUERYDUP
	DW	E_COLON			;Interpret following word sequence
	DW	C_DUP			;Duplicate top value on stack
	DW	C_0BRANCH		;Add offset to BC if stack top = 0
	DW	B0002-$			;$0004
	DW	C_DUP			;Duplicate top value on stack
B0002
	DW	C_STOP			;Pop BC from return stack (=next)

W_TRAVERSE
	DB	$88,'TRAVERS','E'+$80
	DW	W_QUERYDUP
C_TRAVERSE
	DW	E_COLON			;Interpret following word sequence
	DW	C_SWAP			;Swap top 2 values on stack
B0054
	DW	C_OVER			;Copy 2nd down to top of stack
	DW	C_PLUS			;n1 + n2
	DW	C_LIT			;Puts next 2 bytes on the stack
	DW	$007F
	DW	C_OVER			;Copy 2nd down to top of stack
	DW	C_CFETCH		;Get byte from addr on stack
	DW	C_LESSTHAN
	DW	C_0BRANCH		;Add offset to BC if stack top = 0
	DW	B0054-$			;FFF0h
	DW	C_SWAP			;Swap top 2 values on stack
	DW	C_DROP			;Drop top value from stack
	DW	C_STOP			;Pop BC from return stack (=next)

W_LATEST
	DB	$86,'LATES','T'+$80
	DW	W_TRAVERSE
C_LATEST
	DW	E_COLON			;Interpret following word sequence
	DW	C_CURRENT
	DW	C_FETCH			;Get word from addr on stack
	DW	C_FETCH			;Get word from addr on stack
	DW	C_STOP			;Pop BC from return stack (=next)

W_LFA
	DB	$83,'LF','A'+$80
	DW	W_LATEST
C_LFA
	DW	E_COLON			;Interpret following word sequence
	DW	C_LIT			;Puts next 2 bytes on the stack
	DW	$0004
	DW	C_MINUS
	DW	C_STOP			;Pop BC from return stack (=next)

W_CFA
	DB	$83,'CF','A'+$80
	DW	W_LFA
C_CFA
	DW	2+$			;Vector to code
	POP	HL			; get n
	DEC	HL			; subtract 1
	DEC	HL			; subtract 2
	JP	NEXTS1			; save result & NEXT
W_NFA
	DB	$83,'NF','A'+$80
	DW	W_CFA
C_NFA
	DW	E_COLON			;Interpret following word sequence
	DW	C_LIT			;Puts next 2 bytes on the stack
	DW	$0005
	DW	C_MINUS
	DW	C_LIT			;Puts next 2 bytes on the stack
	DW	$FFFF
	DW	C_TRAVERSE
	DW	C_STOP			;Pop BC from return stack (=next)

W_PFA					;Convert NFA to PFA
	DB	$83,'PF','A'+$80
	DW	W_NFA
C_PFA
	DW	E_COLON			;Interpret following word sequence
	DW	C_1			;Traverse up memory
	DW	C_TRAVERSE		;End of name on stack
	DW	C_LIT			;Puts next 2 bytes on the stack
	DW	$0005			;Offset to start of word code
	DW	C_PLUS			;n1 + n2
	DW	C_STOP			;Pop BC from return stack (=next)

W_CSPSTORE
	DB	$84,'!CS','P'+$80
	DW	W_PFA
C_CSPSTORE
	DW	E_COLON			;Interpret following word sequence
	DW	C_SPFETCH		;Stack pointer onto stack
	DW	C_CSP			;Push check stack pointer addr
	DW	C_STORE			;Store word at addr
	DW	C_STOP			;Pop BC from return stack (=next)

W_QERROR
	DB	$86,'?ERRO','R'+$80
	DW	W_CSPSTORE
C_QERROR
	DW	E_COLON			;Interpret following word sequence
	DW	C_SWAP			;Swap top 2 values on stack
	DW	C_0BRANCH		;Branch if no error
	DW	B0003-$			;0008h
	DW	C_ERROR
	DW	C_BRANCH		;Add following offset to BC
	DW	B0004-$			;$0004
B0003
	DW	C_DROP			;Drop error no.
B0004
	DW	C_STOP			;Pop BC from return stack (=next)

W_QCOMP		;Error if not in compile mode
	DB	$85,'?COM','P'+$80
	DW	W_QERROR
C_QCOMP
	DW	E_COLON			;Interpret following word sequence
	DW	C_STATE			;Push STATE addr
	DW	C_FETCH			;Get word from addr on stack
	DW	C_0EQUALS		;=0
	DW	C_LIT			;Puts next 2 bytes on the stack
	DW	$0011			;Error message number
	DW	C_QERROR		;Error if state <> 0
	DW	C_STOP			;Pop BC from return stack (=next)

W_QEXEC		;Error not if not in execute mode
	DB	$85,'?EXE','C'+$80
	DW	W_QCOMP
C_QEXEC
	DW	E_COLON			;Interpret following word sequence
	DW	C_STATE			;Push STATE addr
	DW	C_FETCH			;Get word from addr on stack
	DW	C_LIT			;Puts next 2 bytes on the stack
	DW	$0012			;Error not if not in execute mode
	DW	C_QERROR		;
	DW	C_STOP			;Pop BC from return stack (=next)

W_QPAIRS
	DB	$86,'?PAIR','S'+$80
	DW	W_QEXEC
C_QPAIRS
	DW	E_COLON			;Interpret following word sequence
	DW	C_MINUS
	DW	C_LIT			;Puts next 2 bytes on the stack
	DW	$0013
	DW	C_QERROR
	DW	C_STOP			;Pop BC from return stack (=next)

W_WHATSTACK	;Check stack pointer, error if not ok
	DB	$84,'?CS','P'+$80
	DW	W_QPAIRS
C_WHATSTACK
	DW	E_COLON			;Interpret following word sequence
	DW	C_SPFETCH		;Stack pointer onto stack
	DW	C_CSP			;Push check stack pointer addr
	DW	C_FETCH			;Get check stack pointer
	DW	C_MINUS			;If ok then result is 0
	DW	C_LIT			;Puts next 2 bytes on the stack
	DW	$0014			;Error no if not ok
	DW	C_QERROR		;Error if stack top -1 <> 0
	DW	C_STOP			;Pop BC from return stack (=next)

W_QLOADING
	DB	$88,'?LOADIN','G'+$80
	DW	W_WHATSTACK
C_QLOADING
	DW	E_COLON			;Interpret following word sequence
	DW	C_BLK
	DW	C_FETCH			;Get word from addr on stack
	DW	C_0EQUALS		;=0
	DW	C_LIT			;Puts next 2 bytes on the stack
	DW	$0016
	DW	C_QERROR
	DW	C_STOP			;Pop BC from return stack (=next)

W_COMPILE
	DB	$87,'COMPIL','E'+$80
	DW	W_QLOADING
C_COMPILE
	DW	E_COLON			;Interpret following word sequence
	DW	C_QCOMP			;Error if not in compile mode
	DW	C_RMOVE			;Move word from return to data stack
	DW	C_DUP			;Bump return address and put back
	DW	C_2PLUS			;
	DW	C_MOVER			;
	DW	C_FETCH			;Get word from addr on stack
	DW	C_COMMA			;Reserve 2 bytes and save n
	DW	C_STOP			;Pop BC from return stack (=next)

W_LEFTBRKT	;Set STATE to execute
	DB	$81,'['+$80
	DW	W_COMPILE
C_LEFTBRKT
	DW	E_COLON			;Interpret following word sequence
	DW	C_ZERO			;Put zero on stack
	DW	C_STATE			;Push STATE addr
	DW	C_STORE			;Store word at addr
	DW	C_STOP			;Pop BC from return stack (=next)

W_RIGHTBRKT	;Set STATE to compile
	DB	$81,']'+$80
	DW	W_LEFTBRKT
C_RIGHTBRKT
	DW	E_COLON			;Interpret following word sequence
	DW	C_LIT			;Puts next 2 bytes on the stack
	DW	$00C0
	DW	C_STATE			;Push STATE addr
	DW	C_STORE			;Set STATE to execute
	DW	C_STOP			;Pop BC from return stack (=next)

W_SMUDGE
	DB	$86,'SMUDG','E'+$80
	DW	W_RIGHTBRKT
C_SMUDGE
	DW	E_COLON			;Interpret following word sequence
	DW	C_LATEST		;Push top words NFA
	DW	C_LIT			;Puts next 2 bytes on the stack
	DW	$0020
	DW	C_TOGGLE		;XOR (addr) with byte
	DW	C_STOP			;Pop BC from return stack (=next)

W_HEX
	DB	$83,'HE','X'+$80
	DW	W_SMUDGE
C_HEX
	DW	E_COLON			;Interpret following word sequence
	DW	C_LIT			;Puts next 2 bytes on the stack
	DW	$0010
	DW	C_BASE			;Put BASE addr on stack
	DW	C_STORE			;Store word at addr
	DW	C_STOP			;Pop BC from return stack (=next)

W_DECIMAL	;Sets decimal mode
	DB	$87,'DECIMA','L'+$80
	DW	W_HEX
C_DECIMAL
	DW	E_COLON			;Interpret following word sequence
	DW	C_LIT			;Puts next 2 bytes on the stack
	DW	$000A			;Sets decimal value
	DW	C_BASE			;Put BASE addr on stack
	DW	C_STORE			;Store word at addr
	DW	C_STOP			;Pop BC from return stack (=next)

W_CCODE		;Stop compillation & terminate word
	DB	$87,'<;CODE','>'+$80
	DW	W_DECIMAL
C_CCODE
	DW	E_COLON			;Interpret following word sequence
	DW	C_RMOVE			;Move word from return to data stack
	DW	C_LATEST		;Push top words NFA
	DW	C_PFA			;Convert NFA to PFA
	DW	C_CFA			;Convert PFA to CFA
	DW	C_STORE			;Store word at addr
	DW	C_STOP			;Pop BC from return stack (=next)

W_SCCODE
	DB	$C5,';COD','E'+$80
	DW	W_CCODE
C_SCCODE
	DW	E_COLON			;Interpret following word sequence
	DW	C_WHATSTACK		;Check stack pointer, error if not ok
	DW	C_COMPILE		;Compile next word into dictionary
	DW	C_CCODE
	DW	C_LEFTBRKT		;Set STATE to execute
	DW	C_TASK
	DW	C_STOP			;Pop BC from return stack (=next)

W_CREATE
	DB	$86,'CREAT','E'+$80
	DW	W_SCCODE
C_CREATE
	DW	E_COLON			;Interpret following word sequence
	DW	C_ZERO			;Put zero on stack
	DW	C_CONSTANT
	DW	C_STOP			;Pop BC from return stack (=next)

W_DOES
	DB	$85,'DOES','>'+$80
	DW	W_CREATE
C_DOES
	DW	E_COLON			;Interpret following word sequence
	DW	C_RMOVE			;Move word from return to data stack
	DW	C_LATEST		;Push top words NFA
	DW	C_PFA			;Convert NFA to PFA
	DW	C_STORE			;Store word at addr
	DW	C_CCODE			;Execute following machine code

X_DOES
	LD	HL,(RPP)		;Get return stack pointer
	DEC	HL			;Push next pointer
	LD	(HL),B			;
	DEC	HL			;
	LD	(HL),C			;
	LD	(RPP),HL
	INC	DE
	EX	DE,HL
	LD	C,(HL)
	INC	HL
	LD	B,(HL)
	INC	HL
	JP	NEXTS1			;Save & NEXT

W_COUNT		;Convert string at addr to addr + length
	DB	$85,'COUN','T'+$80
	DW	W_DOES
C_COUNT
	DW	E_COLON			;Interpret following word sequence
	DW	C_DUP			;Duplicate address
	DW	C_1PLUS			;Add 1 (points to string start)
	DW	C_SWAP			;Get address back
	DW	C_CFETCH		;Get byte from addr on stack
	DW	C_STOP			;Pop BC from return stack (=next)

W_TYPE		;Output n bytes from addr
	DB	$84,'TYP','E'+$80
	DW	W_COUNT
C_TYPE
	DW	E_COLON			;Interpret following word sequence
	DW	C_QUERYDUP		;Copy length if length <> 0
	DW	C_0BRANCH		;Branch if length = 0
	DW	B0005-$			;0018h
	DW	C_OVER			;Copy address to stack top
	DW	C_PLUS			;Add to length
	DW	C_SWAP			;Swap top 2 values on stack
	DW	C_LDO			;Put start & end loop values on RPP
B004F
	DW	C_I			;Copy LOOP index to data stack
	DW	C_CFETCH		;Get byte from string
	DW	C_EMIT			;Output CHR from stack
	DW	C_LLOOP			;Increment loop & branch if not done
	DW	B004F-$			;FFF8h
	DW	C_BRANCH		;Done so branch to next
	DW	B0006-$			;$0004
B0005
	DW	C_DROP			;Drop string address
B0006
	DW	C_STOP			;Pop BC from return stack (=next)

W_TRAILING
	DB	$89,'-TRAILIN','G'+$80
	DW	W_TYPE
C_TRAILING
	DW	E_COLON			;Interpret following word sequence
	DW	C_DUP			;Duplicate top value on stack
	DW	C_ZERO			;Put zero on stack
	DW	C_LDO			;Put start & end loop values on RPP
B0009
	DW	C_OVER			;Copy 2nd down to top of stack
	DW	C_OVER			;Copy 2nd down to top of stack
	DW	C_PLUS			;n1 + n2
	DW	C_1			;Put 1 on stack
	DW	C_MINUS
	DW	C_CFETCH		;Get byte from addr on stack
	DW	C_BL			;Leaves ASCII for space on stack
	DW	C_MINUS
	DW	C_0BRANCH		;Add offset to BC if stack top = 0
	DW	B0007-$			;0008h
	DW	C_LEAVE			;Quit loop by making index = limit
	DW	C_BRANCH		;Add following offset to BC
	DW	B0008-$			;0006h
B0007
	DW	C_1			;Put 1 on stack
	DW	C_MINUS
B0008
	DW	C_LLOOP			;Increment loop & branch if not done
	DW	B0009-$			;FFE0h
	DW	C_STOP			;Pop BC from return stack (=next)

W_CQUOTE	;Output following string
	DB	$84,'<.',$22,'>'+$80
	DW	W_TRAILING
C_CQUOTE
	DW	E_COLON			;Interpret following word sequence
	DW	C_RFETCH		;Copy return stack top to data stack
	DW	C_COUNT			;Convert string at addr to addr + length
	DW	C_DUP			;Duplicate top value on stack
	DW	C_1PLUS			;1 plus
	DW	C_RMOVE			;Move word from return to data stack
	DW	C_PLUS			;Add length of string +1
	DW	C_MOVER			;Move value from data to return stack
	DW	C_TYPE			;Output n bytes from addr
	DW	C_STOP			;Pop BC from return stack (=next)

W_QUOTE		;Accept following text
	DB	$C2,'.',$22+$80
	DW	W_CQUOTE
C_QUOTE
	DW	E_COLON			;Interpret following word sequence
	DW	C_LIT			;Puts next 2 bytes on the stack
	DW	$0022
	DW	C_STATE			;Push STATE addr
	DW	C_FETCH			;Get word from addr on stack
	DW	C_0BRANCH		;Add offset to BC if stack top = 0
	DW	B000A-$			;0012h
	DW	C_COMPILE		;Compile next word into dictionary
	DW	C_CQUOTE		;
	DW	C_WORD
	DW	C_CFETCH		;Get byte from addr on stack
	DW	C_1PLUS			;1 plus
	DW	C_ALLOT
	DW	C_BRANCH		;Add following offset to BC
	DW	B000B-$			;0008h
B000A
	DW	C_WORD
	DW	C_COUNT			;Convert string at addr to addr + length
	DW	C_TYPE			;Output n bytes from addr
B000B
	DW	C_STOP			;Pop BC from return stack (=next)

W_EXPECT
	DB	$86,'EXPEC','T'+$80
	DW	W_QUOTE
C_EXPECT
	DW	E_COLON			;Interpret following word sequence
	DW	C_OVER			;Copy buffer start addr
	DW	C_PLUS			;Add to length to give start,end
	DW	C_OVER			;Copy start
	DW	C_LDO			;Put start & end loop values on RPP
B0012
	DW	C_KEY			;Wait for key, value on stack
	DW	C_DUP			;Duplicate key value
	DW	C_LIT			;Push backspace addr
	DW	BACKSPACE		;
	DW	C_FETCH			;Get backspace value
	DW	C_EQUALS		;Was it backspace ?
	DW	C_0BRANCH		;If not then jump
	DW	B000C-$			;002Ah
	DW	C_DROP			;Drop top value from stack
	DW	C_DUP			;Duplicate top value on stack
	DW	C_I			;Copy LOOP index to data stack
	DW	C_EQUALS
	DW	C_DUP			;Duplicate top value on stack
	DW	C_RMOVE			;Move word from return to data stack
	DW	C_2
	DW	C_MINUS
	DW	C_PLUS			;n1 + n2
	DW	C_MOVER			;Move value from data to return stack
	DW	C_0BRANCH		;Add offset to BC if stack top = 0
	DW	B000D-$			;000Ah
	DW	C_LIT			;Puts next 2 bytes on the stack
	DW	$0007
	DW	C_BRANCH		;Add following offset to BC
	DW	B000E-$			;0006h
B000D
	DW	C_LIT			;Puts next 2 bytes on the stack
	DW	$0008
B000E
	DW	C_BRANCH		;Add following offset to BC
	DW	B000F-$			;0028h
B000C
	DW	C_DUP			;Duplicate key value
	DW	C_LIT			;Puts next 2 bytes on the stack
	DW	$000D			;CR
	DW	C_EQUALS		;Was it cariage return
	DW	C_0BRANCH		;If not then jump
	DW	B0010-$			;000Eh
	DW	C_LEAVE			;Quit loop by making index = limit
	DW	C_DROP			;Drop top value from stack
	DW	C_BL			;Leaves ASCII for space on stack
	DW	C_ZERO			;Put zero on stack
	DW	C_BRANCH		;Add following offset to BC
	DW	B0011-$			;$0004
B0010
	DW	C_DUP			;Duplicate key value
B0011
	DW	C_I			;Copy LOOP index to data stack
	DW	C_CSTORE		;Store byte at addr
	DW	C_ZERO			;Put zero on stack
	DW	C_I			;Copy LOOP index to data stack
	DW	C_1PLUS			;1 plus
	DW	C_STORE			;Store word at addr
B000F
	DW	C_EMIT			;Output CHR from stack
	DW	C_LLOOP			;Increment loop & branch if not done
	DW	B0012-$			;FF9Eh
	DW	C_DROP			;Drop top value from stack
	DW	C_STOP			;Pop BC from return stack (=next)

W_QUERY
	DB	$85,'QUER','Y'+$80
	DW	W_EXPECT
C_QUERY
	DW	E_COLON			;Interpret following word sequence
	DW	C_TIB			;Put TIB addr on stack
	DW	C_FETCH			;Get word from addr on stack
	DW	C_LIT			;Puts next 2 bytes on the stack
	DW	$0050			;Max line length 50h
	DW	C_EXPECT		;Get line
	DW	C_ZERO			;Put zero on stack
	DW	C_TOIN			;Current input buffer offset
	DW	C_STORE			;Store word at addr
	DW	C_STOP			;Pop BC from return stack (=next)

W_NULL
	DB	$C1,$80
	DW	W_QUERY
C_NULL
	DW	E_COLON			;Interpret following word sequence
	DW	C_BLK
	DW	C_FETCH			;Get word from addr on stack
	DW	C_0BRANCH		;Add offset to BC if stack top = 0
	DW	B0013-$			;002Ah
	DW	C_1			;Put 1 on stack
	DW	C_BLK
	DW	C_PLUSSTORE		;Add n1 to addr
	DW	C_ZERO			;Put zero on stack
	DW	C_TOIN			;Current input buffer offset
	DW	C_STORE			;Store word at addr
	DW	C_BLK
	DW	C_FETCH			;Get word from addr on stack
	DW	C_BSCR			;Number of buffers per block on stack
	DW	C_1			;Put 1 on stack
	DW	C_MINUS
	DW	C_AND			;AND
	DW	C_0EQUALS		;=0
	DW	C_0BRANCH		;Add offset to BC if stack top = 0
	DW	B0014-$			;0008h
	DW	C_QEXEC			;Error not if not in execute mode
	DW	C_RMOVE			;Move word from return to data stack
	DW	C_DROP			;Drop top value from stack
B0014
	DW	C_BRANCH		;Add following offset to BC
	DW	B0015-$			;0006h
B0013
	DW	C_RMOVE			;Move word from return to data stack
	DW	C_DROP			;Drop top value from stack
B0015
	DW	C_STOP			;Pop BC from return stack (=next)

W_FILL		;Fill with byte n bytes from addr
	DB	$84,'FIL','L'+$80
	DW	W_NULL
C_FILL
	DW	2+$			;Vector to code
	LD	L,C			;Save BC for now
	LD	H,B			;
	POP	DE			; get byte
	POP	BC			; get n
	EX	(SP),HL			; get addr and save BC
	EX	DE,HL			;
NEXT_BYTE
	LD	A,B			;Test count
	OR	C			;
	JR	Z,NO_COUNT		;If 0 we're done
	LD	A,L			;Byte into A
	LD	(DE),A			;Save byte
	INC	DE			;Next addr
	DEC	BC			;Decr count
	JR	NEXT_BYTE		;Loop
NO_COUNT
	POP	BC			;Get BC back
	JP	NEXT

W_ERASE		;Fill addr & length from stack with 0
	DB	$85,'ERAS','E'+$80
	DW	W_FILL
C_ERASE
	DW	E_COLON			;Interpret following word sequence
	DW	C_ZERO			;Put zero on stack
	DW	C_FILL			;Fill with byte n bytes from addr
	DW	C_STOP			;Pop BC from return stack (=next)

W_BLANKS	;Fill addr & length from stack with [SP]
	DB	$86,'BLANK','S'+$80
	DW	W_ERASE
C_BLANKS
	DW	E_COLON			;Interpret following word sequence
	DW	C_BL			;Leaves ASCII for space on stack
	DW	C_FILL			;Fill with byte n bytes from addr
	DW	C_STOP			;Pop BC from return stack (=next)

W_HOLD
	DB	$84,'HOL','D'+$80
	DW	W_BLANKS
C_HOLD
	DW	E_COLON			;Interpret following word sequence
	DW	C_LIT			;Puts next 2 bytes on the stack
	DW	$FFFF
	DW	C_HLD
	DW	C_PLUSSTORE		;Add n1 to addr
	DW	C_HLD
	DW	C_FETCH			;Get word from addr on stack
	DW	C_CSTORE		;Store byte at addr
	DW	C_STOP			;Pop BC from return stack (=next)

W_PAD
	DB	$83,'PA','D'+$80
	DW	W_HOLD
C_PAD
	DW	E_COLON			;Interpret following word sequence
	DW	C_HERE			;Dictionary pointer onto stack
	DW	C_LIT			;Puts next 2 bytes on the stack
	DW	$0044
	DW	C_PLUS			;n1 + n2
	DW	C_STOP			;Pop BC from return stack (=next)

W_WORD
	DB	$84,'WOR','D'+$80
	DW	W_PAD
C_WORD
	DW	E_COLON			;Interpret following word sequence
	DW	C_BLK
	DW	C_FETCH			;Get word from addr on stack
	DW	C_0BRANCH		;Add offset to BC if stack top = 0
	DW	B0016-$			;000Ch
	DW	C_BLK
	DW	C_FETCH			;Get word from addr on stack
	DW	C_BLOCK
	DW	C_BRANCH		;Add following offset to BC
	DW	B0017-$			;0006h
B0016
	DW	C_TIB
	DW	C_FETCH			;Get word from addr on stack
B0017
	DW	C_TOIN			;Current input buffer offset
	DW	C_FETCH			;Get word from addr on stack
	DW	C_PLUS			;n1 + n2
	DW	C_SWAP			;Swap top 2 values on stack
	DW	C_ENCLOSE
	DW	C_HERE			;Dictionary pointer onto stack
	DW	C_LIT			;Puts next 2 bytes on the stack
	DW	$0022
	DW	C_BLANKS
	DW	C_TOIN			;Current input buffer offset
	DW	C_PLUSSTORE		;Add n1 to addr
	DW	C_OVER			;Copy 2nd down to top of stack
	DW	C_MINUS
	DW	C_MOVER			;Move value from data to return stack
	DW	C_RFETCH		;Return stack top to data stack
	DW	C_HERE			;Dictionary pointer onto stack
	DW	C_CSTORE		;Store byte at addr
	DW	C_PLUS			;n1 + n2
	DW	C_HERE			;Dictionary pointer onto stack
	DW	C_1PLUS			;1 plus
	DW	C_RMOVE			;Move word from return to data stack
	DW	C_CMOVE			;Move block
	DW	C_HERE			;Dictionary pointer onto stack
	DW	C_STOP			;Pop BC from return stack (=next)

W_CONVERT
	DB	$87,'CONVER','T'+$80
	DW	W_WORD
C_CONVERT
	DW	E_COLON			;Interpret following word sequence
B001A
	DW	C_1PLUS			;1 plus
	DW	C_DUP			;Duplicate top value on stack
	DW	C_MOVER			;Move value from data to return stack
	DW	C_CFETCH		;Get byte from addr on stack
	DW	C_BASE			;Put BASE addr on stack
	DW	C_FETCH			;Get word from addr on stack
	DW	C_DIGIT			;Convert digit n2 using base n1
	DW	C_0BRANCH		;Add offset to BC if stack top = 0
	DW	B0018-$			;002Ch
	DW	C_SWAP			;Swap top 2 values on stack
	DW	C_BASE			;Put BASE addr on stack
	DW	C_FETCH			;Get word from addr on stack
	DW	C_USTAR
	DW	C_DROP			;Drop top value from stack
	DW	C_ROT			;3rd value down to top of stack
	DW	C_BASE			;Put BASE addr on stack
	DW	C_FETCH			;Get word from addr on stack
	DW	C_USTAR
	DW	C_DPLUS
	DW	C_DPL
	DW	C_FETCH			;Get word from addr on stack
	DW	C_1PLUS			;1 plus
	DW	C_0BRANCH		;Add offset to BC if stack top = 0
	DW	B0019-$			;0008h
	DW	C_1			;Put 1 on stack
	DW	C_DPL
	DW	C_PLUSSTORE		;Add n1 to addr
B0019
	DW	C_RMOVE			;Move word from return to data stack
	DW	C_BRANCH		;Add following offset to BC
	DW	B001A-$			;FFC6h
B0018
	DW	C_RMOVE			;Move word from return to data stack
	DW	C_STOP			;Pop BC from return stack (=next)

W_NUMBER
	DB	$86,'NUMBE','R'+$80
	DW	W_CONVERT
C_NUMBER
	DW	E_COLON			;Interpret following word sequence
	DW	C_ZERO			;Put zero on stack
	DW	C_ZERO			;Put zero on stack
	DW	C_ROT			;3rd value down to top of stack
	DW	C_DUP			;Duplicate top value on stack
	DW	C_1PLUS			;1 plus
	DW	C_CFETCH		;Get byte from addr on stack
	DW	C_LIT			;Puts next 2 bytes on the stack
	DW	$002D			;'-'
	DW	C_EQUALS		;Is first chr = '-'
	DW	C_DUP			;Duplicate negative flag
	DW	C_MOVER			;Move value from data to return stack
	DW	C_PLUS			;n1 + n2
	DW	C_LIT			;Puts next 2 bytes on the stack
	DW	$FFFF			; -1
B001C
	DW	C_DPL
	DW	C_STORE			;Store word at addr
	DW	C_CONVERT
	DW	C_DUP			;Duplicate top value on stack
	DW	C_CFETCH		;Get byte from addr on stack
	DW	C_BL			;Leaves ASCII for space on stack
	DW	C_MINUS
	DW	C_0BRANCH		;Add offset to BC if stack top = 0
	DW	B001B-$			;0016h
	DW	C_DUP			;Duplicate top value on stack
	DW	C_CFETCH		;Get byte from addr on stack
	DW	C_LIT			;Puts next 2 bytes on the stack
	DW	$002E			;'.'
	DW	C_MINUS
	DW	C_ZERO			;Put zero on stack
	DW	C_QERROR
	DW	C_ZERO			;Put zero on stack
	DW	C_BRANCH		;Add following offset to BC
	DW	B001C-$			;FFDCh
B001B
	DW	C_DROP			;Drop top value from stack
	DW	C_RMOVE			;Move word from return to data stack
	DW	C_0BRANCH		;Add offset to BC if stack top = 0
	DW	B001D-$			;$0004
	DW	C_DNEGATE
B001D
	DW	C_STOP			;Pop BC from return stack (=next)

W_MFIND
	DB	$85,'-FIN','D'+$80
	DW	W_NUMBER
C_MFIND
	DW	E_COLON			;Interpret following word sequence
	DW	C_BL			;Leaves ASCII for space on stack
	DW	C_WORD
	DW	C_CONTEXT
	DW	C_FETCH			;Get word from addr on stack
	DW	C_FETCH			;Get word from addr on stack
	DW	C_FIND			;Find word & return vector,byte & flag
	DW	C_DUP			;Duplicate top value on stack
	DW	C_0EQUALS		;=0
	DW	C_0BRANCH		;Add offset to BC if stack top = 0
	DW	B001E-$			;000Ah
	DW	C_DROP			;Drop top value from stack
	DW	C_HERE			;Dictionary pointer onto stack
	DW	C_LATEST		;Push top words NFA
	DW	C_FIND			;Find word & return vector,byte & flag
B001E
	DW	C_STOP			;Pop BC from return stack (=next)

W_CABORT
	DB	$87,'<ABORT','>'+$80
	DW	W_MFIND
C_CABORT
	DW	E_COLON			;Interpret following word sequence
	DW	C_ABORT
	DW	C_STOP			;Pop BC from return stack (=next)

W_ERROR
	DB	$85,'ERRO','R'+$80
	DW	W_CABORT
C_ERROR
	DW	E_COLON			;Interpret following word sequence
	DW	C_WARNING		;Put WARNING addr on stack
	DW	C_FETCH			;Get word from addr on stack
	DW	C_0LESS			;Less than 0 leaves true
	DW	C_0BRANCH		;Add offset to BC if stack top = 0
	DW	B001F-$			;$0004
	DW	C_CABORT
B001F
	DW	C_HERE			;Dictionary pointer onto stack
	DW	C_COUNT			;Convert string at addr to addr + length
	DW	C_TYPE			;Output n bytes from addr
	DW	C_CQUOTE		;Output following string
	DB	S_END7-S_START7
S_START7
	DB	'? '		;
S_END7
	DW	C_MESSAGE		;Output message
	DW	C_SPSTORE		;Set initial stack pointer value
	DW	C_BLK
	DW	C_FETCH			;Get word from addr on stack
	DW	C_QUERYDUP
	DW	C_0BRANCH		;Add offset to BC if stack top = 0
	DW	B0020-$			;0008h
	DW	C_TOIN			;Current input buffer offset
	DW	C_FETCH			;Get word from addr on stack
	DW	C_SWAP			;Swap top 2 values on stack
B0020
	DW	C_QUIT

W_ID		;Print definition name from name field addr
	DB	$83,'ID','.'+$80
	DW	W_ERROR
C_ID
	DW	E_COLON			;Interpret following word sequence
	DW	C_COUNT			;Convert string at addr to addr + length
	DW	C_LIT			;Puts next 2 bytes on the stack
	DW	$001F			;Max length is 1Fh
	DW	C_AND			;AND lenght with 1Fh
	DW	C_TYPE			;Output n bytes from addr
	DW	C_SPACE			;Output space
	DW	C_STOP			;Pop BC from return stack (=next)

C_XXX1
	DW	E_COLON			;Interpret following word sequence
	DW	C_MFIND			;Find name returns PFA,length,true or false
	DW	C_0BRANCH		;Branch if name not found
	DW	B0021-$			;0010h
	DW	C_DROP			;Drop length
	DW	C_NFA			;Convert PFA to NFA
	DW	C_ID			;Print definition name from name field addr
	DW	C_LIT			;Puts next 2 bytes on the stack
	DW	$0004			;Message 4, name defined twice
	DW	C_MESSAGE		;Output message
	DW	C_SPACE			;Output space
B0021
	DW	C_HERE			;Dictionary pointer onto stack
	DW	C_DUP			;Duplicate top value on stack
	DW	C_CFETCH		;Get byte from addr on stack
	DW	C_WIDTH
	DW	C_FETCH			;Get word from addr on stack
	DW	C_MIN
	DW	C_1PLUS			;1 plus
	DW	C_ALLOT			;Which ever is smallest width or namelength
	DW	C_DUP			;Duplicate top value on stack
	DW	C_LIT			;Puts next 2 bytes on the stack
	DW	$00A0
	DW	C_TOGGLE		;XOR (addr) with byte
	DW	C_HERE			;Dictionary pointer onto stack
	DW	C_1			;Put 1 on stack
	DW	C_MINUS
	DW	C_LIT			;Puts next 2 bytes on the stack
	DW	$0080
	DW	C_TOGGLE		;XOR (addr) with byte
	DW	C_LATEST		;Push top words NFA
	DW	C_COMMA			;Reserve 2 bytes and save n
	DW	C_CURRENT
	DW	C_FETCH			;Get word from addr on stack
	DW	C_STORE			;Store word at addr
	DW	C_HERE			;Dictionary pointer onto stack
	DW	C_2PLUS			;2 plus
	DW	C_COMMA			;Reserve 2 bytes and save n
	DW	C_STOP			;Pop BC from return stack (=next)

W_CCOMPILE
	DB	$89,'[COMPILE',']'+$80
	DW	W_ID
C_CCOMPILE
	DW	E_COLON			;Interpret following word sequence
	DW	C_MFIND
	DW	C_0EQUALS		;=0
	DW	C_ZERO			;Put zero on stack
	DW	C_QERROR
	DW	C_DROP			;Drop top value from stack
	DW	C_CFA			;Convert PFA to CFA
	DW	C_COMMA			;Reserve 2 bytes and save n
	DW	C_STOP			;Pop BC from return stack (=next)

W_LITERAL
	DB	$C7,'LITERA','L'+$80
	DW	W_CCOMPILE
C_LITERAL
	DW	E_COLON			;Interpret following word sequence
	DW	C_STATE			;Push STATE addr
	DW	C_FETCH			;Get word from addr on stack
	DW	C_0BRANCH		;Add offset to BC if stack top = 0
	DW	B0022-$			;0008h
	DW	C_COMPILE		;Compile next word into dictionary
	DW	C_LIT			;Puts next 2 bytes on the stack
	DW	C_COMMA			;Reserve 2 bytes and save n
B0022
	DW	C_STOP			;Pop BC from return stack (=next)

W_DLITERAL
	DB	$C8,'DLITERA','L'+$80
	DW	W_LITERAL
C_DLITERAL
	DW	E_COLON			;Interpret following word sequence
	DW	C_STATE			;Push STATE addr
	DW	C_FETCH			;Get word from addr on stack
	DW	C_0BRANCH		;Add offset to BC if stack top = 0
	DW	B0023-$			;0008h
	DW	C_SWAP			;Swap top 2 values on stack
	DW	C_LITERAL
	DW	C_LITERAL
B0023
	DW	C_STOP			;Pop BC from return stack (=next)

W_QSTACK
	DB	$86,'?STAC','K'+$80
	DW	W_DLITERAL
C_QSTACK
	DW	E_COLON			;Interpret following word sequence
	DW	C_SPFETCH		;Stack pointer onto stack
	DW	C_S0			;Push S0 (initial data stack pointer)
	DW	C_FETCH			;Get word from addr on stack
	DW	C_SWAP			;Swap top 2 values on stack
	DW	C_ULESS			;IF stack-1 < stack_top leave true flag
	DW	C_1			;Put 1 on stack
	DW	C_QERROR
	DW	C_SPFETCH		;Stack pointer onto stack
	DW	C_HERE			;Dictionary pointer onto stack
	DW	C_LIT			;Puts next 2 bytes on the stack
	DW	$0080
	DW	C_PLUS			;n1 + n2
	DW	C_ULESS			;IF stack-1 < stack_top leave true flag
	DW	C_LIT			;Puts next 2 bytes on the stack
	DW	$0007
	DW	C_QERROR
	DW	C_STOP			;Pop BC from return stack (=next)

W_INTERPRET
	DB	$89,'INTERPRE','T'+$80
	DW	W_QSTACK
C_INTERPRET
	DW	E_COLON			;Interpret following word sequence
B002A
	DW	C_MFIND			;Find name returns PFA,length,true or false
	DW	C_0BRANCH		;Branch if name not found
	DW	NO_NAME-$		;
	DW	C_STATE			;STATE addr on stack
	DW	C_FETCH			;Get STATE
	DW	C_LESSTHAN		;Is it quit compile word ?
	DW	C_0BRANCH		;If so then branch
	DW	B0025-$			;
	DW	C_CFA			;Convert PFA to CFA
	DW	C_COMMA			;Reserve 2 bytes and save n
	DW	C_BRANCH		;Add following offset to BC
	DW	B0026-$			;
B0025
	DW	C_CFA			;Convert PFA to CFA
	DW	C_EXECUTE		;Jump to address on stack
B0026
	DW	C_QSTACK		;Error message if stack underflow
	DW	C_BRANCH		;Add following offset to BC
	DW	B0027-$			;
NO_NAME
	DW	C_HERE			;Dictionary pointer onto stack
	DW	C_NUMBER		;Convert string at addr to double
	DW	C_DPL			;
	DW	C_FETCH			;Get word from addr on stack
	DW	C_1PLUS			;1 plus
	DW	C_0BRANCH		;Add offset to BC if stack top = 0
	DW	B0028-$			;
	DW	C_DLITERAL
	DW	C_BRANCH		;Add following offset to BC
	DW	B0029-$			;
B0028
	DW	C_DROP			;Drop top value from stack
	DW	C_LITERAL
B0029
	DW	C_QSTACK		;Error message if stack underflow
B0027
	DW	C_BRANCH		;Add following offset to BC
	DW	B002A-$			;FFC2h

W_IMMEDIATE
	DB	$89,'IMMEDIAT','E'+$80
	DW	W_INTERPRET
C_IMMEDIATE
	DW	E_COLON			;Interpret following word sequence
	DW	C_LATEST		;Push top words NFA
	DW	C_LIT			;Puts next 2 bytes on the stack
	DW	$0040
	DW	C_TOGGLE		;XOR (addr) with byte
	DW	C_STOP			;Pop BC from return stack (=next)

W_VOCABULARY
	DB	$8A,'VOCABULAR','Y'+$80
	DW	W_IMMEDIATE
C_VOCABULARY
	DW	E_COLON			;Interpret following word sequence
	DW	C_CREATE
	DW	C_LIT			;Puts next 2 bytes on the stack
	DW	$A081
	DW	C_COMMA			;Reserve 2 bytes and save n
	DW	C_CURRENT
	DW	C_FETCH			;Get word from addr on stack
	DW	C_CFA			;Convert PFA to CFA
	DW	C_COMMA			;Reserve 2 bytes and save n
	DW	C_HERE			;Dictionary pointer onto stack
	DW	C_VOC_LINK
	DW	C_FETCH			;Get word from addr on stack
	DW	C_COMMA			;Reserve 2 bytes and save n
	DW	C_VOC_LINK
	DW	C_STORE			;Store word at addr
	DW	C_DOES
	DW	C_2PLUS			;2 plus
	DW	C_CONTEXT
	DW	C_STORE			;Store word at addr
	DW	C_STOP			;Pop BC from return stack (=next)

C_LINK
	DW	C_2PLUS			;2 plus
	DW	C_FETCH			;Get word from addr on stack
	DW	C_CONTEXT
	DW	C_STORE			;Store word at addr
	DW	C_STOP			;Pop BC from return stack (=next)

W_FORTH
	DB	$C5,'FORT','H'+$80
	DW	W_VOCABULARY
C_FORTH
	DW	X_DOES
	DW	C_LINK

	DB	$81,' '+$80
	DW	FLAST+2
E_FORTH
	DW	$0000

W_DEFINITIONS	;Set CURRENT as CONTEXT vocabulary
	DB	$8B,'DEFINITION','S'+$80
	DW	W_FORTH
C_DEFINITIONS
	DW	E_COLON			;Interpret following word sequence
	DW	C_CONTEXT		;Get CONTEXT addr
	DW	C_FETCH			;Get word from addr on stack
	DW	C_CURRENT		;Get CURRENT addr
	DW	C_STORE			;Set CURRENT as the context vocabulary
	DW	C_STOP			;Pop BC from return stack (=next)

W_OPENBRKT
	DB	$C1,'('+$80
	DW	W_DEFINITIONS
C_OPENBRKT
	DW	E_COLON			;Interpret following word sequence
	DW	C_LIT			;Puts next 2 bytes on the stack
	DW	$0029
	DW	C_WORD
	DW	C_DROP			;Drop top value from stack
	DW	C_STOP			;Pop BC from return stack (=next)

;		This it the last thing ever executed and is the interpreter
;		outer loop. This NEVER quits.

W_QUIT
	DB	$84,'QUI','T'+$80
	DW	W_OPENBRKT
C_QUIT
	DW	E_COLON			;Interpret following word sequence
	DW	C_ZERO			;Put zero on stack
	DW	C_BLK			;Get current BLK pointer
	DW	C_STORE			;Set BLK to 0
	DW	C_LEFTBRKT		;Set STATE to execute
B002C
	DW	C_RPSTORE		;Set initial return stack pointer
	DW	C_CR			;Output [CR][LF]
	DW	C_QUERY			;Get string from input, ends in CR
	DW	C_INTERPRET		;Interpret input stream
	DW	C_STATE			;Push STATE addr
	DW	C_FETCH			;Get word from addr on stack
	DW	C_0EQUALS		;=0
	DW	C_0BRANCH		;Add offset to BC if stack top = 0
	DW	S_END8-$		;0007h
	DW	C_CQUOTE		;Output following string
	DB	S_END8-S_START8
S_START8
	DB	'OK'
S_END8
	DW	C_BRANCH		;Add following offset to BC
	DW	B002C-$			;FFE7h

W_ABORT
	DB	$85,'ABOR','T'+$80
	DW	W_QUIT
C_ABORT
	DW	E_COLON			;Interpret following word sequence
	DW	C_UABORT		;Put UABORT on stack
	DW	C_FETCH			;Get word from addr on stack
	DW	C_EXECUTE		;Jump to address on stack
	DW	C_STOP			;Pop BC from return stack (=next)

CF_UABORT
	DW	E_COLON			;Interpret following word sequence
	DW	C_SPSTORE		;Set initial stack pointer value
	DW	C_DECIMAL		;Sets decimal mode
	DW	C_QSTACK		;Error message if stack underflow
	DW	C_CR			;Output [CR][LF]
	DW	C_CQUOTE		;Output following string
	DB	S_END1-S_START1		;String length
S_START1
	DB	$0C,'* Z80 FORTH *'
S_END1
	DW	C_FORTH
	DW	C_DEFINITIONS			;Set CURRENT as CONTEXT vocabulary
	DW	C_QUIT

W_WARM
	DB	$84,'WAR','M'+$80
	DW	W_ABORT
C_WARM
	DW	E_COLON					;Interpret following word sequence
	DW	C_LIT					;Puts next 2 bytes on the stack
	DW	WORD1					;Start of detault table
	DW	C_LIT					;Puts next 2 bytes on the stack
	DW	S0						;S0 addr
	DW	C_LIT					;Puts next 2 bytes on the stack
	DW	START_TABLE-WORD1		;(000Ch) Table length
	DW	C_CMOVE					;Move block
	DW	C_ABORT

X_COLD
	LD	HL,START_TABLE			;Copy table to ram
	LD	DE,FLAST				;Where the table's going
	LD	BC,NEXTS2-START_TABLE	;Bytes to copy
	LDIR						;
	LD	HL,W_TASK				;Copy TASK to ram
	LD	DE,VOCAB_BASE			;Where it's going
	LD	BC,W_TASKEND-W_TASK		;Bytes to copy
	LDIR						;
	LD	BC,FIRSTWORD			;BC to first forth word
	LD	HL,(WORD1)				;Get stack pointer
	LD	SP,HL					;Set it
	JP	NEXT

FIRSTWORD
	DW	C_COLD

W_COLD
	DB	$84,'COL','D'+$80
	DW	W_WARM
	DW	X_COLD
C_COLD
	DW	E_COLON					;Interpret following word sequence
	DW	C_EBUFFERS				;Clear pseudo disk buffer
	DW	C_ZERO					;Put zero on stack
	DW	C_OFFSET				;Put disk block offset on stack
	DW	C_STORE					;Clear disk block offset
	DW	C_LIT					;Puts next 2 bytes on the stack
	DW	WORD1					;Start of default table
	DW	C_LIT					;Puts next 2 bytes on the stack
	DW	S0						;S0 addr
	DW	C_LIT					;Puts next 2 bytes on the stack
	DW	START_TABLE-WORD1		;Block length on stack (0010h)
	DW	C_CMOVE					;Move block
	DW	C_ABORT

W_SINGTODUB						;Change single number to double
	DB	$84,'S->','D'+$80
	DW	W_COLD
C_SINGTODUB
	DW	2+$						;Vector to code
	POP	DE						;Get number
	LD	HL,$0000				;Assume +ve extend
	LD	A,D						;Check sign
	AND	$80						;
	JR	Z,IS_POS				;Really +ve so jump
	DEC	HL						;Make -ve extension
IS_POS	
	JP	NEXTS2					;Save both & NEXT

W_PLUSMINUS
	DB	$82,'+','-'+$80
	DW	W_SINGTODUB
C_PLUSMINUS
	DW	E_COLON					;Interpret following word sequence
	DW	C_0LESS					;Less than 0
	DW	C_0BRANCH				;Add offset to BC if stack top = 0
	DW	B002D-$					;$0004
	DW	C_NEGATE				;Form 2s complement of n
B002D		
	DW	C_STOP					;Pop BC from return stack (=next)

W_DPLUSMINUS					;Add sign of n to double
	DB	$83,'D+','-'+$80
	DW	W_PLUSMINUS
C_DPLUSMINUS
	DW	E_COLON					;Interpret following word sequence
	DW	C_0LESS					;Less than 0
	DW	C_0BRANCH				;Add offset to BC if stack top = 0
	DW	B002E-$					;$0004
	DW	C_DNEGATE		
B002E		
	DW	C_STOP					;Pop BC from return stack (=next)

W_ABS
	DB	$83,'AB','S'+$80
	DW	W_DPLUSMINUS
C_ABS
	DW	E_COLON					;Interpret following word sequence
	DW	C_DUP					;Duplicate top value on stack
	DW	C_PLUSMINUS
	DW	C_STOP					;Pop BC from return stack (=next)

W_DABS
	DB	$84,'DAB','S'+$80
	DW	W_ABS
C_DABS
	DW	E_COLON					;Interpret following word sequence
	DW	C_DUP					;Duplicate top value on stack
	DW	C_DPLUSMINUS			;Add sign of n to double
	DW	C_STOP					;Pop BC from return stack (=next)

W_MIN
	DB	$83,'MI','N'+$80
	DW	W_DABS
C_MIN
	DW	E_COLON					;Interpret following word sequence
	DW	C_2DUP					;Dup top 2 values on stack
	DW	C_GREATER		
	DW	C_0BRANCH				;Add offset to BC if stack top = 0
	DW	B002F-$					;$0004
	DW	C_SWAP					;Swap top 2 values on stack
B002F		
	DW	C_DROP					;Drop top value from stack
	DW	C_STOP					;Pop BC from return stack (=next)

W_MAX
	DB	$83,'MA','X'+$80
	DW	W_MIN
C_MAX
	DW	E_COLON			;Interpret following word sequence
	DW	C_2DUP			;Dup top 2 values on stack
	DW	C_LESSTHAN
	DW	C_0BRANCH		;Add offset to BC if stack top = 0
	DW	B0030-$			;$0004
	DW	C_SWAP			;Swap top 2 values on stack
B0030
	DW	C_DROP			;Drop top value from stack
	DW	C_STOP			;Pop BC from return stack (=next)

W_MTIMES
	DB	$82,'M','*'+$80
	DW	W_MAX
C_MTIMES
	DW	E_COLON			;Interpret following word sequence
	DW	C_2DUP			;Dup top 2 values on stack
	DW	C_XOR			;Works out sign of result
	DW	C_MOVER			;Move value from data to return stack
	DW	C_ABS
	DW	C_SWAP			;Swap top 2 values on stack
	DW	C_ABS
	DW	C_USTAR
	DW	C_RMOVE			;Move word from return to data stack
	DW	C_DPLUSMINUS		;Add sign of n to double
	DW	C_STOP			;Pop BC from return stack (=next)

W_MDIV
	DB	$82,'M','/'+$80
	DW	W_MTIMES
C_MDIV
	DW	E_COLON			;Interpret following word sequence
	DW	C_OVER			;Copy 2nd down to top of stack
	DW	C_MOVER			;Move value from data to return stack
	DW	C_MOVER			;Move value from data to return stack
	DW	C_DABS
	DW	C_RFETCH		;Return stack top to data stack
	DW	C_ABS
	DW	C_UMOD			;Unsigned divide & MOD
	DW	C_RMOVE			;Move word from return to data stack
	DW	C_RFETCH		;Return stack top to data stack
	DW	C_XOR			;XOR
	DW	C_PLUSMINUS
	DW	C_SWAP			;Swap top 2 values on stack
	DW	C_RMOVE			;Move word from return to data stack
	DW	C_PLUSMINUS
	DW	C_SWAP			;Swap top 2 values on stack
	DW	C_STOP			;Pop BC from return stack (=next)

W_TIMES
	DB	$81,'*'+$80
	DW	W_MDIV
C_TIMES
	DW	E_COLON			;Interpret following word sequence
	DW	C_MTIMES
	DW	C_DROP			;Drop top value from stack
	DW	C_STOP			;Pop BC from return stack (=next)

W_DIVMOD
	DB	$84,'/MO','D'+$80
	DW	W_TIMES
C_DIVMOD
	DW	E_COLON			;Interpret following word sequence
	DW	C_MOVER			;Move value from data to return stack
	DW	C_SINGTODUB		;Change single number to double
	DW	C_RMOVE			;Move word from return to data stack
	DW	C_MDIV
	DW	C_STOP			;Pop BC from return stack (=next)

W_DIV
	DB	$81,'/'+$80
	DW	W_DIVMOD
C_DIV
	DW	E_COLON			;Interpret following word sequence
	DW	C_DIVMOD
	DW	C_SWAP			;Swap top 2 values on stack
	DW	C_DROP			;Drop top value from stack
	DW	C_STOP			;Pop BC from return stack (=next)

W_MOD
	DB	$83,'MO','D'+$80
	DW	W_DIV
C_MOD
	DW	E_COLON			;Interpret following word sequence
	DW	C_DIVMOD
	DW	C_DROP			;Drop top value from stack
	DW	C_STOP			;Pop BC from return stack (=next)

W_TIMESDIVMOD
	DB	$85,'*/MO','D'+$80
	DW	W_MOD
C_TIMESDIVMOD
	DW	E_COLON			;Interpret following word sequence
	DW	C_MOVER			;Move value from data to return stack
	DW	C_MTIMES
	DW	C_RMOVE			;Move word from return to data stack
	DW	C_MDIV
	DW	C_STOP			;Pop BC from return stack (=next)

W_TIMESDIV
	DB	$82,'*','/'+$80
	DW	W_TIMESDIVMOD
C_TIMESDIV
	DW	E_COLON			;Interpret following word sequence
	DW	C_TIMESDIVMOD
	DW	C_SWAP			;Swap top 2 values on stack
	DW	C_DROP			;Drop top value from stack
	DW	C_STOP			;Pop BC from return stack (=next)

W_MDIVMOD
	DB	$85,'M/MO','D'+$80
	DW	W_TIMESDIV
C_MDIVMOD
	DW	E_COLON			;Interpret following word sequence
	DW	C_MOVER			;Move value from data to return stack
	DW	C_ZERO			;Put zero on stack
	DW	C_RFETCH		;Return stack top to data stack
	DW	C_UMOD			;Unsigned divide & MOD
	DW	C_RMOVE			;Move word from return to data stack
	DW	C_SWAP			;Swap top 2 values on stack
	DW	C_MOVER			;Move value from data to return stack
	DW	C_UMOD			;Unsigned divide & MOD
	DW	C_RMOVE			;Move word from return to data stack
	DW	C_STOP			;Pop BC from return stack (=next)

W_CLINE
	DB	$86,'<LINE','>'+$80
	DW	W_MDIVMOD
C_CLINE
	DW	E_COLON			;Interpret following word sequence
	DW	C_MOVER			;Move value from data to return stack
	DW	C_CL			;Put characters/line on stack
	DW	C_BBUF			;Put bytes per block on stack
	DW	C_TIMESDIVMOD
	DW	C_RMOVE			;Move word from return to data stack
	DW	C_BSCR			;Number of buffers per block on stack
	DW	C_TIMES
	DW	C_PLUS			;n1 + n2
	DW	C_BLOCK
	DW	C_PLUS			;n1 + n2
	DW	C_CL			;Put characters/line on stack
	DW	C_STOP			;Pop BC from return stack (=next)

W_DOTLINE
	DB	$85,'.LIN','E'+$80
	DW	W_CLINE
C_DOTLINE
	DW	E_COLON			;Interpret following word sequence
	DW	C_CLINE
	DW	C_TRAILING
	DW	C_TYPE			;Output n bytes from addr
	DW	C_STOP			;Pop BC from return stack (=next)

W_MESSAGE
	DB	$87,'MESSAG','E'+$80
	DW	W_DOTLINE
C_MESSAGE
	DW	E_COLON			;Interpret following word sequence
	DW	C_WARNING		;Put WARNING addr on stack
	DW	C_FETCH			;Get WARNING value
	DW	C_0BRANCH		;If WARNING = 0 output MSG # n
	DW	B0031-$			;001Eh
	DW	C_QUERYDUP
	DW	C_0BRANCH		;Add offset to BC if stack top = 0
	DW	B0032-$			;0014h
	DW	C_LIT			;Puts next 2 bytes on the stack
	DW	$0004
	DW	C_OFFSET		;Put disk block offset on stack
	DW	C_FETCH			;Get word from addr on stack
	DW	C_BSCR			;Number of buffers per block on stack
	DW	C_DIV
	DW	C_MINUS
	DW	C_DOTLINE		;Output line from screen
	DW	C_SPACE			;Output space
B0032
	DW	C_BRANCH		;Add following offset to BC
	DW	B0033-$			;000Dh
B0031
	DW	C_CQUOTE		;Output following string
		DB	S_END2-S_START2
S_START2
	DB	'MSG # '
S_END2
	DW	C_DOT
B0033
	DW	C_STOP			;Pop BC from return stack (=next)

W_PORTIN	;Fetch data from port
	DB	$82,'P','@'+$80
	DW	W_MESSAGE
C_PORTIN
	DW	2+$			;Vector to code
	POP	DE			;Get port addr
	LD	HL,PAT+1		;Save in port in code
	LD	(HL),E			;
	CALL	PAT			;Call port in routine
	LD	L,A			;Save result
	LD	H,$00			;
	JP	NEXTS1			;Save & NEXT

W_PORTOUT	;Save data to port
	DB	$82,'P','!'+$80
	DW	W_PORTIN
C_PORTOUT
	DW	2+$			;Vector to code
	POP	DE			;Get port addr
	LD	HL,PST+1		;Save in port out code
	LD	(HL),E			;
	POP	HL			;
	LD	A,L			;Byte to A
	CALL	PST			;Call port out routine
	JP	NEXT

W_USE
	DB	$83,'US','E'+$80
	DW	W_PORTOUT
C_USE
	DW	X_USER			;Put next word on stack then do next
	DW	USE-SYSTEM

W_PREV
	DB	$84,'PRE','V'+$80
	DW	W_USE
C_PREV
	DW	X_USER			;Put next word on stack then do next
	DW	PREV-SYSTEM

W_PLUSBUF
	DB	$84,'+BU','F'+$80
	DW	W_PREV
C_PLUSBUF
	DW	NEXT

W_UPDATE
	DB	$86,'UPDAT','E'+$80
	DW	W_PLUSBUF
C_UPDATE
	DW	NEXT

W_EBUFFERS	;Clear pseudo disk buffer
	DB	$8D,'EMPTY-BUFFER','S'+$80
	DW	W_UPDATE
C_EBUFFERS
	DW	E_COLON			;Interpret following word sequence
	DW	C_FIRST			;Start of pseudo disk onto stack
	DW	C_LIMIT			;End of pseudo disk onto stack
	DW	C_OVER			;Start to top of stack
	DW	C_MINUS			;Work out buffer length
	DW	C_ERASE			;Fill addr & length from stack with 0
	DW	C_STOP			;Pop BC from return stack (=next)

W_BUFFER
	DB	$86,'BUFFE','R'+$80
	DW	W_EBUFFERS
C_BUFFER
	DW	E_COLON			;Interpret following word sequence
	DW	C_BLOCK
	DW	C_STOP			;Pop BC from return stack (=next)

W_BLOCK		;Put address of block n (+ offset) on stack
	DB	$85,'BLOC','K'+$80
	DW	W_BUFFER
C_BLOCK
	DW	E_COLON			;Interpret following word sequence
	DW	C_LIT			;Puts next 2 bytes on the stack
	DW	DISK_END/BLOCK_SIZE-DISK_START/BLOCK_SIZE
					;Max number of blocks
	DW	C_MOD			;MOD to max number
	DW	C_OFFSET		;Put address of disk block offset on stack
	DW	C_FETCH			;Get disk block offset
	DW	C_PLUS			;Add offset to block #
	DW	C_BBUF			;Put bytes per block on stack
	DW	C_TIMES			;Bytes times block number
	DW	C_FIRST			;Put address of first block on stack
	DW	C_PLUS			;Add address of first to byte offset
	DW	C_STOP			;Pop BC from return stack (=next)

W_RW
	DB	$83,'R/','W'+$80
	DW	W_BLOCK
C_RW
	DW	E_COLON			;Interpret following word sequence
	DW	C_URW			;
	DW	C_FETCH			;Get word from addr on stack
	DW	C_EXECUTE		;Jump to address on stack
	DW	C_STOP			;Pop BC from return stack (=next)
CF_URW
	DW	E_COLON			;Interpret following word sequence
	DW	C_DROP			;Drop top value from stack
	DW	C_DROP			;Drop top value from stack
	DW	C_DROP			;Drop top value from stack
	DW	C_STOP			;Pop BC from return stack (=next)

W_FLUSH
	DB	$85,'FLUS','H'+$80
	DW	W_RW
C_FLUSH
	DW	E_COLON			;Interpret following word sequence
	DW	C_STOP			;Pop BC from return stack (=next)

W_DUMP
	DB	$84,'DUM','P'+$80
	DW	W_FLUSH
C_DUMP
	DW	E_COLON			;Interpret following word sequence
	DW	C_ZERO			;Put zero on stack
	DW	C_LDO			;Put start & end loop values on RPP
B0051
	DW	C_CR			;Output [CR][LF]
	DW	C_DUP			;Duplicate top value on stack
	DW	C_ZERO			;Put zero on stack
	DW	C_LIT			;Puts next 2 bytes on the stack
	DW	$0005
	DW	C_DDOTR
	DW	C_SPACE			;Output space
	DW	C_LIT			;Puts next 2 bytes on the stack
	DW	$0004
	DW	C_SWAP			;Swap top 2 values on stack
	DW	C_OVER			;Copy 2nd down to top of stack
	DW	C_ZERO			;Put zero on stack
	DW	C_LDO			;Put start & end loop values on RPP
B0050
	DW	C_DUP			;Duplicate top value on stack
	DW	C_CFETCH		;Get byte from addr on stack
	DW	C_3
	DW	C_DOTR
	DW	C_1PLUS			;1 plus
	DW	C_LLOOP			;Increment loop & branch if not done
	DW	B0050-$			;FFF4h
	DW	C_SWAP			;Swap top 2 values on stack
	DW	C_PLOOP			;Loop + stack & branch if not done
	DW	B0051-$			;FFD4h
	DW	C_DROP			;Drop top value from stack
	DW	C_CR			;Output [CR][LF]
	DW	C_STOP			;Pop BC from return stack (=next)

W_LOAD
	DB	$84,'LOA','D'+$80
	DW	W_DUMP
C_LOAD
	DW	E_COLON			;Interpret following word sequence
	DW	C_BLK			;Get current block number (0 = keyboard)
	DW	C_FETCH			;Get word from addr on stack
	DW	C_MOVER			;Save it for now
	DW	C_TOIN			;Current input buffer offset
	DW	C_FETCH			;Get word from addr on stack
	DW	C_MOVER			;Save it for now
	DW	C_ZERO			;Put zero on stack
	DW	C_TOIN			;Current input buffer offset
	DW	C_STORE			;Set to zero
	DW	C_BSCR			;Number of buffers per block on stack
	DW	C_TIMES			;Multiply block to load by buffers/block
	DW	C_BLK			;Get BLK pointer
	DW	C_STORE			;Make load block current input stream
	DW	C_INTERPRET		;Interpret input stream
	DW	C_RMOVE			;Move word from return to data stack
	DW	C_TOIN			;Current input buffer offset
	DW	C_STORE			;Store word at addr
	DW	C_RMOVE			;Move word from return to data stack
	DW	C_BLK			;Current block
	DW	C_STORE			;Store word at addr
	DW	C_STOP			;Pop BC from return stack (=next)

W_NEXTSCREEN
	DB	$C3,'--','>'+$80
	DW	W_LOAD
C_NEXTSCREEN
	DW	E_COLON			;Interpret following word sequence
	DW	C_QLOADING
	DW	C_ZERO			;Put zero on stack
	DW	C_TOIN			;Current input buffer offset
	DW	C_STORE			;Store word at addr
	DW	C_BSCR			;Number of buffers per block on stack
	DW	C_BLK
	DW	C_FETCH			;Get word from addr on stack
	DW	C_OVER			;Copy 2nd down to top of stack
	DW	C_MOD
	DW	C_MINUS
	DW	C_BLK
	DW	C_PLUSSTORE		;Add n1 to addr
	DW	C_STOP			;Pop BC from return stack (=next)

W_TICK
	DB	$81,$2C+$80
	DW	W_NEXTSCREEN
C_TICK
	DW	E_COLON			;Interpret following word sequence
	DW	C_MFIND			;Find name returns PFA,length,true or false
	DW	C_0EQUALS		;=0
	DW	C_ZERO			;Put zero on stack
	DW	C_QERROR
	DW	C_DROP			;Drop top value from stack
	DW	C_LITERAL
	DW	C_STOP			;Pop BC from return stack (=next)

W_FORGET
	DB	$86,'FORGE','T'+$80
	DW	W_TICK
C_FORGET
	DW	E_COLON			;Interpret following word sequence
	DW	C_CURRENT
	DW	C_FETCH			;Get word from addr on stack
	DW	C_CONTEXT
	DW	C_FETCH			;Get word from addr on stack
	DW	C_MINUS
	DW	C_LIT			;Puts next 2 bytes on the stack
	DW	$0018
	DW	C_QERROR
	DW	C_TICK
	DW	C_DUP			;Duplicate top value on stack
	DW	C_FENCE
	DW	C_FETCH			;Get word from addr on stack
	DW	C_LESSTHAN
	DW	C_LIT			;Puts next 2 bytes on the stack
	DW	$0015
	DW	C_QERROR
	DW	C_DUP			;Duplicate top value on stack
	DW	C_NFA			;Convert PFA to NFA
	DW	C_DP			;Dictionary pointer addr on stack
	DW	C_STORE			;Store word at addr
	DW	C_LFA
	DW	C_FETCH			;Get word from addr on stack
	DW	C_CONTEXT
	DW	C_FETCH			;Get word from addr on stack
	DW	C_STORE			;Store word at addr
	DW	C_STOP			;Pop BC from return stack (=next)

W_BACK
	DB	$84,'BAC','K'+$80
	DW	W_FORGET
C_BACK
	DW	E_COLON			;Interpret following word sequence
	DW	C_HERE			;Dictionary pointer onto stack
	DW	C_MINUS
	DW	C_COMMA			;Reserve 2 bytes and save n
	DW	C_STOP			;Pop BC from return stack (=next)

W_BEGIN
	DB	$C5,'BEGI','N'+$80
	DW	W_BACK
C_BEGIN
	DW	E_COLON			;Interpret following word sequence
	DW	C_QCOMP			;Error if not in compile mode
	DW	C_HERE			;Dictionary pointer onto stack
	DW	C_1			;Put 1 on stack
	DW	C_STOP			;Pop BC from return stack (=next)

W_ENDIF
	DB	$C5,'ENDI','F'+$80
	DW	W_BEGIN
C_ENDIF
	DW	E_COLON			;Interpret following word sequence
	DW	C_QCOMP			;Error if not in compile mode
	DW	C_2
	DW	C_QPAIRS
	DW	C_HERE			;Dictionary pointer onto stack
	DW	C_OVER			;Copy 2nd down to top of stack
	DW	C_MINUS
	DW	C_SWAP			;Swap top 2 values on stack
	DW	C_STORE			;Store word at addr
	DW	C_STOP			;Pop BC from return stack (=next)

W_THEN
	DB	$C4,'THE','N'+$80
	DW	W_ENDIF
C_THEN
	DW	E_COLON			;Interpret following word sequence
	DW	C_ENDIF
	DW	C_STOP			;Pop BC from return stack (=next)

W_DO
	DB	$C2,'D','O'+$80
	DW	W_THEN
C_DO
	DW	E_COLON			;Interpret following word sequence
	DW	C_COMPILE		;Compile next word into dictionary
	DW	C_LDO			;Put start & end loop values on RPP
	DW	C_HERE			;Dictionary pointer onto stack
	DW	C_3
	DW	C_STOP			;Pop BC from return stack (=next)

W_LOOP
	DB	$C4,'LOO','P'+$80
	DW	W_DO
C_LOOP
	DW	E_COLON			;Interpret following word sequence
	DW	C_3
	DW	C_QPAIRS
	DW	C_COMPILE		;Compile next word into dictionary
	DW	C_LLOOP			;Increment loop & branch if not done
	DW	C_BACK
	DW	C_STOP			;Pop BC from return stack (=next)

W_PLUSLOOP
	DB	$C5,'+LOO','P'+$80
	DW	W_LOOP
C_PLUSLOOP
	DW	E_COLON			;Interpret following word sequence
	DW	C_3
	DW	C_QPAIRS
	DW	C_COMPILE		;Compile next word into dictionary
	DW	C_PLOOP			;Loop + stack & branch if not done
	DW	C_BACK
	DW	C_STOP			;Pop BC from return stack (=next)

W_UNTIL
	DB	$C5,'UNTI','L'+$80
	DW	W_PLUSLOOP
C_UNTIL
	DW	E_COLON			;Interpret following word sequence
	DW	C_1			;Put 1 on stack
	DW	C_QPAIRS
	DW	C_COMPILE		;Compile next word into dictionary
	DW	C_0BRANCH		;Add offset to BC if stack top = 0
	DW	C_BACK
	DW	C_STOP			;Pop BC from return stack (=next)

W_END
	DB	$C3,'EN','D'+$80
	DW	W_UNTIL
C_END
	DW	E_COLON			;Interpret following word sequence
	DW	C_UNTIL
	DW	C_STOP			;Pop BC from return stack (=next)

W_AGAIN
	DB	$C5,'AGAI','N'+$80
	DW	W_END
C_AGAIN
	DW	E_COLON			;Interpret following word sequence
	DW	C_1			;Put 1 on stack
	DW	C_QPAIRS
	DW	C_COMPILE		;Compile next word into dictionary
	DW	C_BRANCH		;Add following offset to BC
	DW	C_BACK
	DW	C_STOP			;Pop BC from return stack (=next)

W_REPEAT
	DB	$C6,'REPEA','T'+$80
	DW	W_AGAIN
C_REPEAT
	DW	E_COLON			;Interpret following word sequence
	DW	C_MOVER			;Move value from data to return stack
	DW	C_MOVER			;Move value from data to return stack
	DW	C_AGAIN
	DW	C_RMOVE			;Move word from return to data stack
	DW	C_RMOVE			;Move word from return to data stack
	DW	C_2
	DW	C_MINUS
	DW	C_ENDIF
	DW	C_STOP			;Pop BC from return stack (=next)

W_IF
	DB	$C2,'I','F'+$80
	DW	W_REPEAT
C_IF
	DW	E_COLON			;Interpret following word sequence
	DW	C_COMPILE		;Compile next word into dictionary
	DW	C_0BRANCH		;Add offset to BC if stack top = 0
	DW	C_HERE			;Dictionary pointer onto stack
	DW	C_ZERO			;Put zero on stack
	DW	C_COMMA			;Reserve 2 bytes and save n
	DW	C_2
	DW	C_STOP			;Pop BC from return stack (=next)

W_ELSE
	DB	$C4,'ELS','E'+$80
	DW	W_IF
C_ELSE
	DW	E_COLON			;Interpret following word sequence
	DW	C_2
	DW	C_QPAIRS
	DW	C_COMPILE		;Compile next word into dictionary
	DW	C_BRANCH		;Add following offset to BC
	DW	C_HERE			;Dictionary pointer onto stack
	DW	C_ZERO			;Put zero on stack
	DW	C_COMMA			;Reserve 2 bytes and save n
	DW	C_SWAP			;Swap top 2 values on stack
	DW	C_2
	DW	C_ENDIF
	DW	C_2
	DW	C_STOP			;Pop BC from return stack (=next)

W_WHILE
	DB	$C5,'WHIL','E'+$80
	DW	W_ELSE
C_WHILE
	DW	E_COLON			;Interpret following word sequence
	DW	C_IF
	DW	C_2PLUS			;2 plus
	DW	C_STOP			;Pop BC from return stack (=next)

W_SPACES
	DB	$86,'SPACE','S'+$80
	DW	W_WHILE
C_SPACES
	DW	E_COLON			;Interpret following word sequence
	DW	C_ZERO			;Put zero on stack
	DW	C_MAX
	DW	C_QUERYDUP
	DW	C_0BRANCH		;Add offset to BC if stack top = 0
	DW	B0034-$			;000Ch
	DW	C_ZERO			;Put zero on stack
	DW	C_LDO			;Put start & end loop values on RPP
B0035
	DW	C_SPACE			;Output space
	DW	C_LLOOP			;Increment loop & branch if not done
	DW	B0035-$			;FFFCh
B0034
	DW	C_STOP			;Pop BC from return stack (=next)

W_LESSHARP
	DB	$82,'<','#'+$80
	DW	W_SPACES
C_LESSHARP
	DW	E_COLON			;Interpret following word sequence
	DW	C_PAD			;Save intermediate string address
	DW	C_HLD
	DW	C_STORE			;Store word at addr
	DW	C_STOP			;Pop BC from return stack (=next)

W_SHARPGT
	DB	$82,'#','>'+$80
	DW	W_LESSHARP
C_SHARPGT
	DW	E_COLON			;Interpret following word sequence
	DW	C_DROP			;Drop top value from stack
	DW	C_DROP			;Drop top value from stack
	DW	C_HLD
	DW	C_FETCH			;Get word from addr on stack
	DW	C_PAD			;Save intermediate string address
	DW	C_OVER			;Copy 2nd down to top of stack
	DW	C_MINUS
	DW	C_STOP			;Pop BC from return stack (=next)

W_SIGN
	DB	$84,'SIG','N'+$80
	DW	W_SHARPGT
C_SIGN
	DW	E_COLON			;Interpret following word sequence
	DW	C_ROT			;3rd valu down to top of stack
	DW	C_0LESS			;Less than 0
	DW	C_0BRANCH		;Add offset to BC if stack top = 0
	DW	B0036-$			;0008h
	DW	C_LIT			;Puts next 2 bytes on the stack
	DW	$002D
	DW	C_HOLD
B0036
	DW	C_STOP			;Pop BC from return stack (=next)

W_SHARP
	DB	$81,'#'+$80
	DW	W_SIGN
C_SHARP
	DW	E_COLON			;Interpret following word sequence
	DW	C_BASE			;Put BASE addr on stack
	DW	C_FETCH			;Get word from addr on stack
	DW	C_MDIVMOD
	DW	C_ROT			;3rd valu down to top of stack
	DW	C_LIT			;Puts next 2 bytes on the stack
	DW	$0009
	DW	C_OVER			;Copy 2nd down to top of stack
	DW	C_LESSTHAN
	DW	C_0BRANCH		;Add offset to BC if stack top = 0
	DW	B0037-$			;0008h
	DW	C_LIT			;Puts next 2 bytes on the stack
	DW	$0007
	DW	C_PLUS			;n1 + n2
B0037
	DW	C_LIT			;Puts next 2 bytes on the stack
	DW	$0030
	DW	C_PLUS			;n1 + n2
	DW	C_HOLD
	DW	C_STOP			;Pop BC from return stack (=next)

W_SHARPS
	DB	$82,'#','S'+$80
	DW	W_SHARP
C_SHARPS
	DW	E_COLON			;Interpret following word sequence
B0038
	DW	C_SHARP
	DW	C_OVER			;Copy 2nd down to top of stack
	DW	C_OVER			;Copy 2nd down to top of stack
	DW	C_OR			;OR
	DW	C_0EQUALS		;=0
	DW	C_0BRANCH		;Add offset to BC if stack top = 0
	DW	B0038-$			;FFF4h
	DW	C_STOP			;Pop BC from return stack (=next)

W_DDOTR
	DB	$83,'D.','R'+$80
	DW	W_SHARPS
C_DDOTR
	DW	E_COLON			;Interpret following word sequence
	DW	C_MOVER			;Move value from data to return stack
	DW	C_SWAP			;Swap top 2 values on stack
	DW	C_OVER			;Copy 2nd down to top of stack
	DW	C_DABS
	DW	C_LESSHARP
	DW	C_SHARPS
	DW	C_SIGN
	DW	C_SHARPGT
	DW	C_RMOVE			;Move word from return to data stack
	DW	C_OVER			;Copy 2nd down to top of stack
	DW	C_MINUS
	DW	C_SPACES
	DW	C_TYPE			;Output n bytes from addr
	DW	C_STOP			;Pop BC from return stack (=next)

W_DOTR
	DB	$82,'.','R'+$80
	DW	W_DDOTR
C_DOTR
	DW	E_COLON			;Interpret following word sequence
	DW	C_MOVER			;Move value from data to return stack
	DW	C_SINGTODUB		;Change single number to double
	DW	C_RMOVE			;Move word from return to data stack
	DW	C_DDOTR
	DW	C_STOP			;Pop BC from return stack (=next)

W_DDOT
	DB	$82,'D','.'+$80
	DW	W_DOTR
C_DDOT
	DW	E_COLON			;Interpret following word sequence
	DW	C_ZERO			;Put zero on stack
	DW	C_DDOTR
	DW	C_SPACE			;Output space
	DW	C_STOP			;Pop BC from return stack (=next)

W_DOT
	DB	$81,'.'+$80
	DW	W_DDOT
C_DOT
	DW	E_COLON			;Interpret following word sequence
	DW	C_SINGTODUB		;Change single number to double
	DW	C_DDOT
	DW	C_STOP			;Pop BC from return stack (=next)

W_QUESTION
	DB	$81,'?'+$80
	DW	W_DOT
C_QUESTION
	DW	E_COLON			;Interpret following word sequence
	DW	C_FETCH			;Get word from addr on stack
	DW	C_DOT
	DW	C_STOP			;Pop BC from return stack (=next)

W_UDOT					;Output as unsigned value
	DB	$82,'U','.'+$80
	DW	W_QUESTION
C_UDOT
	DW	E_COLON			;Interpret following word sequence
	DW	C_ZERO			;Put zero on stack
	DW	C_DDOT			;Output double value
	DW	C_STOP			;Pop BC from return stack (=next)

W_VLIST
	DB	$85,'VLIS','T'+$80
	DW	W_UDOT
C_VLIST
	DW	E_COLON			;Interpret following word sequence
	DW	C_CONTEXT		;Leave vocab pointer on stack
	DW	C_FETCH			;Get word from addr on stack
	DW	C_FETCH			;Get word from addr on stack
	DW	C_CR			;Output [CR][LF]
B0039
	DW	C_DUP			;Duplicate top value on stack
	DW	C_PFA			;Convert NFA to PFA
	DW	C_SWAP			;Swap top 2 values on stack
	DW	C_ID			;Print definition name from name field addr
	DW	C_LFA			;Convert param addr to link addr
	DW	C_FETCH			;Get word from addr on stack
	DW	C_DUP			;Duplicate top value on stack
	DW	C_0EQUALS		;=0
	DW	C_TERMINAL		;Check for break key
	DW	C_OR			;OR
	DW	C_0BRANCH		;Add offset to BC if stack top = 0
	DW	B0039-$			;FFE2h
	DW	C_DROP			;Drop top value from stack
	DW	C_CR			;Output [CR][LF]
	DW	C_STOP			;Pop BC from return stack (=next)

W_LIST
	DB	$84,'LIS','T'+$80
	DW	W_VLIST
C_LIST
	DW	E_COLON			;Interpret following word sequence
	DW	C_BASE			;Put BASE addr on stack
	DW	C_FETCH			;Put current base on stack
	DW	C_SWAP			;Get number of list screen to top
	DW	C_DECIMAL		;Sets decimal mode
	DW	C_CR			;Output [CR][LF]
	DW	C_DUP			;Duplicate top value on stack
	DW	C_SCR			;Set most recently listed
	DW	C_STORE			;Store word at addr
	DW	C_CQUOTE		;Output following string
	DB	S_END3-S_START3
S_START3
	DB	'SCR # '
S_END3
	DW	C_DOT			;Output the screen number
	DW	C_LIT			;Puts next 2 bytes on the stack
	DW	$0010			;16 lines to do
	DW	C_ZERO			;From 0 to 15
	DW	C_LDO			;Put start & end loop values on RPP
DO_LINE
	DW	C_CR			;Output [CR][LF]
	DW	C_I			;Line number onto data stack
	DW	C_LIT			;Puts next 2 bytes on the stack
	DW	$0003			;Fromat right justified 3 characters
	DW	C_DOTR			;Output formatted
	DW	C_SPACE			;Output space
	DW	C_I			;Line number onto data stack
	DW	C_SCR			;Get screen number
	DW	C_FETCH			;Get word from addr on stack
	DW	C_DOTLINE		;Output line from screen
	DW	C_TERMINAL		;Check for break key
	DW	C_0BRANCH		;Jump if no break key
	DW	NO_BRK-$		;
	DW	C_LEAVE			;Else set loop index to limit (quit loop)
NO_BRK
	DW	C_LLOOP			;Increment loop & branch if not done
	DW	DO_LINE-$		;
	DW	C_CR			;Output [CR][LF]
	DW	C_BASE			;Put BASE addr on stack
	DW	C_STORE			;Restore original base
	DW	C_STOP			;Pop BC from return stack (=next)

W_INDEX
	DB	$85,'INDE','X'+$80
	DW	W_LIST
C_INDEX
	DW	E_COLON			;Interpret following word sequence
	DW	C_1PLUS			;1 plus
	DW	C_SWAP			;Swap top 2 values on stack
	DW	C_LDO			;Put start & end loop values on RPP
B003D
	DW	C_CR			;Output [CR][LF]
	DW	C_I			;Copy LOOP index to data stack
	DW	C_LIT			;Puts next 2 bytes on the stack
	DW	$0003
	DW	C_DOTR
	DW	C_SPACE			;Output space
	DW	C_ZERO			;Put zero on stack
	DW	C_I			;Copy LOOP index to data stack
	DW	C_DOTLINE		;Output line from screen
	DW	C_TERMINAL		;Check for break key
	DW	C_0BRANCH		;Add offset to BC if stack top = 0
	DW	B003C-$			;$0004
	DW	C_LEAVE			;Quit loop by making index = limit
B003C
	DW	C_LLOOP			;Increment loop & branch if not done
	DW	B003D-$			;FFE4h
	DW	C_CR			;Output [CR][LF]
	DW	C_STOP			;Pop BC from return stack (=next)

W_INT
	DB	$C4,';IN','T'+$80
	DW	W_INDEX
C_INT
	DW	E_COLON			;Interpret following word sequence
	DW	C_WHATSTACK		;Check stack pointer, error if not ok
	DW	C_COMPILE		;Compile next word into dictionary
	DW	X_INT
	DW	C_LEFTBRKT		;Set STATE to execute
	DW	C_SMUDGE
	DW	C_STOP			;Pop BC from return stack (=next)

X_INT
	DW	2+$			;Vector to code
	LD	HL,INTFLAG
	RES	6,(HL)
	EI
	JP	X_STOP

W_INTFLAG
	DB	$87,'INTFLA','G'+$80
	DW	W_INT
C_INTFLAG
	DW	X_USER			;Put next word on stack then do next
	DW	INTFLAG-SYSTEM

W_INTVECT
	DB	$87,'INTVEC','T'+$80
	DW	W_INTFLAG
C_INTVECT
	DW	X_USER			;Put next word on stack then do next
	DW	INTVECT-SYSTEM

W_CPU
	DB	$84,'.CP','U'+$80
	DW	W_INTVECT
C_CPU
	DW	E_COLON			;Interpret following word sequence
	DW	C_CQUOTE		;Output following string
	DB	S_END4-S_START4
S_START4
	DB	'Z80 '
S_END4
	DW	C_STOP			;Pop BC from return stack (=next)

W_2SWAP
	DB	$85,'2SWA','P'+$80
	DW	W_CPU
C_2SWAP
	DW	E_COLON			;Interpret following word sequence
	DW	C_ROT			;3rd valu down to top of stack
	DW	C_MOVER			;Move value from data to return stack
	DW	C_ROT			;3rd valu down to top of stack
	DW	C_RMOVE			;Move word from return to data stack
	DW	C_STOP			;Pop BC from return stack (=next)

W_2OVER
	DB	$85,'2OVE','R'+$80
	DW	W_2SWAP
C_2OVER
	DW	E_COLON			;Interpret following word sequence
	DW	C_MOVER			;Move value from data to return stack
	DW	C_MOVER			;Move value from data to return stack
	DW	C_2DUP			;Dup top 2 values on stack
	DW	C_RMOVE			;Move word from return to data stack
	DW	C_RMOVE			;Move word from return to data stack
	DW	C_2SWAP
	DW	C_STOP			;Pop BC from return stack (=next)

W_EXIT
	DB	$84,'EXI','T'+$80
	DW	W_2OVER
C_EXIT
	DW	X_STOP

W_J		;Push outer loop value on stack
	DB	$81,'J'+$80
	DW	W_EXIT
C_J
	DW	2+$			;Vector to code
	LD	HL,(RPP)		;Get return stack pointer
	INC	HL			;Skip inner loop values
	INC	HL			;
	INC	HL			;
	INC	HL			;
	JP	X_I2

W_ROLL
	DB	$84,'ROL','L'+$80
	DW	W_J
C_ROLL
	DW	E_COLON			;Interpret following word sequence
	DW	C_DUP			;Duplicate top value on stack
	DW	C_ZERO			;Put zero on stack
	DW	C_GREATER
	DW	C_0BRANCH		;Add offset to BC if stack top = 0
	DW	B003E-$			;002Ch
	DW	C_DUP			;Duplicate top value on stack
	DW	C_MOVER			;Move value from data to return stack
	DW	C_PICK
	DW	C_RMOVE			;Move word from return to data stack
	DW	C_ZERO			;Put zero on stack
	DW	C_SWAP			;Swap top 2 values on stack
	DW	C_LDO			;Put start & end loop values on RPP
B003F
	DW	C_SPFETCH		;Stack pointer onto stack
	DW	C_I			;Copy LOOP index to data stack
	DW	C_DUP			;Duplicate top value on stack
	DW	C_PLUS			;n1 + n2
	DW	C_PLUS			;n1 + n2
	DW	C_DUP			;Duplicate top value on stack
	DW	C_2MINUS		;2 minus
	DW	C_FETCH			;Get word from addr on stack
	DW	C_SWAP			;Swap top 2 values on stack
	DW	C_STORE			;Store word at addr
	DW	C_LIT			;Puts next 2 bytes on the stack
	DW	$FFFF
	DW	C_PLOOP			;Loop + stack & branch if not done
	DW	B003F-$			;FFE6h
B003E
	DW	C_DROP			;Drop top value from stack
	DW	C_STOP			;Pop BC from return stack (=next)

W_DEPTH
	DB	$85,'DEPT','H'+$80
	DW	W_ROLL
C_DEPTH
	DW	E_COLON			;Interpret following word sequence
	DW	C_S0			;Push S0 (initial data stack pointer)
	DW	C_FETCH			;Get word from addr on stack
	DW	C_SPFETCH		;Stack pointer onto stack
	DW	C_MINUS
	DW	C_2
	DW	C_DIV
	DW	C_1MINUS		;1 minus
	DW	C_STOP			;Pop BC from return stack (=next)

W_DLESSTHAN
	DB	$82,'D','<'+$80
	DW	W_DEPTH
C_DLESSTHAN
	DW	E_COLON			;Interpret following word sequence
	DW	C_ROT			;3rd valu down to top of stack
	DW	C_2DUP			;Dup top 2 values on stack
	DW	C_EQUALS
	DW	C_0BRANCH		;Add offset to BC if stack top = 0
	DW	B0040-$			;000Ah
	DW	C_2DROP			;Drop top two values from stack
	DW	C_ULESS			;IF stack-1 < stack_top leave true flag
	DW	C_BRANCH		;Add following offset to BC
	DW	B0041-$			;0008h
B0040
	DW	C_2SWAP
	DW	C_2DROP			;Drop top two values from stack
	DW	C_GREATER
B0041
	DW	C_STOP			;Pop BC from return stack (=next)

W_0GREATER
	DB	$82,'0','>'+$80
	DW	W_DLESSTHAN
C_0GREATER
	DW	E_COLON			;Interpret following word sequence
	DW	C_ZERO			;Put zero on stack
	DW	C_GREATER
	DW	C_STOP			;Pop BC from return stack (=next)

W_DOTS
	DB	$82,'.','S'+$80
	DW	W_0GREATER
C_DOTS
	DW	E_COLON			;Interpret following word sequence
	DW	C_CR			;Output [CR][LF]
	DW	C_DEPTH
	DW	C_0BRANCH		;Add offset to BC if stack top = 0
	DW	B0042-$			;0020h
	DW	C_SPFETCH		;Stack pointer onto stack
	DW	C_2MINUS		;2 minus
	DW	C_S0			;Push S0 (initial data stack pointer)
	DW	C_FETCH			;Get word from addr on stack
	DW	C_2MINUS		;2 minus
	DW	C_LDO			;Put start & end loop values on RPP
B0043
	DW	C_I			;Copy LOOP index to data stack
	DW	C_FETCH			;Get word from addr on stack
	DW	C_DOT
	DW	C_LIT			;Puts next 2 bytes on the stack
	DW	$FFFE
	DW	C_PLOOP			;Loop + stack & branch if not done
	DW	B0043-$			;FFF4h
	DW	C_BRANCH		;Add following offset to BC
	DW	S_END5-$		;0011h
B0042
	DW	C_CQUOTE		;Output following string
	DB	S_END5-S_START5
S_START5
	DB	'STACK EMPTY '
S_END5
	DW	C_STOP			;Pop BC from return stack (=next)

W_CODE
	DB	$84,'COD','E'+$80
	DW	W_DOTS
C_CODE
	DW	E_COLON			;Interpret following word sequence
	DW	C_QEXEC			;Error not if not in execute mode
	DW	C_XXX1
	DW	C_SPSTORE		;Set initial stack pointer value
	DW	C_STOP			;Pop BC from return stack (=next)

W_ENDCODE
	DB	$88,'END-COD','E'+$80
	DW	W_CODE
C_ENDCODE
	DW	E_COLON			;Interpret following word sequence
	DW	C_CURRENT
	DW	C_FETCH			;Get word from addr on stack
	DW	C_CONTEXT
	DW	C_STORE			;Store word at addr
	DW	C_QEXEC			;Error not if not in execute mode
	DW	C_WHATSTACK		;Check stack pointer, error if not ok
	DW	C_SMUDGE
	DW	C_STOP			;Pop BC from return stack (=next)

W_NEXT
	DB	$C4,'NEX','T'+$80
	DW	W_ENDCODE
C_NEXT
	DW	E_COLON			;Interpret following word sequence
	DW	C_LIT			;Puts next 2 bytes on the stack
	DW	$00C3			;Jump instruction
	DW	C_CCOMMA		;Save as 8 bit value
	DW	C_LIT			;Puts next 2 bytes on the stack
	DW	NEXT			;The address of NEXT
	DW	C_COMMA			;Reserve 2 bytes and save n
	DW	C_STOP			;Pop BC from return stack (=next)

W_IM2		;Set interrupt mode 2
	DB	$83,'IM','2'+$80
	DW	W_NEXT
C_IM2
	DW	2+$			;Vector to code
	IM	2			;Mode 2
	JP	NEXT

W_IM1		;Set interrupt mode 1
	DB	$83,'IM','1'+$80
	DW	W_IM2
C_IM1
	DW	2+$			;Vector to code
	IM	1			;Mode 1
	JP	NEXT

W_IM0		;Set interrupt mode 0
	DB	$83,'IM','0'+$80
	DW	W_IM1
C_IM0
	DW	2+$			;Vector to code
	IM	0			;Mode 0
	JP	NEXT

W_DI		;Disable interrupt
	DB	$82,'D','I'+$80
	DW	W_IM0
C_DI
	DW	2+$			;Vector to code
	DI				;Disable interrupt
	JP	NEXT

W_EI		;Enable interrupt
	DB	$82,'E','I'+$80
	DW	W_DI
C_EI
	DW	2+$			;Vector to code
	EI				;Enable interrupt
	JP	NEXT

W_MON		;Jump to m/c monitor
	DB	$83,'MO','N'+$80
	DW	W_EI
C_MON
	DW 	2+$
	JP	MONSTART

W_LLOAD
	DB	$85,'LLOA','D'+$80
	DW	W_MON
C_LLOAD
	DW	E_COLON			;Interpret following word sequence
	DW	C_BLOCK			;Get block address
	DW	C_LIT			;Enter loop with null
	DW	$0000			;
LL_BEGIN
	DW	C_DUP			;Dup key
	DW	C_0BRANCH		;If null then don't store
	DW	LL_NULL-$		;
	DW	C_DUP			;Dup key again
	DW	C_LIT			;Compare to [CR]
	DW	$000D			;
	DW	C_EQUALS		;
	DW	C_0BRANCH		;If not [CR] then jump
	DW	LL_STORE-$		;
	DW	C_DROP			;Drop the [CR]
	DW	C_CL			;Get characters per line
	DW	C_PLUS			;Add to current addr
	DW	C_CL			;Make CL MOD value
	DW	C_NEGATE		;Form 2s complement of n
	DW	C_AND			;Mask out bits
	DW	C_BRANCH		;Done this bit so jump
	DW	NO_STORE-$
LL_STORE
	DW	C_OVER			;Get address to store at
	DW	C_STORE			;Save chr
NO_STORE
	DW	C_1PLUS			;Next addres
	DW	C_BRANCH		;Done so jump
	DW	LL_CHAR-$		;
LL_NULL
	DW	C_DROP			;Was null so drop it
LL_CHAR
	DW	C_KEY			;Get key
	DW	C_DUP			;Duplicate it
	DW	C_LIT			;Compare with [CTRL] Z
	DW	$001A			;
	DW	C_EQUALS		;
	DW	C_0BRANCH		;If not EOF then jump
	DW	LL_BEGIN-$		;
	DW	C_DROP			;Drop EOF character
	DW	C_DROP			;Drop next address
	DW	C_STOP			;Pop BC from return stack (=next)

W_TASK
	DB	$84,'TAS','K'+$80
	DW	W_LLOAD
C_TASK
	DW	E_COLON			;Interpret following word sequence
	DW	C_STOP			;Pop BC from return stack (=next)
W_TASKEND

W_EDITI

W_CLEAR		;Clear block n
	DB	$85,'CLEA','R'+$80
	DW	W_TASK
C_CLEAR
	DW	E_COLON			;Interpret following word sequence
	DW	C_DUP			;Duplicate number
	DW	C_SCR			;Get SCR addr
	DW	C_STORE			;Store screen number
	DW	C_BLOCK			;Get the address of the block
	DW	C_BBUF			;Put number of bytes/block on stack
	DW	C_ERASE			;Clear the block
	DW	C_STOP			;Pop BC from return stack (=next)

CF_UKEY					;Get key onto stack
	DW	2+$			;Vector to code
	CALL	CHR_RD			;User key in routine
	LD	L,A			;Put key on stack
	LD	H,$00			;
	JP	NEXTS1			;Save & NEXT

CF_UEMIT				;Chr from stack to output
	DW	2+$			;Vector to code
	POP	HL			;Get CHR to output
	LD	A,L			;Put in A
	PUSH	BC			;Save regs
	PUSH	DE			;
	CALL	CHR_WR			;User output routine
	POP	DE			;Restore regs
	POP	BC			;
	JP	NEXT			;

CF_UCR					;CR output
	DW	2+$			;Vector to code
	PUSH	BC			;Save regs
	PUSH	DE			;Just in case
	LD	A,$0D			;Carrage return
	CALL	CHR_WR			;User output routine
	LD	A,$0A			;Line feed
	CALL	CHR_WR			;User output routine
	POP	DE			;Get regs back
	POP	BC			;
	JP	NEXT			;Next

CF_UQTERMINAL				;Test for user break
	DW	2+$			;Vector to code
	PUSH	BC			;Save regs
	PUSH	DE			;Just in case
	CALL	BREAKKEY		;User break test routine
	POP	DE			;Get regs back
	POP	BC			;
	LD	H,$00			;Clear H
	LD	L,A			;Result in L
	JP	NEXTS1			;Store it & Next

	;Serial I/O routines

; Change these to suit your target system .....

CHR_RD					;8251 Character in
	LD	A,(KEYBUF)		;Get key buffer
	OR	A			;Set flags
	JR	Z,NO_BUF_KEY		;If empty go wait for key
	LD	(KEYBUF+1),A		;Save key
	XOR	A			;Clear buffer
	LD	(KEYBUF),A		;
	LD	A,(KEYBUF+1)		;Get key back
	RET
NO_BUF_KEY
	IN	A,(URTCNT)		;Get status byte
	BIT	1,A			;Check buffer full bit
	JR	Z,NO_BUF_KEY		;Not full so wait
	IN	A,(URTDA)		;Get byte from buffer
	RET				;

BREAKKEY
	LD	A,(KEYBUF)		;Get buffer contents
	OR	A			;Set the flags
	JR	NZ,NO_KEY		;If buffer is full then exit
	IN	A,(URTCNT)		;Get status byte
	BIT	1,A			;Check buffer full bit
	JR	Z,NO_KEY		;Not full so go on
	IN	A,(URTDA)		;Get byte from buffer
	CP	$03			;Is it break
	JR	Z,WAS_BRK
	LD	(KEYBUF),A		;Not break so save key
NO_KEY
	XOR	A			;Wasn't break, or no key, so clear
	RET
WAS_BRK
	LD	A,$01			;Was break so set flag
	RET

CHR_WR					;8251 Character out
	AND	$7F			;Mask off top bit
	PUSH	AF			;Save byte for now
WAIT1
	IN	A,(URTCNT)
	BIT	0,A			;Check buffer full bit
	JR	Z,WAIT1			;Out buffer full so wait
	POP	AF			;Get byte back
	OUT	(URTDA),A		;Send byte
	RET				;

	END
