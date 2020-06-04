	.OPT	NOLIST
;-----------------------
;
;Scrolling Screen Editor
;for SNOWPLOW!
;
;by: Barry Kolbe
;and Bryan Schappel
;
;-----------------------
;
	*=	0
PASS	.=	PASS+1
	.IF	PASS=1
	.INCLUDE	#D:SYSEQU.M65
	.ENDIF
ICP	=	$3F
SCNMEM	=	$9000
PMB	=	$8000
MYPMB	=	$8400
P1MEM	=	MYPMB+$0100
CHSET	=	PMB
TXTWIN	=	$8B00
CHRLN1	=	TXTWIN+40
CHRLN2	=	TXTWIN
TXLN	=	TXTWIN+120
STSLN	=	TXTWIN+80
SC2	=	SCNMEM+128
SC3	=	SC2+128
SC4	=	SC3+128
SC5	=	SC4+128
SC6	=	SC5+128
SC7	=	SC6+128
SC8	=	SC7+128
SC9	=	SC8+128
SC10	=	SC9+128
BCKUP	=	$7FC0
;
	*=	$80
X1	.DS	1
X2	.DS	1
X3	.DS	1
PGT	.DS	1
CREG	.DS	1
PXP	.DS	2
PYP	.DS	1
NYP	.DS	1
DRX	.DS	2
DRY	.DS	2
NPTS	.DS	1
INITAB
SPRT	.DS	1
LRCRS	.DS	1
LRSCRL	.DS	1
UDSCRL	.DS	1
UDCRS	.DS	1
XPOS	.DS	1
YPOS	.DS	1
PCHR	.DS	1
CXPOS	.DS	1
LRADD	.DS	1
UDADD	.DS	1
XERXFLG	.DS	1
KCHRS	.DS	10
DBH	.DS	1
DBV	.DS	1
YH2	.DS	1
YH3	.DS	1
DLIDX	.DS	1
IL	.DS	2
JL	.DS	2
;
;Display List
;
	*=	$7F80
DL1	.BYTE	$70,$70,$70
	.BYTE	$45
SL1	.WORD	SCNMEM
	.BYTE	$45
	.WORD	SC2
	.BYTE	$45
	.WORD	SC3
	.BYTE	$45
	.WORD	SC4
	.BYTE	$45
	.WORD	SC5
	.BYTE	$45
	.WORD	SC6
	.BYTE	$45
	.WORD	SC7
	.BYTE	$45
	.WORD	SC8
	.BYTE	$45
	.WORD	SC9
	.BYTE	$45
	.WORD	SC10
	.BYTE	$C4
	.WORD	TXTWIN
	.BYTE	$82,$82,$02,$41
	.WORD	DL1
	.OPT	LIST
	.OPT	NOLIST
;
;Display List Interrupt
;
	*=	$3000
BEGIN	JMP	STRT
DLI	PHA
	LDA	#$E0
	STA	CHBASE
	LDA	#$0A
	STA	COLPF1
	TXA
	PHA
	LDX	DLIDX
	LDA	DLICL,X
	STA	COLPF2
	LDA	#0
	STA	COLBK
	STA	WSYNC
	INC	DLIDX
	PLA
	TAX
	PLA
	RTI
;
;Start of Program
;
STRT	LDY	#50
MDL	LDA	DL1,Y
	STA	BCKUP,Y
	DEY
	BPL	MDL
RSTRT	JSR	CLRSCN
RBEG	JSR	CLRTXT
	JSR	SETSTS
	JSR	PLRMEM
	JSR	SETPMG
	JSR	CLRPM
	JSR	DEFPLR
	LDA	#6
	LDY	#<VBI
	LDX	#>VBI
	JSR	SETVBV
;
	LDA	#>DL1
	STA	SDLSTL+1
	LDA	#<DL1
	STA	SDLSTL
	JSR	INIT
	JSR	SHWCRS
	JSR	SHWXY
	JSR	CHRCRS
;
;Try Stick
;
CHKSTK	LDA	STICK0
	CMP	#$0F
	BEQ	AKEY
	JSR	GENMOV
	JSR	TIME
	JMP	CHKSTK
AKEY	LDA	CH
	JSR	SWITCH
	BCC	AKEY
	CMP	#$FF
	BEQ	TRYTRG
	LDX	#$FF
	STX	CH
	LDY	#14
CKCMP	CMP	CMKEY,Y
	BEQ	GTCM
	DEY
	BPL	CKCMP
	BMI	TRYTRG
GTCM	TYA
	ASL	A
	TAX
	LDA	CMTAB,X
	STA	JMPOF+1
	LDA	CMTAB+1,X
	STA	JMPOF+2
	JSR	CLRLN1
JMPOF	JSR	$FFFF
	JSR	CLRLN1
	JSR	SHWXY
	JMP	AKEY
TRYTRG	LDA	STRIG0
	BNE	CHKSTK
	JSR	PLOT
	JMP	CHKSTK
;
;Immed. Vblank
;
VBI	LDY	#4
VBI1	LDA	COLOR0,Y
	STA	COLPF0,Y
	DEY
	BPL	VBI1
	LDA	#>CHSET
	STA	CHBASE
	INY
	STY	DLIDX
	JMP	SYSVBV
;
;General Move Routine
;
GENMOV	CMP	#7	;right?
	BNE	TLF
	JMP	MVRT
;
;Timer
;
TIME	JSR	DELAY
	JSR	SHWXY
	LDA	#0
	STA	ATRACT
	RTS
;
TLF	CMP	#11	;left?
	BNE	TUP
	JMP	MVLF
;
;Move Up
;
TUP	CMP	#14
	BNE	TDN
UP1	LDA	UDCRS
	BEQ	AA3	;scrol?
	DEC	UDCRS
	DEC	YPOS
	LDA	NYP
	SEC
	SBC	#16
	STA	NYP
TU1	JMP	UPDN
AA3	LDA	UDSCRL
	BEQ	NOUD
	DEC	UDSCRL
	DEC	YPOS
	JSR	SCRUP
NOUD	RTS
;
;Move Down
;
TDN	CMP	#13
	BNE	TUR
DN1	LDA	UDCRS
	CMP	#9
	BEQ	AA4	;scroll?
	INC	UDCRS
	INC	YPOS
	LDA	NYP
	CLC
	ADC	#16
	STA	NYP
	JMP	TU1
AA4	LDA	UDSCRL
	CMP	#9
	BEQ	NOUD
	INC	UDSCRL
	JSR	SCRDN
	INC	YPOS
	RTS
;Up-Right
TUR	CMP	#6
	BNE	TDR
	JSR	MVRT
	JMP	UP1
;Down-Right
TDR	CMP	#5
	BNE	TUL
	JSR	MVRT
	JMP	DN1
;Up-Left
TUL	CMP	#10
	BNE	TDL
	JSR	MVLF
	JMP	UP1
;Down-Left
TDL	CMP	#9
	BNE	NST
	JSR	MVLF
	JSR	DN1
NST	RTS
;
;Move Up and Down
;
UPDN	JSR	PLRMEM
	JSR	ERSPLR
	LDA	NYP
	STA	PYP
	JMP	PUTPLR
;
;Erase Player
;
ERSPLR	LDA	#0
	LDY	PYP
	LDX	#15
EML	STA	(IL),Y
	INY
	DEX
	BPL	EML
	RTS
;
;Set up Player Memory
;
PLRMEM	LDA	#>MYPMB
	STA	IL+1
	LDA	#0
	STA	IL
	RTS
;
;Move Right
;
MVRT	LDA	LRCRS
	CMP	#39
	BNE	AA1
	LDA	#1
	STA	LRADD
	LDA	LRSCRL
	CMP	#88	;end scrn
	BEQ	NOLR
	INC	LRSCRL
	INC	XPOS
	JSR	SCRLR
NOLR	RTS
AA1	INC	LRCRS
	INC	XPOS
	LDA	PXP
	CLC
	ADC	#4
	STA	PXP
MV1	LDA	PXP
	STA	HPOSP0
	RTS
;
;Move Left
;
MVLF	LDA	LRCRS
	BEQ	AA2
	DEC	LRCRS
	LDA	PXP
	SEC
	SBC	#4
	STA	PXP
	DEC	XPOS
	JMP	MV1
AA2	LDA	LRSCRL
	BEQ	NOLR
	DEC	LRSCRL
	DEC	XPOS
	LDA	#$FF
	STA	LRADD
	JMP	SCRLR
;
;Close IOCB
;
CLOSE	STX	X1
	LDA	#12
	STA	ICCOM,X
	JSR	CIOV
	LDX	X1
	RTS
;
;Set up PMG
;
SETPMG	LDA	#62
	STA	SDMCTL
	LDA	#1
	STA	GPRIOR
	LDA	#3
	STA	GRACTL
	LDA	#>PMB
	STA	PMBASE
	LDA	#$6C
	STA	PCOLR0
	LDA	#0
	STA	SIZEP0
	STA	SIZEP1
	RTS
;
;Clear P/M area
;
CLRPM	LDA	#>MYPMB
	STA	IL+1
	LDA	#0
	STA	IL
CA2	LDY	#0
CA1	STA	(IL),Y
	INY
	BNE	CA1
	RTS
;
;Define Players
;
DEFPLR	LDY	#$20
	STY	NYP
	STY	PYP
	JSR	PLRMEM
	JSR	PUTPLR
	LDA	#$2E
	STA	HPOSP0
	STA	PXP
	RTS
;
;Put Player on screen
;
PUTPLR	LDY	PYP
	LDX	#0
DF1	LDA	PL0DEF,X
	STA	(IL),Y
	INX
	INY
	CPX	#16
	BNE	DF1
	RTS
;
;Delay Loop
;
DELAY	LDX	#0
	STX	RTCLOK
YLP1	LDX	RTCLOK
	CPX	#4
	BNE	YLP1
	RTS
;
DLICL	.BYTE	$92,$42,$04
NBF	.BYTE	"000 "
A2I	.BYTE	$40,$00,$20,$60
PL0DEF	.BYTE	$FF,$C3,$C3,$C3
	.BYTE	$C3,$C3,$C3,$C3
	.BYTE	$C3,$C3,$C3,$C3
	.BYTE	$C3,$C3,$C3,$FF
P1DEF	.BYTE	$FC,$C6,$C6,$C6
	.BYTE	$C6,$C6,$C6,$FC
;
;Show Char Set
;
SHWCRS	LDX	SPRT
	INX
	TXA
	ASL	A
	ASL	A
	ASL	A
	ASL	A
	ASL	A
	TAX
	DEX
	TXA
	LDY	#31
SH1	STA	CHRLN1+4,Y
	STA	CHRLN2+4,Y
	DEX
	TXA
	DEY
	BPL	SH1
	RTS
;
;Init Memory
;
INIT	LDY	#25
	LDA	#0
INILP	STA	INITAB,Y
	DEY
	BPL	INILP
;set up 128
	LDY	#0
	TYA
	STA	M128L
	LDA	#>SCNMEM
	STA	M128H
TLP	LDA	M128L,Y
	CLC
	ADC	#128
	STA	M128L+1,Y
	LDA	M128H,Y
	ADC	#0
	STA	M128H+1,Y
	INY
	CPY	#33
	BNE	TLP
	JSR	OPNKEY
	LDA	#>CHSET
	STA	CHBAS
	LDA	#192
	STA	NMIEN
	LDA	#>DLI
	STA	VDSLST+1
	LDA	#<DLI
	STA	VDSLST
	RTS
;
;Plot a Character
;
PLOT	LDX	YPOS
	LDA	M128L,X
	STA	JL
	LDA	M128H,X
	STA	JL+1
	LDA	PCHR
	LDY	XPOS
	STA	(JL),Y
	RTS
;
STSCRL	LDA	#>SL1
	STA	JL+1
	LDA	#<SL1
	STA	JL
	RTS
;
;Scroll Left/right
;
SCRLR	JSR	STSCRL
	LDY	#0
SLR	LDA	(JL),Y
	CLC
	ADC	LRADD
	STA	(JL),Y
	INY
	INY
	INY
	CPY	#30
	BNE	SLR
	RTS
;
;Scroll Down
;
SCRDN	LDY	#0
SQ1	LDA	SL1+4,Y
	STA	SL1+1,Y
	LDA	SL1+3,Y
	STA	SL1,Y
	INY
	INY
	INY
	CPY	#27
	BNE	SQ1
	LDA	SL1+24
	CLC
	ADC	#$80
	STA	SL1+27
	LDA	SL1+25
	ADC	#0
	STA	SL1+28
	RTS
;
;Scroll Up
;
SCRUP	LDY	#27
SUP1	LDA	SL1-3,Y
	STA	SL1,Y
	LDA	SL1-2,Y
	STA	SL1+1,Y
	DEY
	DEY
	DEY
	BNE	SUP1
	LDA	SL1
	SEC
	SBC	#$80
	STA	SL1
	LDA	SL1+1
	SBC	#0
	STA	SL1+1
	RTS
;
;Clear Screen
;
CLRSCN	LDA	#>SCNMEM
	STA	IL+1
	LDA	#0
	STA	IL
	LDX	#9	;10 pages
CS1	LDY	#$FF
CSLP	STA	(IL),Y
	DEY
	CPY	#$FF
	BNE	CSLP
	INC	IL+1
	DEX
	BPL	CS1
	RTS
;
;Character Cursor
;
CHRCRS	LDY	#$FF	;erase
	LDA	#0
CR1	INY
	STA	P1MEM,Y
	CPY	#$FF
	BNE	CR1
;define playr
	LDY	#200
	LDX	#0
CR2	LDA	P1DEF,X
	STA	P1MEM,Y
	INY
	INX
	CPX	#8
	BNE	CR2
	LDA	#ICP
	STA	HPOSP0+1
	STA	PXP+1
	LDA	#$4D
	STA	PCOLR1
	RTS
;
;Move Character Cursor
;
KSELECT	LDX	#<CHRMES
	LDA	#>CHRMES
	JSR	PRINT
MVCRS	LDA	STICK0
	CMP	#$0F
	BNE	BH
	JMP	CKTRG2
BH	CMP	#7	;rt?
	BNE	ML
	LDA	CXPOS
	CMP	#31
	BEQ	BB
	INC	CXPOS
	LDA	PXP+1
	CLC
	ADC	#4
	JMP	BF
BB	LDA	#0
	STA	CXPOS
	LDA	#ICP
	BNE	BF
;
ML	CMP	#11	;lef?
	BNE	MU
	LDA	CXPOS
	BEQ	BE
	DEC	CXPOS
	LDA	PXP+1
	SEC
	SBC	#4
BF	STA	PXP+1
	STA	HPOSP0+1
	JMP	SLOW
BE	LDA	#31
	STA	CXPOS
	LDA	#187
	BNE	BF
;up
MU	CMP	#14
	BNE	MD
	LDA	SPRT
	BEQ	BC
	DEC	SPRT
DOC	JSR	SHWCRS
	JMP	SLOW
BC	LDA	#3
	STA	SPRT
	BNE	DOC
;
MD	CMP	#13
	BNE	CKTRG2
	INC	SPRT
	LDA	SPRT
	CMP	#4
	BNE	DOC
	LDA	#0
	STA	SPRT
	BEQ	DOC
;
CKTRG2	LDA	STRIG0
	BNE	SJ
	JSR	CLICK
	JSR	DELAY
CTR	LDA	STRIG0
	BEQ	CTR
	LDX	SPRT
	INX
	TXA
	ASL	A
	ASL	A
	ASL	A
	ASL	A
	ASL	A
	CLC
	ADC	CXPOS
	SEC
	SBC	#32
	STA	PCHR
	JMP	DELAY
SLOW	JSR	DELAY
SJ	JMP	MVCRS
;
;Print Text  x=lo,a=hi
;
PRINT	STX	IL
	STA	IL+1
	LDY	#$FF
MLP	INY
	LDA	(IL),Y
	STA	TXLN+2,Y
	BPL	MLP
	AND	#$7F
	STA	TXLN+2,Y
	RTS
;
CHRMES	.SBYTE	"Choose character"
COLMES	.SBYTE	"Color register 0-4"
DRWMES	.SBYTE	"Draw mode"
BLKMES	.SBYTE	"Block fill"
FNTMES	.SBYTE	"Loading font"
DEFMES	.SBYTE	"Define block"
STPMES	.SBYTE	"Copy block"
;
;clearline
;
CLRLN1	LDY	#39
	LDA	#0
CN1	STA	TXLN,Y
	DEY
	BPL	CN1
	RTS
;
;Clear Text Window
;
CLRTXT	LDY	#160
	LDA	#0
CTLP	STA	TXTWIN,Y
	DEY
	CPY	#$FF
	BNE	CTLP
	RTS
;
;colors
;
COLORS	LDX	#<COLMES
	LDA	#>COLMES
	JSR	PRINT
CKEY	LDA	CH
	LDX	#$FF
	CMP	#$FF
	BEQ	CKEY
	CMP	#$1C	;out
	BEQ	CA
	LDY	#4
CMS	CMP	CLRKEY,Y
	BEQ	CCC
	DEY
	BPL	CMS
	BMI	CKEY
CA	STX	CH
	RTS
CCC	LDA	CLREG,Y	;offset
	STA	CREG	;save it
	JSR	CLRLN1
;Change Register
	LDX	#<REGMES
	LDA	#>REGMES
	JSR	PRINT
	JSR	DISREG
	LDY	CREG
	LDA	COLOR0,Y
	PHA
	AND	#$F0
	STA	X2
	PLA
	AND	#$0F
	STA	X3
CSTK	LDA	STICK0
	CMP	#7	;rt
	BNE	CLF
	LDA	X2
	CLC
	ADC	#16
	STA	X2
	JMP	SCOLR
CLF	CMP	#11
	BNE	CUP
	LDA	X2
	SEC
	SBC	#16
	STA	X2
	JMP	SCOLR
CUP	CMP	#14
	BNE	CDN
	INC	X3
	INC	X3
	LDA	X3
	AND	#$0F
	STA	X3
	JMP	SCOLR
CDN	CMP	#13
	BNE	CSTG
	DEC	X3
	DEC	X3
	LDA	X3
	AND	#$0F
	STA	X3
SCOLR	LDA	X2
	ORA	X3
	LDY	CREG
	STA	COLOR0,Y
	JSR	DISREG
	JSR	DELAY
CSTG	LDA	STRIG0
	BNE	CSTK
CC2	LDA	STRIG0
	BNE	CC2
	RTS
;
CLRKEY	.BYTE	$32,$1F,$1E,$1A,$18
CLREG	.BYTE	0,1,2,3,4
;
;Show X/Y Position
;
SHWXY	LDA	XPOS
	LDX	#10
	JSR	RJUST
	LDA	YPOS
	LDX	#16
	JSR	RJUST
;
;Show character
;
	LDY	YPOS
	JSR	WHER
	LDY	XPOS
	LDA	(JL),Y
	STA	STSLN+22
;
NOERM	LDY	#3
NLP	LDA	NOM,Y
	STA	STSLN+31,Y
	DEY
	BPL	NLP
	RTS
;
;Right justify a number
;
RJUST	STA	FR0
	LDA	#0
	STA	FR0+1
	TXA
	PHA
	JSR	IFP
	JSR	FASC
	LDY	#2
	LDA	#'0
RJ1	STA	NBF,Y
	DEY
	BPL	RJ1
	LDY	#$FF
RJ2	INY
	LDA	(INBUFF),Y
	BPL	RJ2
	AND	#$7F
	STA	(INBUFF),Y
	INY
	TYA
	EOR	#3
	AND	#3
	TAX
	LDY	#0
RJ3	LDA	(INBUFF),Y
	STA	NBF,X
	INY
	INX
	CPX	#3
	BNE	RJ3
	LDY	#3
	PLA
	TAX
RJ4	LDA	NBF,Y
	AND	#$1F
	STA	STSLN,X
	DEX
	DEY
	BPL	RJ4
	RTS
;
;Set up Status Line
;
SETSTS	LDY	#39
	LDA	#0
STLP	STA	STSLN,Y
	DEY
	BPL	STLP
	LDY	#24
STLX	LDA	SLD,Y
	STA	STSLN+5,Y
	DEY
	BPL	STLX
	JMP	SHWXY
SLD	.SBYTE	"X:000 Y:000 CHAR:  "
	.SBYTE	"Error:"
;
WHER	LDA	M128L,Y
	STA	JL
	LDA	M128H,Y
	STA	JL+1
	RTS
;
DRAW	LDA	#$FF
	STA	NPTS
	LDA	#>DRWMES
	LDX	#<DRWMES
	JSR	PRINT
DRG	JSR	GETTWO
	BCS	DRP
DODRW	LDA	DRX
	CMP	DRX+1
	BEQ	DUD	;up/dn
	LDA	DRY
	CMP	DRY+1
	BNE	DRP
	LDA	DRX+1
	CMP	DRX
	BCS	DR5
	PHA
	LDA	DRX
	STA	DRX+1
	PLA
	STA	DRX
DR5	JSR	DRLR
	JMP	DRG
DRP	LDA	#$FF
	STA	CH
	RTS
;
;Up and Down
DUD	LDA	DRY+1
	CMP	DRY
	BEQ	DRP
	BCS	UYOK
	PHA
	LDA	DRY
	STA	DRY+1
	PLA
	STA	DRY
UYOK	JSR	DWUD
	JMP	DRP
;
;Do Up/Down Draw
DWUD	LDY	DRY+1
DDB	JSR	WHER
	LDY	DRX
	LDA	PCHR
	STA	(JL),Y
	DEC	DRY+1
	LDY	DRY+1
	CPY	DRY
	BNE	DDB
	JSR	WHER
	LDY	DRX
	LDA	PCHR
	STA	(JL),Y
	RTS
;
;Draw left and right
DRLR	LDY	DRY
	JSR	WHER
	LDY	DRX+1
	LDA	PCHR
DR7	STA	(JL),Y
	DEY
	CPY	DRX
	BNE	DR7
	STA	(JL),Y
DR8	RTS
;
;Click Speaker
;
CLICK	LDA	#0
	STA	CONSOL
	RTS
;
BLOCK	LDA	#$FF
	STA	NPTS
	LDA	#>BLKMES
	LDX	#<BLKMES
	JSR	PRINT
	JSR	GETTWO
	BCC	BAB
BAC	RTS
BAB	LDA	DRX+1
	CMP	DRX
	BEQ	BAC
	BCC	BAC
	LDA	DRY+1
	CMP	DRY
	BEQ	BAC
	BCC	BAC
	INC	DRY+1
BAD	JSR	DRLR
	INC	DRY
	LDA	DRY
	CMP	DRY+1
	BNE	BAD
	BEQ	BAC
;
;Get two screen Positions
GETTWO	LDA	#$FF
	STA	NPTS
GTWO	LDA	CH
	CMP	#$1C
	BNE	DRS
	LDA	#$FF
	STA	CH
	SEC
	RTS
DRS	LDA	STICK0
	CMP	#$0F
	BEQ	DRU
	JSR	GENMOV
	JSR	TIME
DRU	LDA	STRIG0
	BNE	GTWO
	JSR	CLICK
REL	LDA	STRIG0
	BEQ	REL
	INC	NPTS
	LDY	NPTS
	LDA	XPOS
	STA	DRX,Y
	LDA	YPOS
	STA	DRY,Y
	LDA	NPTS
	CMP	#1
	BEQ	GOM
	JMP	GTWO
GOM	CLC
	RTS
CMTAB	.WORD	KSELECT
	.WORD	COLORS
	.WORD	DRAW
	.WORD	BRIGHT
	.WORD	BLOCK
	.WORD	FONT
	.WORD	LOADM
	.WORD	SAVEM
	.WORD	QUIT
	.WORD	CLRMAP
	.WORD	RESTART
	.WORD	HOME
	.WORD	DEFINE
	.WORD	XEROX
	.WORD	DEFKEY
;
CMKEY	.BYTE	$05,$12,$3A,$0A
	.BYTE	$15,$38,$00,$3E,$2F
	.BYTE	$B6,$B9,$39,$25
	.BYTE	$16,$2D
;k c d q clr ^h h m x t
;
;Change Luminance of Player
;
BRIGHT	LDA	PCOLR0
	EOR	#$0E
	STA	PCOLR0
	RTS
;
;Load Font
;
FONT	LDX	#<FNTMES
	LDA	#>FNTMES
	JSR	PRINT
	JSR	GTNAME
	BCC	FAA
	RTS
FAA	LDX	#$10
	JSR	CLOSE
	LDA	#3
	STA	ICCOM,X
	LDA	#>FNAME
	STA	ICBAH,X
	LDA	#<FNAME
	STA	ICBAL,X
	LDA	#0
	STA	AUX2,X
	LDA	#4
	STA	AUX1,X
	JSR	CIOV
	BPL	FAB
FAC	STY	X2
	JMP	IOERR
FAB	LDA	#7
	STA	ICCOM,X
	LDA	#>CHSET
	STA	ICBAH,X
	LDA	#0
	STA	ICBAL,X
	LDA	#4
	STA	ICBLH,X
	LDA	#0
	STA	ICBLL,X
	JSR	CIOV
	STY	X2
	BMI	IOERR
	LDX	#$10
	JSR	CLOSE
	JMP	NOERM
;
IOERR	LDX	#$10
	JSR	CLOSE
	JSR	ZFR0
	LDA	X2
	LDX	#34
	JSR	RJUST
	JMP	GETKEY
;
;Open keyboard
;
OPNKEY	LDX	#$20
	JSR	CLOSE
	LDA	#3
	STA	ICCOM,X
	LDA	#>KDEV
	STA	ICBAH,X
	LDA	#<KDEV
	STA	ICBAL,X
	LDA	#0
	STA	AUX2,X
	LDA	#4
	STA	AUX1,X
	JMP	CIOV
;
NOM	.SBYTE	+$80,"None"
KDEV	.BYTE	"K:",EOL
;
;Get a Key from CIO
GETKEY	LDA	#0
	LDX	#$20
	STA	ICBLL,X
	STA	ICBLH,X
	LDA	#7
	STA	ICCOM,X
	JMP	CIOV
;
;Get filename
;
GTNAME	LDY	#0
	TYA
GT1	STA	TXLN+18,Y
	INY
	CPY	#13
	BNE	GT1
	LDA	#$24
	STA	TXLN+16
	LDA	#$1A
	STA	TXLN+17
	LDX	#0
INLP	STX	X3
	LDA	#$3F
	STA	TXLN+18,X	;cursor
	LDA	#0
	STA	694
	LDA	#64
	STA	702
	JSR	GETKEY
	LDX	X3
	CMP	#$1B
	BNE	GT2
	SEC
	RTS
GT2	CMP	#$9B
	BEQ	INEOL
	AND	#$7F
	CMP	#$20
	BCC	INLP
	CMP	#126
	BNE	INEXT
	CPX	#0
	BEQ	INLP
	DEX
	LDA	#0
	STA	TXLN+18,X
	STA	TXLN+19,X
	BEQ	INLP
;
INEXT	CMP	#96
	BEQ	INLP
	CMP	#123
	BCS	INLP
	CPX	#13
	BEQ	INLP
	PHA
	STA	FNAME+2,X
	ROL	A
	ROL	A
	ROL	A
	ROL	A
	AND	#3
	TAY
	PLA
	AND	#$9F
	ORA	A2I,Y
	STA	TXLN+18,X
	INX
	BNE	INLP
;
INEOL	STA	FNAME+2,X
	CLC
	RTS
;
;Show color register
;
DISREG	LDY	CREG
RGD	LDA	CRG1,Y
	STA	TXLN+11
	LDA	CRG2,Y
	STA	TXLN+12
	LDA	COLOR0,Y
	PHA
	AND	#$F0
	LSR	A
	LSR	A
	LSR	A
	LSR	A
	JSR	HEX
	STA	TXLN+19
	PLA
	AND	#$0F
	JSR	HEX
	STA	TXLN+27
	RTS
;
HEX	TAX
	LDA	HEXB,X
	RTS
;
HEXB	.SBYTE	"0123456789ABCDEF"
;
CRG1	.SBYTE	"00111"
CRG2	.SBYTE	"89012"
REGMES	.SBYTE	" Color: 7   Hue:$   Lum:$"
;
;Load a Map
LOADM	LDA	#4	;read
	STA	X2
	LDA	#7
	STA	PGT
	LDA	#>LODMES
	LDX	#<LODMES
INLOD	JSR	PRINT
	JSR	GTNAME
	BCC	NMOK
	RTS
NMOK	LDX	#$10
	JSR	CLOSE
	LDA	X2
	STA	AUX1,X
	LDA	#3
	STA	ICCOM,X
	LDA	#>FNAME
	STA	ICBAH,X
	LDA	#<FNAME
	STA	ICBAL,X
	LDA	#0
	STA	AUX2,X
	JSR	CIOV
	BPL	RWOK
	STY	X2
RWER	JMP	IOERR
RWOK	LDX	#$10
	LDA	#>SCNMEM
	STA	ICBAH,X
	LDA	#<SCNMEM
	STA	ICBAL,X
	LDA	#0
	STA	ICBLL,X
	LDA	#10
	STA	ICBLH,X
	LDA	PGT
	STA	ICCOM,X
	JSR	CIOV
	STY	X2
	BMI	RWER
	LDX	#$10
	JSR	CLOSE
	JMP	NOERM
;
;Save a map
;
SAVEM	LDA	#8	;write
	STA	X2
	LDA	#11
	STA	PGT
	LDA	#>SAVMES
	LDX	#<SAVMES
	JMP	INLOD
;
;quit
QUIT	LDA	#>QUTMES
	LDX	#<QUTMES
	JSR	PRINT
	JSR	SURE
	BCS	NOQ
	PLA
	PLA
	JSR	MOVEB
	LDA	#0
	STA	HPOSP0
	STA	HPOSP0+1
	LDA	#6
	LDY	#<SYSVBV
	LDX	#>SYSVBV
	JSR	SETVBV
	JMP	WARMSV
NOQ	RTS
;
;Clear Map
CLRMAP	LDA	#>SURMES
	LDX	#<SURMES
	JSR	PRINT
	JSR	SURE
	BCS	ERT
	JSR	CLRSCN
ERT	RTS
;
;sure?
SURE	LDA	CH
	LDX	#$FF
	CMP	#$23
	BEQ	NO
	CMP	#$2B
	BNE	SURE
	STX	CH
	CLC
	RTS
NO	STX	CH
	SEC
	RTS
LODMES	.SBYTE	"Loading file"
SAVMES	.SBYTE	"Saving file"
SURMES	.SBYTE	"CLEAR! Are you sure Y/N"
QUTMES	.SBYTE	"QUIT! Are you sure Y/N"
;
;restart
RESTART	JSR	MOVEB
	PLA
	PLA
	JMP	RSTRT
;
;home
HOME	JSR	MOVEB
	PLA
	PLA
	JMP	RBEG
;
;Get Display List back
MOVEB	LDY	#50
MDLB	LDA	BCKUP,Y
	STA	DL1,Y
	DEY
	BPL	MDLB
	RTS
;
;Define block
DEFINE	LDA	#>DEFMES
	LDX	#<DEFMES
	JSR	PRINT
	LDA	#$FF
	STA	NPTS
	JSR	GETTWO
	BCC	DFJ
DFR	RTS
DFJ	LDA	DRY+1
	SEC
	SBC	DRY
	CMP	#10
	BCS	DFR
	TAX		;keep
	LDA	DRX+1
	SEC
	SBC	DRX
	CMP	#10
	BCS	DFR
	STA	DBH
	STX	DBV
	LDA	#0
	STA	YH3
	LDA	DRX
	STA	YH2
	INC	DRX+1
	INC	DRY+1
DFK	LDY	DRY
	JSR	WHER
DFL	LDY	YH2
	LDA	(JL),Y
	LDY	YH3
	STA	DEFBLK,Y
	INC	YH3
	INC	YH2
	LDA	YH2
	CMP	DRX+1
	BNE	DFL
	LDA	DRX
	STA	YH2
	INC	DRY
	LDA	DRY
	CMP	DRY+1
	BNE	DFK
	LDA	#1
	STA	XERXFLG	;set flag
	RTS
;
;xerox
XEROX	LDA	XERXFLG	;chk if
	BNE	XEROX1	;block defined
	RTS
XEROX1	LDA	#>STPMES
	LDX	#<STPMES
	JSR	PRINT
XST	LDA	STICK0
	CMP	#$0F
	BEQ	XKY
	JSR	GENMOV
	JSR	TIME
XKY	LDA	CH
	CMP	#$1C
	BNE	XTRG
	LDA	#$FF
	STA	CH
	RTS
XTRG	LDA	STRIG0
	BNE	XST
	JSR	CLICK
XT2	LDA	STRIG0
	BEQ	XT2
	JSR	DELAY
	LDA	XPOS
	STA	DRX
	STA	YH3
	CLC
	ADC	DBH
	STA	DRX+1
	INC	DRX+1
	CMP	#128
	BCC	XAA
XAB	RTS
XAA	LDA	YPOS
	STA	DRY
	CLC
	ADC	DBV
	STA	DRY+1
	INC	DRY+1
	CMP	#18
	BCS	XAB
;do xerox
	LDA	#0
	STA	YH2
XLQ	LDY	DRY
	JSR	WHER
XLP	LDY	YH2
	LDA	DEFBLK,Y
	LDY	YH3
	STA	(JL),Y
	INC	YH3
	INC	YH2
	LDA	YH3
	CMP	DRX+1
	BNE	XLP
	LDA	DRX
	STA	YH3
	INC	DRY
	LDA	DRY
	CMP	DRY+1
	BNE	XLQ
	RTS
;
;Define a key
DEFKEY	JSR	KSELECT
	LDA	#>KEYMES
	LDX	#<KEYMES
	JSR	PRINT
DKEY	LDA	CH
	CMP	#$FF
	BEQ	DKEY
	CMP	#$1C
	BNE	DKO
	RTS
DKO	LDY	#9
DK2	CMP	KEYK,Y
	BEQ	DK3
	DEY
	BPL	DK2
	BMI	DKEY
DK3	LDA	PCHR
	STA	KCHRS,Y
	RTS
;
KEYMES	.SBYTE	"  Define 1-0               "
;
KEYK	.BYTE	$1F,$1E,$1A,$18
	.BYTE	$1D,$1B,$33,$35
	.BYTE	$30,$32
;
;Switch keys
;
SWITCH	LDY	#9
SW1	CMP	KEYK,Y
	BEQ	SW2
	DEY
	BPL	SW1
	SEC
	RTS
SW2	LDA	KCHRS,Y
	STA	PCHR
	LDA	#$FF
	STA	CH
	CLC
	RTS
FNAME	.BYTE	"D:"
;
	.DS	15
M128L	.DS	36
M128H	.DS	36
DEFBLK	.DS	120
	*=	$02E0
	.WORD	BEGIN
