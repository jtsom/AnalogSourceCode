;*****************************
;*            BONK           *
;*      Copyright  1984      *
;* Programmed by James Hague *
;*  Using MAC/65 by OSS Inc. *
;*****************************
;
;HARDWARE REGISTERS
;
RANDOM	=	$D20A	;Random #s
GRACTL	=	$D01D	;Graphic ctrl
AUDC1	=	$D201	;Audio controls
AUDC2	=	$D203
AUDC3	=	$D205
AUDC4	=	$D207
AUDF1	=	$D200	;Audio frequency
AUDF2	=	$D202
AUDF3	=	$D204
AUDF4	=	$D206
AUDCTL	=	$D208
HPOSP0	=	$D000	;Pl. 0 horiz.
HPOSP1	=	$D001	;Pl. 1 horiz.
P0PF	=	$D004	;P0 to PF coll.
P0PL	=	$D00C	;P0 to PL coll.
HITCLR	=	$D01E	;Collision clear
CONSOL	=	$D01F	;Console buttons
PMBASE	=	$D407
SETVBV	=	$E45C	;VBLANK vectors
XITVBV	=	$E462	;VBLANK exit
SIOINV	=	$E465	;Initialize SIO
;
;SHADOW REGISTERS
;
CLOCK	=	$14	;Real time clock
ATTRACT	=	$4D
DMACTL	=	$022F	;DMA control
SDLSTL	=	$0230	;Dlist pointer
GPRIOR	=	$026F
STICK	=	$0278	;Joystick 0
COL0	=	$02C4	;Color regs.
COL1	=	$02C5
COL2	=	$02C6
COL3	=	$02C7
PCOL0	=	$02C0	;Player colors
PCOL1	=	$02C1
CHBAS	=	$02F4	;Character base
CH	=	$02FC	;Keyboard buffer
;
	*=	$80
;
;GAME VARIABLES
;
SCORE	.DS	3	;Player's score
LEVEL	.DS	1	;Current level
SLEVEL	.DS	1	;Starting level
BLEVEL	.DS	1	;Binary level
BOARD	.DS	1	;Current board
LIVES	.DS	1	;Remaining lives
TIME	.DS	2	;Bonus timer
DIE	.DS	1	;Death flag
P0Y	.DS	1	;Pl0 y position
P0X	.DS	1	;Pl0 x position
GAMCTL	.DS	1	;Game control
ENXPOS	.DS	3	;Enemy X pos.
ENYPOS	.DS	3	;Enemy Y pos.
ENXADD	.DS	1	;Enemy X add
ENYADD	.DS	1	;Enemy Y add
ENBOUN	.DS	3	;En bounce flags
ENDIR	.DS	3	;Enemy direction
BDIST	.DS	1	;Bounce distance
ENAN	.DS	1	;Enemy pointer
PLAN	.DS	1	;Play. pointer
FLASH	.DS	1	;Treas. flasher
FREEZE	.DS	2	;Freeze timers
FTIME	.DS	1	;Freeze time
WAIT	.DS	4	;Time delay
TEMP	.DS	2	;Temp storage
DIR	.DS	1	;Jstick direct.
TOTAL	.DS	1	;Jewels/board
COUNT	.DS	1	;Jewels/taken
BONK	.DS	1	;Bounce sound
DING	.DS	1	;Bell sound
WSND	.DS	1	;Eat wall sound
ENEMY	.DS	10	;Enemy image
PLAYER	.DS	8	;Player image
LO	.DS	2	;General pointer
VLO	.DS	2	;Ditto
POINT	.DS	2	;Play. pointer
;
;RESERVED MEMORY
;
	*=	$2000
;
PM	.DS	$0400	;Pmbase
PL0	.DS	$0100
PL1	.DS	$0100
PL2	.DS	$0100
PL3	.DS	$0100
;
DISP	=	$1D00	;Display area
CHSET	=	$2000	;New char set
LOTBL	=	$2200	;Plotter table
HITBL	=	LOTBL+50
;
	*=	$2800	;Program start
;
;SET-UP PLOTTER
;
GAME	JSR	SIOINV	;Init sounds
	LDA	# <DISP+80
	STA	LO
	LDA	# >DISP+80
	STA	LO+1
	LDX	#2
SEPL	LDA	LO+1
	STA	HITBL,X
	LDA	LO
	STA	LOTBL,X
	CLC
	ADC	#20
	STA	LO
	BCC	SEP2
	INC	LO+1
SEP2	INX
	CPX	#24
	BNE	SEPL
	LDA	#0
	STA	SLEVEL
;
;REDEFINE CHARSET
;
	TAX		;Move set
MSET	LDA	$E000,X
	STA	CHSET,X
	LDA	$E0FF,X
	STA	CHSET+$FF,X
	INX
	BNE	MSET
	LDA	# >CHSET	;Install it
	STA	CHBAS
	LDX	#119	;Redefine set
RDEF	LDA	CDAT,X
	STA	CHSET+8,X
	DEX
	BPL	RDEF
	LDX	#7
RDEF2	LDA	CDAT2,X
	STA	CHSET+216,X
	DEX
	BPL	RDEF2
;
GO	LDA	#0	;Turn off VBI
	STA	GAMCTL
	JSR	PMCLR	;No players
	JSR	QUIET	;No sound
;
;TITLE SCREEN
;
	LDA	# <TDL	;Point to title
	STA	SDLSTL	;screen display
	LDA	# >TDL	;list.
	STA	SDLSTL+1
	LDA	#200	;Set up title
	STA	COL0	;colors.
	LDA	#120
	STA	COL1
	LDA	#70
	STA	COL2
;
START	LDA	CONSOL	;Start key
	ROR	A	;pressed?
	BCC	ST1	;Yes!
;
;LEVEL SELECTION
;
	ROR	A	;Select pressed?
	BCS	START	;No, skip this.
	INC	SLEVEL	;Yes, start at
	LDA	SLEVEL	;next level.
	CMP	#9	;Highest level?
	BNE	Z1	;No, continue.
	LDA	#0	;Yes, reset and
	STA	SLEVEL	;store it.
Z1	CLC		;Add 1 to start-
	ADC	#1	;ing level #
	ORA	#16	;Add color
	STA	TITLE+73	;and show it
Z2	LDA	CONSOL	;Get keys again
	CMP	#5	;Key released?
	BEQ	Z2	;No, wait for it
	BNE	START	;Branch always!
;
ST1	LDA	CONSOL
	ROR	A
	BCC	ST1
	LDA	#0	;Set variables
	STA	SCORE	;that are set
	STA	SCORE+1	;once per game.
	STA	SCORE+2
	STA	BOARD
	LDA	#3	;3 lives
	STA	LIVES
	LDA	SLEVEL	;Set level
	STA	LEVEL
	STA	BLEVEL
;
NEWLEV	LDA	#0	;Turn off VBI
	STA	GAMCTL
	LDA	LEVEL	;Get BCD level
	SED
	CLC
	ADC	#1	;And raise it
	CLD
	STA	LEVEL	;Then store.
	LDX	BLEVEL	;Get bin. level
	CPX	#15	;Highest level?
	BEQ	SAMEL	;Yes, keep it.
	INC	BLEVEL	;No, raise it.
SAMEL	LDX	BOARD	;Get board #
	CPX	#3	;Highest board?
	BEQ	BRD1	;Yes, reset
	INC	BOARD	;and store
	BNE	SETLEV	;Branch always!
;
BRD1	LDX	#1	;Reset board #
	STX	BOARD
	LDA	LIVES	;And give extra
	CMP	#9	;life
	BEQ	SETLEV
	INC	LIVES
SETLEV	LDX	BLEVEL	;Binary level
	LDA	DEL1-1,X	;Set up delay
	STA	WAIT
	LDA	#5
	STA	WAIT+2
	LDA	BOUN-1,X	;Get bounces
	STA	BDIST
	LDA	FTM-1,X	;Get freeze time
	STA	FTIME
	LDX	BOARD	;Board #
	LDA	TOT-1,X	;Get jewels
	STA	TOTAL
	LDA	# <DL	;Install DL
	STA	SDLSTL
	LDA	# >DL
	STA	SDLSTL+1
;
NEWLIFE	JSR	QUIET	;No sound.
	LDA	#0	;Zero items
	STA	GAMCTL	;that must be
	STA	DIE	;zeroed for each
	STA	COUNT	;new life
	STA	DIR
	STA	HITCLR
	STA	ENXADD
	STA	ENYADD
	STA	WAIT+1
	STA	WAIT+3
	STA	TIME+1
	STA	ENAN	;Reset pointers
	STA	PLAN
	STA	FLASH
	LDX	BLEVEL	;Set timer
	LDA	TIM-1,X
	STA	TIME
	LDY	# <VBI	;Deferred VBI
	LDX	# >VBI
	LDA	#7
	JSR	SETVBV
;
;DRAW SCREEN
;
	LDA	BOARD	;Get board #
	ASL	A	;Times 2
	TAX		;use as index
	LDA	BDTBL-2,X	;Board lo byte
	STA	LO
	LDA	BDTBL-1,X	;Hi byte of it
	STA	LO+1
	LDY	#0	;Draw 1st part
DR1	LDA	(LO),Y	;Get screen byte
	STA	DISP+80,Y	;and show it
	INY
	CPY	#240
	BNE	DR1
	CLC
	LDA	LO	;point to part 2
	ADC	#240
	STA	LO
	BCC	DR2
	INC	LO+1
DR2	LDY	#0
DR3	LDA	(LO),Y	;Get byte
	STA	DISP+320,Y
	INY
	CPY	#240
	BNE	DR3
;
;INITIALIZE
;
	LDA	#104	;Color 0 is
	STA	COL0	;purple
	LDA	#200	;Color 1 is
	STA	COL1	;green
	LDA	#0	;Color 2 is
	STA	COL2	;black
	LDA	#134	;Color 3 is
	STA	COL3	;blue
	LDX	#39	;Print score
PS	LDA	SCL,X	;line
	STA	DISP,X
	LDA	#0
	STA	DISP+40,X
	DEX
	BPL	PS
	JSR	SHOSC	;Show score
	JSR	SHOBO	;Show bonus
	JSR	SHOLI	;Show lives
	LDA	LEVEL	;Show level
	LDY	#74
	JSR	BCD
	LDA	BOARD	;Set initial
	ASL	A	;player
	ASL	A	;positions.
	TAX
	LDA	IX-4,X	;Set player X
	STA	P0X
	LDA	IY-4,X	;and Y
	STA	P0Y
	INX
	LDY	#2	;Set all enemy
SET	LDA	IX-4,X	;X
	STA	ENXPOS,Y
	LDA	IY-4,X	;Y
	STA	ENYPOS,Y
	LDA	#0
	STA	ENDIR,Y	;Zero enemy
	STA	ENBOUN,Y	;status
	INX
	DEY
	BPL	SET	;Finish up
;
;P/M SET UP
;
	JSR	PMCLR	;Clear players
	LDA	# >PM	;Point to PM
	STA	PMBASE	;area
	LDA	#2	;Set gractl
	STA	GRACTL
	LDA	#62	;Set dmactl
	STA	DMACTL
	LDA	#1	;Set priority
	STA	GPRIOR
	LDA	#218	;Set pl0 color
	STA	PCOL0
	LDA	#26	;Set enemy color
	STA	PCOL1
	STA	PCOL1+1
	STA	PCOL1+2
	LDA	P0X	;Draw player
	STA	HPOSP0	;Set x pos.
	LDY	P0Y	;Get y
	LDX	#0
PD	LDA	PDAT,X	;Get player byte
	STA	PLAYER,X
	STA	PL0,Y	;And show it
	INY
	INX
	CPX	#8
	BNE	PD
	LDX	#9	;Copy enemy data
CD	LDA	EDAT,X	;from memory to
	STA	ENEMY,X	;animation table
	DEX
	BPL	CD
	JSR	DRAWEN	;Draw enemy
	LDA	#170	;Introduction
	STA	AUDC1
	LDX	#5
IN	LDA	MUSIC,X
	STA	AUDF1
	LDA	#5
	JSR	DELAY
	DEX
	BPL	IN
	JSR	QUIET
	LDA	#40
	JSR	DELAY
	LDA	#$FF	;Turn on the
	STA	GAMCTL	;VBI
;
;MAIN LOOP
;
MAIN	JSR	ENMOVE	;Move enemy
	JSR	SHOSC	;Show score
	JSR	SHOBO	;Show bonus
M1	LDA	CONSOL	;Start pressed?
	ROR	A
	BCC	M4	;Yes.
	LDA	CH
	CMP	#$21	;Space bar?
	BNE	M2	;No.
	LDA	#$FF
	STA	CH	;Reset keycode
	EOR	GAMCTL	;Flip pause
	STA	GAMCTL
	BNE	M2
	JSR	HUSH	;Peace and...
M2	LDA	GAMCTL
	BEQ	M1
	LDA	DIE	;Player dead?
	BNE	M3	;Yes.
	LDA	TIME	;Time up?
	BEQ	M3
	LDA	COUNT	;Level done?
	CMP	TOTAL
	BNE	MAIN
	JMP	LDONE
M3	JMP	KILL	;Auuughh!
M4	JMP	GO
;
;CLEAR PM
;
PMCLR	LDA	#0
	TAX
PC	STA	PL0,X
	STA	PL1,X
	STA	PL2,X
	STA	PL3,X
	INX
	BNE	PC
DE3	RTS
;
;SOUND OFF
;
QUIET	LDA	#0	;Turn off sound
	STA	BONK
	STA	DING
	STA	FREEZE
	STA	WSND
HUSH	STA	AUDC1
	STA	AUDC2
	STA	AUDC3
	STA	AUDC4
	STA	AUDCTL
	RTS
;
;DRAW ENEMY
;
DRAWEN	LDA	# <PL1	;Draw all 3
	STA	POINT	;enemy
	LDA	# >PL1
	STA	POINT+1
	LDA	#0
	STA	TEMP
DE1	LDX	TEMP
	CPX	#3
	BEQ	DE3
	LDA	ENXPOS,X	;Set x position
	STA	HPOSP1,X
	LDY	ENYPOS,X
	LDX	#0
DE2	LDA	ENEMY,X
	STA	(POINT),Y
	INY
	INX
	CPX	#10
	BNE	DE2
	INC	TEMP
	INC	POINT+1
	JMP	DE1
;
;VBI
;
VBI	CLD		;Kill decimal!
	LDA	GAMCTL	;Do this VBI?
	BEQ	EXIT	;No! Get out!
	JSR	PCHK	;Check player
	JSR	STUFF	;Do work
	JSR	ANIM	;Animate
	JSR	PLMOVE	;Move player
	JSR	SOUND	;Make noise
EXIT	STA	HITCLR	;Clear all hits
	JMP	XITVBV	;Go home!
;
;MOVE PLAYER
;
PLMOVE	LDX	#7	;1st- erase
	LDY	P0Y	;player
	LDA	#0
	STA	ATTRACT	;Kill attract
ERPL	STA	PL0,Y
	INY
	DEX
	BPL	ERPL
	LDX	STICK	;2nd- get new
	STX	DIR	;player position
	LDA	P0X	;Get x position
	CLC		;then add offset
	ADC	XOFF-5,X	;to old coord
	STA	P0X	;Save new pos.
	STA	HPOSP0	;and show it
	LDA	P0Y	;Now repeat for
	CLC		;y position.
	ADC	YOFF-5,X
	STA	P0Y
	LDX	#7	;3rd- redraw
	TAY
DRPL	LDA	PLAYER,X
	STA	PL0,Y
	INY
	DEX
	BPL	DRPL
	RTS
;
;ENEMY HANDLER
;
ENMOVE	LDA	FREEZE	;Frozen?
	BNE	TWX	;Yup, ice cold.
	LDA	WAIT+1	;Get 1st timer
	BEQ	TWO	;If 0, do next.
	DEC	WAIT+1	;Decrement 1st
	RTS		;And leave.
;
TWO	LDA	WAIT	;Reset 1st timer
	STA	WAIT+1
	LDA	WAIT+3	;Get 2nd timer
	BEQ	MOVE	;If 0, move 'em
	DEC	WAIT+3	;Decrement 2nd
TWX	RTS
;
MOVE	LDA	WAIT+2	;Reset 2nd
	STA	WAIT+3
	LDX	#0	;Main counter
DOMOR	JSR	CHECK	;Check enemy
	LDA	ENBOUN,X	;Bouncing?
	BEQ	NOB	;No, continue.
	DEC	ENBOUN,X	;Yes,
	JMP	OUT	;Do next enemy.
;
NOB	LDA	ENXPOS,X	;Get x pos
	CMP	P0X	;Comp with play
	BCC	XLES	;Less than?
	BNE	XMOR	;More than?
	LDA	#0	;Equal to, stop
	BEQ	DOY	;movement.
XMOR	LDA	#$FF	;More than, move
	BNE	DOY	;left.
XLES	LDA	#1	;Less than, move
DOY	STA	ENXADD	;right.
	LDA	ENYPOS,X	;Get y pos
	CMP	P0Y	;Comp eith play
	BCC	YLES	;Less than?
	BNE	YMOR	;More than?
	LDA	#0	;Equal to, stop
	BEQ	FINI	;movement.
YMOR	LDA	#$FF	;More than, move
	BNE	FINI	;left.
YLES	LDA	#1	;Less than, move
FINI	STA	ENYADD	;right.
	LDY	#8	;Convert to dir
CDIR	LDA	ENXADD	;Is x direction
	CMP	ENX,Y	;correct?
	BNE	AGA	;No, check more.
	LDA	ENYADD	;Is y direction
	CMP	ENY,Y	;correct?
	BNE	AGA	;Nope.
	TYA
	STA	ENDIR,X	;It's correct!
	BPL	OUT	;Branch always!
;
AGA	DEY		;Continue
	BPL	CDIR	;searching
OUT	LDA	ENDIR,X	;Get direction
	TAY
	LDA	ENXPOS,X	;Update x pos
	CLC
	ADC	ENX,Y
	STA	ENXPOS,X
	LDA	ENYPOS,X	;Update y
	CLC
	ADC	ENY,Y
	STA	ENYPOS,X
	INX
	CPX	#3
	BNE	DOMOR
	JMP	DRAWEN	;Draw enemy
;
CHECK	LDA	ENDIR,X	;Check if the
	TAY		;enemy hit
	LDA	ENXPOS,X	;anything
	SEC		;1st, scan on
	SBC	SCX,Y	;x axis
	LSR	A
	LSR	A
	LSR	A
	STA	ENXADD
	LDA	ENYPOS,X	;2nd, scan on
	SEC		;y axis
	SBC	SCY,Y
	LSR	A
	LSR	A
	LSR	A
	TAY		;Now, get point
	LDA	LOTBL,Y
	STA	LO
	LDA	HITBL,Y
	STA	LO+1
	LDY	ENXADD
	LDA	(LO),Y
	AND	#$3F	;Mask off color
	BEQ	L0	;Hit anything?
	CMP	#27	;Hit diamond?
	BEQ	L0	;Yup, forget it
	CMP	#$0F	;Hit freezer?
	BEQ	L0	;Yup, who cares
	LDA	BDIST	;A hit! Make the
	STA	ENBOUN,X	;enemy bounce!
	LDA	#16	;Set sound
	STA	AUDF1
	LDA	#6
	STA	AUDC1
	STA	BONK
	LDA	RANDOM	;Get new direct.
	AND	#3
	TAY
	LDA	BDIR,Y
	STA	ENDIR,X
	BPL	CHECK	;Check it out!
;
;CHECK PLAYER
;
PCHK	LDA	P0Y	;Get y pos
	SEC		;And convert to
	SBC	#28	;screen position
	LSR	A
	LSR	A
	LSR	A
	TAY		;Get address
	LDA	LOTBL,Y
	STA	VLO
	LDA	HITBL,Y
	STA	VLO+1
	LDA	P0X	;Now convert x
	SEC
	SBC	#44
	LSR	A
	LSR	A
	LSR	A
	TAY
	LDA	(VLO),Y	;Get point
	AND	#$3F	;Mask out color
	BEQ	L0	;Nothing there
	CMP	#$0F	;Hit freezer?
	BEQ	HITFR	;Yup, handle it
	CMP	#$1B	;Hit diamond?
	BEQ	HITDI	;Yup, fix it
	LDA	(VLO),Y	;Get point
	AND	#192	;Get color used
	CMP	#64	;Hit weak wall?
	BNE	L0	;No, leave.
;
;Hit weak wall
;
	LDA	#3	;Set sound
	STA	WSND
	LDA	#240
	STA	AUDF4
	LDA	#200
	STA	AUDC4
HITX	LDA	#0	;Erase wall
	STA	(VLO),Y
L0	RTS
;
;Hit diamond
;
HITDI	LDA	#$70	;Give points
	JSR	ADD
	LDA	#16	;Set sound
	STA	DING
	LDA	#130
	STA	AUDF2
	INC	COUNT	;Count it
	JMP	HITX
;
;Hit freezer
;
HITFR	JSR	HITX	;Erase freezer
	LDA	FTIME	;Set freeze time
	STA	FREEZE
	LDA	#5
	STA	FREEZE+1
	LDA	#166	;Set sound
	STA	AUDC3
	LDA	#$50	;Give points
;
;SCORE ROUTINES
;
ADD	SED		;Add points to
	CLC		;score
	ADC	SCORE
	STA	SCORE
	LDA	#0
	ADC	SCORE+1
	STA	SCORE+1
	LDA	#0
	ADC	SCORE+2
	STA	SCORE+2
	CLD
	RTS
;
SHOBO	LDA	TIME	;Show bonus
	LDY	#54
;
BCD	PHA		;Show 1 bcd
	SEC
	ROR	A
	LSR	A
	LSR	A
	LSR	A
	STA	DISP,Y
	INY
	PLA
	AND	#$0F
	ORA	#$10
	STA	DISP,Y
	RTS
;
SHOSC	LDX	#2	;Show score
	LDY	#42
SS	LDA	SCORE,X
	JSR	BCD
	INY
	DEX
	BPL	SS
	RTS
;
SHOLI	LDA	LIVES	;Show lives
	LDY	#64
	BNE	BCD
;
;SOUND ROUTINES
;
SOUND	LDY	BONK	;Bounce sound?
	BEQ	T1	;No
	DEY
	STY	BONK
	STY	AUDC1
T1	LDY	DING	;Bell sound?
	BEQ	T2	;No
	DEY
	STY	DING
	TYA
	ORA	#$A0
	STA	AUDC2
T2	LDA	FREEZE	;Freezer sound?
	BEQ	T3	;No
	LDY	FREEZE+1
	LDA	FSND,Y
	STA	AUDF3
	DEC	FREEZE+1
	BNE	T3
	LDA	#5
	STA	FREEZE+1
	DEC	FREEZE
	BNE	T3
	LDA	#0
	STA	AUDC3
T3	LDA	WSND	;Wall sound?
	BEQ	T4	;No
	DEC	WSND
	BNE	T4
	LDA	#0
	STA	AUDC4
T4	RTS
;
;FLASH JEWELS
;
STUFF	INC	FLASH	;Handle flash
	LDA	FLASH	;timers.
	CMP	#20
	BNE	S1
	LDA	#0
	STA	FLASH
	LDA	#104
	CMP	COL0
	BNE	S2
	LDA	#10
S2	STA	COL0
;
;HANDLE TIME
;
S1	INC	TIME+1	;Count down
	LDA	TIME+1
	CMP	#60	;We interrupt
	BNE	S3	;this program
	LDA	#0	;for an import-
	STA	TIME+1	;ant news
	LDA	TIME	;bulletin:
	SED		;  HI MOM!
	SEC
	SBC	#1
	CLD
	STA	TIME
S3	LDA	P0PL	;Check player
	STA	DIE	;collisions
	LDA	P0PF
	AND	#8
	BEQ	S4
	STA	DIE
S4	RTS
;
;ANIMATE
;
ANIM	LDA	ENAN	;Animate enemy.
	CLC		;Hey guys, look!
	ADC	#10	;Your names are
	CMP	#50	;in print :
	BNE	A1	; David Hague
	LDA	#0	; Robbie Hague
A1	STA	ENAN	; Martin Beck
	TAY		; Nathan Zink
	LDX	#9	;and everyone's
A2	LDA	EDAT,Y	;favorite:
	STA	ENEMY,X	; A. ZLOTNICK!
	INY		;Tron to you!
	DEX		;(No you don't
	BPL	A2	;get paid)
	LDA	DIR	;Animate player
	CMP	#15	;by storing a
	BEQ	A3	;different image
	LDA	PLAN	;in the player
	CLC		;animation table
	ADC	#8
	CMP	#64
	BNE	A4	;Is this game
A3	LDA	#0	;better than
A4	STA	PLAN	;The Electroids?
	TAY
	LDX	#7
A5	LDA	PDAT,Y
	STA	PLAYER,X
	INY
	DEX
	BPL	A5
	RTS
;
;TIME DELAY
;
DELAY	STA	TEMP	;Enter with
	LDA	#0	;length of pause
	STA	CLOCK	;(in jiffies) in
D0	LDA	CLOCK	;the accumulator
	CMP	TEMP
	BEQ	S4
	LDA	CONSOL
	CMP	#7
	BEQ	D0
	JMP	GO
;
;DIE
;
KILL	LDA	#0	;Stop movement
	STA	GAMCTL
	JSR	QUIET	;No sound
	DEC	LIVES	;Take a life
	JSR	SHOLI	;And show them.
	LDA	#204
	STA	AUDC1
	LDX	#40	;Kill player
K1	INC	P0X	;1st shift
	LDA	P0X
	STA	HPOSP0
	LDA	RANDOM
	STA	AUDF1
	LDA	#1
	JSR	DELAY
	DEC	P0X	;2nd shift
	LDA	P0X
	STA	HPOSP0
	LDA	RANDOM
	STA	AUDF1
	LDA	#1
	JSR	DELAY
	DEX
	BPL	K1	;Repeat again.
	JSR	QUIET
	LDA	LIVES	;Any lives?
	BEQ	OVR
	JMP	NEWLIFE
;
;GAME OVER
;
OVR	LDX	#9	;Show GAME OVER
O1	LDA	GOVR,X
	STA	DISP+305,X
	DEX
	BPL	O1
	JSR	PMCLR
	LDA	#255
	JSR	DELAY
	JMP	GO
;
;LEVEL DONE
;
LDONE	LDA	#0	;Stop movement
	STA	GAMCTL
	JSR	QUIET	;No sound
C1	LDA	TIME	;Give 10 points
	SED		;for each second
	SEC		;left on the
	SBC	#1	;timer.
	STA	TIME
	CLD
	JSR	SHOBO	;Add points for
	LDA	#$10	;time remaining
	JSR	ADD	;and make bell
	JSR	SHOSC	;tones by vary-
	LDA	#50	;ing the volume
	STA	AUDF1	;of voice 1.
	LDY	#164
C2	STY	AUDC1
	LDA	#1
	JSR	DELAY
	DEY
	CPY	#160
	BNE	C2
	LDA	TIME
	BNE	C1
	JSR	QUIET	;Kill noise
	JMP	NEWLEV	;Start new level
;
;CHARACTER DATA
;
CDAT	.BYTE	0,0,255,255,255,255,0
	.BYTE	0,60,60,60,60,60,60
	.BYTE	60,60,0,0,248,252,252
	.BYTE	252,60,60,0,0,31,63,63
	.BYTE	63,60,60,60,60,252,252
	.BYTE	252,248,0,0,60,60,63
	.BYTE	63,63,31,0,0,60,124
	.BYTE	252,252,252,252,124,60
	.BYTE	60,62,63,63,63,63,62
	.BYTE	60,0,0,255,255,255,255
	.BYTE	126,60,60,126,255,255
	.BYTE	255,255,0,0,0,24,60,60
	.BYTE	60,60,60,60,60,60,60
	.BYTE	60,60,60,24,0,0,0,252
	.BYTE	254,254,252,0,0,0,0,63
	.BYTE	127,127,63,0,0,255,129
	.BYTE	189,161,185,161,129
	.BYTE	255
CDAT2	.BYTE	0,126,255,126,60,24,0
	.BYTE	0
;
;LEVEL DATA
;
DEL1	.BYTE	40,37,35,31,29,25
	.BYTE	24,23,22,21,20,19,18
	.BYTE	17,16
BOUN	.BYTE	50,45,40,30,25,25
	.BYTE	25,25,25,25,25,25,25
	.BYTE	25,25
FTM	.BYTE	25,24,23,22,21,20
	.BYTE	19,18,17,16,15,14,13
	.BYTE	12,11
TOT	.BYTE	16,14,26
TIM	.BYTE	$60,$60,$55,$55,$50
	.BYTE	$50,$45,$45,$40,$40
	.BYTE	$40,$40,$40,$40,$40
BDTBL	.WORD	BD1,BD2,BD3
;
;INSTALL DISPLAY LIST
;
DL	.BYTE	$70,$70,$70,$42
	.WORD	DISP
	.BYTE	2,$46
	.WORD	DISP+80
	.BYTE	6,6,6,6,6,6,6,6,6,6,6
	.BYTE	6,6,6,6,6,6,6,6,6,6
	.BYTE	$41
	.WORD	DL
;
SCL	.SBYTE	"  SCORE:    BONUS: "
	.SBYTE	"   LIVES:    LEVEL:"
	.SBYTE	"  "
;
TDL	.BYTE	$70,$70,$70,$70,$70
	.BYTE	$70,$70,$70,$70,$47
	.WORD	TITLE
	.BYTE	$70,6,$70,7,$70,6
	.BYTE	$70,6,6,$41
	.WORD	TDL
;
TITLE	.SBYTE	"        BoNk     "
	.SBYTE	+$80,"    COPYRIGH"
	.SBYTE	+$80,"T 1984 BY:  "
	.SBYTE	"   JAMES  HAGUE  "
	.SBYTE	"        level: 1 "
	.SBYTE	+$80,"       SELEC"
	.SBYTE	+$80,"T FOR LEVEL "
	.SBYTE	+$80,"    START TO"
	.SBYTE	+$80," BEGIN   "
;
IX	.BYTE	72,126,126,184
	.BYTE	128,96,152,128
	.BYTE	80,80,146,184
IY	.BYTE	120,72,192,120
	.BYTE	72,96,96,208
	.BYTE	210,168,104,128
;
; PLAYER, ENEMY, MUSIC DATA
;
PDAT	.BYTE	254,214,254,16,124,108
	.BYTE	108,238,254,214,254
	.BYTE	16,124,108,236,14,254
	.BYTE	214,254,16,124,236,12
	.BYTE	14,254,214,254,16,124
	.BYTE	108,236,14,254,214,254
	.BYTE	16,124,108,108,238,254
	.BYTE	214,254,16,124,108,110
	.BYTE	224,254,214,254,16,124
	.BYTE	110,96,224,254,214,254
	.BYTE	16,124,108,110,224
EDAT	.BYTE	0,32,32,63,60,60,252
	.BYTE	4,4,0,0,16,16,60,63
	.BYTE	252,60,8,8,0,0,8,8,60
	.BYTE	252,63,60,16,16,0,0,4
	.BYTE	4,252,60,60,63,32,32,0
	.BYTE	0,129,66,60,60,60,60
	.BYTE	66,129,0
MUSIC	.BYTE	160,0,160,130,140,150
;
;X,Y OFFSETS + MISC.
;
XOFF	.BYTE	1,1,1,0,$FF
	.BYTE	$FF,$FF,0,0,0,0
YOFF	.BYTE	1,$FF,0,0
	.BYTE	1,$FF,0,0,1,$FF,0
ENX	.BYTE	0,0,1,1,1,0,$FF,$FF
	.BYTE	$FF
ENY	.BYTE	0,$FF,$FF,0,1,1,1,0
	.BYTE	$FF
SCX	.BYTE	44,44,42,42,42,44,46
	.BYTE	46,46
SCY	.BYTE	28,30,30,28,26,26,26
	.BYTE	28,30
BDIR	.BYTE	2,4,6,8
FSND	.BYTE	0,200,220,210,230,150
GOVR	.SBYTE	"GAME  OVER"
;
;BOARD DATA
;
BD1	.SBYTE	+$A0,"DAAAAIAAAAAAAA"
	.SBYTE	+$A0,"IAAAACB@"
	.SBYTE	";"
	.SBYTE	+$20,"@@B@@@@@@@@B@@"
	.SBYTE	";"
	.SBYTE	+$A0,"@BB@@"
	.SBYTE	";"
	.SBYTE	+$20,"@B@@@@@@@@B@"
	.SBYTE	";"
	.SBYTE	+$A0,"@@BB@@@"
	.SBYTE	";"
	.SBYTE	+$20,"B@@@@@@@@B"
	.SBYTE	";"
	.SBYTE	+$A0,"@@@BH"
	.SBYTE	+$20,"AAAAE@@@@@@@@F"
	.SBYTE	+$20,"AAAA"
	.SBYTE	+$A0,"GB@@@@@@@@@@@@"
	.SBYTE	+$A0,"@@@@@@BB@@@@@@"
	.SBYTE	+$A0,"@@@@@@@@@@@@BB"
	.SBYTE	+$A0,"@@@@@@DAAAAC@@"
	.SBYTE	+$A0,"@@@@BB@@@@DAJA"
	.SBYTE	+$A0,"IIAJAC@@@@BHC@"
	.SBYTE	+$20,"@@B@"
	.SBYTE	";"
	.SBYTE	+$A0,"@BB@@"
	.SBYTE	";"
	.SBYTE	+$20,"B@@@"
	.SBYTE	+$A0,"DGBB"
	.SBYTE	+$20,"@@@B@@O"
	.SBYTE	+$A0,"BB@"
	.SBYTE	+$20,"O@B@@@"
	.SBYTE	+$A0,"BBHE@@"
	.SBYTE	+$20,"@B@"
	.SBYTE	";"
	.SBYTE	+$A0,"@BB@@"
	.SBYTE	";"
	.SBYTE	+$20,"B@@@"
	.SBYTE	+$A0,"FGB@@"
	.SBYTE	+$A0,"@@FAIAJJAIAE@@"
	.SBYTE	+$A0,"@@BB@@@@@@FAAA"
	.SBYTE	+$A0,"AE@@@@@@BB@@@@"
	.SBYTE	+$A0,"@@@@@@@@@@@@@@"
	.SBYTE	+$A0,"BB@@@@@@@@@@@@"
	.SBYTE	+$A0,"@@@@@@BB@@@@@@"
	.SBYTE	+$A0,"@@@@@@@@@@@@BH"
	.SBYTE	+$20,"AAAAC@@@@@@@@D"
	.SBYTE	+$20,"AAAA"
	.SBYTE	+$A0,"GB@@@"
	.SBYTE	";"
	.SBYTE	+$20,"B@@@@@@@@B"
	.SBYTE	";"
	.SBYTE	+$A0,"@@@BB@@"
	.SBYTE	";"
	.SBYTE	+$20,"@B@@@@@@@@B@"
	.SBYTE	";"
	.SBYTE	+$A0,"@@BB@"
	.SBYTE	";"
	.SBYTE	+$20,"@@B@@@@@@@@B@@"
	.SBYTE	";"
	.SBYTE	+$A0,"@BFAAAAJAAAAAA"
	.SBYTE	+$A0,"AAJAAAAE"
;
BD2	.SBYTE	+$A0,"DAAAAAAAAAAAA"
	.SBYTE	+$A0,"AAAAAACB@"
	.SBYTE	";"
	.SBYTE	+$A0,"@@@@@@@@@@@@@@"
	.SBYTE	";"
	.SBYTE	+$A0,"@BB@@@@@@@@@@@"
	.SBYTE	+$A0,"@@@@@@@"
	.SBYTE	+$A0,"BB@@DAAAC@@@@"
	.SBYTE	+$A0,"DAAC@@@BB@@B@"
	.SBYTE	";"
	.SBYTE	+$20,"@L@@@@L"
	.SBYTE	";"
	.SBYTE	+$A0,"@B@@@BB@@B@@@@"
	.SBYTE	+$A0,"@@@@@@@B@@@BB"
	.SBYTE	+$A0,"@@L@@@@K@@K@@"
	.SBYTE	+$A0,"@L@@@BB@@@@@@"
	.SBYTE	+$A0,"@B@"
	.SBYTE	";"
	.SBYTE	+$A0,"HAM@@@@@BB@@@"
	.SBYTE	+$A0,"@@NAG@@"
	.SBYTE	+$20,"B"
	.SBYTE	+$A0,"@@@@@@@BB@@@@@"
	.SBYTE	";"
	.SBYTE	+$20,"@HAAG@"
	.SBYTE	";"
	.SBYTE	+$A0,"@@@@@BB@@@@@@@"
	.SBYTE	+$20,"B@@"
	.SBYTE	+$A0,"HAM@@@@@BB@@@"
	.SBYTE	+$A0,"@@NAG"
	.SBYTE	";"
	.SBYTE	+$A0,"@B@@@@@@@BB@@@"
	.SBYTE	+$A0,"@@@@L@@L@@@@@"
	.SBYTE	+$A0,"@@BB@@@"
	.SBYTE	";"
	.SBYTE	+$A0,"@@@@@@@@@"
	.SBYTE	";"
	.SBYTE	+$A0,"@@@@BB@@@@@@"
	.SBYTE	+$20,"K@@@@K@@@@@@"
	.SBYTE	+$A0,"BB@@@@@@B@@@@"
	.SBYTE	+$A0,"B@@@@@@BB@@@@@"
	.SBYTE	";"
	.SBYTE	+$A0,"B@@@@B"
	.SBYTE	";"
	.SBYTE	+$A0,"@@@@@BB@@@@NAE"
	.SBYTE	+$A0,"@@@@FAM@@@@BB@"
	.SBYTE	+$A0,"@@@@@@@@@@@@@@"
	.SBYTE	+$A0,"@@@BH"
	.SBYTE	+$20,"AC@@@@@@@O@@@"
	.SBYTE	+$20,"@@@DA"
	.SBYTE	+$A0,"GB"
	.SBYTE	";"
	.SBYTE	+$20,"B@@@@@@@@@@@@"
	.SBYTE	+$20,"@@B"
	.SBYTE	";"
	.SBYTE	+$A0,"BFAJAAAAAAAAA"
	.SBYTE	+$A0,"AAAAAJAE"
;
BD3	.SBYTE	+$A0,"DAAAAAIAAAAAAI"
	.SBYTE	+$A0,"AAAAACB"
	.SBYTE	"; ; ;"
	.SBYTE	+$20,"B@@@@@@"
	.SBYTE	+$A0,"B@"
	.SBYTE	"END"
	.SBYTE	+$A0,"@BB@"
	.SBYTE	"; ;"
	.SBYTE	+$20,"@B@@"
	.SBYTE	";"
	.SBYTE	+$A0,"@@@HAAAAAGB"
	.SBYTE	"; ; ;"
	.SBYTE	+$20,"B@@"
	.SBYTE	+$A0,"DC@@B@"
	.SBYTE	"; ;"
	.SBYTE	+$A0,"@BH"
	.SBYTE	+$20,"AAAAA"
	.SBYTE	+$A0,"G@@B"
	.SBYTE	+$20,"B@@"
	.SBYTE	+$A0,"B@@"
	.SBYTE	";"
	.SBYTE	+$A0,"@@BB@@@@@B@@"
	.SBYTE	+$20,"B"
	.SBYTE	+$A0,"B@@B@"
	.SBYTE	"; ;"
	.SBYTE	+$A0,"@BB@@"
	.SBYTE	";"
	.SBYTE	+$A0,"@@B@@FE@@B@@"
	.SBYTE	";"
	.SBYTE	+$A0,"@@BB@@@@@B@@@@"
	.SBYTE	+$20,"@@B@@@@@"
	.SBYTE	+$A0,"BB@@K@@B@@@@"
	.SBYTE	+$20,"O@B@@@@@"
	.SBYTE	+$A0,"BB@@B@"
	.SBYTE	";"
	.SBYTE	+$A0,"B@@@@@@"
	.SBYTE	+$20,"B@@@@@"
	.SBYTE	+$A0,"BB@@B@@B@@DC@@"
	.SBYTE	+$A0,"B@@@@@BB@@B@@B"
	.SBYTE	+$20,"@@B"
	.SBYTE	+$A0,"B@@B"
	.SBYTE	";  ;"
	.SBYTE	+$A0," BB"
	.SBYTE	";"
	.SBYTE	+$A0,"@B@@B@@B"
	.SBYTE	+$20,"B@"
	.SBYTE	";"
	.SBYTE	+$A0,"H"
	.SBYTE	+$20,"M@@@N"
	.SBYTE	+$A0,"GB@@L@@B@@FE@"
	.SBYTE	+$A0,"@B@@@@@BB@@@@"
	.SBYTE	+$A0,"@B@@@@@@B@@@@"
	.SBYTE	+$A0,"@BB@@@@@B@@@@"
	.SBYTE	+$A0,"@@B@@@@@BB@@@"
	.SBYTE	+$A0,"@@HAAA"
	.SBYTE	+$20,"C@@"
	.SBYTE	+$A0,"H"
	.SBYTE	+$20,"AAAAA"
	.SBYTE	+$A0,"GH"
	.SBYTE	+$20,"AAAAA"
	.SBYTE	+$A0,"G@"
	.SBYTE	";"
	.SBYTE	+$20,"@B@@B@@@@@"
	.SBYTE	+$A0,"BB@@"
	.SBYTE	+$20,"O@@B@"
	.SBYTE	";"
	.SBYTE	+$20,"@B@@L@@@@@"
	.SBYTE	+$A0,"BB@@@@@"
	.SBYTE	+$20,"B@"
	.SBYTE	";"
	.SBYTE	+$20,"@B@@@@@"
	.SBYTE	";"
	.SBYTE	+$A0,"@@BB@@@@@"
	.SBYTE	+$20,"B@"
	.SBYTE	";"
	.SBYTE	+$20,"@B@@@@@@@@"
	.SBYTE	+$A0,"BFAAAAAJAAA"
	.SBYTE	+$A0,"JAAAAAAAAE"
;
	*=	$02E0
	.WORD	GAME
	.END
