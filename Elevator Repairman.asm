; +----------------------+
; |                      |
; |  ELEVATOR REPAIRMAN  |
; |                      |   /\
; |   by Fred Caprilli   |  /UP\
; |                      |  |--|
; |       (c) 1985       |  \DN/
; |                      |   \/
; |   Analog Computing   |
; |                      |
; +----------------------+
;
; System equates
;
VDSLST	=	$0200
SDLSTL	=	$0230
SDMCTL	=	$022F
GRACTL	=	$D01D
NMIEN	=	$D40E
WSYNC	=	$D40A
COLBAK	=	$D01A
CHBASE	=	$D409
PMBASE	=	$D407
HSCROL	=	$D404
VCOUNT	=	$D40B
HPOSP0	=	$D000
HPOSP2	=	$D002
HPOSP3	=	$D003
COLRP0	=	$02C0
COLRP1	=	$02C1
COLRP2	=	$02C2
COLRP3	=	$02C3
SIZEP0	=	$D008
SIZEP1	=	$D009
SIZEP2	=	$D00A
SIZEP3	=	$D00B
SIZEM	=	$D00C
RANDOM	=	$D20A
SETVBV	=	$E45C
XITVBV	=	$E462
CONSOL	=	$D01F
STICK	=	$D300
P2PL	=	$D00E
P3PL	=	$D00F
M0PL	=	$D008
M1PL	=	$D009
M2PL	=	$D00A
COLPF0	=	$D016
HITCLR	=	$D01E
JIFFY	=	$14
GPRIOR	=	$026F
COLOR0	=	$02C4
COLOR1	=	$02C5
COLOR2	=	$02C6
SCOLBK	=	$02C8
BOOT	=	$09
COLDST	=	$0244
DOSINI	=	$0C
ATRACT	=	$4D
DRKMSK	=	$4E
COLRSH	=	$4F
CHSET	=	$0600
;
AUDF0	=	$D200
AUDF1	=	$D202
AUDC1	=	$D203
AUDF2	=	$D204
AUDC2	=	$D205
AUDF3	=	$D206
AUDC3	=	$D207
AUDCTL	=	$D208
SKCTL	=	$D20F
PACTL	=	$D302
;
; Player / Missile Area
;
	*=	$3800
;
PMAREA	.DS	$0300
MAREA	.DS	$0100
P0AREA	.DS	$0100
P1AREA	.DS	$0100
P2AREA	.DS	$0100
P3AREA	.DS	$0100
;
; Page Zero Variables
;
	*=	$80
;
EHT	.DS	2	;P/M ht for elev
EMSK	.DS	1	;msk to clr bits
D1S	.DS	2	;climb fr height
D2S	.DS	2	;same (P3)
D1D	.DS	2	;climb to height
D2D	.DS	2	;same (P3)
DAN1	.DS	2	;P/M pg. Dan (P2)
DAN2	.DS	2	;P/M pg. Dan (P3)
ESP	.DS	2	;speed tbl pntr
COFSET	.DS	1	;DLI tbl offset
ESPEED	.DS	7	;elevator speeds
LEVEL	.DS	1	;level no.
FLOOR	.DS	1	;current floor
CLIMBF	.DS	1	;Dan climbing flg
DIEFLAG	.DS	1	;indicates dying
NEWLVL	.DS	1	;flags new level
SCORE	.DS	3	;score in BCD
OVERFLG	.DS	1	;game over status
HITES	.DS	7	;elevator heights
DIR	.DS	7	;elevator dirs
DANHOR	.DS	1	;Dan's hor pos
CLIMBHT	.DS	1	;climb height
DANDIR	.DS	1	;Dan's direction
DANSPD	.DS	1	;Dan's speed
SPDCNT	.DS	1	;speed counter
ELDLAY	.DS	1	;elev # to stall
DLYCNT	.DS	1	;death delay
COLCNT	.DS	1	;color counter
TIME	.DS	4	;time in BCD
BASCNT	.DS	1	;Bass note cntr
BASTIM	.DS	1	;Bass timer
TRBCNT	.DS	1	;Treble counter
TRBTIM	.DS	1	;Treble timer
;
; Game starts here
;
	*=	$2000
;
INIT	LDA	#$3C	;cassette off
	STA	PACTL	;if necessary
	LDA	#0
	STA	COLDST	;Warm start
	LDA	#1
	STA	BOOT	;Disk boot OK
	LDA	# <RST
	STA	DOSINI
	LDA	# >RST
	STA	DOSINI+1	;Trap S/RESET
	JSR	CLRHI	;clear hiscore
RST	CLD		;just in case
	JSR	TITLE	;Title screen
	JSR	ZERO	;init. variables
	JSR	SLEVEL
	JSR	SETUP	;main display
	JSR	INITIM	;reset timer
;
; Mainline (non-VBI) code
;
MAIN	LDA	OVERFLG	;Game over?
	BEQ	MN1	;No.
	LDA	#8	;Yes, so clear
	STA	CONSOL	;CONSOL and
MN0	LDA	CONSOL	;poll START key
	EOR	#6	;Is it pressed?
	BNE	MN0	;No.
	STA	OVERFLG	;Yes, zero flag
	LDA	#7	;back to   
	LDY	# <XITVBV	;standard VB
	LDX	# >XITVBV	;routine
	JSR	SETVBV
	JMP	RST	;and start at top
MN1	LDA	NEWLVL	;Check new level
	BEQ	MAIN	;Not yet, loop
	JSR	SLEVEL	;Yes, new level
	JMP	MAIN	;and loop back
;
; End of Mainline code
;
SETUP	LDX	#0
	STX	SDMCTL	;Disable DMA
	LDA	#$40
	STA	NMIEN	;Disable DLI
	LDA	# <DLIST
	STA	SDLSTL	;Point to
	LDA	# >DLIST	;the game
	STA	SDLSTL+1	;display list
	LDA	# <DLI1	;DLI vector
	STA	VDSLST
	LDA	# >DLI1
	STA	VDSLST+1
	LDY	# <VBI	;Set up VBI
	LDX	# >VBI
	LDA	#7	;Deferred
	JSR	SETVBV
	LDA	#$3D	;P/M enable, and
	STA	SDMCTL	;narrow playfield
	LDA	#$C0
	STA	NMIEN	;enable DLI's
	LDA	#$0A	;white
	STA	COLOR0	;for stairs
	LDA	#$00	;black 
	STA	COLOR1	;for shafts
	STA	SCOLBK	;and screen top.
	STA	BASCNT	;bass notes index
	LDA	#$CC	;green
	STA	COLOR2	;for digits
;
	LDA	#$50	;16-bit ch. 0/1
	STA	AUDCTL	;8-bit ch. 2,3
	LDA	#3
	STA	SKCTL	;reset POKEY
	LDA	#$AA	;vol.10, dist.10
	STA	AUDC1
	STA	AUDC2
	STA	AUDC3
	LDA	#$FF
	STA	TRBTIM	;timer for treble
	STA	TRBCNT	;treble note cntr
	LDA	#14
	STA	BASTIM	;timer for bass
;
; Download charset to page 6
;
	LDX	#55	;# of bytes
CDL	LDA	CSETB,X
	STA	CHSET,X
	DEX
	BPL	CDL
	RTS
;
ZERO	LDA	#0	;zero variables
	LDX	#OVERFLG-COFSET
Z1	STA	COFSET,X
	DEX
	BPL	Z1
	LDA	#2	;Dan moves...
	STA	DANSPD	;every other VBI
	LDA	#$90	;ATASCII inv "0"
	LDX	#5
L1	STA	SSCORE,X	;0 score
	DEX
	BPL	L1
	STA	LEVBYTE	;level 0
	LDA	#$FF
	STA	DANDIR	;no initial dir.
	LDA	#$99	;digit 9 on 
	STA	MENBYT	;screen - 9 men
	LDA	# <TLINE
	STA	MSG
	LDA	# >TLINE
	STA	MSG+1	;Top shows timer
	RTS
;
CLRHI	LDX	#5	;hi to 000000
	LDA	#$90
CR1	STA	HISCORE,X
	DEX
	BPL	CR1
	RTS
;
PMSETUP	LDA	# >PMAREA
	STA	PMBASE	;to P/M area
	LDA	#3
	STA	GRACTL	;enable P/M DMA
	LDA	#0	;clear P/M area
	TAY
CLN	STA	MAREA,Y
	STA	P0AREA,Y
	STA	P1AREA,Y
	STA	P2AREA,Y
	STA	P3AREA,Y
	DEY
	BNE	CLN
;
	LDY	#7	;8 P/M locs
INITPM	LDA	ELEPOS,Y	;init P/M
	STA	HPOSP0,Y	;horizontal pos
	DEY		;next P/M
	BPL	INITPM	;done? No.
	LDA	#64
	STA	DANHOR
;
	JSR	SETHTS	;elev heights
;
	LDA	#$7A	;Set P/M colors
	STA	COLRP0
	LDA	#$F8
	STA	COLRP1
	LDA	#$48
	STA	COLRP2
	LDA	#$90
	STA	COLRP3
;
	LDA	#$3F	;P/M widths
	STA	SIZEP0	;quadruple for
	STA	SIZEP1	;elevators (P0,
	STA	SIZEM	;P1,M0-M2)
	LDA	#0	;single for
	STA	SIZEP2	;Dan
	STA	SIZEP3	;(P2,P3)
	LDA	#$21
	STA	GPRIOR	;Multicolor PL
	LDA	# >P2AREA	;Set up zero
	STA	DAN1+1	;page pointers
	STA	D1S+1
	STA	D1D+1
	LDA	# >P3AREA
	STA	DAN2+1
	STA	D2S+1
	STA	D2D+1
	RTS
;
; The Display list interrupt routines
;
DLI1	PHA		;Save registers
	TXA
	PHA
	LDX	# >CHSET	;new charset
	LDA	#$C2
	STA	WSYNC
	STX	CHBASE
	EOR	COLRSH	;mask attract
	AND	DRKMSK
	STA	WSYNC
	STA	COLBAK	;change color
	LDA	# >DLI2
	STA	VDSLST+1
	LDA	# <DLI2
	STA	VDSLST	;next DLI
	PLA
	TAX
	PLA		;Restore regs
	RTI
;
DLI2	PHA		;Save registers
	TXA
	PHA
	LDA	#0
	STA	WSYNC
	STA	COLBAK	;Black ceiling
	LDX	COFSET
	LDA	COLORS,X	;get color
	EOR	COLRSH	;mask attract
	AND	DRKMSK
	STA	WSYNC
	STA	COLBAK
	INC	COFSET	;inc index
	LDA	COFSET	;table index
	CMP	#11	;last DLI?
	BNE	EX	;no.
	LDA	#$E0	;Yes, so restore
	STA	CHBASE	;default cset.
	LDA	#0
	STA	COFSET	;and zero index
	STA	COLPF0	;and color 0.
	LDA	# <DLI1	;Point back to
	STA	VDSLST	;first DLI.
	LDA	# >DLI1
	STA	VDSLST+1
EX	PLA
	TAX
	PLA		;Restore registers.
	RTI
;
; The Vertical Blank routine
;
VBI	LDA	OVERFLG	;Skip VBI if
	BEQ	V0	;game over.
	JMP	XVB
V0	LDA	DIEFLAG	;Dan dying?
	BNE	DAN	;Yes, skip elevs
;
; Check screen heights for elevators
; and reverse direction if necessary
;
C3	LDX	#6	;do 7 elevator
C0	LDA	HITES,X
	CMP	#32	;At top?
	BPL	C1	;No. skip
	CMP	#68	;Intermediate
	BPL	C1
	LDA	#1	;Going down!
	BNE	C2A
;
C1	CMP	#159	;intermediate
	BMI	C2
	CMP	#193	;At bottom?
	BMI	C2	;No. no change
	LDA	#0	;Yes, going up!
C2A	STA	DIR,X
C2	DEX		;next elevator
	BPL	C0	;done? No.
;
; Now set up for movement of elevators
;
	LDX	#6	;do 7 elevators
M1	CPX	ELDLAY	;slow it down?
	BNE	M2	;No.
	LDA	DLYCNT	;Yes.
	BEQ	M2	;Delay over yet?
	DEC	DLYCNT	;No.
	LDA	DLYCNT	;count down one
	AND	#3	;and skip a turn
	BEQ	M5	;every 1/15 sec.
M2	LDA	ELOCS,X	;P/M page
	STA	EHT+1
	LDA	HITES,X	;byte loc in page
	STA	EHT
	LDA	EMASKS,X	;Get mask
	EOR	#$FF	;save its inverse
	STA	EMSK
	LDA	DIR,X	;0=up, 1=down
	BEQ	UP
;
; Set up for down movement
;
	LDA	ESPEED,X	;elevator speed
	BEQ	D1
	INC	HITES,X
	INC	EHT	;double speed
D1	INC	HITES,X
	INC	EHT	;normal speed
	JMP	M4
;
; Set up for up movement
;
UP	LDA	ESPEED,X
	BEQ	U1
	DEC	HITES,X
	DEC	EHT	;double speed
U1	DEC	HITES,X
	DEC	EHT	;normal speed
;
; Execute the movement
;
M4	JSR	MV	;move the bytes
M5	DEX		;next elevator
	BPL	M1	;done? No.
;
	LDA	JIFFY	;Stall elevator?
	BNE	DAN	;(when JIFFY=0)
	JSR	ELNEW
;
; Elevators done. Now, we process
; Dan the Elevator Repair Man.
;
DAN	LDA	CLIMBF	;climbing?
	BEQ	VB1	;No.
	JSR	CLIMB1	;Yes, move him up
	JMP	DANEND	;and exit.
VB1	LDA	DIEFLAG	;Presently dying?
	BEQ	VB2	;No. skip
	JSR	DEATH	;Yes. keep dying
	JMP	XVB	;and exit.
VB2	LDY	FLOOR
	LDA	STAIRS,Y	;Has he reached
	CMP	DANHOR	;the stairs?
	BNE	VB4	;No.
	CPY	#10	;Top floor?
	BMI	VB3	;No, climb stairs
	JSR	ENDLEV	;Yes, so end it
	JMP	DANEND	;and exit.
VB3	JSR	SCLIMB	;init climbing
	JMP	DANEND	;and exit.
VB4	JSR	HITCHK	;Chk collision
	BEQ	VB5	;Dan hit? No.
	LDA	#120	;Yes, start 120
	STA	DIEFLAG	;jiffy death...
	BNE	DANEND	;and exit
;
; If we make it to here, it means our
; hero is either starting or in the
; midst of his perilous trek across
; the screen.
;
VB5	INC	SPDCNT	;Speed counter
	LDA	SPDCNT
	CMP	DANSPD	;Time to move?
	BMI	DANEND	;No, so exit.
	LDA	#0
	STA	SPDCNT	;Zero the counter
	LDX	DANDIR	;Save old dir
	JSR	JOY	;dir change?
	CPX	DANDIR
	BEQ	MOVEDAN	;No, skip
	JSR	DRAWDAN	;Yes, redraw him
MOVEDAN	LDA	DANDIR
	BMI	DANEND	;Wait on joystick
	LDY	FLOOR
	LDA	STARTS,Y	;Is Dan at start
	CMP	DANHOR	;of floor?
	BEQ	F3	;Yes, skip next
	CLC		;animate feet
	LDA	DANHT,Y
	ADC	#15	;Bottom of Dan
	TAY		;for feet.
	LDA	JIFFY
	AND	#7	;Mod 8 counter
	CMP	#4	;at 4 jiffies?
	BMI	F2
	LDA	#$18	;"feet in" byte
	BNE	F3A
F2	LDA	#$24	;"feet out" byte
F3A	STA	P2AREA,Y
F3	LDA	DANDIR
	ROR	A	;Right or left?
	BCC	MVRT	;Right (DANDIR=0)
	LDA	DANHOR	;trying to pass
	CMP	#$40	;left edge?
	BEQ	DANEND	;Yes, stop him
	DEC	DANHOR	;Dec horizontal
	JMP	MVLF
MVRT	LDA	DANHOR	;Trying to pass
	CMP	#$B8	;right edge?
	BEQ	DANEND	;Yes, stop him
	INC	DANHOR	;No, so move it
MVLF	LDA	DANHOR	;position shadow
	STA	HPOSP2	;and do the
	STA	HPOSP3	;horizontal move
;
DANEND	JSR	TIMER	;Do the timer
	JSR	MUSIC	;Do the music
XVB	STA	HITCLR	;clr collisions
	JMP	XITVBV	;and finish VBI!
;
; Subroutines
; -----------
;
; Pick an elevator to stall [0-6]
;
ELNEW	LDA	RANDOM
	AND	#7	;0-7
	CMP	#7
	BEQ	ELNEW	;0-6
	STA	ELDLAY
	LDA	#$80
	STA	DLYCNT
	RTS
;
; Animate the elevators - on entry,
; (EHT) pointS to the pertinent P/M
; area, and EMSK contains inverse bit
; mask, to zero out bits (tops and
; bottoms of elevators).  Elevators
; are 12 solid lines plus 2 blanks on
; top and 2 on bottom.
;
MV	LDY	#15	;16 bytes
	JSR	V2	;15-14 (bottom)
	DEY
V1	LDA	(EHT),Y	;lines 13 to 2
	AND	EMSK	;Clr current bits
	ORA	EMASKS,X	;set new ones
	STA	(EHT),Y
	DEY
	CPY	#1
	BNE	V1
V2	LDA	(EHT),Y	;line 1
	AND	EMSK	;Zero out bits
	STA	(EHT),Y	;with mask
	DEY
	LDA	(EHT),Y	;line 0 (top)
	AND	EMSK
	STA	(EHT),Y
	RTS
;
; Generate elevator starting heights
;
SETHTS	LDX	#6	;7 elevators
SH1	LDA	RANDOM
	AND	#$3F	;0-63
	ASL	A	;0-126 even
	ADC	#40	;40-166 even
	STA	HITES,X
	DEX
	BPL	SH1
	RTS
;
; This subroutine updates the
; countdown timer, and puts it to
; the screen
;
TIMER	LDA	CLIMBF	;Don't time
	BNE	TI1	;if climbing
	LDA	TIME+2
	BNE	TI0
	LDA	TIME+1
	AND	#$0F
	BEQ	TI1	;If 0 don't dec
TI0	SED		;Decimal math
	SEC
	LDA	TIME+3	;Fractional byte
	SBC	#17	;approx. 0.1 sec
	STA	TIME+3	;(rolls over
	LDA	TIME+2	;every 6 jiffies)
	SBC	#0
	STA	TIME+2
	LDA	TIME+1
	SBC	#0
	STA	TIME+1
	CLD
;
	LDA	TIME+2	;Take 3-byte (6
	AND	#$0F	;decimal digit),
	ORA	#$90	;take the low 3
	STA	TLINE+8	;digits and put
	LDA	TIME+2	;to the screen.
	LSR	A	;move high nybble
	LSR	A	;for 2nd decimal
	LSR	A	;digit down to
	LSR	A	;low nybble
	ORA	#$90	;make it ATASCII
	STA	TLINE+7	;put to screen
	LDA	TIME+1	;we only want low
	AND	#$0F	;nybble here
	STA	TIME+1	;(3 digits total)
	ORA	#$90	;make it ATASCII
	STA	TLINE+6	;put to screen
	LDA	#0
	STA	TIME	;not used
TI1	RTS
;
; This subroutine updates the scoring
; when Dan reaches a new floor
;
SCORING	LDX	#3	;3-byte (6-digit)
	SED		;decimal add
	CLC
SC1	DEX
	LDA	SCORE,X
	ADC	TIME,X
	STA	SCORE,X
	TXA
	BNE	SC1
	CLD
	STA	TIME	;Zero out timer
	STA	TIME+1
	STA	TIME+2
	STA	TIME+3
	LDX	#2
	LDY	#5
SC2	LDA	SCORE,X
	PHA		;Save it
	AND	#$0F	;low nybble
	ORA	#$90	;make it ATASCII
	STA	SSCORE,Y	;put on screen
	PLA		;use same byte
	LSR	A	;high nybble
	LSR	A	;we move it
	LSR	A	;down to
	LSR	A	;low nybble
	ORA	#$90	;make it ATASCII
	DEY
	STA	SSCORE,Y	;put to screen
	DEY
	DEX
	BPL	SC2
	RTS
;
; This subroutine reads the joystick.
;
JOY	LDA	STICK	;Read joystick
	AND	#8	;Right?
	BEQ	JLR	;Yes.
	LDA	STICK
	AND	#4	;No. left?
	BNE	JE	;No, dir same
	LDA	#1	;1 = left
JLR	STA	DANDIR
JE	RTS
;
; This subroutine updates the score
; and sets up the climb.
;
SCLIMB	JSR	SCORING	;Update score
	LDA	#16	;16 scan lines
	STA	CLIMBF	;to climb.
	LDY	FLOOR	;index to screen.
	LDA	DANHT,Y	;height table
	STA	CLIMBHT	;start climb here
	RTS
;
; This subroutine makes Dan climb 1
; scan line per VBI (if CLIMBF<>0).
; It continues into the INITIM
; subroutine.
;
CLIMB1	LDY	#0
	LDA	CLIMBHT	;Set up zero page
	STA	D1S	;pointers
	STA	D2S
	DEC	CLIMBHT	;destination is
	LDA	CLIMBHT	;one scan line up
	STA	D1D
	STA	D2D
CL1	LDA	(D1S),Y	;Move P2 up one.
	STA	(D1D),Y
	LDA	(D2S),Y	;Move P3 up one.
	STA	(D2D),Y
	INY
	CPY	#16	;All bytes moved?
	BMI	CL1	;No.
	LDA	#0	;Erase last line
	STA	(D1D),Y
	STA	(D2D),Y
	DEC	CLIMBF
	BNE	INITIM	;Is climb over?
	INC	FLOOR	;Yes, new floor.
;
; This subroutine sets timer to 250
;
INITIM	LDA	#0	;250 decimal
	STA	TIME
	LDA	#2
	STA	TIME+1
	LDA	#$50
	STA	TIME+2
	LDA	#$92	;"2"
	STA	TLINE+6
	LDA	#$95	;"5"
	STA	TLINE+7
	LDA	#$90	;"0"
	STA	TLINE+8
	RTS
;
; This subroutine sets up a new level,
; speeds of elevators and Dan, timer,
; Dan on bottom, increased level no.
;
SLEVEL	LDY	LEVEL
	CPY	#7	;Level 7 or more?
	BMI	SL0	;No.
	LDA	#1	;Yes, so we have
	STA	DANSPD	;superfast Dan.
SL0	CPY	#4	;Level 4 or more?
	BMI	SL1	;No.
	LDY	#4	;Yes, lev.4 speed
SL1	TYA
	ASL	A
	TAY		;Lev *2 index
	LDA	LEVSPD,Y	;elev speed tbl
	STA	ESP	;init 0 page pntr
	INY
	LDA	LEVSPD,Y
	STA	ESP+1
	LDY	#6	;Download elev
SL2	LDA	(ESP),Y	;speeds to 
	STA	ESPEED,Y	;zero page tbl
	DEY
	BPL	SL2
	JSR	PMSETUP	;reset P/M gr
	LDA	#0
	STA	FLOOR	;floor 0
	JSR	SFLOOR
	JSR	INITIM
	LDA	LEVEL
	ORA	#$90	;make it ATASCII
	STA	LEVBYTE	;put to screen.
	LDA	#0
	STA	NEWLVL	;Turn off flag.
	RTS
;
SFLOOR	LDY	FLOOR	;find hor. start
	LDA	STARTS,Y
	STA	HPOSP2	;put Dan there.
	STA	HPOSP3
	STA	DANHOR
	JSR	DRAWDAN	;Draw him
	LDA	#0
	STA	ATRACT	;defeat attract
	LDA	#$FF
	STA	DANDIR	;no initial dir.
	RTS
;
DRAWDAN	LDY	FLOOR	;index to height
	LDA	DANHT,Y	;tbl corresponds
	STA	DAN1	;to P/M memory
	STA	DAN2	;'height'
	LDY	#15	;draw 16 bytes
	LDA	DANDIR
	ROR	A	;Right or left?
	BCS	S2
;
; Draw Dan facing right
;
S1	LDA	DANRT1,Y	;P2 data
	STA	(DAN1),Y
	LDA	DANRT2,Y	;P3 data
	STA	(DAN2),Y
	DEY
	BPL	S1
	RTS
;
; Draw Dan facing left
;
S2	LDA	DANLF1,Y	;P2 data
	STA	(DAN1),Y
	LDA	DANLF2,Y	;P3 data
	STA	(DAN2),Y
	DEY
	BPL	S2
	RTS
;
; Death subroutine - flip-flop Dan
; for 1 second, then freeze for 1
; second.  If no lives are left,
; it ends the game.
;
DEATH	LDA	#0
	STA	AUDF0
	STA	AUDF1
	STA	AUDF2	;Silence music
	DEC	DIEFLAG	;lower counter
	LDA	DIEFLAG	;Done yet?
	BEQ	DE2	;Yes.
	CMP	#60	;time for freeze?
	BPL	DE8	;No.
	LDA	#0	;Yes...
	STA	AUDF3	;silence
	RTS		;skip flip-flop.
DE8	AND	#3	;No, flip Dan
	BNE	DE3	;every 4 jiffies
	LDA	DANDIR
	BEQ	DE1
	JSR	DRAWDAN	;flip left
	LDA	#0	;and set up for
	STA	DANDIR	;right flip
	LDA	#$20	;high note
	BNE	DE0
DE1	JSR	DRAWDAN	;flip right
	LDA	#1	;and set up for
	STA	DANDIR	;left flip
	LDA	#$40	;low note
DE0	STA	AUDF3
	RTS
;
; Death over
;
DE2	JSR	SFLOOR	;put Dan back
	DEC	MENBYT	;One less man...
	LDA	MENBYT	;Any men left?
	AND	#$0F
	BNE	DE3	;Yes, continue.
	LDA	# <OVERLN	;No, change
	STA	MSG	;top line LMS
	LDA	# >OVERLN	;LMS to show
	STA	MSG+1	;"GAME OVER"
	LDA	#1	;set flag
	STA	OVERFLG
	LDX	#0	;Compare score to
DE4	LDA	SSCORE,X	;high score
	CMP	HISCORE,X	;digit by digit
	BMI	DE3	;lt?, no change
	BNE	DE5	;gt?, update hi
	INX		;next digit
	CPX	#6
	BMI	DE4
	RTS
DE5	LDX	#5
DE6	LDA	SSCORE,X	;Move score
	STA	HISCORE,X	;to high score
	DEX
	BPL	DE6
DE3	RTS
;
; This subroutine does collision
; detection.
;
HITCHK	LDA	P2PL	;Did P2
	ORA	P3PL	;or P3 hit
	AND	#3	;elev 0,1,5,6?
	BNE	ENDCHK	;Yes, Dan's dead.
	LDA	M0PL	;Did M0 (elev 2)
	ORA	M1PL	;or M1 (elev 3)
	ORA	M2PL	;or M2 (elev 4)?
	AND	#$0C
ENDCHK	STA	HITCLR	;Clear collision
	RTS
;
ENDLEV	JSR	SCORING	;update score
	INC	LEVEL	;on to next level
	LDA	#1	;Flag so mainline
	STA	NEWLVL	;code can set up
	RTS		;a new level
;
; This subroutine produces the title
; screen, and waits for START.
;
TITLE	LDA	#0
	STA	SDMCTL	;disable DMA
	STA	COLOR0	;black letters
	LDA	# <TDLIST	;Point to
	STA	SDLSTL	;Display list
	LDA	# >TDLIST	;for title
	STA	SDLSTL+1	;screen
	LDA	#$3D	;narrow playfield
	STA	SDMCTL
	LDA	#$0E	;white letters
	STA	COLOR1
	LDA	#4	;center titles
	STA	HSCROL
X1	LDA	VCOUNT	;rainbow backgrnd
	BNE	X1	;wait for line 0
	TAY		;and keep track
	LDX	COLCNT	;colour counter
X2	STA	WSYNC	;sync to TV line
	STA	COLBAK	;store in reg
	INX		;inc color #
	TXA
	AND	#$F0	;but make it
	ORA	#$08	;luminance 8
	INY
	CPY	#$F0	;screen bottom?
	BNE	X2	;No.
;
; Now increase the starting colour for
; next TV frame, produces scrolling
; rainbow effect
;
	INC	COLCNT
	LDA	#8	;We have some
	STA	CONSOL	;time left to
	LDA	CONSOL	;check for START
	EOR	#6	;Pushed?
	BEQ	X3	;Yes, so exit
	STA	WSYNC	;keep stuffing
	STA	COLBAK
	BNE	X1	;Infinite loop
X3	RTS		;unless sent here
;
; This subroutine plays the music.
;
MUSIC	LDA	BASTIM	;New note time?
	BPL	BN0	;No.
	LDA	#14	;all notes
	STA	BASTIM	;are 15 jiffies.
	INC	BASCNT
BN0	LDA	BASCNT	;Get the note.
	AND	#7	;mod 8 counter
	TAY
	LDA	BASSLO,Y	;Bass is 16-bit
	STA	AUDF0	;sound, so stuff
	LDA	BASSHI,Y	;lo and hi bytes
	STA	AUDF1	;in channels 0,1
	LDX	BASTIM
	LDA	BASENV,X
	STA	AUDC1	;Apply envelope
	DEC	BASTIM	;dec. duration
;
; Melody (Treble)
;
	LDA	TRBTIM	;Note timer done?
	BPL	TN1	;No.
	INC	TRBCNT	;Yes - inc cntr
	LDY	TRBCNT	;Are we at...
	CPY	#26	;end of tune?
	BMI	TN0	;No.
	LDA	#$FF	;Yes, reset
	STA	TRBCNT	;counter
	BNE	TN2
TN0	LDA	TRBDUR,Y	;load the
	STA	TRBTIM	;duration
TN1	LDY	TRBCNT
	LDA	TREBLE,Y	;Play the note..
	STA	AUDF2
	DEC	TRBTIM	;and dec timer.
TN2	RTS
;
; Various Data Tables
;
ELEPOS	.BYTE	72,160,64,64
	.BYTE	108,124,140,0
COLORS	.BYTE	$82,$22,$B2,$42,$12,$52
	.BYTE	$72,$32,$62,$E4,$06
EMASKS	.BYTE	$C0,$0C,$03,$0C
	.BYTE	$30,$C0,$0C
ELOCS	.BYTE	>P0AREA,>P0AREA
	.BYTE	>MAREA,>MAREA
	.BYTE	>MAREA,>P1AREA
	.BYTE	>P1AREA
STARTS	.BYTE	$40,$B8,$40,$B8,$40
	.BYTE	$B8,$40,$B8,$40,$B8,$40
STAIRS	.BYTE	$B8,$40,$B8,$40,$B8
	.BYTE	$40,$B8,$40,$B8,$40,$B8
ESPED1	.BYTE	0,0,0,0,0,0,0
ESPED2	.BYTE	0,1,0,0,1,0,0
ESPED3	.BYTE	1,1,0,1,0,1,0
ESPED4	.BYTE	0,1,1,1,1,0,1
ESPED5	.BYTE	1,1,1,1,1,1,1
;
LEVSPD	.WORD	ESPED1,ESPED2,ESPED3
	.WORD	ESPED4,ESPED5
;
; Vertical height of tops of floors
;
DANHT	.BYTE	$C0,$B0,$A0,$90
	.BYTE	$80,$70,$60,$50
	.BYTE	$40,$30,$20
;
DANLF1	.BYTE	$00,$0F,$3F,$1C
	.BYTE	$34,$7D,$7D,$6F
	.BYTE	$06,$02,$1E,$3F
	.BYTE	$3F,$3F,$1E,$0C
DANLF2	.BYTE	$00,$0F,$3F,$03
	.BYTE	$0B,$02,$02,$10
	.BYTE	$18,$0E,$1E,$3D
	.BYTE	$39,$39,$1E,$00
DANRT1	.BYTE	$00,$78,$7E,$1C
	.BYTE	$16,$5F,$5F,$7B
	.BYTE	$30,$20,$3C,$7E
	.BYTE	$7E,$7E,$3C,$18
DANRT2	.BYTE	$00,$78,$7E,$60
	.BYTE	$68,$20,$20,$04
	.BYTE	$0C,$38,$3C,$5E
	.BYTE	$4E,$4E,$3C,$00
;
TLINE	.SBYTE	"      "
	.SBYTE	+$80,"000"
	.SBYTE	"       "
TOPLINE	.BYTE	1,$46,0,$46,0,0,$41,0
	.BYTE	$41,0,$41,0,$46,0,$46,5
LLINE	.BYTE	3,$46,0,$46,0,0,$41,0
	.BYTE	$41,0,$41,0,$46,0,$46,2
RLINE	.BYTE	1,$46,0,$46,0,0,$41,0
	.BYTE	$41,0,$41,0,$46,0,$46,4
INFOLN	.SBYTE	"SC "
SSCORE	.SBYTE	+$80,"000000"
	.SBYTE	" MEN "
MENBYT	.SBYTE	+$80,"0"
	.SBYTE	" HI "
HISCORE	.SBYTE	+$80,"000000"
	.SBYTE	" LEV "
LEVBYTE	.SBYTE	+$80,"0"
OVERLN	.SBYTE	"   GAME OVER    "
;
; Music Data
;
BASSLO	.BYTE	$6B,$6B,$96,$6B
	.BYTE	$EA,$6B,$03,$64
BASSHI	.BYTE	$35,$35,$2F,$35
	.BYTE	$2C,$35,$28,$2A
BASENV	.BYTE	$A2,$A6,$AA,$A8
	.BYTE	$A8,$A8,$A8,$A8
	.BYTE	$A8,$A8,$A7,$A5
	.BYTE	$A3,$A0,$A0
TREBLE	.BYTE	68,81,0,68,40,57,0,81
	.BYTE	68,60,57,0,57,0,57,0
	.BYTE	57,60,68,81,91,81,108
	.BYTE	96,0,0
TRBDUR	.BYTE	114,34,89,114,19,19,99
	.BYTE	14,14,14,19,0,18,0,18
	.BYTE	0,18,19,19,19,19,19,14
	.BYTE	14,127,80
;
; The Game Display List
;
DLIST	.BYTE	$70,$70,$C6
MSG	.WORD	TLINE
	.BYTE	$C7
	.WORD	TOPLINE
	.BYTE	$C7
	.WORD	LLINE
	.BYTE	$C7
	.WORD	RLINE
	.BYTE	$C7
	.WORD	LLINE
	.BYTE	$C7
	.WORD	RLINE
	.BYTE	$C7
	.WORD	LLINE
	.BYTE	$C7
	.WORD	RLINE
	.BYTE	$C7
	.WORD	LLINE
	.BYTE	$C7
	.WORD	RLINE
	.BYTE	$C7
	.WORD	LLINE
	.BYTE	$C7
	.WORD	RLINE
	.BYTE	$10,$46
	.WORD	INFOLN
	.BYTE	$06,$41
	.WORD	DLIST
;
; Title Screen Display List
;
TDLIST	.BYTE	$70,$70,$70,$70
	.BYTE	$70,$70,$47
	.WORD	GAME
	.BYTE	$70,$17,$70,$70,$46
	.WORD	AUTHOR
	.BYTE	$70,$70,$46
	.WORD	COPYR
	.BYTE	$70,$06,$70,$70,$56
	.WORD	INSTR
	.BYTE	$70,$70,$41
	.WORD	TDLIST
;
GAME	.SBYTE	"    ELEVATOR    "
	.SBYTE	"     REPAIRMAN      "
AUTHOR	.SBYTE	"BY FRED CAPRILLI"
COPYR	.SBYTE	"    (C) 1985    "
	.SBYTE	"ANALOG COMPUTING"
INSTR	.SBYTE	"    press"
	.SBYTE	" start     "
;
;MODIFIED CHARACTER SET
;
CSETB	.BYTE	$00,$00,$00,$00
	.BYTE	$00,$00,$00,$00
	.BYTE	$80,$80,$80,$80
	.BYTE	$80,$80,$80,$80
	.BYTE	$01,$01,$01,$01
	.BYTE	$01,$01,$01,$01
	.BYTE	$80,$FF,$80,$FF
	.BYTE	$80,$FF,$80,$FF
	.BYTE	$01,$FF,$01,$FF
	.BYTE	$01,$FF,$01,$FF
	.BYTE	$3C,$7E,$7E,$E7
	.BYTE	$E7,$FF,$FF,$FF
	.BYTE	$08,$08,$08,$08
	.BYTE	$08,$08,$08,$08
;
	*=	$02E0
;
	.WORD	INIT
	.END
