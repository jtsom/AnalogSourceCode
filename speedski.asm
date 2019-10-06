**************************
*                        *
*        SPEEDSKI        *
*                        *
*   By Bill Richardson   *
*                        *
*   Copyright (c) 1985   *
*    ANALOG Computing    *
*                        *
**************************
;
;OS EQUATES
;----------
;
HPOSP0	=	$D000	;Plr0 horiz pos
HPOSP1	=	$D001	;Plr1 horiz pos
P0PF	=	$D004	;Plr0 collision
GRACTL	=	$D01D	;Graphics ctrl
HITCLR	=	$D01E	;Collision reg
CONSOL	=	$D01F	;Consol keys
AUDF1	=	$D200	;Audio Freq 1
AUDC1	=	$D201	;Audio Ctrl 1
AUDF2	=	$D202	;Audio Freq 2
AUDC2	=	$D203	;Audio Ctrl 2
AUDCTL	=	$D208	;Main audio ctrl
SKCTL	=	$D20F	;Serial ctrl
VSCROL	=	$D405	;Vert Scroll reg
PMBASE	=	$D407	;P/M base addr
SETVBV	=	$E45C	;Set VBLANK
SYSVBV	=	$E45F	;Exit VBLANK
;
;PAGE ZERO
;---------
;
	*=	$80
;
CLOCK	.DS	7	;Special clock
SCROLLED	.DS	1	;# lines scrolled
SCROLFLG	.DS	1	;Scroll done flag
SPEED	.DS	1	;Scrolling speed
XPOS	.DS	1	;Skier's horz pos
YPOS	.DS	1	;Skier's vert pos
IMAGEPTR	.DS	2	;Image pntr
TIMES	.DS	1	;Course scrl cnt
TIMESFLG	.DS	1	;End course flg
VOLUME	.DS	1	;Volume of sounds
;
;SHADOW REGISTERS, ETC.
;----------------------
;
ATRACT	=	77	;Attract mode flg
SAVMSC	=	88	;Scrn memory pntr
SDMCTL	=	$022F	;DMA enable
SDLSTL	=	$0230	;Disp List pntr
GPRIOR	=	$026F	;Priority reg
STICK0	=	$0278	;Joystick 0
STRIG0	=	$0284	;Stick trigger 0
PCOLR0	=	$02C0	;Player 0 color
PCOLR1	=	$02C1	;Player 1 color
COLOR0	=	$02C4	;Playfld Color 0
CHBAS	=	$02F4	;CH Base addr
CH	=	$02FC	;Last Key pressed
;
	*=	$3000
;
SCRN1	.DS	480	;1st screen
SCRN2	.DS	480	;2nd screen
SCRN3	.DS	480	;3rd screen
SCRN4	.DS	480	;4th screen
SCRN5	.DS	480	;5th screen
SCRN6	.DS	240	;6th screen
SCRLFIN	.DS	240	;End scrl adr
;
	*=	$0400
;
PMSTART	.DS	$0200	;P/M area
PLR0	.DS	$80	;Player0
PLR1	.DS	$80	;Player1
;
;CHARACTER SET
;-------------
;
	*=	$2000
;
CHSET	.BYTE	0,0,0,0,0,0,0,0,128,128
	.BYTE	128,170,130,170,0,170
	.BYTE	0,0,0,8,8,10,0,170
	.BYTE	0,0,0,32,32,160,32,160
	.BYTE	21,16,16,21,16,16,21,0
	.BYTE	65,17,17,80,16,16,64,0
	.BYTE	80,16,80,0,64,64,64,0
	.BYTE	64,64,64,64,64,64,64,0
	.BYTE	64,64,64,64,64,64,64,0
	.BYTE	0,84,65,65,85,68,65,65
	.BYTE	0,16,0,17,17,17,17,17
	.BYTE	0,0,0,81,17,81,17,81
	.BYTE	0,1,1,81,1,1,1,81
	.BYTE	0,0,0,81,16,17,17,17
	.BYTE	0,0,24,24,0,24,24,0,0,0
	.BYTE	0,0,0,24,24,0,126,103
	.BYTE	103,103,103,103,127,63
	.BYTE	28,60,124,28,28,28,127
	.BYTE	127,126,103,7,127,112
	.BYTE	115,115,127,126,103,7
	.BYTE	63,7,103,127,63,6,15,27
	.BYTE	51,127,127,7,15,126,96
	.BYTE	126,103,7,103,127,63
	.BYTE	126,103,96,126,103,103
	.BYTE	127,63,126,103,7,14,28
	.BYTE	28,28,28,126,103,103
	.BYTE	127,103,103,127,63,126
	.BYTE	103,103,127,7,103,127
	.BYTE	63,0,0,0,0,0,0,0,1
	.BYTE	1,1,5,21,21,85,85,85
	.BYTE	0,64,64,80,64,80,84,84
	.BYTE	0,0,0,1,5,1,0,0
	.BYTE	5,21,21,85,85,85,0,0
	.BYTE	85,85,85,85,85,85,63,63
	.BYTE	85,85,85,85,85,85,0,0
	.BYTE	0,0,64,80,84,85,0,0
	.BYTE	0,0,15,60,0,252,15,0
	.BYTE	192,192,192,252,204,207
	.BYTE	192,207,0,0,0,0,0,192,0
	.BYTE	192,0,0,15,60,48,0,0,0
	.BYTE	252,207,195,192,192,192
	.BYTE	192,192,0,0,192,0,0,0,0
	.BYTE	0,0,0,0,0,0,0,0,2,0,0,2
	.BYTE	2,10,42,170,170,32,168
	.BYTE	168,170,170,170,170,170
	.BYTE	0,0,0,0,0,128,160,160
	.BYTE	0,0,0,0,0,2,0,0,2,10,10
	.BYTE	42,170,170,0,0,170,170
	.BYTE	170,170,170,170,3,3,170
	.BYTE	170,170,170,170,170,252
	.BYTE	252,168,170,170,170,170
	.BYTE	170,0,0,0,0,128,160,168
	.BYTE	170,0,0,0,0,0,0,0,0,1,5
	.BYTE	0,0,1,5,21,85,85,85
	.BYTE	20,85,85,85,85,85,85,85
	.BYTE	0,0,80,84,85,85,85,85
	.BYTE	0,0,0,0,0,80,84,85
	.BYTE	0,0,1,5,0,0,0,0
	.BYTE	21,85,85,85,0,0,0,0,85
	.BYTE	85,85,85,0,0,0,0,85,85
	.BYTE	85,85,255,255,255,255
	.BYTE	85,85,85,85,192,192,192
	.BYTE	192,85,85,85,85,0,0,0,0
	.BYTE	64,80,84,85,0,0,0,0
	.BYTE	0,0,0,64,0,0,0,0,2,10
	.BYTE	10,10,42,42,42,42,0,128
	.BYTE	160,160,160,168,168,168
	.BYTE	0,2,2,2,0,0,0,0,170,170
	.BYTE	170,170,170,3,3,3,168
	.BYTE	170,170,170,170,192,192
	.BYTE	192,0,0,0,0,128,0,0,0
	.BYTE	1,5,5,5,21,21,21,21
	.BYTE	0,64,80,80,80,84,84,84
	.BYTE	0,1,1,1,0,0,0,0,85,85
	.BYTE	85,85,85,3,3,3,84,85,85
	.BYTE	85,85,192,192,192
	.BYTE	0,0,0,0,64,0,0,0
	.BYTE	0,0,0,252,15,0,63,0,48
	.BYTE	48,60,60,255,63,252,63
	.BYTE	0,0,0,240,0,252,0,240
	.BYTE	240,60,15,0,0,0,0,0,60
	.BYTE	60,255,60,63,60,60,60
	.BYTE	12,192,192,0,0,0,0,0
	.BYTE	0,0,0,0,192,240,255,255
	.BYTE	0,0,0,0,0,0,0,192
	.BYTE	0,0,0,0,0,0,0,0
	.BYTE	0,0,0,0,0,0,0,3,0,0,0
	.BYTE	0,3,15,255,255,192,192
	.BYTE	192,192,192,192,192,192
	.BYTE	3,3,3,3,3,3,3,3,42,37
	.BYTE	38,38,38,38,37,42,170
	.BYTE	85,170,0,0,170,85,170
	.BYTE	160,96,160,0,0,160,96
	.BYTE	96,0,0,0,0,0,170,149
	.BYTE	154,0,0,0,0,0,168,88
	.BYTE	152,0,0,0,0,0,170,149
	.BYTE	154,0,0,0,0,0,138,137
	.BYTE	137,0,0,0,0,0,168,88
	.BYTE	168,0,0,0,0,0,42,37,42
	.BYTE	2,2,2,2,2,170,85,170,96
	.BYTE	96,96,96,96,96,96,160
	.BYTE	152,154,149,154,152,152
	.BYTE	152,168,152,152,88,168
	.BYTE	0,0,0,0,152,154,150,154
	.BYTE	152,154,149,170,9,9,9,9
	.BYTE	9,137,137,138,128,160
	.BYTE	96,160,128,168,88,168
	.BYTE	0,0,0,0,0,170,149,154
	.BYTE	0,0,0,0,0,128,160,104
	.BYTE	42,37,38,38,38,38,37,42
	.BYTE	170,85,170,0,0,170,85
	.BYTE	170,160,96,160,0,0,162
	.BYTE	98,98,0,0,0,0,0,162,98
	.BYTE	98,0,0,0,0,0,162,98,98
	.BYTE	0,0,0,0,0,170,86,154
	.BYTE	154,152,152,152,154,154
	.BYTE	149,170,152,152,152,152
	.BYTE	152,104,160,128,0,0,0,0
	.BYTE	0,42,37,42,2,2,2,2,2
	.BYTE	170,85,170,98,98,98,98
	.BYTE	98,98,98,162,105,102,90
	.BYTE	102,105,106,98,162,160
	.BYTE	128,0,128,160,98,98,162
	.BYTE	152,152,152,152,152,154
	.BYTE	86,170,0,0,0,17,65,1,1
	.BYTE	1,0,16,16,81,17,17,16
	.BYTE	81,0,0,0,84,0,84,4,84
	.BYTE	0,0,0,84,68,68,68,84
	.BYTE	0,0,0,64,84,68,68,68
	.BYTE	0,0,0,0,0,0,0,0
	.BYTE	0,0,0,0,0,0,0,0
	.BYTE	0,0,0,0,0,0,0,0
;
;MESSAGES
;--------
;
GAMELOGO	.BYTE	88,89,90,91,92,93,94,95
	.BYTE	104,105,106,107,108,109
	.BYTE	110,111,96,97,98,99,100
	.BYTE	101,102,103,112,113,114
	.BYTE	115,116,117,118,119
MYNAME	.BYTE	1,2,3,0,4,5,6,7,8,0,9
	.BYTE	10,12,13,11,120,121,122
	.BYTE	123,124
;
;DISPLAY LIST
;------------
;
DLIST	.BYTE	$70,$70,$44
	.WORD	$00
	.BYTE	$04,$00,$04,$65
	.WORD	$4000
	.BYTE	$25,$25,$25,$25
	.BYTE	$25,$25,$25,$25
	.BYTE	$25,$25,$05,$41
	.WORD	DLIST
;
;P/M SHAPES
;----------
;
IM1	.BYTE	12,0,24,0,24,24
	.BYTE	60,0,124,0,48,136
	.BYTE	56,68,36,2,72,0
	.BYTE	72,34,0,68,0,136
IM2	.BYTE	0,0,12,0,24,0
	.BYTE	24,24,60,0,24,36
	.BYTE	60,66,60,0,36,0
	.BYTE	36,0,0,36,0,36
IM3	.BYTE	48,0,24,0,24,24
	.BYTE	60,0,62,0,12,17
	.BYTE	28,34,36,64,18,0
	.BYTE	18,68,0,34,0,17
IM4	.BYTE	4,0,25,2,25,28
	.BYTE	254,0,185,0,120,128
	.BYTE	56,128,40,0,64,20
	.BYTE	76,34,65,0,0,0
IM5	.BYTE	16,0,24,0,128,96
	.BYTE	88,24,58,4,45,2
	.BYTE	28,0,26,0,34,0
	.BYTE	66,129,0,66,0,4
;
;Initial screen colors
;---------------------
;
COLTBL	.BYTE	184,180,20,52,14
;
;Copy screens
;------------
;
PRGSTART	LDX	#0
COPY1	LDA	SCRNBASE,X
	STA	SCRN1,X
	STA	SCRN4,X
	LDA	SCRNBASE+480,X
	STA	SCRN2,X
	STA	SCRN5,X
	LDA	SCRNBASE+960,X
	STA	SCRN3,X
	STA	SCRN6,X
	INX
	BNE	COPY1
COPY2	LDA	SCRNBASE+256,X
	STA	SCRN1+256,X
	STA	SCRN4+256,X
	LDA	SCRNBASE+736,X
	STA	SCRN2+256,X
	STA	SCRN5+256,X
	LDA	SCRNBASE+1216,X
	STA	SCRN3+256,X
	STA	SCRN6+256,X
	INX
	CPX	#224
	BNE	COPY2
	LDA	#0
	TAX
CLEAR1	STA	SCRN6+480,X	;Clr bottom
	INX		;of scrolling
	BNE	CLEAR1	;screen memory
	LDA	SAVMSC
	STA	DLIST+3	;Set DLIST
	LDA	SAVMSC+1	;pointer to
	STA	DLIST+4	;screen memory
	LDA	#0	;Clear
	LDY	#120	;top
CLEARSCR	STA	(SAVMSC),Y	;of
	DEY		;screen
	BPL	CLEARSCR
	LDX	#4
COLORSCR	LDA	COLTBL,X	;color tbl
	STA	COLOR0,X
	DEX
	BPL	COLORSCR
	LDA	# <DLIST	;Tell ANTIC
	STA	SDLSTL	;where to
	LDA	# >DLIST	;find custom
	STA	SDLSTL+1	;Display List
	LDY	#27	;This routine
	LDX	#15	;puts the top 16
I1	LDA	GAMELOGO,X	;characters of
	STA	(SAVMSC),Y	;"SPEEDSKI"
	DEY		;logo on the
	DEX		;screen
	BPL	I1
	LDY	#67	;Puts
	LDX	#31	;the last
I2	LDA	GAMELOGO,X
	STA	(SAVMSC),Y	;16 characters
	DEY		;of logo on
	DEX		;the screen
	CPX	#15
	BNE	I2
	LDA	# >CHSET	;Give computer
	STA	CHBAS	;adr of new CHSET
	LDA	#0	;Initialize
	STA	AUDCTL	;POKEY
	LDA	#3	;sound
	STA	SKCTL	;chip
	LDA	#2	;Enable
	STA	GRACTL	;P/M graphics
	LDA	# >PMSTART	;Tell where PM
	STA	PMBASE	;graphics are
	JSR	ERASE	;Clear P/M memory
	LDA	#40	;Multi-color plrs
	STA	GPRIOR	;Set P/M priority
	LDA	#152	;light blue
	STA	PCOLR0
	LDA	#118	;blue
	STA	PCOLR1
	LDA	#46	;Double line
	STA	SDMCTL	;resolution plrs
	LDY	#110
	LDX	#19	;This routine
I3	LDA	MYNAME,X	;puts the
	STA	(SAVMSC),Y	;author's name
	DEY		;on the 3rd line
	DEX		;of the screen
	BPL	I3
;
;EVERY TIME INITIALIZATION
;-------------------------
;
INIT	LDA	# <SCRN1	;Point DLIST
	STA	DLIST+9	;to scrolling
	LDA	# >SCRN1	;screen
	STA	DLIST+10
	LDA	#0	;Reset # scan
	STA	SCROLLED	;lines scrolled
	STA	TIMESFLG	;and TIMESFLG
	STA	TIMES	;+ course scroll
	STA	SCROLFLG	;Do scrolling
	LDA	#1	;Set scroll speed
	STA	SPEED	;to slow
	LDA	#0	;Set
	LDX	#6	;clock
I4	STA	CLOCK,X	;to
	DEX		;0:00.00
	BPL	I4
	STX	CLOCK+2	;"." character
	STX	CH	;Reset last key
	DEX
	STX	CLOCK+5	;":" character
	LDA	#120	;Set horizontal
	STA	XPOS	;pos of skier
	LDA	#36	;Set vertical
	STA	YPOS	;pos of skier
;
;BEGIN GAME
;----------
;
WAITLOOP	LDA	CONSOL
	ROR	A	;START Pressed?
	BCC	LETSGO	;Yes! start game
	LDA	STRIG0	;Trigger pressed?
	BNE	WAITLOOP	;No, wait
LETSGO	JSR	CLEAR3RD	;Clr 3rd line
	LDA	#6	;Chg ANTIC 4 line
	STA	DLIST+7	;to GR.1 line
	STA	ATRACT	;Reset Attract
	JSR	SCROLLIT	;Start VBLANK
;
;INTRODUCTION
;------------
;
	LDA	XPOS	;Position the
	STA	HPOSP0	;skier
	STA	HPOSP1	;horizontally
INTRO	JSR	ERASE	;Erase skier
	LDA	# <IM2	;Tell IMAGEPTR
	STA	IMAGEPTR	;which image
	LDA	# >IM2	;to
	STA	IMAGEPTR+1	;draw
	JSR	DRAW	;Go draw skiers
	INC	YPOS	;Move down screen
	LDA	YPOS	;See if skier has
	CMP	#72	;reached middle
	BEQ	MAINLOOP	;of screen? Yes.
	LDA	YPOS	;Vert position
	LSR	A	;/2
	LSR	A	;/4
	LSR	A	;/8
	STA	AUDF1	;Set frequency,
	STA	AUDC1	;vol, distortion
	LDX	#10	;HI byte and LO
	LDY	#0	;byte of delay
	JSR	DELAY	;Slow down action
	JMP	INTRO	;Do it again
;
;THE MAIN LOOP
;-------------
;
MAINLOOP	STA	HITCLR	;Clr Collision
	LDA	STICK0	;Read joystick
	CMP	#5	;Down and right?
	BEQ	MP2A	;Go draw skier
	CMP	#6	;Up and right?
	BEQ	MP2
	CMP	#7
	BNE	MP3
MP2	DEC	SPEED
MP2A	JMP	RIGHT
;
MP3	CMP	#9	;Down and left?
	BEQ	MP5A
	CMP	#10	;Up and left?
	BEQ	MP5
	CMP	#11	;Left?
	BNE	MP6
MP5	DEC	SPEED
MP5A	JMP	LEFT
;
MP6	CMP	#13	;Down?
	BNE	MP7
	INC	SPEED
	JMP	STRAIGHT
;
MP7	CMP	#14	;Up?
	BNE	MP8
	DEC	SPEED
	JSR	TESTSPD
	DEC	SPEED
MP8	JMP	STRAIGHT
;
CONTINUE	LDA	XPOS	;Horizontal pos
	STA	HPOSP0	;Position Plr0
	STA	HPOSP1	;Position Plr1
	LDA	CH	;Last key pressed
	CMP	#255
	BEQ	MP9	;No key pressed
	JSR	PAUSE	;Activate pause
MP9	LDA	CONSOL
	CMP	#6	;START pressed?
	BNE	MP10	;No.
	JMP	INIT	;Start over
;
MP10	LDA	P0PF	;Check collision
	BEQ	MP11	;Nobody crashed
	JSR	CRASH	;Crash occured
MP11	LDX	#12
	LDY	#0
	JSR	DELAY	;Slow the action
	LDA	SCROLFLG	;scrolling?
	BEQ	MP12	;Yes. continue
	JMP	ENDGAME
;
MP12	JSR	TESTX	;Skier's X coord
	JMP	MAINLOOP	;Loop back
;
;Delay subroutine
;----------------
;
DELAY	DEY
	BNE	DELAY
	DEX
	BNE	DELAY
	RTS
;
;Erase players 0 & 1
;-------------------
;
ERASE	LDA	#0
	TAX
MP13	STA	PLR0,X	;Erase Plr0
	STA	PLR1,X	;Erase Plr1
	DEX
	BNE	MP13
	RTS
;
;Start scrolling & clock
;-----------------------
;
SCROLLIT	LDX	# >VBI
	LDY	# <VBI
	BNE	HALT2
;
;Disable VBLANK
;--------------
;
HALT	LDX	# >SYSVBV
	LDY	# <SYSVBV
HALT2	LDA	#6
	JMP	SETVBV
;
;Subroutine to draw players
;--------------------------
;
DRAW	LDX	YPOS	;Get vert pos
	LDY	#23	;# bytes to draw
DRAWLOOP	LDA	(IMAGEPTR),Y	;Get number
	STA	PLR1,X	;Put it in Plr1
	DEY
	LDA	(IMAGEPTR),Y	;Get another
	STA	PLR0,X	;Put it in Plr0
	DEX
	DEY
	BPL	DRAWLOOP	;Do until Y=255
	RTS
;
;Set skier to right
;------------------
;
RIGHT	JSR	TESTSPD
	INC	XPOS
	LDA	# <IM3	;Point to
	STA	IMAGEPTR	;right
	LDA	# >IM3	;skier
	STA	IMAGEPTR+1
	LDA	#6
	BNE	LEFT1
;
;Set skier to left
;-----------------
;
LEFT	JSR	TESTSPD
	DEC	XPOS
	LDA	# <IM1	;Point to
	STA	IMAGEPTR	;left
	LDA	# >IM1	;skier
	STA	IMAGEPTR+1
	LDA	#4
LEFT1	STA	AUDF1
	LDA	#12
LEFT2	STA	AUDC1
	JSR	DRAW
	JMP	CONTINUE
;
;Set skier to straight
;---------------------
;
STRAIGHT	JSR	TESTSPD
	LDA	# <IM2	;Point to
	STA	IMAGEPTR	;straight
	LDA	# >IM2	;skier
	STA	IMAGEPTR+1
	LDA	#2
	STA	AUDF1
	LDA	#8
	BNE	LEFT2
;
;Test scrolling speed
;--------------------
;
TESTSPD	LDA	SPEED
	CMP	#65	;Is it > maximum?
	BNE	MP14	;No
	DEC	SPEED	;Make maximum
	RTS
MP14	LDA	SPEED	;Speed < minimum?
	BNE	MP15	;No.
	INC	SPEED	;Make minimum
MP15	RTS
;
;Pause subroutine
;----------------
;
PAUSE	JSR	HALT	;Stop scrolling
	LDA	#255	;Reset last
	STA	CH	;key pressed
MP16	LDA	CONSOL	;Wait for OPTION
	CMP	#3	;to be
	BNE	MP16	;pressed
	JMP	SCROLLIT
;
;Gameover
;--------
;
ENDGAME	JSR	HALT	;Stop scrolling
	LDA	#121	;note C
	STA	AUDF1
	LDA	#166	;with pure tone
	STA	AUDC1	;and some volume
	LDX	#0	;hold the tone
	LDY	#0	;for a while
	JSR	DELAY
	LDA	#96	;note E
	STA	AUDF1
	LDA	#121	;note C
	STA	AUDF2
	LDA	#170	;with pure tone
	STA	AUDC1	;and more volume
	STA	AUDC2
	LDX	#128	;Hold tone half
	JSR	DELAY	;as long
	LDA	#81	;note G
	STA	AUDF1
	LDA	#96	;note E
	STA	AUDF2
	LDA	#172	;more volume
	STA	AUDC1
	STA	AUDC2
	LDX	#192	;Hold tone
	JSR	DELAY
	LDA	#60	;note C
	STA	AUDF1
	LDA	#81	;note G
	STA	AUDF2
	LDA	#174	;more volume
	STA	AUDC1
	STA	AUDC2
	JSR	DELAY	;Hold note twice
	JSR	DELAY	;as long as 1st
	LDA	#0
	STA	AUDC1	;Turn off
	STA	AUDC2	;sound
MP17	LDA	CONSOL	;See if START
	ROR	A	;pressed
	BCC	MP18
	LDA	STRIG0	;If trig pressed
	BNE	MP17	;start game over
MP18	JMP	INIT
;
;Crash!
;------
;
CRASH	LDA	#1	;Stop
	STA	SCROLFLG	;scrolling
	LDA	#15	;Set volume
	STA	VOLUME	;to loud
MP19	LDA	#255
	STA	AUDF1
	SBC	VOLUME	;255-VOLUME
	STA	AUDF2	;for Freq 2
	LDA	VOLUME	;dist 0+VOLUME
	STA	AUDC1	;for Ctrl 1
	ADC	#192	;Dist 12+VOLUME
	STA	AUDC2	;for Ctrl 2
	DEC	VOLUME	;Reduce volumn
	LDX	#20
	JSR	DELAY
	LDA	VOLUME	;See if VOLUME=0
	BNE	MP19
	LDA	# <IM4	;Point to
	STA	IMAGEPTR	;1st crashing
	LDA	# >IM4	;skier
	STA	IMAGEPTR+1	;image
	JSR	DRAW
	LDX	#30
	JSR	DELAY
	LDA	# <IM5	;Point to
	STA	IMAGEPTR	;2nd crashing
	LDA	# >IM5	;skier
	STA	IMAGEPTR+1	;image
	JSR	DRAW
	JSR	DELAY
	JSR	DELAY
	JSR	DELAY
	LDA	#0	;Enable
	STA	SCROLFLG	;scroll again
	LDA	# <IM2	;Stand
	STA	IMAGEPTR	;skier
	LDA	# >IM2	;up
	STA	IMAGEPTR+1	;again
	LDA	#1	;Reset speed
	STA	SPEED	;to slow
	JMP	DRAW
;
;Clear screen's 3rd line
;-----------------------
;
CLEAR3RD	LDA	#0
	LDY	#120
MP20	STA	(SAVMSC),Y
	DEY
	CPY	#79
	BNE	MP20
	RTS
;
;Test skier's X position
;-----------------------
;
TESTX	LDA	XPOS
	CMP	#47
	BNE	MP21
	INC	XPOS
	RTS
;
MP21	CMP	#196
	BNE	MP22
	DEC	XPOS
MP22	RTS
;
;VERTICAL BLANK INTERRUPT
;------------------------
;
VBI	LDA	SCROLFLG	;If not 0 do
	BNE	VBICLOCK	;not scroll
;
;Calculate scroll speed
;----------------------
;
	LDA	SPEED	;Current speed
	LSR	A	;/2
	LSR	A	;/4
	LSR	A	;/8
	LSR	A	;/16 If not zero
	BNE	VB1	;do fine scroll
	LDX	#1	;If 0 make it 1
	BNE	SCROLLON
;
VB1	TAX
;
;Perform fine scroll
;-------------------
;
SCROLLON	INC	SCROLLED	;lines scrolled
	LDA	SCROLLED
	STA	VSCROL	;put in vscrol
	CMP	#16	;reached limit?
	BEQ	COARSE	;coarse scroll
	DEX		;No. Scroll until
	BNE	SCROLLON	;X=0
	BEQ	VBICLOCK	;Handle clock
;
;Do a coarse scroll
;------------------
;
COARSE	LDA	#0	;Reset the fine
	STA	VSCROL	;scroll reg and #
	STA	SCROLLED	;lines scrolled
	LDA	DLIST+9	;DLIST's LO byte
	CLC
	ADC	#40	;Add 40 (1 line)
	STA	DLIST+9	;New LO byte
	BCC	COMPEND	;Over 256? No.
	INC	DLIST+10	;Inc HI byte
;
;Check on scrolling limit
;------------------------
;
COMPEND	LDA	TIMESFLG
	BNE	COMPDONE	;check scrolling
	LDA	DLIST+10	;DLIST HI byte
	CMP	# >SCRN4	;Reached end?
	BNE	VBICLOCK	;No, skip this
	LDA	DLIST+9	;Examine LO byte
	CMP	# <SCRN4	;LO byte limit?
	BNE	VBICLOCK	;No, Go on
	LDA	# >SCRN1	;Yes!
	STA	DLIST+10	;Flip back to
	LDA	# <SCRN1	;beginning of
	STA	DLIST+9	;course
	INC	TIMES	;Inc # of times
	LDA	TIMES	;course scrolled
	CMP	#10	;10 times?
	BNE	VBICLOCK	;No
	LDA	#1
	STA	TIMESFLG	;Set times flag
	BNE	VBICLOCK
;
;See if end of scrolling reached
;-------------------------------
;
COMPDONE	LDA	DLIST+10	;DLIST HI byte
	CMP	# >SCRLFIN	;Reached?
	BNE	VBICLOCK	;No
	LDA	DLIST+9	;DLIST LO byte
	CMP	# <SCRLFIN	;Reached?
	BNE	VBICLOCK	;No
	LDA	#1	;Set scroll flag
	STA	SCROLFLG
;
;Clock routine
;-------------
;
VBICLOCK	INC	CLOCK	;Inc the 60ths
	LDA	CLOCK
	CMP	#6	;6/60ths yet?
	BNE	PRTCLOCK	;No
	LDA	#0
	STA	CLOCK	;Reset to zero
	INC	CLOCK+1	;Inc 10ths cntr
	LDA	CLOCK+1
	CMP	#10	;10/10ths yet?
	BNE	PRTCLOCK	;Clock on scrn
	LDA	#0	;Yes!
	STA	CLOCK+1	;Reset to zero
	INC	CLOCK+3	;Inc seconds cntr
	LDA	CLOCK+3
	CMP	#10	;10 secs. yet?
	BNE	PRTCLOCK	;No, branch
	LDA	#0	;Yes!
	STA	CLOCK+3	;Reset to zero
	INC	CLOCK+4	;Inc 10s of secs
	LDA	CLOCK+4
	CMP	#6	;60 seconds yet?
	BNE	PRTCLOCK	;No, branch
	LDA	#0	;Yes!
	STA	CLOCK+4	;Reset to zero
	INC	CLOCK+6	;Inc minutes cntr
;
;Print clock on screen
;---------------------
;
PRTCLOCK	LDY	#87
	LDX	#6
VB2	LDA	CLOCK,X	;Get a character
	CLC
	ADC	#208	;Make screen val
	STA	(SAVMSC),Y	;Put on scrn
	INY
	DEX
	BNE	VB2
	JMP	SYSVBV
;
;SCROLLING SCRN DATA
;---------------------
;
SCRNBASE	.BYTE	0,50,51,52,53,54,0,0,0
	.BYTE	169,192,0,0,0,0,209,210
	.BYTE	0,0,0,0,209,210,0,27,70
	.BYTE	0,0,0,0,69,70,0,0,0,0,0
	.BYTE	0,0,0,55,56,57,58,59,60
	.BYTE	61,0,65,66,67,68,34,35
	.BYTE	0,214,0,0,0,0,0,214,29
	.BYTE	30,31,32,33,0,0,71,72
	.BYTE	73,74,0,0,0,0,0,0,0,0
	.BYTE	69,70,0,0,40,41,42,43,0
	.BYTE	0,0,37,38,39,0,0,0,0,0
	.BYTE	0,0,0,0,0,40,41,42,43,0
	.BYTE	0,0,0,41,64,0,0,0,0,0
	.BYTE	71,72,73,74,44,45,46,47
	.BYTE	48,49,0,0,0,0,0,0,0,0,0
	.BYTE	0,0,0,0,0,44,45,46,47
	.BYTE	48,49,0,0,65,66,67,68,0
	.BYTE	0,0,0,75,76,77,0,41,64
	.BYTE	0,0,0,0,0,0,41,64,0,0,0
	.BYTE	0,0,0,0,0,0,0,0,0,0,34
	.BYTE	35,36,0,69,28,0,0,0,0,0
	.BYTE	0,0,78,79,80,65,66,67
	.BYTE	68,0,69,70,0,65,66,67,0
	.BYTE	0,212,213,128,0,0,0,212
	.BYTE	213,0,0,0,37,38,39,71
	.BYTE	72,73,74,0,0,0,0,0,0,0
	.BYTE	26,27,28,0,0,0,71,72,73
	.BYTE	74,69,28,0,0,41,64,215
	.BYTE	0,0,0,0,0,215,0,0,0,40
	.BYTE	41,42,43,0,0,26,27,28,0
	.BYTE	0,0,0,29,30,31,32,33,0
	.BYTE	34,35,36,0,71,72,73,74
	.BYTE	65,66,67,68,0,0,0,0,0,0
	.BYTE	0,0,44,45,46,47,48,49
	.BYTE	29,30,31,32,33,0,0,0,0
	.BYTE	0,0,0,0,0,37,38,39,40
	.BYTE	41,42,43,0,0,0,0,0,0,0
	.BYTE	0,0,0,0,0,0,0,0,0,0,0
	.BYTE	41,64,0,0,34,35,36,0,0
	.BYTE	0,27,28,0,0,69,70,0,44
	.BYTE	45,46,47,48,49,0,0,0,0
	.BYTE	0,0,0,0,0,0,0,0,27,70,0
	.BYTE	0,65,66,67,68,0,37,38
	.BYTE	39,0,0,71,72,73,74,71
	.BYTE	72,73,74,0,0,0,0,209
	.BYTE	210,0,0,0,128,209,210,0
	.BYTE	0,0,0,0,71,72,73,74,0,0
	.BYTE	0,0,34,35,36,0,0,0,0,75
	.BYTE	76,77,0,50,51,52,53,54
	.BYTE	0,0,0,214,0,0,0,0,0,214
	.BYTE	0,0,69,70,0,0,41,64,0,0
	.BYTE	26,27,28,0,37,38,39,0
	.BYTE	69,70,0,78,79,80,55,56
	.BYTE	57,58,59,60,61,0,0,0,0
	.BYTE	0,0,0,0,0,0,71,72,73,74
	.BYTE	65,66,67,68,29,30,31,32
	.BYTE	33,0,0,0,71,72,73,0,0,0
	.BYTE	26,27,28,0,0,0,0,0,41
	.BYTE	64,0,0,0,0,0,0,0,0,0,0
	.BYTE	0,41,64,0,0,75,76,77,0
	.BYTE	0,0,40,41,42,43,0,0,0,0
	.BYTE	29,30,31,32,33,0,0,0,65
	.BYTE	66,67,68,0,0,0,0,0,0,0
	.BYTE	0,0,65,66,67,68,0,78,79
	.BYTE	80,0,0,44,45,46,47,48
	.BYTE	49,0,0,0,50,51,52,53,54
	.BYTE	0,0,0,0,0,0,69,70,0,128
	.BYTE	209,210,0,0,128,128,209
	.BYTE	210,0,27,70,0,0,0,0,34
	.BYTE	35,36,0,0,41,64,0,0,55
	.BYTE	56,57,58,59,60,61,34,35
	.BYTE	36,0,71,72,73,74,0,214
	.BYTE	0,0,0,0,0,214,29,30,31
	.BYTE	32,33,0,0,0,37,38,39,0
	.BYTE	65,66,67,68,0,0,0,0,0
	.BYTE	34,35,0,37,38,40,41,42
	.BYTE	43,0,0,0,0,0,0,0,0,0,0
	.BYTE	0,0,0,0,69,28,0,0,27,70
	.BYTE	0,0,0,0,0,0,0,0,0,0,0
	.BYTE	37,38,39,0,44,45,46,47
	.BYTE	48,49,0,0,0,0,0,0,0,0,0
	.BYTE	0,0,0,71,72,73,74,71,72
	.BYTE	73,74,0,27,70,0,0,0,0
	.BYTE	41,64,0,0,0,27,70,0,0,0
	.BYTE	0,0,26,27,28,0,0,0,0,0
	.BYTE	0,0,0,0,0,0,0,0,41,64,0
	.BYTE	0,29,30,31,32,33,0,0,65
	.BYTE	66,67,68,29,30,31,32,33
	.BYTE	0,0,0,29,30,31,32,33,75
	.BYTE	76,77,212,213,0,0,0,128
	.BYTE	212,213,65,66,67,68,0
	.BYTE	69,70,0,0,0,0,0,0,0,27
	.BYTE	70,0,0,0,0,0,40,41,42
	.BYTE	43,0,0,0,0,78,79,80,0
	.BYTE	215,0,0,0,0,0,215,0,0,0
	.BYTE	0,71,72,73,74,0,0,0,0
	.BYTE	29,30,31,32,33,0,0,0,44
	.BYTE	45,46,47,48,49,0,0,0,0
	.BYTE	0,0,0,0,0,0,0,0,0,0,0,0
	.BYTE	41,64,0,0,26,27,28,0,0
	.BYTE	0,0,0,0,0,0,75,76,77,0
	.BYTE	0,0,0,0,0,75,76,77,0,0
	.BYTE	0,0,0,0,0,0,0,0,0,0,65
	.BYTE	66,67,68,29,30,31,32,33
	.BYTE	0,0,0,41,64,0,0,78,79
	.BYTE	80,0,69,70,0,0,0,78,79
	.BYTE	80,0,0,0,0,0,0,0,0,0,0
	.BYTE	34,35,36,0,0,41,64,0,0
	.BYTE	69,28,0,0,65,66,67,68,0
	.BYTE	27,70,0,71,72,73,74,34
	.BYTE	35,36,0,0,212,213,0,0,0
	.BYTE	0,212,213,0,0,37,38,39
	.BYTE	0,65,66,67,68,71,72,73
	.BYTE	74,0,0,0,0,0,71,72,73
	.BYTE	74,0,0,0,0,37,38,39,0,0
	.BYTE	0,215,0,0,0,0,0,215,0,0
	.BYTE	0,0,0,69,70,0,0,0,0,0,0
	.BYTE	0,0,0,168,169,170,171,0
	.BYTE	0,0,26,27,28,0,0,0,0,0
	.BYTE	0,0,0,0,0,0,0,0,0,40,41
	.BYTE	42,43,71,72,73,74,0,75
	.BYTE	76,77,0,0,0,172,173,46
	.BYTE	47,48,49,0,29,30,31,32
	.BYTE	33,0,0,41,64,0,0,0,0,0
	.BYTE	0,0,0,44,45,46,47,48,49
	.BYTE	0,41,64,0,78,79,80,0,0
	.BYTE	0,0,0,0,0,197,198,0,0,0
	.BYTE	128,0,0,0,65,66,67,68,0
	.BYTE	0,0,0,0,0,0,0,0,0,0,0,0
	.BYTE	65,66,67,68,0,26,27,28
	.BYTE	0,0,0,0,0,71,72,73,74,0
	.BYTE	41,64,0,0,0,0,0,0,209
	.BYTE	210,128,0,128,128,209
	.BYTE	210,0,0,50,51,52,53,54
	.BYTE	0,0,0,29,30,31,32,33,0
	.BYTE	0,0,0,0,0,0,0,65,66,67
	.BYTE	68,0,0,0,0,0,214,0,0,0
	.BYTE	0,0,214,0,0,55,56,57,58
	.BYTE	59,60,61,0,0,27,70,0,0
	.BYTE	0,0,0,0,27,70,0,0,34,35
	.BYTE	36,0,0,40,41,42,43,0,0
	.BYTE	0,0,0,0,0,0,69,70,0,0
	.BYTE	41,64,0,0,0,29,30,31,32
	.BYTE	33,0,0,0,0,71,72,73,74
	.BYTE	0,37,38,39,0,44,45,46
	.BYTE	47,48,49,0,0,0,0,0,0,71
	.BYTE	72,73,74,65,66,67,68,0
	.BYTE	41,42,43,0,0,34,35,0,0
	.BYTE	0,41,64,0,0,0,0,0,75,76
	.BYTE	77,0,0,0,0,0,0,0,0,0
	.BYTE	0,0,0,0,0,41,64,0,0,44
	.BYTE	45,46,47,48,49,0,37,38
	.BYTE	0,0,65,66,67,68,0,0,0,0
	.BYTE	0,79,80,0,0,0,0,0,0,0,0
	.BYTE	0,0,0,0,0,65,66,67,68,0
	.BYTE	0,0,0,0,0,0,0,0,0,0,0
;
	*=	$02E0
;
	.WORD	PRGSTART
	.END
