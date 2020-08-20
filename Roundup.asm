;------------------------
;ROUNDUP by RICHARD LOKEN
;------------------------

; EQUATES FOR "ROUNDUP"

DMACTL	=	$22F
CHBASE	=	$2F4
POKMSK	=	16
RTCLOC	=	18
ATRACT	=	77
VDSLST	=	512
CDTMV2	=	538
CDTMA1	=	552
VVBLKI	=	546
SDMCTL	=	559
SDLSTL	=	560
GPRIOR	=	623
STRIG	=	$284
STRIG0	=	644
PCOLR0	=	704
PCOLR1	=	705
PCOLR2	=	706
PCOLR3	=	707
COLOR0	=	708
COLOR1	=	709
COLOR2	=	710
COLOR3	=	711
COLOR4	=	712
CHBAS	=	756
HPOSP0	=	$D000
M0PF	=	$D000
HPOSP1	=	$D001
M1PF	=	$D001
HPOSP2	=	$D002
M2PF	=	$D002
HPOSP3	=	$D003
M3PF	=	$D003
HPOSM0	=	$D004
P0PF	=	$D004
HPOSM1	=	$D005
P1PF	=	$D005
HPOSM2	=	$D006
P2PF	=	$D006
HPOSM3	=	$D007
P3PF	=	$D007
M0PL	=	$D008
SIZEP0	=	$D008
M1PL	=	$D009
SIZEP1	=	$D009
M2PL	=	$D00A
SIZEP2	=	$D00A
M3PL	=	$D00B
SIZEP3	=	$D00B
P0PL	=	$D00C
SIZEM	=	$D00C
P1PL	=	$D00D
P2PL	=	$D00E
P3PL	=	$D00F
TRIG0	=	$D010
PRIOR	=	$D01B
GRACTL	=	$D01D
HITCLR	=	$D01E
CONSOL	=	$D01F
AUDF1	=	$D200
AUDC1	=	$D201
AUDF2	=	$D202
AUDC2	=	$D203
AUDF3	=	$D204
AUDC3	=	$D205
AUDF4	=	$D206
AUDC4	=	$D207
AUDCTL	=	$D208
STIMER	=	$D209
RANDOM	=	$D20A
PORTA	=	$D300
PACTL	=	$D302
HSCROL	=	$D404
PMBASE	=	$D407
WSYNC	=	$D40A
VCOUNT	=	$D40B
NMIEN	=	$D40E
SETVBV	=	$E45C
SYSVBV	=	$E45F
XITVBV	=	$E462
CGREY	=	$00
CGOLD	=	$10
CORANG	=	$20
CREDOR	=	$30
CPINK	=	$40
CPURPL	=	$50
CPURBL	=	$60
CBLUE1	=	$70
CBLUE2	=	$80
CLBLUE	=	$90
CTURQO	=	$A0
CGRNBL	=	$B0
CGREEN	=	$C0
CYEGRN	=	$D0
CORGRN	=	$E0
CLORNG	=	$F0

COLBK	=	$2C8

MYPMB	=	$0000
MISSIL	=	$0300
PL0	=	$0400
PL1	=	$0500
PL2	=	$0600
PL3	=	$0700
CHSET	=	$0800

;These memory areas are reserved for
;the scrolling cow lines.  They are
;aligned on 256-byte boundaries for
;ease of use.

COW	=	$3600	;3 COWS
COW.A	=	$3700	;2 COWS
COW.B	=	$3800	;1 COW
ANG	=	$3900	;LONE ANGUS

	ORG	$2000

;the display list interupt stuffs
;the cow color and fine scrolling
;data into the hardware
;also checks herding and lasso
;collisions - sets flags for
;other routines to process

DLI	PROC
	PHA	; save all registers
	TXA
	PHA
	TYA
	PHA
	LDX	LINECT	; get DLI counter
	LDA	LNSC1,X	; get fscrol for line
	LDY	LNCOL1,X	; get line color
	STA	WSYNC
	STA	HSCROL	; and stuff them into
	STY	$D016	; the hardware

; check for hits on cows

	LDA	P3PF
	BEQ	:L3
	LDA	#1
	STA	HIT-1,X
	BNE	:L2

; check for herding

:L3	LDA	LMSHI-1,X
	CMP	#HIGH ANG
	BEQ	:L2
	LDA	P0PF	; get the coll. reg.
	ORA	P2PF
	BEQ	:L2	; if zero then no coll.
	LDA	LFRT-1,X
	BEQ	:L2
	LDA	#0	; yes, a coll. ; change
	STA	LFRT-1,X	; dir. of prev. ln
	INC	NUMHRD-1,X
:L2	STA	HITCLR	; and clear hit

; finish DLI

	INX
	CPX	#9	; 8 is too many
	BNE	:L
	LDX	#0
:L	STX	LINECT
	PLA
	TAY
	PLA
	TAX
	PLA
	RTI
COWLFT	DB	3
	DB	0
NUMHRD	DB	0,0,0,0,0,0,0,0
	DB	0,0
HIT	DB	0,0,0,0,0,0,0,0

;program begins and restarts here

START	PROC
	LDX	#0	; TRANSFER CHARACTER SET
:L	LDA	$E000,X
	STA	CHSET,X
	LDA	$E100,X
	STA	CHSET+$FF,X
	LDA	$E200,X
	STA	CHSET+$1FF,X
	LDA	$E300,X
	STA	CHSET+$2FF,X
	INX
	BNE	:L
	LDA	#HIGH CHSET	;INSTALL CHAR SET
	STA	CHBAS
	LDX	#0	; ALTER CHARACTER SET
:L1	LDA	FNCE,X
	STA	CHSET+8,X
	INX
	CPX	#$10
	BNE	:L1
	LDX	#0
:L2	LDA	COW1,X
	STA	CHSET+$18,X
	INX
	CPX	#$10
	BNE	:L2
	LDX	#0
:L5	LDA	ANGUS,X
	STA	CHSET+$28,X
	INX
	CPX	#$10
	BNE	:L5
	LDX	#0	; CLEAR P/M AND COW LINES
	TXA
:L3	STA	MISSIL,X
	STA	PL0,X
	STA	PL1,X
	STA	PL2,X
	STA	PL3,X
	STA	COW,X
	STA	COW.A,X
	STA	COW.B,X
	STA	ANG,X
	INX
	BNE	:L3

;now set up the character bytes in the
;cow lines that represent the cows.

	LDA	#3
	STA	COW+26
	STA	COW+29
	STA	COW+32
	STA	COW.A+29
	STA	COW.A+32
	STA	COW.B+32
	LDA	#4
	STA	COW+27
	STA	COW+30
	STA	COW+33
	STA	COW.A+30
	STA	COW.A+33
	STA	COW.B+33
	LDA	#5
	STA	ANG+26
	LDA	#6
	STA	ANG+27
	JSR	INILMS
	LDA	#LOW DLI	; install DLI
	STA	VDSLST
	LDA	#HIGH DLI
	STA	VDSLST+1
	LDA	#$C0	;ENABLE DLI
	STA	NMIEN
	LDA	#$3F	; EN.SIN RES + WIDE PF
	STA	SDMCTL
	LDA	#3	; ENABLE P/M
	STA	GRACTL
	LDA	#LOW DISPL	; install DISPLIST
	STA	SDLSTL
	LDA	#HIGH DISPL
	STA	SDLSTL+1
	LDA	#$11	; $11 for 5th player
	STA	GPRIOR
	LDA	#$C6
	STA	COLOR4
	LDA	#$D0	; horse is
	STA	PCOLR1
	STA	PCOLR2
	LDA	#$A	; rider and lasso
	STA	PCOLR0
	STA	PCOLR3
	STA	COLOR3
	LDA	#$A8
	STA	COLOR0
	LDA	#$E4
	STA	COLOR1
	LDA	#$16
	STA	COLOR2
	LDA	#0	; rider is narrow
	STA	SIZEP0
	LDA	#1	; horse is medium
	STA	SIZEP1
	STA	SIZEP2
	LDA	#1	; lasso is MEDIUM
	STA	SIZEP3
	LDA	#$FF
	STA	STIMER
	STA	SIZEM
	LDA	#$30	; enable joystick
	STA	PACTL
	LDA	#$F0
	STA	PORTA
	LDA	#$34
	STA	PACTL
	LDA	#HIGH MYPMB
	STA	PMBASE
	LDA	#60
	STA	HPOSP0
	LDA	#48
	STA	HPOSP1
	LDA	#64
	STA	HPOSP2
	LDA	#68
	STA	HPOSM3	; lasso hpos
	LDA	#76
	STA	HPOSM2
	LDA	#84
	STA	HPOSM1
	LDA	#92
	STA	HPOSM0
	LDA	#100
	STA	HPOSP3
	LDA	#100
	STA	VPOSP0
	LDA	#0
	STA	$D208
	LDA	#3
	STA	$D20F
	LDA	#100
	STA	AUDF1
	LDA	#30
	STA	AUDF2
	LDA	#200
	STA	AUDF4
	JSR	CWPKLD
	JSR	CHEKST
	JSR	INICOL
	LDA	#0
	STA	GAMEND
:L10	LDA	VCOUNT
	CMP	#$19
	BNE	:L10
	LDA	#LOW VBLANK
	STA	VVBLKI
	LDA	#HIGH VBLANK
	STA	VVBLKI+1

;most processor time is spent waiting
;for the next VBLANK. mnloop handles
;the stick,lasso, and player image
;lasso in progress will mask the
;stick handler

MNLOOP
	PROC
	LDA	#1
	STA	VBDONE
:L	LDA	VBDONE
	BNE	:L
	LDA	GAMEND
	BEQ	:L3
	JMP	NEWGAM
:L3	LDA	LASTAT
	BNE	:L2
	JSR	UPDOWN
:L2	JSR	ROPEM
	JSR	CWPKLD
	JMP	MNLOOP

;simple display list with lms and
;hscrol enable and dli on each line

DISPL	DB	$70,$70,$80,$60,$57
LMS1	DW	FENCE
	DB	$80,$50,$57
CW1	DW	COW
	DB	$80,$50,$57
CW2	DW	COW
	DB	$80,$50,$57
CW3	DW	COW
	DB	$80,$50,$57
CW4	DW	COW
	DB	$80,$50,$57
CW5	DW	COW
	DB	$80,$50,$57
CW6	DW	COW
	DB	$80,$50,$57
FN1	DW	FENCE
	DB	$80,$50,$46
SCRLN	DW	SCORLN
	DB	$41
	DW	DISPL

;checks for hi score and sets score
;for end of game score line

CHKHSC	PROC
	LDX	#0
:L	LDA	SCORE,X
	CMP	HSCR,X
	BEQ	:L1
	BCC	:L2
	BCS	:L3
:L1	INX
	CPX	#6
	BNE	:L
:L3	LDX	#0
:L4	LDA	SCORE,X
	STA	HSCR,X
	INX
	CPX	#6
	BNE	:L4
:L2	LDX	#0
:L5	LDA	SCORE,X
	STA	SCR1,X
	INX
	CPX	#6
	BNE	:L5
	LDA	#LOW HSCRL
	STA	SCRLN
	LDA	#HIGH HSCRL
	STA	SCRLN+1
	RTS

HSCRL	DB	0,0,0,0,0
SCR1	DB	$10,$10,$10,$10,$10,$10
	DB	0,0
HSCR	DB	$10,$10,$10,$10,$10,$10
	DB	0,0,0,0,0,0,0,0

;reads stick for up/down and sets
;vposp0 for CWPKLD

UPDOWN	PROC
	LDA	PORTA
	CMP	#$F
	BEQ	:L
	LDA	#0
	STA	ATRACT
	LDA	PORTA
	CMP	#14	; GO UP ?
	BEQ	UP
	CMP	#13	; GO DOWN ?
	BNE	:L
DOWN	LDA	VPOSP0
	CMP	#152
	BEQ	:L
	INC	VPOSP0
	INC	VPOSP0
:L	RTS
UP	LDA	VPOSP0
	CMP	#50
	BEQ	:L
	DEC	VPOSP0
	DEC	VPOSP0
	RTS

;updates horse + cowboy whether it
;needs it or not and animates horse

CWPKLD	PROC
	DEC	HRSCTR
	BMI	:L
	JMP	:L1
:L	LDA	#4
	STA	HRSCTR
	LDX	HRSAV
	LDA	HS,X
	STA	:L5+1
	INX
	LDA	HS,X
	STA	:L5+2
	INX
	LDA	HS,X
	STA	:L6+1
	INX
	LDA	HS,X
	STA	:L6+2
	INX
	CPX	#12
	BNE	:L2
	LDX	#0
:L2	STX	HRSAV
:L1	LDY	VPOSP0
	LDX	#0
:L3	LDA	COWBOY,X
	STA	PL0,Y
	INY
	INX
	CPX	#35
	BNE	:L3
	LDA	VPOSP0
	CLC
	ADC	#17
	TAY
	LDX	#0
:L5	LDA	$FFFF,X
	STA	PL1,Y
:L6	LDA	$FFFF,X
	STA	PL2,Y
	INY
	INX
	CPX	#26
	BNE	:L5
	RTS
	EPROC

;image data for cowboy and horse

COWBOY	DB	0,0,$26,$36,$32,$32
	DB	$7A,$32,$32,$22,$26,$7C
	DB	$78,$70,$70,$70,$70,$70
	DB	$70,$70,$70,$70,$38,$3E
	DB	$1F,3,3,3,6,$C,4,2,0,0
H1A	DB	0,0,0,0,0,$F,$1F,$3F
	DB	$5F,$5F,$5F,$5F,$5F,$1F
	DB	$10,$30,$30,$30,$50,$A0
	DB	$20,$40,0,0,0
H1B	DB	0,0,8,$1C,$1C,$FE,$FE
	DB	$F6,$F2,$F0,$E0,$E0,$E0
	DB	$E0,$30,$38,$C,4,4,8,8
	DB	0,0,0,0
H2A	DB	0,0,0,0,0,$F,$1F,$3F
	DB	$5F,$5F,$5F,$9F,$9F,$1F
	DB	$18,$18,$18,$28,$28,$28
	DB	$48,$50,$50,0,0
H2B	DB	0,0,8,$1C,$1C,$FE,$FE
	DB	$F6,$F2,$F2,$E0,$E0,$E0
	DB	$E0,$20,$20,$20,$20,$50
	DB	$50,$50,$50,$40,0,0
H3A	DB	0,0,0,0,0,$F,$1F,$3F,$5F
	DB	$5F,$5F,$5F,$5F,$1F,$18,8
	DB	8,8,8,8,5,5,4,0,0
H3B	DB	0,0,8,$1C,$1C,$FE,$FE
	DB	$F6,$F2,$F0,$E0,$E0,$E0
	DB	$E0,$60,$60,$60,$A0,$A0
	DB	$A0,$20,$40,0,0,0
HRSAV	DB	0
HS	DW	H1A
	DW	H1B
	DW	H2A
	DW	H2B
	DW	H3A
	DW	H3B
HRSCTR	DB	0
FNCE	DB	0,$FF,3,6,$FF,$18,$30,$60
	DB	0,$FF,0,0,$FF,0,0,0
COW1	DB	0,0,$F,$1F,$2F,$CC,$A,$A
	DB	0,4,$FE,$F0,$F0,$30,$48,8
COW2	DB	0,$80,$4F,$3F,$1F,$1C,$64,6
	DB	0,$C,$FE,$F0,$F0,$30,$28,$28
COW3	DB	0,0,$F,$7F,$8F,$C,$14,$14
	DB	0,$C,$FE,$F0,$F0,$18,$14,$10
ANGUS	DB	$20,$70,$1F,$1F,$F,$B,8,8
	DB	0,0,$E0,$F0,$E8,$A8,$20,$20
SCORLN	DB	0,0,51,35,47,50,37,0
SCORE	DB	16,16,16,16,16,16,0
	DB	35,47,55,51,0
CWLEFT	DB	19,0,0,0
	DB	0,0,0,0,0,0,0,0,0,0,0,0
FENCE	DB	1,2,1,2,1,2,1,2,1,2
	DB	1,2,1,2,1,2,1,2,1,2,1,2
	DB	1,2,1,2,1,2,1,2,1,2,1,2
VPOSP0	DB	0

;animates cows in character set

ANIMATE	PROC
	LDX	CHINDX
	CPX	#$30
	BNE	:L
	LDX	#0
:L	LDY	#0
:L1	LDA	COW1,X
	STA	CHSET+$18,Y
	INX
	INY
	CPY	#$10
	BNE	:L1
	STX	CHINDX
	RTS
CHINDX	DB	0,0,0
LINECT	DB	0,0,0
LNSC1	DB	0,0,0,0,0,0,0,0,0
LNCOL1	DB	0,0,0,0,0,0,0,0,$C
LN1SP	DB	0,6,2,4,4,1,2,0,0,0
LFRT	DB	1,1,0,1,0,1,0,1,0,0
SLMS1	DB	0,0,0,0,0,0,0,0

;controls speed of character anima-
;tion and processes fine and coarse
;scrolling
;updates three clocks which are used
;by other routines

VBLANK	PROC
	LDA	#0
	STA	VBDONE
	INC	VBCTR
	INC	VBCTR1
	INC	VBCTR2
	LDA	GAMEND
	BEQ	:L14
	JMP	SYSVBV
:L14	LDA	SSPEED	; time to animate?
	BEQ	:L	; yes
	DEC	SSPEED	; no  just count
	JMP	:L1
:L	JSR	ANIMATE
	LDA	SPEED	; reset counter
	STA	SSPEED
:L1	LDA	#0	; handshake with main
	STA	VBDONE
	LDX	#0	; start scrolling sequence
:L7	CPX	#0
	BEQ	MVFENC
:L11	LDA	LFRT,X
	BEQ	GOLEFT
	BPL	GORIT
	JSR	COUNTD
	JMP	NXLN
GORIT	LDA	SLN1SP,X
	BEQ	:L2
	DEC	SLN1SP,X
	JMP	NXLN
:L2	LDA	LNSC1,X
	SBC	#1
	BMI	:L4
	STA	LNSC1,X
	JMP	:L8
:L4	LDA	#7
	STA	LNSC1,X
	INC	SLMS1,X
	LDA	LN1SP,X
	STA	SLN1SP,X
	JMP	NXLN
GOLEFT	LDA	VBCTR
	AND	#1
	BEQ	NXLN
	LDA	LNSC1,X
	ADC	#1
	CMP	#8
	BEQ	:L6
	BCC	:L6
	STA	LNSC1,X
	JMP	NXLN
:L6	LDA	#0
	STA	LNSC1,X
	DEC	SLMS1,X
:L8	LDA	LN1SP,X
	STA	SLN1SP,X
NXLN	INX
	CPX	#7
	BNE	:L11

;resolve hardware collisions, check
;scrolling for events and effect
;the lms's so the fence and cows
;move

	JSR	CHKHIT
	JSR	LMSCK	; check for excess
	JSR	LMSLD
	JSR	SETSCO
	JSR	SOUND
	JMP	SYSVBV

;the fence never coarse scrolls
;16 fine scrolls = two characters

MVFENC	PROC
:L	LDA	LNSC1,X
	SBC	#2
	BMI	:L1
	STA	LNSC1,X
	STA	LNSC1+7,X
	LDA	LN1SP,X
	STA	SLN1SP,X
	JMP	NXLN
:L1	LDA	#15
	STA	LNSC1,X
	STA	LNSC1,X
	JMP	NXLN
VBCTR	DB	0
VBCTR1	DB	0
SLN1SP	DB	0,0,0,0,0,0,0,0
VBDONE	DB	0
VBCTR2	DB	0
SSPEED	DB	0
SPEED	DB	6	; speed of animation

;initializes color shadows and
;loads six groups of cows

INICOL	PROC
	LDX	#0
	LDA	#$D8
	STA	LNCOL1,X
	STA	LNCOL1+7,X
	LDA	#$A
	STA	LNCOL1+8,X
:L	INX
	JSR	NEWCOW
	CPX	#6
	BNE	:L
	RTS

;writes lms work area into the
;display list

LMSLD	PROC
	LDA	#0
	TAX
	TAY
:L	LDA	SLMS1,X
	STA	LMS1,Y
	LDA	LMSHI,X
	STA	LMS1+1,Y
	INY
	INY
	INY
	INY
	INY
	INX
	CPX	#8
	BNE	:L
	RTS

;takes display list lms from ori-
;ginal load and shadows them in
;the SLMS1 array

INILMS	PROC
	LDA	#0
	TAX
	TAY
:L	LDA	LMS1,Y
	STA	SLMS1,X
	INY
	INY
	INY
	INY
	INY
	INX
	CPX	#8
	BNE	:L
	RTS

;critical routine which prevents
;scrolling from going beyond limits
;calculates missed cows,brings
;herded cows back and checks for
;end of game

LMSCK	PROC	; check lms for excess
	LDX	#1
:L	JSR	HERD
	LDA	SLMS1,X
	BMI	:L1
	CMP	#LOW COW+36
	BEQ	:L2
:L3	INX
	CPX	#7
	BNE	:L
	RTS
:L1
	LDA	#1
	STA	LFRT,X
	LDA	#0
	STA	SLMS1,X
	JMP	:L3
:L2	LDA	#30
	STA	MISCOW
	LDA	#$A8
	STA	AUDC4
	LDA	LMSHI,X
	CMP	#HIGH COW+2
	BEQ	:L4
	CMP	#HIGH COW+1
	BEQ	:L5
	CMP	#HIGH COW
	BEQ	:L6
	CMP	#HIGH ANG
	BEQ	:L4
	JMP	:L3
:L4	DEC	CWLEFT
	DEC	COWLFT
	BEQ	:L7
	JSR	NEWCOW
	JMP	:L3
:L5	DEC	COWLFT
	DEC	CWLEFT
	DEC	CWLEFT
	DEC	COWLFT
	BMI	:L7
	BEQ	:L7
	JSR	NEWCOW
	JMP	:L3
:L6	DEC	COWLFT
	DEC	CWLEFT
	DEC	CWLEFT
	DEC	CWLEFT
	DEC	COWLFT
	DEC	COWLFT
	BEQ	:L7
	BMI	:L7
	JSR	NEWCOW
	JMP	:L3
:L7	LDA	#1
	STA	GAMEND
	JMP	:L3
GAMEND	DB	0

;calculates time to return cows
;after being herded. The number
;of times the line has been
;herded shortens the return time

HERD	PROC
	LDA	LFRT,X
	BEQ	:L1
	RTS
:L1	LDA	NUMHRD,X
	CMP	SLMS1,X
	BNE	:L2
	LDA	#1
	STA	LFRT,X
:L2	RTS
LASSO1	DB	0,0,$80,0,0,0,0,0,0,0
	DB	0,0,0,0,0,0,0,0,0,0,0,0
	DB	0,0,0,0

; second image

	DB	0,0,$80,$40,$40,0,0,0,0,0
	DB	0,0,0,0,0,0,0,0,0,0
	DB	0,0,0,0,0,0

; third image

	DB	0,0,$80,$40,$40,$20,$20,0,0,0
	DB	0,0,0,0,0,0,0,0,0,0
	DB	0,0,0,0,0,0

; fourth image

	DB	0,0,$80,$40,$40,$20,$20,$10,$10
	DB	0,0,0,0,0,0,0,0,0,0,0
	DB	0,0,0,0,0,0

; fifth image

	DB	0,0,$80,$40,$40,$20,$20,$10,$10
	DB	8,8,0,0,0,0,0,0,0,0,0
	DB	0,0,0,0,0,0

; sixth image

	DB	0,0,$80,$40,$40,$20,$20,$10,$10
	DB	8,8,4,4,0,0,0,0,0,0,0
	DB	0,0,0,0,0,0

; seventh image

	DB	0,0,$80,$40,$40,$20,$20,$10,$10
	DB	8,8,4,4,2,2,0,0,0,0,0
	DB	0,0,0,0,0,0

; eigthth image

	DB	0,0,$80,$40,$40,$20,$20,$10,$10
	DB	8,8,4,4,2,2,1,1,0,0,0
	DB	0,0,0,0,0,0
LASSO2	DB	0,0,0,0,0,0,0,0
	DB	0,0,0,0,0,0,$1C,$22,$22,$C1,$81
	DB	$41,$41,$41,$41,$3C,0,0

;throws the lasso,sets flag which
;disables the stick while lasso is
;on screen

ROPEM	PROC
	LDA	#1	; test for appropriate
	BIT	LASTAT	; sequence
	BMI	:L	; initial recall
	BVS	:L1	; continue recall
	BNE	:L2	; continue shoot
	LDA	STRIG0	; none of above so
	BEQ	:L3	; check for trigger
:L4	RTS		; not puched so return
:L3	LDA	#1	; he wants to fire so
	STA	LASTAT	; set status for cont.sht
	LDX	#0	; initial index for image
	STX	LSCTR
:L2	LDA	VBCTR	; don't execute every
	AND	#1	; time
	BEQ	:L4	; not yet so return
	LDA	#26	; initialize counter for
	STA	LSCTR1	; 26 bytes
	LDY	VPOSP0	; initialize index to ms
	LDX	LSCTR	; 0,26,52,78,104,130,156
:L5	LDA	LASSO1,X	; or 182 - do block
	STA	MISSIL,Y	; move into missile
	INX		; next image byte
	INY		; next missile image
	DEC	LSCTR1	; 26 bytes been moved?
	BNE	:L5	; not yet so loop back
	SEC		; have we done the eigtht image?
	CPX	#206	;a=208 - 206 leaves carry
	BCS	:L6	; yes,eigtht image done so
	STX	LSCTR	; no so store image cnt
	RTS		; for next time and return
:L6	LDA	#26	; set up fill for pl3
	LDY	VPOSP0	; and same vertical pos
	LDX	#0	; initialize ctr for image
:L7	LDA	LASSO2,X	; get image byte
	STA	PL3,Y	; and put in pl3
	INY		; next vertical position
	INX		; next image byte
	CPX	#26	; 26 bytes moved ?
	BNE	:L7	; no go do more
	LDA	#245	; yes - set delay for recal
	STA	VBCTR1
	LDA	#$80	; and set status for recall
	STA	LASTAT
	RTS
:L	LDA	VBCTR1	; check to see if time
	BEQ	:L8	; if = 0 then init recall
	RTS		; not time yet
:L8	LDA	#$40	; set status for recall
	STA	LASTAT	; in progress
	LDY	VPOSP0	; get vertical index
	LDX	#27	; # of bytes to erase from
	LDA	#0	; player 3
:L9	STA	PL3,Y	; erase player 3
	INY
	DEX
	BNE	:L9	; not done yet
	LDA	#1
	STA	LSCTR
	RTS
:L1	LDA	VBCTR
	AND	#1
	BEQ	:L14
	RTS
:L14	LDX	LSCTR
	LDA	#$FF
:L11	ASL	A
	DEX
	BNE	:L11
	STA	MSMASK
	LDY	VPOSP0
	LDX	#27
:L12	LDA	MISSIL,Y
	AND	MSMASK
	STA	MISSIL,Y
	INY
	DEX
	BNE	:L12
	LDA	LSCTR
	ADC	#1
	CMP	#10
	BEQ	:L13
	STA	LSCTR
	RTS
:L13	LDA	#0
	STA	LASTAT
	RTS
LASTAT	DB	0
LSCTR	DB	0
LSCTR1	DB	0
MSMASK	DB	$FF

;checks HIT array (set by DLI) for
;lasso hits and jumps to a routine
;which removes the cow so to speak

CHKHIT	PROC
	LDX	#1
:L	LDA	HIT,X
	BNE	:L3
	INX
	CPX	#8
	BNE	:L
	RTS
:L3	LDA	#0
	STA	HIT,X
	JSR	CLCOW
	RTS
COWRTH	DB	2,5,10,100
COWCOL	DB	CGREY+10
	DB	CYEGRN+8
	DB	CBLUE1+6
	DB	0
COWSP	DB	2,3,4,0
LMSHI	DB	HIGH FENCE
	DB	HIGH COW
	DB	HIGH COW
	DB	HIGH COW
	DB	HIGH COW
	DB	HIGH COW
	DB	HIGH COW
	DB	HIGH FENCE
COWVAL	DB	0,0,0,0,0,0,0,0
NEWSCO	DB	0

;sets points to be scored by VBLANK
;and advances cow sequence

CLCOW	PROC
	LDA	#0
	STA	VBCTR1
	LDA	COWVAL,X
	ADC	NEWSCO
	STA	NEWSCO
	INC	LMSHI,X
	LDA	LMSHI,X
	CMP	#HIGH ANG
	BEQ	NEWCOW
	CMP	#HIGH ANG+1
	BEQ	NEWCOW
	STA	LMSHI,X
	RTS

;initializes various cow tables and
;advances sequence of cows

NEWCOW	PROC
	LDA	WHICHC,X
	TAY
	LDA	COWCOL,Y
	STA	LNCOL1,X
	LDA	COWRTH,Y
	STA	COWVAL,X
	LDA	COWSP,Y
	STA	LN1SP,X
	CPY	#3
	BEQ	:L1
	LDA	#HIGH COW
	STA	LMSHI,X
	LDA	#0
	STA	SLMS1,X
	LDA	#1
	STA	LFRT,X
:L2	LDA	#0
	STA	NUMHRD,X
	INC	WHICHC,X
	LDA	WHICHC,X
	CMP	#4
	BNE	:L
	LDA	#0
	STA	WHICHC,X
:L	RTS
:L1	LDA	#HIGH ANG
	STA	LMSHI,X
	LDA	#0
	STA	SLMS1,X
	LDA	#255
	STA	LFRT,X
	LDA	RANDOM
	STA	ANGCNT
	JMP	:L2
ANGCNT	DB	0

;kills time waiting to put angus on
;the screen - angcnt set by random
;number for a delay of 0 to 3 sec.

COUNTD	PROC
	DEC	ANGCNT
	BNE	:L
	LDA	#1
	STA	LFRT,X
:L	RTS
WHICHC	DB	0,1,1,0,2,0,1,0
TWHICH	DB	0,1,1,0,2,0,1,0

;called from VBLANK. scores the
;points accumulated in NEWSCO

SETSCO	PROC
	LDA	NEWSCO
	BNE	:L
	RTS
:L	LDA	VBCTR
	AND	#3
	BEQ	:L3
	RTS
:L3	DEC	NEWSCO
	LDY	#5
:L2	LDA	SCORE,Y
	CMP	#$19
	BEQ	:L1
	ADC	#1
	STA	SCORE,Y
	RTS
:L1	LDA	#$10
	STA	SCORE,Y
	DEY
	BPL	:L2
	RTS

;zeroes the score at game start

CLSCOR	PROC
	LDA	#0
	STA	NEWSCO
	LDY	#5
:L	LDA	#$10
	STA	SCORE,Y
	DEY
	BNE	:L
	RTS

;freezes execution until START
;key is pressed

CHEKST	PROC
	LDA	#8
	STA	CONSOL
:L	LDA	CONSOL
	CMP	#6
	BNE	:L
	RTS

;the game is over so look for a new
;high score and show the score - high
;score line
;upon START key reset some arrays

NEWGAM	PROC
	JSR	CHKHSC
	JSR	CHEKST
	LDA	#0
	STA	LASTAT
	STA	LSCTR
	STA	LSCTR1
	JSR	CLSCOR
	LDA	#LOW SCORLN
	STA	SCRLN
	LDA	#HIGH SCORLN
	STA	SCRLN+1
	LDA	#3
	STA	COWLFT
	LDA	#19
	STA	CWLEFT
	LDX	#0
:L	LDA	TWHICH,X
	STA	WHICHC,X
	INX
	CPX	#8
	BNE	:L
	PLA
	PLA
	PLA
	JMP	START

;AUDF1 is point sound
;AUDF2 is clippity clop
;AUDF4 is missed cow sound
;clippity clop is shaped by a
;counter which toggles AUDC2

SOUND	PROC
	LDA	GAMEND
	BEQ	:L
	LDA	#0
	STA	AUDC1
	STA	AUDC2
	STA	AUDC3
	STA	AUDC4
	RTS
:L	LDA	PTFLAG
	BEQ	:L1
	LDA	NEWSCO
	BEQ	:L4
	LDA	#0
	STA	PTFLAG
	LDA	#$A8
	STA	AUDC1
	JMP	:L4
:L1	LDA	VBCTR
	AND	#2
	BNE	:L4
	LDA	#0
	STA	AUDC1
	LDA	#1
	STA	PTFLAG
:L4	INC	CLIPCT
	LDA	CLIPCT
	CMP	#21
	BNE	:L5
	LDA	#0
	STA	CLIPCT
:L5	CMP	#0
	BEQ	:L6
	CMP	#3
	BEQ	:L7
	CMP	#10
	BEQ	:L6
	CMP	#12
	BEQ	:L7
	CMP	#15
	BEQ	:L6
	CMP	#17
	BEQ	:L7
	JMP	:L8
:L6	LDA	#$84
	STA	AUDC2
	JMP	:L8
:L7	LDA	#0
	STA	AUDC2
:L8	LDA	MISCOW
	BEQ	:L9
	DEC	MISCOW
	JMP	:L10
:L9	STA	AUDC4
:L10	RTS
PTFLAG	DB	1
CLIPCT	DB	0
MISCOW	DB	0

	END	START
