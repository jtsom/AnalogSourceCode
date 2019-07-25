; *********************
; *     ROCKS!        *
; *                   *
; *  BY DOUGLAS ENGEL *
; *                   *
; *********************
;
; OS EQUATES
;
ATRACT	=	$4D
AUDC1	=	$D201
AUDC2	=	$D203
AUDC3	=	$D205
AUDC4	=	$D207
AUDCTL	=	$D208
AUDF1	=	$D200
AUDF2	=	$D202
AUDF3	=	$D204
AUDF4	=	$D206
CH	=	$02FC
CHBAS	=	$02F4
COLOR0	=	$02C4
COLOR4	=	$02C8
COLPF0	=	$D016
COLPM0	=	$D012
COLRSH	=	$4F
CONSOL	=	$D01F
DRKMSK	=	$4E
GRACTL	=	$D01D
HITCLR	=	$D01E
HPOSP0	=	$D000
HPOSP1	=	$D001
HPOSP2	=	$D002
HPOSP3	=	$D003
HPOSM0	=	$D004
HSCROL	=	$D404
KBCODE	=	$D209
M2PF	=	$D002
M2PL	=	$D00A
NMIEN	=	$D40E
P0PF	=	$D004
P0PL	=	$D00C
P1PF	=	$D005
P1PL	=	$D00D
P3PL	=	$D00F
PCOLR0	=	$02C0
PMBASE	=	$D407
PRIOR	=	$D01B
RANDOM	=	$D20A
RUNAD	=	$02E0
SDLSTL	=	$0230
SDMCTL	=	$022F
SETVBV	=	$E45C
SIZEP0	=	$D008
SKCTL	=	$D20F
STICK0	=	$0278
STRIG0	=	$0284
VDSLST	=	$0200
VKEYBD	=	$0208
WSYNC	=	$D40A
XITVBV	=	$E462
;
; PROGRAM EQUATES
;
MISSLES	=	PMTABL+768	;PM missles
PLAYER0	=	PMTABL+1024	;PM players 0 & 1
PLAYER1	=	PMTABL+1280
PMSATS	=	PMTABL+1918	;PM for sats
PMTABL	=	$5000	;Loc. of table
PMZAP	=	PMSATS-180	;PM for zap
SCOREBOARD	=	SCREEN+$08	;Print score here
SCREEN	=	$3000	;Screen mem.
;
; PROGRAM VARIABLES
;
	*=	PMTABL
ACCOUNT	*=	*+1	;Velocity counter
ALT	*=	*+1	;1/30 sec counter
ANIMATE	*=	*+1	;Animation counter
ANIPTR	*=	*+1	;Offset to frame values
BEAMDLAY	*=	*+1	;Delay counter
BEAMFLG	*=	*+1	;Flags beam on
BEAMPOS	*=	*+1	;Beam length
BLEEP	*=	*+1	;Decay
BLINK	*=	*+1	;Light counter
BLINK1	*=	*+1	;Ditto
COMPLETED	*=	*+1	;Level done flag
COWNTER	*=	*+1	;Explosion counter
DIGIT	*=	*+1	;Current score dig.
DOOM	*=	*+1	;Doom flag
EMPTY	*=	*+1	;No fuel flag
ENDCNTR	*=	*+1	;Doom counter
ETC.	*=	*+1	;Misc. sound flag
EXPLOSION	*=	*+1	;Flag
FD	*=	*+1	;Flame dir.
FLASHME	*=	*+1	;Light counter
FLIP	*=	*+1	;Direction mask
FUEL	*=	*+1	;Amount of fuel
FUELMTR	*=	*+1	;Offset to needle
FUELUSE	*=	*+1	;Rate of use
GRAVITY	*=	*+1	;Counter for veloc. change
G.O	*=	*+1	;Game over flag
HOLDA	*=	*+1	;Temp accumulator
HOLDX	*=	*+1	;Temp index reg.
HPOSME	*=	*+1	;My horiz.
HPOSSAT	*=	*+1	;Sat horiz.
KONSOL	*=	*+1	;Former consol val.
LANDFLAG	*=	*+1	;Flag landing
LOADED	*=	*+1	;Flag  loaded
MISS	*=	*+1	;M2PF shadow (sort of)
MULTIPLY	*=	*+1	;Multiplier
NEWLEV	*=	*+1	;Next level flag
NEWSC	*=	*+1	;Flag show score
PAUSED	*=	*+1	;Pause flag
POWNTER	*=	*+1	;Explosion counter
RADCOUNT	*=	*+1	;Rate of rad increase
RADS	*=	*+1	;Amount of rads
RADSMTR	*=	*+1	;Offset to needle
RAND1	*=	*+1	;Saved random #
RESET	*=	*+1	;Set up me flag
ROAR	*=	*+1	;Rocket decay
SAT?	*=	*+1	;Active sat flag
SATCNT	*=	*+1	;Time between sats counter
SATCNT1	*=	*+1	;Sat move counter
SATCOLR	*=	*+1	;Color of sat
SATDIR	*=	*+1	;Move direction
SATEXP	*=	*+1	;Sat explosion flag
SATFRAME	*=	*+1	;Sat explosion counter
SATSPD	*=	*+1	;Speed of sat
SKY	*=	*+1	;Where fall happens
STARCNT	*=	*+1	;Star move counter
STROBE	*=	*+1	;Light counter
SUPER	*=	*+1	;Super sat flag
TEMPA	*=	*+1	;Temporary
TEMPB	*=	*+1	;Temporary
VELOCITY	*=	*+1	;Fall veloc.
VOL	*=	*+1	;Decay
VOL4	*=	*+1	;Decay
VPOSME	*=	*+1	;My vert.
WAITCNTR	*=	*+1	;Message delay
WAITING	*=	*+1	;Message flag
ZAPCNT	*=	*+1	;Zap counter
ZAPFLAG	*=	*+1	;Flags zap
;
; ZERO PAGE EQUATES
;
LINENO	=	$CA	;Current DL mode line
SHAPEA	=	$E0	;Player 0 bit pattern
SHAPEB	=	$E2	;same for Player 1
ZEROPA	=	$CC	;General usage
ZEROPB	=	$CE	;same here
;
; PROGRAM
;
	*=	$2000
START	LDA	#$03	;Init serial port
	STA	SKCTL
	LDA	#<INKEY	;Steal KB vector
	STA	VKEYBD
	LDA	#>INKEY
	STA	VKEYBD+1
	LDA	#$1D	;Star color
	STA	PCOLR0+3
	LDA	#$00	;Init sound
	STA	AUDCTL
;
; Move portion of chars
;
	STA	ZEROPA	;Clear these
	STA	ZEROPB
	LDA	CHBAS	;Point to chars
	STA	ZEROPA+1
	LDA	#>CHARS	;Point to mine
	STA	ZEROPB+1
	LDY	#$40	;16 already defined
	LDX	#$01
CHLOOP	LDA	(ZEROPA),Y	;Move 'em
	STA	(ZEROPB),Y
	INY
	BNE	CHLOOP
	INC	ZEROPA+1
	INC	ZEROPB+1
	DEX
	BPL	CHLOOP
	LDA	#>CHARS	;Tell OS where they went
	STA	CHBAS
;
; Draw title
;
	LDY	#$00
	LDX	#$00
BITBLT	LDA	BITS,X	;Grab title byte
	STA	HOLDA	;Save it
	STX	HOLDX	;Save x
	LDX	#$07	;Rotate byte 8 times
SHFT	LDA	HOLDA
	ASL	A
	STA	HOLDA
	BCC	CC	;See if 0 falls out
	LDA	#$49	;No, load Rock char
	BNE	PLOT	;Always
CC	LDA	#$00	;Space char
PLOT	STA	TITLE,Y	;Store in screen mem.
	INY
	DEX
	BPL	SHFT
	LDX	HOLDX	;Get next byte
	INX
	CPX	#$19
	BNE	BITBLT	;Go back until done
SETUP	LDA	#$40	;DLI off
	STA	NMIEN
	LDA	#$00	;DMA off
	STA	SDMCTL
	LDY	#<XITVBV	;VBI off
	LDX	#>XITVBV
	LDA	#$07
	JSR	SETVBV
	LDA	#<DLIST1	;New DL vectors
	STA	SDLSTL
	LDA	#>DLIST1
	STA	SDLSTL+1
CDLI1	LDA	#<DLI1	;New DLI vector
	STA	VDSLST
	LDA	#>DLI1
	STA	VDSLST+1
	LDA	#$C0	;DLI on
	STA	NMIEN
	JSR	INITPM	;Clear PM regs.
	JSR	SILENT	;No sound
	STA	ATRACT	;No attract
	STA	COLOR0+4	;Black
	LDA	#$02
	STA	COLOR0	;Dk grey
	LDA	#$04
	STA	COLOR0+1	;Grey
	LDA	#$06
	STA	COLOR0+2	;Lt grey
	LDA	#$86
	STA	COLOR0+3	;Blue
	LDA	SLEVEL	;Use start level
	STA	LEVEL
	LDA	#$22	;Screen DMA on
	STA	SDMCTL
;
INPUT	LDA	CONSOL	;Consol input
	CMP	#$07	;No key, try again
	BEQ	INPUT
	STA	ATRACT	;Off
SEL	CMP	#$05	;Select?
	BNE	STA
	INC	LEVEL	;Update level
	LDA	LEVEL
	CMP	#$1A	;Insure wrap at 10
	BNE	DEBOUNCE
	LDA	#$10
	STA	LEVEL
	BNE	DEBOUNCE	;Always
STA	CMP	#$06	;Start?
	BNE	INPUT
LG	LDA	CONSOL	;Wait for release
	CMP	#$07
	BNE	LG
	BEQ	UNPRESS	;Always
DEBOUNCE	STA	SLEVEL	;New start level
	LDX	#$40	;Debounce delay
	LDY	#$00
ASIA	INY
	BNE	ASIA
	DEX
	BNE	ASIA
BOINK	LDX	#$70	;Wait for release
	LDY	#$00
PRESSED	LDA	TEMPA	;Waste time
	INY
	BNE	PRESSED
	LDA	CONSOL	;Let go, go back
	CMP	#$07
	BEQ	INPUT
	DEX
	BNE	PRESSED
	JMP	INPUT	;go back now
;
UNPRESS	LDA	#$00
	STA	SDMCTL
	STA	TOTAL	;Levels done=0
	STA	ATRACT	;Off
CLRSCR	LDX	#$07	;Put ATASCII 0's in score
	LDA	#$10
GEM	STA	SCORE,X
	DEX
	BPL	GEM
	LDA	#$13	;ATASCII 3 ships
	STA	SHIPS
	LDA	SLEVEL	;Start at start level
	STA	LEVEL
	STA	PAINT	;Planet color mask
;
INIT	LDA	#>PMTABL	;Clear all those vars
	LDY	#<PMTABL
	LDX	#$01
	JSR	CLEER	;Use this routine
	JSR	SILENT	;Sound off
	JSR	INITPM	;Reset PM regs.
	LDA	#$05	;Make sure that we
	STA	CHARS+641	;Start with original
	STA	CHARS+646	;Char shapes
	LDA	#$A8
	STA	CHARS+677
	LDA	#$15
	STA	CANISTERS
	STA	PAUSED	;Start paused
ACROSS	LDA	#$03	;PM on
	STA	GRACTL
	LDA	#>PMTABL	;Tell OS where pm is
	STA	PMBASE
	LDA	#$00	;Clear scroll tables
	LDX	#$A7
CLR	STA	SCRLST,X
	DEX
	BPL	CLR
	LDA	#>MISSLES	;Clear PM area
	LDY	#<MISSLES
	LDX	#$05
	JSR	CLEER
	LDA	#>MISSLES	;Put stars in missile 3
	STA	ZEROPA+1
	LDA	#<MISSLES
	STA	ZEROPA
	LDA	#$29	;Starting line
SPOT	TAY
	LDA	#$80	;Put $80
	STA	(ZEROPA),Y	; on 2 consecutive
	INC	ZEROPA	; bytes
	STA	(ZEROPA),Y
	DEC	ZEROPA
	TYA
	CLC
	ADC	#$08	;Then skip 8 bytes
	BCC	SPOT	; and put in more
;
	LDX	#$D7	;Draw guage needles
NEEDLE	LDA	MISSLES,X
	ORA	#$05	;Missiles 0 & 1
	STA	MISSLES,X
	INX
	CPX	#$E0
	BNE	NEEDLE
;
	LDX	#$0A	;Create random distances
STARS	LDA	RANDOM	; between the horiz.
	BEQ	STARS	; positions of the consecutive
	STA	MPOS,X	; star bits.
OFS	LDA	RANDOM
	BEQ	OFS
	STA	OFFSET,X
	DEX
	BPL	STARS
;
FIELDCLR	LDA	#>SCREEN	;Clear asteroid field
	LDY	#<SCREEN
	LDX	#$09
	JSR	CLEER
;
; Put rock chars on screen
;
	LDX	#$02
	LDA	#>SCREEN+768	;Start location
	STA	ZEROPA+1
ROCKS	LDA	#$00
	STA	ZEROPA	;Start at 0
ASTRO	JSR	R16	;Random #
	CMP	#$06	;<6?
	BCC	DOUBLE	;Yes, make big rock
	CLC
	ADC	#$40	;Offset to char code
	LDY	#$00
	STA	(ZEROPA),Y	;Put in char
	JSR	R16	;Find spacing for next rock
	STA	TEMPA
	JSR	GETLEV	;Based on level
	STA	TEMPB
	LDA	#$0D	;By subtracting level from 14
	SEC
	SBC	TEMPB
	CLC
	ADC	TEMPA	; and adding random #
	CLC
	ADC	ZEROPA	;Point to new spot
	BCS	COMPLE	;Done at page end
	STA	ZEROPA
	BCC	ASTRO	;Always
DOUBLE	STA	HOLDA	;Save
	LDA	ZEROPA	;See if near page end
	CMP	#$FE
	BCS	ASTRO	;Too close try again
	LDA	HOLDA	;Get char code
	AND	#$FE	;Make even
	ADC	#$40	;Char offset
	LDY	#$00
	STA	(ZEROPA),Y	;Put in mem
	CLC
	ADC	#$01	;Next char
	INY
	STA	(ZEROPA),Y	; goes in next byte
	JSR	R16	;Random spacing by level again.
	STA	TEMPA
	JSR	GETLEV
	STA	TEMPB
	LDA	#$0E
	SEC
	SBC	TEMPB
	CLC
	ADC	TEMPA
	CLC
	ADC	ZEROPA
	BCS	COMPLE
	STA	ZEROPA
	BCC	ASTRO
COMPLE	INC	ZEROPA+1	;Point to next page
	INC	ZEROPA+1
	DEX
	BPL	ROCKS	;Do more
;
; Put fleet on screen
	LDA	#>SCREEN+256	;Set addr.
	STA	ZEROPA+1
	LDA	#<SCREEN+256
	STA	ZEROPA
PUTSHP	LDY	#$00	;Set index
	LDA	#$D0	;Rear char code
	STA	(ZEROPA),Y	;Place
	INY		;Next byte
	LDA	#$51	;Engines char
	STA	(ZEROPA),Y	;Place
	INY		;Next
	JSR	R07	;Random # <=7 but >3
	CLC
	ADC	#$03
	STA	HOLDA
	LDA	#$52	;Pod back char
SHIP	STA	(ZEROPA),Y
	INY		;Next
	CPY	HOLDA	;Done enough?
	BNE	SHIP
	LDA	#$53	;Bridge char
	STA	(ZEROPA),Y
	INY		;Next
	LDA	#$D4	;Nose char
	STA	(ZEROPA),Y
	INY
	TYA
	CLC
	ADC	ZEROPA	;Start addr is now at
	STA	ZEROPA	;Front of ship
	JSR	R16	;Spacing = 2*level+Rnd
	ADC	LEVEL
	ADC	LEVEL
	ADC	#$20	;+ $20
	CLC
	ADC	ZEROPA	;Add to start
	BCS	OVER	;Page done?
	STA	ZEROPA	;See if too close to
	CMP	#$F0	;Page boundary
	BCC	PUTSHP
;
; Copy for scroll wrap
;
OVER	LDX	#$03	;# of pages
	LDA	#<SCREEN+256	Set up
	STA	ZEROPA
	LDA	#>SCREEN+256
	STA	ZEROPA+1
WRAP	LDY	#$00	;# of bytes moved
COPY	LDA	(ZEROPA),Y	;Get one
	INC	ZEROPA+1	;Put on next page
	STA	(ZEROPA),Y
	DEC	ZEROPA+1	;Point to ogir. page
	INY
	CPY	#$30
	BNE	COPY	;Done?
	INC	ZEROPA+1	;Skip a page
	INC	ZEROPA+1
	DEX		;Done?
	BPL	WRAP
;
;Random scroll directions and speeds
;
	LDA	#$02
	STA	SCRLST+1	;Fleet dir
	LDA	#$03
	STA	LIMIT+1	;Fleet speed
	LDX	#$04
SETDIR	LDA	RANDOM	;Random rock dir
	AND	#$03
	BEQ	SETDIR	;no 0's
	CMP	#$03	;no 3's
	BEQ	SETDIR
	STA	SCRLST,X
	CMP	#$01	;Set counter
	BNE	RD	; to right value
	LDA	#$04	; for left
	STA	CURR,X
	BNE	ZC	;Always
RD	LDA	#$00	;Also for right
	STA	CURR,X
ZC	LDA	#$00	;Set 0 color clocks
	STA	COLCKS,X
	INX
	CPX	#$0B	;Done?
	BNE	SETDIR
SPEED	LDX	#$04	;Set 5 (speed) counters
SETSPD	JSR	R16	;Random # 1-16
	ADC	#$01
	STA	LIMIT,X	;Store it
	LDA	RANDOM	;Bias the speeds
	CMP	#$30	; if <$30
	BCC	CONTIN
	AND	#$03	;High speed
	STA	LIMIT,X
CONTIN	INX
	CPX	#$0B	;Done?
	BNE	SETSPD
;
	LDA	#<DLIST	;New DL vector
	STA	SDLSTL
	LDA	#>DLIST
	STA	SDLSTL+1
	JSR	OLDC	;Set color table
CDLI	LDA	#<DLI	;New DLI vector
	STA	VDSLST
	LDA	#>DLI
	STA	VDSLST+1
	LDY	#<VBLANK	;New VBI vector
	LDX	#>VBLANK
	LDA	#$07
	JSR	SETVBV
FAT	LDA	#$3F	;Wide screen DMA
	STA	SDMCTL
	BNE	RESETME	;Always
;
; PROGRAM LOOP
;
LOOP	LDA	RESET	;Reset flag?
	BEQ	SPCLKEYS	;No, check consol
	BNE	RESETME	;Yes, reset
SPCLKEYS	LDA	CONSOL	;Get consol
	CMP	#$07	;Any pressed
	BNE	AAAAAC	;Yes, go ahead
	LDA	KONSOL	;No, get former
	LDX	#$00
	STX	KONSOL	;Clear it
SEL1	CMP	#$05	;Select?
	BNE	STA1
	JMP	SETUP	;Go to title screen
STA1	CMP	#$06	;Start?
	BNE	AAAAAB
	JMP	UNPRESS	;Restart game
AAAAAC	STA	KONSOL	;Save Console in former
AAAAAB	LDA	NEWLEV	;Check for new level
	BEQ	LOOP
	JMP	INIT	;Start new level
;
RESETME	JSR	BEAMOFF	;No beam
	JSR	SILENT	;No sound
	LDA	#$30	;Init my positions
	STA	VPOSME
	LDA	#$7E
	STA	HPOSME
	JSR	CLRME	;Erase me
	LDA	EXPLOSION	;See if I exploded
	BEQ	RS232	;No? skip this
SUBTRACT	DEC	SHIPS	;Another on bites the dust
	LDA	SHIPS	;Any left?
	CMP	#$10
	BNE	RS232	;Yes skip this
	LDX	#$12	;Game over message and flag
	JSR	DLPRINT
	LDA	#$FF
	STA	G.O
RS232	LDA	#$57	;Reset all variables
	STA	RADSMTR
	LDA	#$98
	STA	FUELMTR
	LDA	#$7D
	STA	SKY
	LDA	#$6C
	STA	PCOLR0+1
	LDA	#$95
	STA	PCOLR0
	JSR	FLAGS	;Reset landed flags
	STA	POWNTER
	STA	EXPLOSION
	STA	GRAVITY
	STA	EMPTY
	STA	ROAR
	STA	ETC.
	STA	RESET
	STA	COMPLETED
	LDA	#$FF	;Fill 'er up
	STA	FUEL
	LDA	#$01
	STA	FLIP
	STA	NEWSC	;Flag new score
	LDA	LEVEL	;Get right ATASCII value
	CLC		; for displaying level
	ADC	#$C0
	STA	PLEVEL
	LDA	LEVEL	;Find multiplier
	CMP	#$19	;If level<9 then
	BNE	ONEDIGIT	;Mult. <10
	LDA	#$D1	;Mult must be 10
	STA	PMULT	;Show "1"
	LDA	#$D0
	STA	PMULT+1	;Show "0"
	BNE	THX1138	;Always
ONEDIGIT	CLC		;Mult. = level+1
	ADC	#$C1	;+$C0 for correct ATASCII
	STA	PMULT+1
	LDA	#$D0
	STA	PMULT	;" " in second digit
THX1138	LDA	G.O	;See if game over
	BNE	NEO
	LDX	#$06	;Yes, show message
	JSR	DLPRINT
	LDA	#$00
	STA	WAITING
	LDA	#$FF	;Permanent pause
	STA	PAUSED
	LDA	#$B4
	STA	WAITCNTR
NEO	JSR	SHOW	;Show me
	JMP	LOOP	;Back to main
;
; SUBROUTINE LIBRARY
;
; routine to find score
;
MATH	LDY	MULTIPLY	;# of iterations
	CLD
STEP	LDX	DIGIT	;Digit to operate on
ADDNUM	LDA	SCORE,X	;Current val
	CLC
	ADC	#$01	;+1 for each iteration
	CMP	#$1A	;Over 10?
	BCS	NEXTPLACE	;Yes, next digit
FIN	STA	SCORE,X	;New val
	DEY		;Next
	BNE	STEP	;Another iteration
	LDA	#$FF
	STA	NEWSC	;Flag score
	RTS		;Done!
NEXTPLACE	CLC		;Sub 9 from val
	SBC	#$09
	STA	SCORE,X	;Save
	DEX		;Next higher digit
	BPL	ADDNUM	;Always
EGG	JMP	LOOP	;Easter egg could go here
;
;Routine to clear me form PM table
;
CLRME	LDA	#>PLAYER0
	LDY	#<PLAYER0
	LDX	#$02
	JSR	CLEER
	RTS
;
; PM register clear routine
;
INITPM	LDX	#$11	;17 registers
INITP	LDA	#$00	;Entry point if other than 17
IPM	STA	HPOSP0,X
	DEX
	BPL	IPM
	RTS
;
; Routine for color attracting
;
MIXUP	EOR	COLRSH
	AND	DRKMSK
	RTS
;
; Routint to initialize color tables
;
OLDC	LDX	#$77
SETCOLR	LDA	COLTAB,X	;Orig color
	STA	ACOLTAB,X	;Attract table
	STA	DCOLTAB,X	;Display table
	CPX	#$46
	BEQ	CHANGE	;Test to see if color in question
	CPX	#$2E
	BEQ	CHANGE	; is a planet color
	CPX	#$16
	BEQ	CHANGE	; and alter it
	DEX
	BPL	SETCOLR	;Done?
	RTS		;Return
CHANGE	LDY	#$0A	;Change next 11
SILLY	LDA	PAINT	;Get mask
	AND	#$0F	;Make lower bits high
	ASL	A
	ASL	A
	ASL	A
	ASL	A
	EOR	PAINT	;Scramble it
	ASL	A	;Scramble more
	AND	#$F7	;Mask high intensity
	EOR	COLTAB,X	;Use it to scramble colors
	STA	ACOLTAB,X
	STA	DCOLTAB,X
	DEX
	DEY
	BPL	SILLY	;All done?
	BMI	SETCOLR	;NO, go back
;
; Routine to set my PM shape pointers
;
SETSHAPE	LDA	#<SHAPE1A	;Player 0
	STA	SHAPEA
	LDA	#>SHAPE1A
	STA	SHAPEA+1
	LDA	#<SHAPE1B	;Player 1
	STA	SHAPEB
	LDA	#>SHAPE1B
	STA	SHAPEB+1
	RTS
;
; Routine to put flames on ship
;
BURN	LDA	RANDOM	;Bits for top and bottom
	AND	#$18	;Flames here
PUT	PHA		;Entry point from side routine
	ORA	PLAYER0,X	;"OR" into player 0
	STA	PLAYER0,X
	PLA
	ORA	PLAYER1,X	;Ditto
	STA	PLAYER1,X
	INC	FUELUSE	;Rockets use fuel
	INC	FUELUSE
	RTS
;
BURN1	LDA	RANDOM	;Bits for side flames
	LDY	FD	;Mov.ng left or right
	CPY	#$01
	BNE	RF	;Right. skip this
	AND	#$03	;Mask bits
	JMP	PUT	;Show them
RF	AND	#$C0	;Mask bits
	JMP	PUT	;Show them
;
; Routine to show me
;
SHOW	LDA	HPOSME	;Set horiz. regs.
	STA	HPOSP0
	STA	HPOSP1
	CLC
	ADC	#$03	;+3 for beam horiz.
	STA	HPOSM0+2
	LDX	VPOSME	;My vert
	DEX
	LDA	#$00
	STA	PLAYER0,X	;Erase flames above
	STA	PLAYER1,X
	INX
	LDY	#$00
LPRINT	LDA	(SHAPEA),Y	;Move shape data
	STA	PLAYER0,X
	LDA	(SHAPEB),Y	;For both players
	STA	PLAYER1,X
	INX
	INY
	CPY	#$0C	;12 bytes?
	BNE	LPRINT
	LDA	NEWSC	;See if score updated
	BEQ	AAAAAD	;No, skip this
	LDX	#$07	;Yes, Put score in screen mem
RMK	LDA	SCORE,X
	STA	SCOREBOARD,X
	DEX
	BPL	RMK
	LDA	#$00	;Clear flag
	STA	NEWSC
AAAAAD	RTS		;Return
;
; Routine to display messages
; by altering Display list
;
DLPRINT	LDY	#$00	;Counter
LLLLLL	LDA	DLTABL,X	;New DL val
	STA	DLIST+40,Y	;Store
	INX
	INY
	CPY	#$06	;6 vals altered
	BNE	LLLLLL	;No, do,it again
	RTS
;
; Routine to clear satellites form PM table
;
CSAT	LDA	#$00
	LDX	#$19	;Zero 64 bytes
RUB	STA	PMSATS-10,X
	DEX
	BPL	RUB
	RTS
;
; General purpose clearing routine
;
CLEER	STA	ZEROPA+1	;Save high byte
	STY	ZEROPA	;Save low byte
	LDA	#$00	;X reg. is # of pages
	TAY
CLEAN	STA	(ZEROPA),Y	;Clear
	INY
	BNE	CLEAN
	INC	ZEROPA+1
	DEX
	BNE	CLEAN	;Do until done
	RTS
;
; Routine to mirror bits in a byte
;
MYRNA	STA	HOLDA	;Entry point for random mirror
	JSR	R01
	BNE	RET	;Don't mirror
	LDA	HOLDA
MIRROR	STA	HOLDA	;Entry point for mirror always
	STX	HOLDX	;Save x
	LDX	#$07	;8 bits
MM	ROL	A	;Rotate bit in carry
	ROR	HOLDA	;Rotate out reverse
	DEX
	BPL	MM	;Do all 8
	LDX	HOLDX	;Restore X & A
RET	LDA	HOLDA
	RTS		;Done!
;
; Routine to turn off sound
;
SILENT	LDA	#$00	;No explanation needed
	LDX	#$07
HUH	STA	AUDC1,X
	DEX
	BPL	HUH
	RTS
;
; Routine to get actual level
;
GETLEV	LDA	LEVEL
	AND	#$0F
	RTS
;
; Routine to erase beam
;
BEAMOFF	LDX	VPOSME	;Beam starts at me+2
	INX
	INX
	LDY	#$23	;Erase this much
OFFLOOP	LDA	#$CF
	AND	MISSLES,X
	STA	MISSLES,X
	DEX
	DEY
	BNE	OFFLOOP	;Do it all
	LDA	#$00	;Clear all beam flags
	STA	BEAMFLG
	STA	BEAMDLAY
	STA	BEAMPOS
	STA	LOADED
	STA	AUDC4
	JSR	SETSHAPE	;Set original shape
	RTS
;
; Random number routines
;
R01	LDA	RANDOM
	AND	#$01
	RTS
R07	LDA	RANDOM
	AND	#$07
	RTS
R16	LDA	RANDOM
	AND	#$0F
	RTS
;
; Landing flag clearing routine
;
FLAGS	LDA	#$00
	STA	LANDFLAG
	STA	ACCOUNT
	STA	ANIPTR
	STA	ANIMATE
	RTS
;
; DISPLAY LIST INTERRUPT ROUTINE
;         FOR GAME SCREEN
;
DLI	PHA		;Save 6502 regs.
	TXA
	PHA
	LDX	LINENO	;Current mode line
	STA	WSYNC
	LDA	DCOLTAB+96,X	;Background color
	STA	COLPF0+4
	LDA	CURR,X	;Current HSCROL val
	STA	HSCROL
	STA	WSYNC
	LDA	DCOLTAB+24,X	;Color1
	STA	COLPF0+1
	LDA	DCOLTAB+48,X	;Color2
	STA	COLPF0+2
	LDA	DCOLTAB+72,X	;Color3
	STA	COLPF0+3
	LDA	DCOLTAB,X	;Color0
	STA	COLPF0
	LDA	MPOS,X	;Stars on this line?
	BEQ	NOSTAR	;No? skip this
	STA	WSYNC
	STA	HPOSM0+3	;Horiz. pos. of star
	LDA	MPOS,X	;Find pos. of star next line
	CLC
	ADC	OFFSET,X
	STA	WSYNC	;Wait for next line
NOSTAR	STA	HPOSM0+3	;Save pos for it
	INC	LINENO
	LDA	PRITAB,X	;Set priority this line
	STA	WSYNC
	STA	PRIOR
	CPX	#$02	;Is it line #2?
	BNE	NADA	;No, skip
	LDA	M2PF	;Hold collisions for line
	STA	MISS
NADA	CPX	#$0B	;Line 11 yet?
	BNE	NAY	;No, skip
	LDA	SATCOLR	;Change color for sats
	JSR	MIXUP	;Attract them first
	STA	COLPM0+3
NAY	PLA		;Restore 6502
	TAX
	PLA
	RTI
;
; DISPLAY LIST INTERRUPT ROUTINE
;         FOR TITLE SCREEN
;
DLI1	PHA		;Save
	LDA	#$36	;Red
	JSR	MIXUP	;Attract
	STA	COLPF0	;Color0
	PLA		;Restore
	RTI
;
; KEYBOARD INTERRUPT ROUTINE
;
INKEY	LDA	KBCODE	;Key code (A saved by OS)
	STA	CH	;Save
	PLA		;Restore
	RTI
;
; COMMON LABELS
;
ACOLTAB	=	$3EC8
BITS	=	$46D8
CANISTERS	=	$3BB7
CHARS	=	$4000
COLCKS	=	$3E08
COLTAB	=	$3E50
CURR	=	$3DF0
DCOLTAB	=	$3F40
DLIST	=	$3D30
DLIST1	=	$3D88
DLTABL	=	$3D70
LEVEL	=	$3CC9
LIMIT	=	$3DD8
MPOS	=	$3E20
OFFSET	=	$3E38
PAINT	=	$4761
PLEVEL	=	$3CDF
PMULT	=	$3CF9
PRITAB	=	$4709
SCORE	=	$4757
SCRLST	=	$3DA8
SHAPE1A	=	$4400
SHAPE1B	=	$440C
SHIPS	=	$3BDA
SLEVEL	=	$475F
TITLE	=	$3BE0
TOTAL	=	$4760
VBLANK	=	$261E
	.END
Listing 3.
Assembly listing
;  ROCKS! VERTICAL BLANK
; ROUTINE AND DATA TABLES
;    By: Douglas Engel
;
; OS EQUATES
;
ATRACT	=	$4D
AUDC1	=	$D201
AUDC2	=	$D203
AUDC3	=	$D205
AUDC4	=	$D207
AUDCTL	=	$D208
AUDF1	=	$D200
AUDF2	=	$D202
AUDF3	=	$D204
AUDF4	=	$D206
CH	=	$02FC
HITCLR	=	$D01E
HPOSP0	=	$D000
HPOSP1	=	$D001
HPOSP2	=	$D002
HPOSP3	=	$D003
HPOSM0	=	$D004
M2PF	=	$D002
M2PL	=	$D00A
P0PF	=	$D004
P0PL	=	$D00C
P1PF	=	$D005
P1PL	=	$D00D
P3PL	=	$D00F
PCOLR0	=	$02C0
PRIOR	=	$D01B
RANDOM	=	$D20A
RUNAD	=	$02E0
SIZEP0	=	$D008
STICK0	=	$0278
STRIG0	=	$0284
XITVBV	=	$E462
;
;COMMON LABELS AND VARIABLES
;SEE PART 1 FOR DESCRIPTIONS
;
ACCOUNT	=	$5000
ALT	=	$5001
ANIMATE	=	$5002
ANIPTR	=	$5003
BEAMDLAY	=	$5004
BEAMFLG	=	$5005
BEAMOFF	=	$2555
BEAMPOS	=	$5006
BLEEP	=	$5007
BLINK	=	$5008
BLINK1	=	$5009
BURN	=	$2485
BURN1	=	$249F
CLRME	=	$241F
COMPLETED	=	$500A
COWNTER	=	$500B
CSAT	=	$2506
DIGIT	=	$500C
DLPRINT	=	$24F7
DOOM	=	$500D
EMPTY	=	$500E
ENDCNTR	=	$500F
ETC.	=	$5010
EXPLOSION	=	$5011
FD	=	$5012
FLAGS	=	$258F
FLASHME	=	$5013
FLIP	=	$5014
FUEL	=	$5015
FUELMTR	=	$5016
FUELUSE	=	$5017
GETLEV	=	$254F
GRAVITY	=	$5018
G.O	=	$5019
HOLDA	=	$501A
HOLDX	=	$501B
HPOSME	=	$501C
HPOSSAT	=	$501D
INITP	=	$242B
KONSOL	=	$501E
LANDFLAG	=	$501F
LINENO	=	$CA
LOADED	=	$5020
MATH	=	$23F6
MIRROR	=	$252E
MIXUP	=	$2434
MISS	=	$5021
MISSLES	=	PMTABL+768
MULTIPLY	=	$5022
MYRNA	=	$2523
NEWLEV	=	$5023
NEWSC	=	$5024
OLDC	=	$2439
PAUSED	=	$5025
PLAYER0	=	PMTABL+1024
PLAYER1	=	PMTABL+1280
PMSATS	=	PMTABL+1918
PMTABL	=	$5000
PMZAP	=	PMSATS-180
POWNTER	=	$5026
PUT	=	$248A
R01	=	$257D
R07	=	$2583
R16	=	$2589
RADCOUNT	=	$5027
RADS	=	$5028
RADSMTR	=	$5029
RAND1	=	$502A
RESETFLAG	=	$502B
ROAR	=	$502C
SAT?	=	$502D
SATCNT	=	$502E
SATCNT1	=	$502F
SATCOLR	=	$5030
SATDIR	=	$5031
SATEXP	=	$5032
SATFRAME	=	$5033
SATSPD	=	$5034
SHAPEA	=	$E0
SHAPEB	=	$E2
SHOW	=	$24B3
SILENT	=	$2544
SKY	=	$5035
STARCNT	=	$5036
START	=	$2000
STROBE	=	$5037
SUPER	=	$5038
UNPRESS	=	$210F
VELOCITY	=	$503B
VOL	=	$503C
VOL4	=	$503D
VPOSME	=	$503E
WAITCNTR	=	$503F
WAITING	=	$5040
ZAPCNT	=	$5041
ZAPFLAG	=	$5042
;
	*=	$261E	;Byte after Part 1
;
; VERTICAL BLANK ROUTINE
;
VBLANK	LDA	RESETFLAG	;Skip most during reset
	BEQ	READY
	JMP	TESTCH
READY	LDA	#$00
	STA	LINENO	;Point to !st line
	STA	FD	;Clear
	LDA	PAUSED	;Skip most if paused
	BEQ	FIN?
	JMP	TESTCH
FIN?	LDA	G.O	;Skip ahead if not over
	BEQ	DOOMSDAY
	LDA	STRIG0	;Trigger restarts
	BNE	BUSY
	PLA		;This breaks out of routine,
	PLA		; so, pull ret. addr.
	JMP	UNPRESS	; and jump back
BUSY	JMP	CLRCH
;
; Planet destruction routine
;
DOOMSDAY	LDA	DOOM	;Test for doom
	BNE	QW
	JMP	MOVEMENT	;No, skip this
QW	INC	ENDCNTR	;Count
	LDA	ENDCNTR	;Test and branch to
	CMP	#$38	; appropriate part of explosion
	BCC	PY0
	CMP	#$E0	;Maximum val?
	BCC	PY1	;No, skip
	LDX	#$12	;Set game over flags
	STX	G.O
	JSR	DLPRINT	;Print message
	JSR	SILENT	;Sound off
	JMP	TESTCH	;Skip rest
PY0	LDX	#$03	;0 all HPOS regs.
	JSR	INITP
	LDX	#$0C	;Increment sky colors
G	LDA	ACOLTAB+96,X
	CLC
	ADC	#$01
	AND	#$0F	;Make them only blue
	ORA	#$70
	STA	ACOLTAB+96,X
	STA	DCOLTAB+96,X
	STA	AUDF1	;Use val for sounds
	ADC	#$20
	STA	AUDF2
	LDA	#$CF	;Set audio control
	STA	AUDC1
	STA	AUDC2
	INX
	CPX	#$13	;Do all sky lines
	BNE	G
	JMP	TESTCH
PY1	LDX	#$77	;Flash all colors
G1	LDA	RAND1	;Random mask
	AND	#$0F	;Only intensity bits
	EOR	ACOLTAB,X
	STA	ACOLTAB,X
	STA	DCOLTAB,X
	LDA	#$0F	;Audio controls
	STA	AUDC1
	STA	AUDC2
	LDA	#$8F
	STA	AUDC3
	STA	AUDC4
	LDA	ENDCNTR	;Use counter for freq.
	STA	AUDF1
	ASL	A	;Freq *2
	STA	AUDF2
	ASL	A	;Freq *2
	STA	AUDF3
	EOR	#$FF	;Inverse
	STA	AUDF4	;Use as freq.
	DEX
	BPL	G1	;Do all colors
	JMP	TESTCH	;Skip ahead
;
; Scrolling routine
;
MOVEMENT	LDX	#$17	;Scrolling 24 lines
SCROLL	LDA	SCRLST,X	;Direction
	BEQ	NXTLIN	;0?, don't
	LDA	COUNT,X	;Speed counter
	CMP	LIMIT,X	;Is it max?
	BCC	INCCNT	;No, skip
	LDA	#$00
	STA	COUNT,X	;0 count
	LDA	SCRLST,X	;Check dir.
	CMP	#$02
	BEQ	RIGHT
LEFT	LDA	#$03	;Find #of color clocks
	SEC
	SBC	COLCKS,X
	STA	CURR,X	;Put in table
	INC	COLCKS,X
	LDA	COLCKS,X	;See if too many
	CMP	#$04
	BNE	NXTLIN
	STA	CURR,X	;Reset table
	LDA	#$00
	STA	COLCKS,X
	STX	HOLDX
	LDA	POINTR,X	;Find DL byte to change
	TAX
	INC	DLIST,X	;Change
	LDX	HOLDX
	JMP	NXTLIN	;Next line
RIGHT	INC	COLCKS,X	;Next color clock
	LDA	COLCKS,X	;Update table
	STA	CURR,X
	CMP	#$04	;See if too many
	BNE	NXTLIN
	LDA	#$00	;Reset table
	STA	CURR,X
	STA	COLCKS,X
	STX	HOLDX
	LDA	POINTR,X	;DL byte to alter
	TAX
	DEC	DLIST,X	;Alter
	LDX	HOLDX
	JMP	NXTLIN	;Next
INCCNT	INC	COUNT,X	;Inc. counter
NXTLIN	DEX		;Do rest of lines
	BPL	SCROLL
SKYLON	INC	STARCNT	;Star counter
	LDA	STARCNT	;Test max.
	CMP	#$80
	BNE	FLASH	;Not yet, skip
	LDX	#$0A
TIME	DEC	MPOS,X	;Change star pos.
	DEX
	BPL	TIME	;Do all lines
	INX
	STX	STARCNT
;
; Light flashing routines
;
FLASH	INC	STROBE	;Light counter
	LDA	STROBE
	CMP	#$1C	;Branch at each of these
	BEQ	YES1
	CMP	#$1E
	BEQ	NO1
	CMP	#$3A
	BEQ	YES
	CMP	#$3C
	BEQ	NO
	BNE	RUNING	;None of them, skip
YES1	LDA	#$0D	;On, alter char
	STA	CHARS+641
	BNE	MOVEME
NO1	LDA	#$05	;Off alter char
	STA	CHARS+641
	BNE	MOVEME
YES	LDA	#$0D	;On, alter these
	STA	CHARS+646
	LDA	#$B8
	STA	CHARS+677
	BNE	MOVEME
NO	LDA	#$05	;Off, alter these
	STA	CHARS+646
	LDA	#$A8
	STA	CHARS+677
	LDA	#$00
	STA	STROBE
RUNING	INC	BLINK	;Other light counter
	LDA	BLINK	;Branch at right vals.
	CMP	#$28
	BEQ	OFF
	CMP	#$3C
	BEQ	ON
	BNE	BASE
OFF	LDA	#$02	;Off, dark color
	STA	DCOLTAB+49
	STA	DCOLTAB+50
	BNE	MOVEME
ON	LDA	#$28	;On, light color
	STA	DCOLTAB+49
	STA	DCOLTAB+50
	LDA	#$00
	STA	BLINK	;Clear count
BASE	INC	BLINK1	;Base light counter
	LDA	BLINK1	;Branch at these
	CMP	#$38
	BEQ	DARK
	CMP	#$48
	BEQ	LIGHT
	BNE	MOVEME
DARK	LDA	#$7F	;Off, alter chars
	STA	CHARS+1012
	LDA	#$F7
	STA	CHARS+970
	STA	CHARS+974
	BNE	MOVEME
LIGHT	LDA	#$3F	;On, alter chars
	STA	CHARS+1012
	LDA	#$F3
	STA	CHARS+970
	STA	CHARS+974
	LDA	#$00
	STA	BLINK1
;
; Movement within atmosphere routine
;
MOVEME	LDA	EXPLOSION	;Skip if exploding
	BEQ	LUKE
	JMP	SPOCK
LUKE	LDA	LANDFLAG	;Skip if landed
	BNE	LANDED
	LDA	VPOSME	;Ground level?
	CMP	#$C0
	BNE	ABOVE
	JMP	GROUND
ABOVE	CMP	SKY	;In space?
	BCS	RISING
	JMP	SPACE
RISING	INC	GRAVITY	;Inc. count
	LDA	GRAVITY
	CMP	#$0A	;Max val?
	BNE	FALL
	LDA	#$00	;Yes, clear
	STA	GRAVITY
	LDA	EMPTY	;No fuel, no stick
	BEQ	JOY1
	LDA	#$FF
	BNE	NOJOY1	;Always
JOY1	LDA	STICK0
NOJOY1	EOR	FLIP	;Change stick for
	AND	#$01	;Up or down accel.
	BNE	DECEL
ACCEL	DEC	VELOCITY	;Move faster
	BNE	FALL	;Can't be <1
	LDA	#$01
	STA	VELOCITY
	BNE	FALL	;Always
DECEL	INC	VELOCITY	;Move slower
	LDA	VELOCITY
	CMP	#$10
	BNE	FALL	;At this slow we are
	LDA	#$0F	; reversing direction
	STA	VELOCITY
	LDA	FLIP
	EOR	#$01	;Flip to reverse dir.
	STA	FLIP
FALL	LDA	VELOCITY	;Counter
	INC	ACCOUNT
	CMP	ACCOUNT
	BEQ	OOOOOH
	BCS	JUMPIT
OOOOOH	LDA	#$00	;Clear them
	STA	ACCOUNT
	LDA	FLIP	;See if going up or down
	BEQ	DECRE
INCRE	INC	VPOSME	;Move down and jump
JUMPIT	JMP	SLEFT
DECRE	DEC	VPOSME	;Move up and jump
	JMP	SLEFT
;
; Landing routines
;
LANDED	LDA	LOADED	;Landed? Then skip
	BNE	BLASTOFF
	INC	ANIMATE	;Count
	BNE	NOSTK	;Not max
	LDA	#$FF	;Reset count
	STA	ANIMATE
	LDA	STICK0	;Wait for stick
	AND	#$01
	BEQ	BLASTOFF
	JMP	PRINT
BLASTOFF	LDA	#$0E	;Set vel.
	STA	VELOCITY
	STA	LOADED	;All loaded
	JSR	FLAGS	;Clear land flags
	STA	FLIP
NOSTK	LDX	ANIPTR	;Find frame val
	LDA	ANITAB,X	;There yet?
	CMP	ANIMATE
	BEQ	NEWFRAME	;Yes
	JMP	PRINT
NEWFRAME	LDA	NOIZE,X	;Get sound vals
	STA	AUDC1
	LDA	FREQ,X
	STA	AUDF1
	CLC
	LDA	SHAPEA	;Point to next frame
	ADC	#$18
	STA	SHAPEA	;Player0
	LDA	#$00	;+ carry
	ADC	SHAPEA+1
	STA	SHAPEA+1
	CLC
	LDA	SHAPEB	;Same, player1
	ADC	#$18
	STA	SHAPEB
	LDA	#$00
	ADC	SHAPEB+1
	STA	SHAPEB+1
	INC	ANIPTR	;Counter
	JMP	PRINT
GROUND	LDA	FLIP	;Up, or down motion?
	BNE	FALLING
	JMP	RISING
FALLING	LDA	VELOCITY	;Too fast, we crash
	CMP	#$0B
	BCC	CRASHED
	LDA	LOADED	;Crash if loaded
	BNE	CRASHED
	LDA	HPOSME	;Not on pad, crash
	CMP	#$81
	BCS	CRASHED
	LDA	#$7C
	CMP	HPOSME
	BCS	CRASHED
	LDA	#$06	;Landed! set flags
	STA	DIGIT
	STA	LANDFLAG
	JSR	GETLEV	;Give score
	STA	MULTIPLY
	INC	MULTIPLY
	JSR	MATH
	JMP	PRINT
CRASHED	INC	EXPLOSION	;Flag <> 0
	JMP	PRINT
;
; Movement in space routine
;
SPACE	LDA	#$01	;In space? reset Vars.
	STA	FLIP
	LDA	#$08
	STA	VELOCITY
;
;Test joystick for movement in space
;
SUP	LDA	EMPTY	;No fuel, no stick
	BNE	CCC
	LDA	STICK0	;Up?
	AND	#$01
	BEQ	MUP
SDOWN	LDA	STICK0	;Down?
	AND	#$02
	BEQ	MDOWN
SLEFT	LDA	EMPTY	;Out of fuel?
	BNE	CCC
	LDA	STICK0	;Left?
	AND	#$04
	BEQ	MLEFT
SRIGHT	LDA	STICK0	;Right
	AND	#$08
	BEQ	MRIGHT
CCC	JMP	PRINT	;No stick, skip
MUP	DEC	VPOSME	;Up.
	JMP	SLEFT	;Test for sideways
MDOWN	INC	VPOSME	;Down
	JMP	SLEFT	;Test for sideways
MLEFT	DEC	HPOSME	;Left
	LDA	#$01	;Flame direction flag
	STA	FD
	BNE	PRINT
MRIGHT	INC	HPOSME	;Right.
	LDA	#$02
	STA	FD
	BNE	PRINT
PRINT	LDA	VPOSME	;Test screen bounds
	CMP	#$25
	BCS	TESTL
	LDA	#$25
	STA	VPOSME
TESTL	LDA	HPOSME
	CMP	#$26
	BCS	TESTR
	LDA	#$26
	STA	HPOSME
TESTR	LDA	#$D1
	CMP	HPOSME
	BCS	DISPLAY
	LDA	#$D1
	STA	HPOSME
DISPLAY	JSR	SHOW	;Now we can show ship
;
; Sattelite creation routine
;
SPOCK	LDA	SAT?	;Move sat?
	BNE	SATMOV
	INC	SATCNT	;Delay between sats
	BEQ	T1
	JMP	NODIFF
T1	JSR	R01	;Random #
	BEQ	T2	;No sat this time
	JMP	NODIFF
T2	JSR	R01	;Dir to move
	BEQ	MINMAY
	LDA	#$01	;Right
	STA	SATDIR
	BNE	SDF1
MINMAY	LDA	#$FE	;Left
	STA	SATDIR
SDF1	JSR	R07	;Speed
	BEQ	SDF1	;<> 0
	STA	SATSPD
	LDA	RANDOM	;Color
	ORA	#$08
	STA	SATCOLR
	JSR	R16	;Random sat
	CMP	TOTAL	;Based on complete levels
	BCS	THAT
	BCC	THIS
THAT	LDA	TOTAL	;Use this for sat
THIS	ASL	A	;Otherwise Random
	ASL	A
	ASL	A
	TAX
	LDY	#$00
SATLP	LDA	ASATS,X	;Move shape to PM
	STA	PMSATS,Y
	INX
	INY
	CPY	#$08
	BNE	SATLP
	LDA	#$00	;Set flags and counters
	STA	SATCNT1
	STA	BLEEP
	STA	VOL
	LDA	#$FF
	STA	SAT?
	JSR	R07	;Is sat super
	BNE	WIMPY	;No, skip
	LDA	#$FF
	STA	SUPER
	BNE	SATMOV	;Always
WIMPY	LDA	#$00	;Not super
	STA	SUPER
;
; Sattelite movement
;
SATMOV	INC	SATCNT1	;Count to speed
	LDA	SATCNT1
	CMP	SATSPD
	BNE	NODIFF
	LDA	SATEXP	;Exploding? skip
	BNE	NSO
	LDA	HPOSSAT	;Sound for sat
	SEC
	SBC	#$80	;Louder at mid screen
	BPL	DIV
	EOR	#$FF
	CLC
	ADC	#$01
DIV	STA	VOL	;save
	LDA	#$FF	;Sub, since higher # is louder
	SEC
	SBC	VOL
	LSR	A	;Div to get ony vol bits
	LSR	A
	LSR	A
	LSR	A
	LSR	A
	STA	VOL
	INC	BLEEP	;Beep count
	LDA	BLEEP
	CMP	#$0B	;Beep between $0B & $0C
	BCC	NBL
	CMP	#$0C
	BCC	YBL
	LDA	#$00
	STA	BLEEP	;Clear
	BEQ	NSO	; Always
YBL	LDA	#$A0	;Beep sound
	ORA	VOL
	STA	AUDC2
	LDA	#$10
	STA	AUDF2
	BNE	NSO	;Always
NBL	LDA	VOL	;Rocket sound
	LSR	A
	ORA	#$80
	STA	AUDC2
	LDA	#$10
	STA	AUDF2
NSO	LDA	#$00
	STA	SATCNT1	;Clear
	LDA	HPOSSAT
	CLC
	ADC	SATDIR	;Move
	STA	HPOSSAT
	STA	HPOSP3
	BNE	NODIFF	;All the way across?
	LDA	#$00
	STA	SAT?	;Reset
	STA	AUDC2
NODIFF	LDA	SUPER	;Super?
	BEQ	WIERD	;No skip
	INC	SATCOLR	;Flash color
;
; Fuel and radiation routines
;
WIERD	INC	RADCOUNT	;Counter
	LDA	RADCOUNT
	CMP	#$38	;Max?
	BNE	THESAME
	LDA	#$00
	STA	RADCOUNT	;Clear
	INC	RADS	;More rads
	LDA	RADS
	CMP	#$FF	;Too many?
	BNE	THESAME
	STA	DOOM	;End of planet?
THESAME	LDA	RADS	;Enough rads to zap?
	CMP	#$80
	BCC	TWOMUCH
	LDA	ZAPFLAG	;Zap in progress?
	BNE	TWOMUCH
	JSR	R01	;Randomly zap
	ORA	RAND1
	BNE	TWOMUCH
RPO	LDA	RANDOM	;Get random spot
	CMP	#$26	;Within bounds?
	BCS	R.T
	BCC	RPO
R.T	CMP	#$D1
	BCC	BATMAN
	BCS	RPO
BATMAN	STA	HPOSP2	;Use this pos.
	LDA	#$FF
	STA	ZAPFLAG	;Do zap
TWOMUCH	LDA	LANDFLAG	;Landed? skip
	BNE	GUAGES
	INC	FUELUSE	;Use fuel
	LDA	FUELUSE
	CMP	#$71	;Limit?
	BCC	GUAGES
	LDA	#$00
	STA	FUELUSE	;Clear
	DEC	FUEL	;Move needle
	BNE	GUAGES	;Fuel left? skip
	STA	AUDC1	;No sound
	LDA	#$FF
	STA	EMPTY	;Flag empty
;
; Display guages routine
;
GUAGES	LDA	DOOM	;Test doom
	BEQ	R
	LDA	RADSMTR	;Pin the needle
	CLC
	ADC	#$20
	STA	HPOSM0	;Show needle
	JMP	BANGTEST
R	LDA	RADS	;Divide to get needle val
	LSR	A
	LSR	A
	LSR	A
	CLC
	ADC	RADSMTR	;+ offset
	STA	HPOSM0
TANK	LDA	EMPTY	;Empty?
	BEQ	F
	LDX	FUELMTR	;Zero needle
	DEX
	STX	HPOSM0+1	;Show needle
	LDA	#$00	;Raise sky so ship falls
	STA	SKY
	BEQ	N
F	LDA	FUEL	;Div. to get needle val
	LSR	A
	LSR	A
	LSR	A
	CLC
	ADC	FUELMTR	;Add offset
	STA	HPOSM0+1
;
; Transporter routine
;
N	LDA	LANDFLAG	;Landed? skip
	BNE	XPORTER
BUTTON	LDA	LOADED	;Not loaded? skip
	BEQ	XPORTER
	LDA	EXPLOSION	;Exploding? skip
	BNE	XPORTER
	LDA	STRIG0	;No button? skip
	BNE	XPORTER
	LDA	#$FF
	STA	BEAMFLG	;Flag beam
XPORTER	LDA	BEAMFLG	;Beaming in progress?
	BNE	ALREADY
	JMP	HITME
ALREADY	INC	BEAMDLAY	;Delay
	LDA	BEAMDLAY
	CMP	#$01	;Only 1/60 sec
	BEQ	PSPS
	JMP	NOACTION
PSPS	LDA	#$00
	STA	BEAMDLAY	;Clear
	LDA	M2PL	;Hit a sat?
	AND	#$08
	BEQ	SORRY	;No, skip
	INC	SATEXP	;Flag <>0
	LDA	#$05	;Give points
	STA	DIGIT
	LDA	SUPER
	BEQ	ASDFG
	DEC	DIGIT
ASDFG	JSR	GETLEV	;Based on level
	STA	MULTIPLY
	INC	MULTIPLY
	JSR	MATH
	JMP	NOTSHIP
JMPTAB	JMP	EXTEND	;Jump table
SORRY	LDA	VPOSME
	CMP	#$88	;If this low, it hit a mountain
	BCS	JMPTAB
	LDA	M2PF	;Hit anything?
	BEQ	JMPTAB
	LDA	MISS	;Was a hit on line 2?
	BEQ	NOTSHIP
	LDA	#$05	;If it gets here it hit fleet
	STA	DIGIT	; so give score
	LDA	#$01
	STA	ETC.
	LDA	#$36
	STA	VOL4
	JSR	GETLEV	;Based on level
	STA	MULTIPLY
	INC	MULTIPLY
	JSR	MATH
	LDA	RADS	;And decrease rads
	CLC
	ADC	#$E0
	STA	RADS
	BCS	MISFITS	;Can't be <0
	LDA	#$00
	STA	RADS	;So, make it 0
MISFITS	DEC	CANISTERS	;1 less can.
	LDA	CANISTERS	;All gone?
	CMP	#$10
	BNE	NOTSHIP
	LDA	SHIPS	;Level done, so give ship
	CMP	#$19	;But no more than 9
	BEQ	ENUF
	INC	SHIPS
ENUF	LDA	LEVEL	;Next level
	CMP	#$19	;No more than 9
	BEQ	CMPL
	INC	LEVEL
CMPL	LDA	TOTAL	;Inc total levels
	CMP	#$0F	;Not more than 15
	BEQ	ZYX
	INC	TOTAL
ZYX	LDX	PAINT	;Next planet color
	INX
	CPX	#$1A	;Wrap at 10
	BNE	XYZ
	LDX	#$10
XYZ	STX	PAINT
	JSR	SILENT	;No sound
	STA	WAITING	;Message delay on
	LDA	#$78
	STA	COMPLETED	;Flag done
	STA	WAITCNTR	; & wait
	STA	PAUSED	; & pause
	LDX	#$0C
	JSR	DLPRINT	;Print message
	JMP	TESTCH
NOTSHIP	JSR	BEAMOFF	;No valid hit
	JMP	LUMINATE	;Skip
EXTEND	INC	BEAMPOS	;Extend beam
	LDA	#$2A	;Beam sound
	STA	AUDC4
	LDA	BEAMPOS
	STA	AUDF4
	CMP	#$20	;Beam limit?
	BNE	NOACTION
	JSR	BEAMOFF	;Yes, off
	JMP	LUMINATE
NOACTION	LDX	VPOSME	;Draw beam at top+2
	INX
	INX
	LDA	#$CF
	AND	MISSLES,X	;clear end
	STA	MISSLES,X
	DEX
	LDY	BEAMPOS
	INY
BEAMLOOP	LDA	#$CF	;Beam mask
	CPX	#$23	;Hit top of screen
	BNE	NOT2HIGH
	JSR	BEAMOFF	;Yes, off
	JMP	LUMINATE
NOT2HIGH	AND	MISSLES,X	;Clear
	STA	HOLDA	;Save
NOTZERO	LDA	#$30	;Ok, random beam
	AND	RANDOM
	BEQ	NOTZERO
	ORA	HOLDA
	STA	MISSLES,X	;Draw it
	DEX
	DEY
	BNE	BEAMLOOP	;Do all of it
	LDA	#$CF
	AND	MISSLES,X	;Clear end
;
; Ship collision detection
;
HITME	LDA	P0PL	;My collision detection
	ORA	P1PL	;Sats and zaps detect
	AND	#$0C
	BNE	KAPOW	;Yes, explode
	LDA	VPOSME	;If this low, I hit mountain
	CMP	#$80
	BCS	LUMINATE
	LDA	P1PF	;Rocks and ships detect
	ORA	P0PF
	BEQ	LUMINATE	;No, skip
KAPOW	INC	EXPLOSION	;Flag <>0
LUMINATE	JSR	R16	;Random blue Zap & beam
	ORA	#$AB
	STA	PCOLR0+2
;
; Rocket flames routine
;
JETS	LDA	EXPLOSION	;No jets if exploded
	BEQ	DARTH
	JMP	BANGTEST
DARTH	LDA	LANDFLAG	;No jets if landed
	BNE	NOFL
	LDA	EMPTY	;No fuel, no jets
	BEQ	XVXV
	JMP	BANGTEST
XVXV	LDA	STICK0	;Stick determines dir.
	AND	#$0F
	CMP	#$0F
	BEQ	NOFL	;No sticks? skip
	AND	#$03
	CMP	#$02	;Test for up
	BEQ	UF
	CMP	#$01	;Test for down
	BEQ	DF
	BNE	SIDES	;Neither, try sides
UF	LDA	VPOSME	;Loc. to put flame
	CLC
	ADC	#$09
	TAX
	JSR	BURN	;Show flame
	INX
	JSR	BURN
	JMP	SIDES
DF	LDX	VPOSME	;Loc. to put flame
	INX
	JSR	BURN	;Show flame
	DEX
	JSR	BURN
SIDES	LDA	FD	;Side flame dir. flag
	BEQ	EFX	;No dir? skip
	LDA	VPOSME	;Location to put flame
	CLC
	ADC	#$05
	TAX
	JSR	BURN1	;Show it
EFX	LDA	ALT	;Flip 1/30 sec counter
	EOR	#$FF
	STA	ALT
	BNE	MYLT	;Skip every other VBLANK
	LDA	ROAR	;Test rocket sound
	CMP	#$08	;Not too loud
	BEQ	SO
	INC	ROAR	;Update and sound on
SO	STA	AUDC1
	LDA	#$18
	STA	AUDF1
	BNE	MYLT	;Always
NOFL	LDA	ROAR	;No flames? Quiet sound
	BEQ	MYLT	; until silent
	DEC	ROAR
	LDA	ROAR
	STA	AUDC1
MYLT	INC	FLASHME	;Light counter
	LDA	FLASHME	;Branch at right time
	CMP	#$40
	BNE	TBIRD
	LDA	#$00
	STA	FLASHME	;Reset count
	BEQ	BANGTEST
TBIRD	CMP	#$30	;Turn off time
	BCS	BANGTEST	;Yes, skip
	LDY	VPOSME	;Pos. of lights
	INY
	INY
	LDA	ANIMATE	;Less if landing
	CMP	ANITAB+1
	BCS	TALL
	CMP	ANITAB
	BCC	TALL
	INY
TALL	LDA	#$42	;Light Bit pattern
	STA	PLAYER1,Y	;Turn on
;
; Satellite explosion routines
;
BANGTEST	LDA	SATEXP	;Sat exploding
	BNE	YESSAT
	JMP	NOTASAT	;No, skip
YESSAT	LDA	#$00
	STA	SUPER	;Turn off supersat
	LDA	#$1F
	STA	SATCOLR	;Yellow explosion
	JSR	CSAT	;Clear sat
	INC	SATFRAME	;Explosion count
	LDA	SATFRAME
	CMP	#$38	;Branch if less than
	BCC	P1
	JSR	CSAT	;Explosion done. Clear it
	LDA	#$00	;Set pos to 0
	STA	HPOSP3
	STA	HPOSSAT
	STA	SATEXP	;Clear flags
	STA	SATFRAME
	STA	SAT?
	STA	AUDC2	;Sound off
	BEQ	NOTASAT	;Always
P1	LDA	RANDOM	;Make random explosion
	AND	#$18	;Mask wrong bits
	TAY
	LDX	#$07	;8 bytes of data
EXPLP1	LDA	SATFRAME	;Test counter
	CMP	#$10
	BCC	SMALLER	;If less do small shape
	CMP	#$28
	BCS	SMALLER	;If greater, do small
	LDA	#$01	;If between, make larger
	STA	SIZEP0+3	;Double width
	BNE	BIGGER	;Branch always
SMALLER	LDA	#$40	;Get sound in range
	SBC	SATFRAME	; by subtracting from 64
	STA	AUDF2	;Set audio
	LDA	#$08
	STA	AUDC2
	LDA	#$00
	STA	SIZEP0+3	;Make it narrow
TINY	LDA	EXPL1,Y	;Get byte
	JSR	MYRNA	;Random mirror
	STA	PMSATS,X	;Place it
	INY
	DEX
	BPL	TINY	;Do 8
	BMI	NOTASAT	;Always
BIGGER	LDA	#$50	;Get sound in range
	SEC		; by subtracting from 80
	SBC	SATFRAME
	STA	AUDF2	;Set audio
	LDA	#$0F
	STA	AUDC2
	TXA		;Multiply X*2
	ASL	A
	TAX		; and put it back
LARGER	LDA	EXPL1,Y	;Get byte
	JSR	MYRNA	;Randomly mirror
	STA	PMSATS-8,X	;Put on 2 lines
	STA	PMSATS-7,X	; for double height
	INY
	DEX		;Update twice for double lines
	DEX
	BPL	LARGER	;Do 16 lines
;
; Zap routine
;
NOTASAT	LDA	ZAPFLAG	;Do a zap?
	BNE	ZZZZT
	JMP	NOZAP	;No, skip
ZZZZT	INC	ZAPCNT	;Counter
	LDA	ZAPCNT	;Test max val.
	CMP	#$6C
	BNE	HUNTER	;No, skip
	LDA	#$00	;Zap is done, clear
	STA	AUDC3	; sound
	STA	ZAPCNT	; & flags
	STA	ZAPFLAG
	STA	HPOSP2	; & pos.
	TAX		; & clear PM zap area
PILL	STA	PMZAP-$50,X
	INX
	CPX	#$60
	BNE	PILL
	BEQ	NOZAP	;Always
HUNTER	CMP	#$36	;Test branches
	BCS	STRIKE	;>$36, skip
	LDA	#$2A	;Set for noise
	STA	AUDC3
	LDA	#$50	;Find freq.
	SEC
	SBC	ZAPCNT
	STA	HOLDA
	JSR	R16	;Randomize it
	EOR	HOLDA
	STA	AUDF3	;Sound it
	LDA	RANDOM	;Make random sparks
	AND	#$0C	;Set pointer
	TAY
	LDX	#$04	;4 lines of them
SPKLP	LDA	SPARKS,Y
	JSR	MYRNA	;Randomly mirror
	STA	PMZAP,X
	INY
	DEX
	BNE	SPKLP	;Do all 4
	BEQ	NOZAP	;Always
STRIKE	LDA	ZAPCNT	;Now make bolt
	SEC
	SBC	#$20	;Find sound freq.
	STA	AUDF3
	LDA	#$00	;Clear remaining sparks
	STA	PMZAP+3
	STA	PMZAP+4
	LDA	#$4F
	STA	AUDC3	;Set audio
	TAX		;Save X for later routine
	LDA	RANDOM	;Random starting pt.
	AND	#$1F	;Mask bits
	TAY
STRILP	LDA	BOLTS,Y
	STA	PMZAP-79,X	;Make 4 same lines
	STA	PMZAP-78,X
	STA	PMZAP-77,X
	STA	PMZAP-76,X
	INY
	TYA
	AND	#$1F	;Make y wrap at 32
	TAY
	DEX
	DEX
	DEX
	DEX
	BPL	STRILP	;Do 78 lines
NOZAP	LDA	SATEXP	;Sat exploding?
	BNE	SATOK	;Yes, skip
	LDA	P3PL	;Sat zapped?
	BEQ	SATOK
	INC	SATEXP	;Yes, Flag it
;
; Misc. sound routine
;
SATOK	LDA	ETC.	;Test misc sound flag
	BEQ	TE	;0?, skip
	CMP	#$01	;Branch to right place
	BNE	UE
	DEC	VOL4	;This is Boing sound decay
	LDA	VOL4
	BEQ	UE	;Until 0
	LSR	A
	LSR	A
	ORA	#$40	;Set distortion
	STA	AUDC4	;Use it
	LDA	#$20
	STA	AUDF4	;This freq.
	BNE	TE	;Always
UE	LDA	#$00
	STA	ETC.	;Clear flag
	STA	AUDC4	;Off sound
;
; Ship explosion routine
;
TE	LDA	EXPLOSION	;Test my exp. flag
	BNE	SHABOOM
	JMP	NOATR	;No, Skip
SHABOOM	INC	POWNTER	;Counter
	LDA	#$30	;Get freq. range
	CLC
	ADC	POWNTER	; by adding $30
	STA	AUDF1
	LDA	POWNTER	;Test branches
	CMP	#$18
	BCC	OVERLAP
	CMP	#$30
	BCS	TA
	JMP	ENGULF
TA	CMP	#$50
	BCC	CATCHUP
	CMP	#$78	;No branches?
	BCC	SLNT
	LDA	#$FF
	STA	RESETFLAG	;Done? reset me
SLNT	LDA	#$00	;My sound off
	STA	AUDC1
	JMP	NOATR
OVERLAP	JSR	SHOW	;Show me
	LDA	#$0A	;Set audio
	STA	AUDC1
	LDA	RANDOM	;Find rand. expl. data
	AND	#$18
	TAY
	LDX	VPOSME	;My position
	INX
	LDA	#$07
	STA	COWNTER
HINKLEY	LDA	EXPL1,Y	;Get byte
	JSR	MYRNA	;Random mirror
	JSR	PUT	;"OR" it on me
	INX
	INY
	DEC	COWNTER
	BPL	HINKLEY	;Do 8
	JMP	NOATR
CATCHUP	JSR	CLRME	;Erase
	LDY	#$03
D	DEC	ROAR	;Fade sound
	BEQ	OW	;Unless 0
	DEY
	BPL	D
	LDA	ROAR
	LSR	A
	LSR	A
	LSR	A
	LSR	A
	STA	AUDC1
OW	JMP	NOATR
ENGULF	LDA	#$0F	;Big explosion sound
	STA	AUDC1
	LDA	#$00
	STA	ROAR	;Clear sound fade
	LDA	#$0F	;Bright white expl.
	STA	PCOLR0
	STA	PCOLR0+1
	LDA	HPOSME	;Center Plyrs on my horiz.
	SEC
	SBC	#$04
	STA	HPOSP0
	CLC
	ADC	#$08
	STA	HPOSP1
	LDA	#$00
	STA	COWNTER	;Clear count
LSIDE	LDA	VPOSME	;Draw random left exp.
	SEC
	SBC	#$04
	TAX
	LDA	RANDOM	;Rand byte
	AND	#$30	;Point to data
	TAY
AUTOMAN	LDA	EXPME,Y	;Xfer data
	STA	PLAYER0,X
	INX
	INY
	INC	COWNTER
	LDA	COWNTER
	CMP	#$10
	BNE	AUTOMAN	;Do 16 lines
RSIDE	LDA	RANDOM	;Draw right side
	AND	#$30	;Point to data
	TAY
ORBOTS	STX	HOLDX	;Save count
	LDA	EXPME,Y	;Get Left side data
	STA	HOLDA
	JSR	MIRROR	;Mirror for right
	LDX	HOLDX	;Get count
	LDA	HOLDA
	STA	PLAYER1,X	;Place byte
	DEX
	INY
	DEC	COWNTER
	LDA	COWNTER
	BNE	ORBOTS	;Do 16 lines
;
; Pause routine and cleanup
;
NOATR	LDA	#$00
	STA	ATRACT	;Attract mode off
TESTCH	STA	HITCLR	;Clr collisions
	LDA	WAITING	;Are we waiting?
	BNE	INCH	;No, skip
	DEC	WAITCNTR	;Count down
	BNE	CLRCH	;Not 0 yet? skip
	LDA	#$B4	;Reset count to 3 sec
	STA	WAITCNTR
	STA	WAITING	;Flag not waiting
	LDX	#$00
	JSR	DLPRINT	;Erase messages
	LDA	COMPLETED	;Level done?
	BEQ	NNLEV	;No, skip
	LDA	#$00	;Flag wait
	STA	WAITING
	LDA	#$FF
	STA	NEWLEV	;Flag new level
	BNE	INCH	;Always
NNLEV	LDA	#$00
	STA	PAUSED	;Pause off
INCH	LDA	CH	;Test KB for space bar
	CMP	#$21
	BNE	CLRCH	;No? skip
	JSR	SILENT	;Sound off
	LDA	PAUSED	;Toggle pause
	EOR	#$FF
	STA	PAUSED
	BNE	CLRCH	;Pause on? skip
	LDX	#$77
	JSR	OLDC	; restore colors
CLRCH	LDA	#$FF
	STA	CH	;Reset KB shadow
	LDA	RANDOM
	STA	RAND1	;Set constant random #
ATR	LDA	PAUSED	;If paused...
	ORA	G.O	; or game over...
	BEQ	EXIT
	LDX	#$77	; do attracting
AC	LDA	ACOLTAB,X
	JSR	MIXUP
	STA	DCOLTAB,X
	DEX
	BPL	AC
EXIT	JMP	XITVBV	;End or routine
;
; PROGRAM DATA TABLES
;
;
; Mountain range data
;
	*=	$3A00
	.SBYTE	+$40,"_______________5:<9___________________7;<8______"
	.SBYTE	+$40,"________5;<8_7;>@BB<879____5;<9_____6:>@BD<86;<9"
	.SBYTE	+$40,"<95:<86;?@BAEF=>@DAIJ?C<96:>@DC<8_5:?>?@ACIJ=@BB"
	.SBYTE	+$40,"IJ=@IJ>?=@ADCBGH@IJ>=>BIJ=?@@ACBAEF==?@@IJ>?>@AC"
	.SBYTE	+$40,"KKLKKLLLKLMNONOMLLKLKLNKLLKKLMONOOMKLLKLKLLKKLMO"
	.SBYTE	+$40,"PRQRPQRPRRQRPRPRPRQRPQRPQRPRQPQPRPRPQRPRQRPRPRRP"
	.SBYTE	+$40,"STUST]STSTUTSUS]SUSTUSTS^^SUTU]TTSUTUTTTUS]SSTU]"
	.SBYTE	+$40,"]WX]V]]V]]]WX]]]XV]X]]YZ[\Y]]]X]]]]]]V]]]]W]]]]]"
	.SBYTE	+$40,"]]]]]]]]]]]]]]]]]]]]]]]]^^]]]]]]]]]]]]]]]]]]]]]]"
BOT	.SBYTE	"     C:0 RADS'!#$#%#$#&  FUEL'!#$#%#$#& P:0     "
CANISTERS	=	*-$29	;# canisters left
SHIPS	=	*-$06	;# ships left
;
; Title screen text
;
TITLE	*=	*+$C8
	.SBYTE	+$C0,"  BY DOUGLAS ENGEL  "
	.SBYTE	"      LEVEL: 0      "
LEVEL	=	*-$07
;
; Message text
;
LEVLLINE	.SBYTE	+$C0,"        LEVEL: 0        "
PLEVEL	=	*-$09
MULTLINE	.SBYTE	+$C0,"     MULTIPLIER: 00     "
PMULT	=	*-$07
MESSLINE	.SBYTE	+$C0,"       GAME  OVER       "
COMPLINE	.SBYTE	+$C0,"    LEVEL COMPLETED     "
;
; Game display list
;
DLIST	.BYTE	$B0,$70,$70,$D6,$00,$30,$10,$D4,$00,$31
	.BYTE	$D4,$80,$30,$D4,$80,$30,$D4,$40,$37,$D4
	.BYTE	$C0,$35,$D4,$40,$33,$D4,$C0,$35,$D4,$40
	.BYTE	$33,$D4,$C0,$37,$D4,$00,$35,$D4,$80,$30
	.BYTE	$D4,$80,$30,$D4,$80,$30,$D4,$00,$3A
	.BYTE	$84,$84,$84,$84,$84,$84,$84,$84
	.BYTE	$20,$52,<BOT,>BOT,$41,<DLIST,>DLIST
;
; Alternate DL lines for messages
;
DLTABL
	.BYTE	$D4,$80,$80,$D4,$80,$80
	.BYTE	$D6,<LEVLLINE,>LEVLLINE,$D6,<MULTLINE,>MULTLINE
	.BYTE	$D6,<COMPLINE,>COMPLINE,$D4,$80,$30
	.BYTE	$D6,<MESSLINE,>MESSLINE,$D4,$80,$30
;
; Title screen display list
;
DLIST1	.BYTE	$70,$70,$70,$70,$70,$44,<TITLE,>TITLE,$04,$04,$04,$04,$70,$86
	.BYTE	$70,$70,$70,$70,$70,$06,$70,$70,$70,$70,$70,$70,$70,$70,$70
	.BYTE	$41,<DLIST1,>DLIST1
;
; Scroll tables
;
SCRLST	*=	*+24	;Direction
COUNT	*=	*+24	;Speed counter
LIMIT	*=	*+24	;Maximum count
CURR	*=	*+24	;Current HSCROL value
COLCKS	*=	*+24	;Scrolled color clocks
MPOS	*=	*+24	;Star missile positions
OFFSET	*=	*+24	;Offset between stars
;
; COLOR TABLES
;
;
;Actual colors
;
COLTAB	.BYTE	$CA,$A4,$A4,$02,$02,$02,$02,$02,$02,$02,$02,$02
	.BYTE	$32,$32,$32,$32,$32,$32,$32,$32,$32,$32,$32,$02
	.BYTE	$24,$A2,$A2,$04,$04,$04,$04,$04,$04,$04,$04,$04
	.BYTE	$04,$34,$34,$34,$34,$34,$34,$34,$34,$34,$34,$0A
	.BYTE	$06,$06,$06,$06,$06,$06,$06,$06,$06,$06,$06,$06
	.BYTE	$06,$36,$36,$36,$36,$36,$36,$36,$36,$36,$36,$50
	.BYTE	$40,$8E,$8E,$40,$40,$40,$40,$40,$40,$40,$40,$40
	.BYTE	$48,$48,$40,$40,$40,$40,$40,$40,$40,$40,$8F,$8F
	.BYTE	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	.BYTE	$80,$82,$84,$86,$88,$8A,$8C,$8E,$1E,$1E,$1E,$50
;
ACOLTAB	*=	*+120	;Attracted table
;
DCOLTAB	*=	*+120	;Displayed table
;
; Character set data
;
	*=	$4000	;First 8 chars
CHARS	.BYTE	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$C0,$C0,$C0,$C0,$CC,$FF
	.BYTE	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$C0,$CC,$FF
	.BYTE	$00,$00,$00,$00,$C0,$C0,$CC,$FF,$00,$00,$00,$C0,$C0,$C0,$CC,$FF
	.BYTE	$00,$0C,$DE,$CC,$C0,$C0,$C0,$C0,$00,$00,$1E,$00,$00,$00,$00,$00
	*=	CHARS+$0200	;Last 64 chars
	.BYTE	$00,$03,$0F,$2F,$3B,$3B,$2F,$05,$00,$40,$90,$A4,$E4,$E4,$90,$40
	.BYTE	$00,$0F,$3B,$1F,$3E,$3B,$3D,$0F,$00,$54,$E5,$79,$F9,$F9,$E5,$54
	.BYTE	$00,$0C,$3F,$BE,$EE,$FE,$3E,$0A,$00,$00,$40,$50,$50,$90,$50,$40
	.BYTE	$00,$14,$E9,$F9,$F9,$E9,$14,$00,$00,$10,$E4,$E4,$E4,$10,$00,$00
	.BYTE	$00,$00,$20,$E4,$E4,$E4,$20,$00,$00,$28,$F9,$79,$F9,$F9,$B9,$25
	.BYTE	$00,$F4,$F9,$F9,$A4,$10,$00,$00,$00,$00,$00,$00,$0D,$09,$05,$00
	.BYTE	$00,$00,$00,$35,$39,$2D,$29,$05,$00,$00,$38,$39,$29,$24,$10,$00
	.BYTE	$00,$38,$38,$24,$00,$00,$00,$00,$00,$00,$08,$39,$39,$29,$25,$05
	.BYTE	$00,$05,$05,$00,$00,$05,$05,$00,$C0,$54,$5A,$AA,$AA,$54,$54,$C0
	.BYTE	$0C,$2A,$AA,$95,$95,$AA,$2A,$0C,$03,$0A,$A9,$A9,$AA,$AA,$0A,$03
	.BYTE	$00,$80,$60,$58,$A8,$A8,$80,$00,$00,$00,$00,$00,$00,$03,$0E,$3E
	.BYTE	$00,$00,$00,$00,$00,$03,$0F,$3B,$00,$00,$00,$00,$00,$03,$0F,$3D
	.BYTE	$00,$00,$00,$00,$40,$50,$94,$59,$00,$00,$00,$00,$40,$50,$94,$55
	.BYTE	$00,$03,$0E,$3F,$FE,$FE,$BB,$EE,$00,$03,$0F,$3D,$FF,$F7,$BF,$FE
	.BYTE	$40,$50,$94,$55,$55,$59,$95,$56,$BE,$EB,$BE,$EA,$BE,$BB,$EE,$BB
	.BYTE	$FE,$FF,$FE,$EE,$BB,$EA,$EE,$AA,$FE,$FB,$DE,$EE,$BB,$FA,$EE,$BA
	.BYTE	$BA,$FA,$BE,$FA,$EB,$EE,$FB,$AE,$99,$A5,$A5,$A6,$A6,$6A,$99,$9A
	.BYTE	$A6,$99,$A9,$96,$69,$A5,$99,$55,$59,$96,$65,$59,$96,$69,$56,$65
	.BYTE	$59,$96,$59,$65,$55,$59,$99,$66,$40,$53,$9B,$55,$55,$59,$55,$56
	.BYTE	$FB,$BA,$FF,$EA,$7E,$5A,$56,$65,$7E,$5F,$97,$59,$55,$59,$95,$65
	.BYTE	$FA,$EE,$FF,$FE,$7B,$5E,$96,$65,$99,$A9,$95,$65,$95,$97,$5F,$BD
	.BYTE	$59,$97,$5F,$7E,$EF,$FF,$BE,$FF,$FF,$BE,$EF,$FF,$BB,$FF,$BE,$FF
	.BYTE	$FE,$BF,$FB,$BF,$EE,$FF,$FB,$BF,$AA,$BA,$FF,$EE,$FF,$FB,$BF,$FF
	.BYTE	$AA,$AA,$EE,$FF,$FB,$BF,$EF,$FE,$AA,$AA,$FB,$FF,$BF,$FE,$EF,$BB
	.BYTE	$FF,$BB,$FF,$FF,$EE,$FF,$FF,$EF,$FF,$BF,$FF,$FB,$BF,$FF,$FE,$EF
	.BYTE	$BF,$FE,$FF,$FF,$FB,$FF,$EF,$FE,$FF,$FF,$EB,$FF,$FF,$FF,$FA,$FF
	.BYTE	$AF,$FF,$FF,$FF,$FA,$FF,$FF,$FF,$FF,$FF,$FF,$EB,$FF,$FF,$FF,$AF
	.BYTE	$FF,$FF,$EF,$BB,$EF,$FF,$FF,$FF,$FF,$AF,$FF,$FF,$FF,$FB,$EE,$FB
	.BYTE	$FF,$FF,$FB,$FF,$FF,$FF,$EF,$FF,$FF,$FF,$F3,$FF,$FF,$FF,$F3,$FF
	.BYTE	$FF,$FF,$FD,$D5,$D6,$D5,$F5,$FF,$FF,$D5,$59,$59,$AA,$59,$59,$55
	.BYTE	$FF,$FF,$5F,$55,$A5,$55,$57,$7F,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	.BYTE	$FF,$FB,$FF,$FF,$3F,$FF,$FF,$FF,$00,$00,$00,$00,$00,$00,$00,$00
;
; PLAYER MISSILE BIT MAPS
;
;
;Data for my ship
;
SHAPE1A
	.BYTE	$00,$24,$7E,$7E,$24,$24,$00,$00,$18,$00,$00,$00
SHAPE1B
	.BYTE	$00,$00,$00,$00,$00,$00,$3C,$7E,$42,$42,$E7,$00
	.BYTE	$00,$00,$24,$7E,$7E,$24,$24,$00,$00,$18,$00,$00
	.BYTE	$00,$00,$00,$00,$00,$00,$00,$3C,$7E,$42,$E7,$00
	.BYTE	$00,$24,$7E,$7E,$24,$24,$00,$00,$18,$00,$00,$00
	.BYTE	$00,$00,$00,$00,$00,$00,$3C,$7E,$42,$42,$E7,$00
	.BYTE	$00,$24,$7E,$7E,$24,$24,$00,$00,$00,$00,$00,$00
	.BYTE	$00,$00,$00,$00,$00,$00,$24,$66,$42,$42,$E7,$00
	.BYTE	$00,$24,$7E,$7E,$24,$24,$00,$00,$00,$00,$00,$00
	.BYTE	$00,$00,$00,$00,$00,$00,$24,$42,$42,$42,$E7,$00
	.BYTE	$00,$24,$7E,$7E,$24,$24,$00,$00,$00,$00,$18,$00
	.BYTE	$00,$00,$00,$00,$00,$00,$24,$42,$42,$42,$FF,$00
	.BYTE	$00,$24,$7E,$7E,$24,$24,$00,$00,$00,$18,$18,$00
	.BYTE	$00,$00,$00,$00,$00,$00,$24,$42,$42,$5A,$FF,$00
	.BYTE	$00,$24,$7E,$7E,$24,$24,$00,$00,$18,$18,$08,$00
	.BYTE	$00,$00,$00,$00,$00,$00,$24,$42,$5A,$5A,$E7,$00
	.BYTE	$00,$24,$7E,$7E,$24,$24,$00,$18,$18,$08,$10,$00
	.BYTE	$00,$00,$00,$00,$00,$00,$24,$5A,$5A,$42,$E7,$00
	.BYTE	$00,$24,$7E,$7E,$24,$24,$18,$18,$08,$10,$08,$00
	.BYTE	$00,$00,$00,$00,$00,$00,$3C,$5A,$42,$42,$E7,$00
	.BYTE	$00,$24,$7E,$7E,$24,$3C,$18,$08,$10,$08,$10,$00
	.BYTE	$00,$00,$00,$00,$00,$18,$3C,$42,$42,$42,$E7,$00
	.BYTE	$00,$24,$7E,$7E,$3C,$3C,$08,$10,$08,$10,$08,$00
	.BYTE	$00,$00,$00,$00,$18,$18,$24,$42,$42,$42,$E7,$00
	.BYTE	$00,$24,$7E,$7E,$3C,$3C,$00,$08,$10,$08,$10,$00
	.BYTE	$00,$00,$00,$00,$18,$18,$24,$42,$42,$42,$E7,$00
	.BYTE	$00,$24,$7E,$7E,$3C,$3C,$00,$00,$08,$10,$08,$00
	.BYTE	$00,$00,$00,$00,$18,$18,$24,$42,$42,$42,$E7,$00
	.BYTE	$00,$24,$7E,$7E,$3C,$3C,$00,$00,$00,$08,$10,$00
	.BYTE	$00,$00,$00,$00,$18,$18,$24,$42,$42,$42,$E7,$00
	.BYTE	$00,$24,$7E,$7E,$3C,$3C,$00,$00,$00,$00,$08,$00
	.BYTE	$00,$00,$00,$00,$18,$18,$24,$42,$42,$42,$E7,$00
	.BYTE	$00,$24,$7E,$7E,$3C,$3C,$00,$00,$00,$00,$00,$00
	.BYTE	$00,$00,$00,$00,$18,$18,$24,$42,$42,$42,$E7,$00
	.BYTE	$00,$24,$7E,$7E,$3C,$3C,$00,$00,$00,$00,$00,$00
	.BYTE	$00,$00,$00,$00,$18,$18,$24,$66,$42,$42,$E7,$00
	.BYTE	$00,$24,$7E,$7E,$3C,$3C,$00,$00,$18,$00,$00,$00
	.BYTE	$00,$00,$00,$00,$18,$18,$3C,$7E,$42,$42,$E7,$00
;
;Sattelite data
;
ASATS	.BYTE	$00,$44,$28,$10,$38,$38,$38,$10,$0E,$CE,$64,$3F,$3F,$64,$CE,$0E
	.BYTE	$36,$49,$1C,$3E,$3E,$1C,$2A,$49,$22,$1C,$1C,$7F,$7F,$08,$08,$14
	.BYTE	$08,$1C,$1C,$1C,$08,$3E,$08,$14,$00,$FF,$18,$FF,$18,$18,$24,$00
	.BYTE	$07,$07,$A4,$7F,$A4,$07,$07,$00,$28,$10,$10,$38,$38,$10,$10,$28
	.BYTE	$00,$00,$3C,$99,$7E,$99,$3C,$00,$10,$54,$38,$7C,$38,$54,$10,$28
	.BYTE	$00,$00,$1A,$BC,$7F,$BC,$1A,$00,$10,$38,$12,$3C,$3C,$12,$38,$10
	.BYTE	$10,$10,$7C,$38,$10,$54,$38,$54,$81,$5A,$3C,$66,$66,$3C,$5A,$81
	.BYTE	$00,$1C,$3E,$55,$3E,$1C,$00,$00,$00,$00,$00,$DB,$7E,$18,$00,$00
;
;Sattelite explosion data
;
EXPL1	.BYTE	$00,$24,$08,$18,$48,$02,$10,$00,$00,$42,$28,$34,$10,$44,$00,$10
	.BYTE	$04,$40,$28,$14,$39,$3C,$50,$02,$80,$25,$1E,$2C,$9A,$21,$48,$02
;
;Spark data
;
SPARKS	.BYTE	$40,$31,$84,$00,$83,$5A,$00,$04,$44,$84,$41,$12,$82,$2C,$11,$40
;
;Bolt data
;
BOLTS	.BYTE	$04,$08,$10,$10,$10,$20,$40,$80,$40,$40,$20,$10,$08,$08,$04,$02
	.BYTE	$02,$04,$08,$10,$10,$08,$04,$04,$02,$01,$01,$02,$04,$08,$08,$04
;
;My explosion data
;
EXPME	.BYTE	$01,$00,$28,$02,$04,$1F,$26,$0F,$15,$0F,$4B,$05,$13,$00,$42,$00
	.BYTE	$20,$00,$44,$01,$12,$05,$8B,$1B,$4E,$0B,$06,$23,$00,$00,$01,$00
	.BYTE	$80,$00,$11,$00,$0A,$05,$1B,$07,$2B,$0D,$27,$0B,$06,$40,$00,$02
	.BYTE	$00,$0A,$10,$00,$55,$00,$05,$02,$8B,$05,$03,$23,$01,$80,$08,$00
;
; MISCELLANEOUS DATA TABLES
;
;
;Title screen bitmap
;
BITS	.BYTE	$07,$8E,$39,$27,$A0,$04,$51,$45,$48,$20,$07,$91,$41,$87,$20
	.BYTE	$04,$51,$45,$40,$80,$04,$4E,$39,$2F,$20
;
;DL modification pointers
;
POINTR	.BYTE	$04,$08,$0B,$0E,$11,$14,$17,$1A,$1D,$20,$23,$26
	.BYTE	$29,$2C,$2F,$32,$35,$38,$3B,$3E,$41,$44,$47,$4B
;
;Priority table
;
PRITAB	.BYTE	$22,$22,$22,$22,$22,$22,$22,$22,$22,$22,$22,$22
	.BYTE	$22,$21,$21,$21,$21,$21,$21,$21,$21,$21,$31,$31
;
;Animation frame pointers
;
ANITAB	.BYTE	$0A,$14,$38,$40,$50,$58,$60,$68,$70
	.BYTE	$78,$80,$88,$90,$98,$A0,$A8,$C8,$D0
;
;Frequency table
;
FREQ	.BYTE	$20,$20,$00,$38,$30,$5F,$5D,$5B,$59
	.BYTE	$58,$58,$59,$5B,$5D,$5F,$30,$38,$00
;
;Distortion table
;
NOIZE	.BYTE	$88,$80,$00,$48,$48,$28,$28,$28,$28
	.BYTE	$28,$28,$28,$28,$28,$28,$48,$48,$00
;
; Other locations
;
SCORE	.SBYTE	"00000000"	;Score in memory
SLEVEL	.SBYTE	"0"	;Starting level
TOTAL	.BYTE	$00	;Total # levels done
PAINT	.BYTE	$00	;Planet color mask
;
;
	*=	RUNAD
	.WORD	START
	.END
