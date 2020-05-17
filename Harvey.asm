;	======================================
;	 HARVEY WALLBANGER by Charles Bachand
;	======================================

;	======================================
;	  Copyright (C) 1982 ANALOG Magazine
;	======================================

;	------------------------
;	Operating System Equates
;	------------------------

HPOSP0	=	$D000	;player 0 horizontal position
M0PF	=	$D000	;missile 0/playfield collision
HPOSP2	=	$D002	;player 2 horizontal position
HPOSP3	=	$D003	;player 3 horizontal position
HPOSM0	=	$D004	;missile 0 horizontal position
P0PF	=	$D004	;player 0/playfield collisions
P0PL	=	$D00C	;player 0 to player collisions
GRP2	=	$D00F	;player 2 graphics register
COLBK	=	$D01A	;background color
GRACTL	=	$D01D	;graphics control register
HITCLR	=	$D01E	;collision 'HIT' clear
CONSOL	=	$D01F	;console switch port
AUDF1	=	$D200	;audio frequency 1
AUDC1	=	$D201	;audio volume 1
AUDF2	=	$D202	;audio frequency 2
AUDC2	=	$D203	;audio volume 2
AUDF3	=	$D204	;audio frequency 3
AUDC3	=	$D205	;audio volume 3
AUDF4	=	$D206	;audio frequency 4
AUDC4	=	$D207	;audio volume 4
RANDOM	=	$D20A	;random number generator
IRQEN	=	$D20E	;IRQ interrupt enable
PMBASE	=	$D407	;P/M base address
WSYNC	=	$D40A	;wait for horizontal sync
VCOUNT	=	$D40B	;scan line counter
SETVBV	=	$E45C	;set vertical blank vector
XITVBV	=	$E462	;vertical blank exit vector
SIOINT	=	$E465	;serial I/O initialization
ATRACT	=	$004D	;atract mode counter

;	-----------------------
;	System Shadow Registers
;	-----------------------

RTCLOK	=	$0012	;system clock
CDTMV1	=	$0218	;system timer 1
CDTMV2	=	$021A	;system timer 2
CDTMA1	=	$0226	;system timer 1 vector
CDTMA2	=	$0228	;system timer 2 vector
SDMCTL	=	$022F	;DMA control
SDLSTL	=	$0230	;display list pointer
GPRIOR	=	$026F	;graphics priority
STICK0	=	$0278	;joystick 1
STRIG0	=	$0284	;trigger 1
PCOLR0	=	$02C0	;player 0 color
PCOLR1	=	$02C1	;player 1 color
PCOLR2	=	$02C2	;player 2 color
PCOLR3	=	$02C3	;player 3 color
COLOR2	=	$02C6	;playfield 2 color
COLOR3	=	$02C7	;playfield 3 color
COLOR4	=	$02C8	;background color

;	-------------------
;	Page Zero Variables
;	-------------------

	ORG	$0080	;area not used by system

PIC	DS	2	;rabbit image pointer

;	--------------------------
;	Player / Missile RAM Space
;	--------------------------

	ORG	$3000	;out of everyones way

PM	DS	$180	;first area not used
MISL	DS	$80	;Missile graphics area
PLR0	DS	$80	;player 0 graphics area
PLR1	DS	$80	;player 1 graphics area
PLR2	DS	$80	;player 2 graphics area
PLR3	DS	$80	;player 3 graphics area

;	-------------------
;	Program entry point
;	-------------------

	JMP	HARVEY

;	-----------------
;	Game display list
;	-----------------

DL	DB	$70,$70	;32 blank scan lines
	DB	$70,$70
	DB	$47	;mode 2 line w/LMS bit
	DW	DISP	;address of game display
	DB	$07,$07	;9 more mode 2 lines
	DB	$07,$07
	DB	$07,$07
	DB	$07,$07
	DB	$07
	DB	$70,$70	;skip 16 lines
	DB	$46	;mode 1 line w/LMS bit
	DW	SLINE	;address of score line
	DB	$41	;jump on vertical blank
	DW	DL	;to start of display list

;	---------------
;	Score line data
;	---------------

SLINE	DB	'R'+$A0
	DB	'A'+$A0
	DB	'B'+$A0
	DB	'B'+$A0
	DB	'I'+$A0
	DB	'T'+$A0
	DB	'S'+$A0
	DB	':'+$A0
RNUM	DB	'3'+$A0	;number of rabbits
	DB	' '+$A0
	DB	'S'+$A0
	DB	'C'+$A0
	DB	'O'+$A0
	DB	'R'+$A0
	DB	'E'+$A0
	DB	':'+$A0
SNUM	DB	'0'+$A0	;score display
	DB	'0'+$A0
	DB	'0'+$A0
	DB	'0'+$A0

;	-----------------
;	Game over message
;	-----------------

GOMSG	DB	'game'
	DB	0,0,'ov'
	DB	'er',$80

PSMSG	DB	'pres'
	DB	's',0,0,'s'
	DB	'tart',$80

;	-------------------
;	Initialization Code
;	-------------------

HARVEY	CLD		;clear decimal flag
	JSR	SIOINT	;stop cassette
	LDA	#'3'+$A0;display for '3'
	STA	RNUM	;3 lives (display)
	LDA	#3	;get 3 lives
	STA	LIVES	;initialize counter
	LDA	#'0'+$A0;display for '0'
	STA	SNUM	;store in the four
	STA	SNUM+1	;bytes used for the
	STA	SNUM+2	;score display
	STA	SNUM+3	;area.
MORE	LDA	#60	;get 1 second count
	STA	TIM2ST	;set reset value
	STA	CDTMV2	;set system timer #2
	JSR	CLSCRN	;clear game playfield
	LDY	#2	;display 3 numbers (0-2)
INUMS	JSR	PUTNUM	;put the number on screen
	DEY		;decrement number counter
	BPL	INUMS	;done yet? No.
	LDA	#DL&$FF	;Yes. low byte DL address
	STA	SDLSTL	;DL pointer (low)
	LDA	#DL/256	;high byte DL address
	STA	SDLSTL+1;DL pointer (high)
	LDA	#$04	;set PF over PLAYER
	STA	GPRIOR	;graphics priority
	LDA	#40	;high wall
	STA	BYLOC	;starting location
	LDA	#196	;low wall
	STA	BYLOC+1	;starting location
	LDA	#60	;left wall
	STA	BXLOC	;starting location
	STA	HPOSP2	;hardware register
	LDA	#184	;right wall
	STA	BXLOC+1	;starting location
	STA	HPOSP3	;hardware register
	LDA	#122	;center screen-4 color clocks
	STA	HARX	;Harvey's initial X position
	LDA	#55	;center P/M-8 bytes
	STA	HARY	;Harvey's initial Y position
	LDA	#$2E	;set P/M DMA on bits
	STA	SDMCTL	;store in DMA control
	LDA	#3	;set P/M enable bits on
	STA	GRACTL	;store in graphics control
	LDA	#PM/256	;get high byte of P/M addr
	STA	PMBASE	;point hardware to it
	LDA	#$96	;light blue color
	STA	COLOR2	;default color too dark
	LDA	#$48	;pink color
	STA	COLOR3	;same here
	LDA	#$18	;gold color
	STA	PCOLR0	;set rabbit color
	LDA	#$98	;blue color
	STA	PCOLR1	;set missile 1 color
	LDA	#$34	;red-orange color
	STA	PCOLR2	;left wall color
	LDA	#$C4	;green color
	STA	PCOLR3	;right wall color
	LDA	#1	;initialize trigger flag-
	STA	STRIGF	;to no shot fired
	LDX	#VB/256	;address of VB (MSB)
	LDY	#VB&$FF	;address of VB (LSB)
	LDA	#7	;deferred vertical blank opt
	JSR	SETVBV	;set deferred Vblank vector
	LDA	#T1&$FF	;addr of timer 1 routine LSB
	STA	CDTMA1	;set timer 1 vector LSB
	LDA	#T1/256	;addr of timer 1 routine MSB
	STA	CDTMA1+1;set timer 1 vector MSB
	LDA	#T2&$FF	;addr of timer 2 routine LSB
	STA	CDTMA2	;set timer 2 vector LSB
	LDA	#T2/256	;addr of timer 2 routine MSB
	STA	CDTMA2+1;set timer 2 vector MSB
	LDA	#1	;get 4.25 second count
	STA	CDTMV1+1;set system timer #1
	LDA	#0	;get a zero
	STA	HITCLR	;reset collision registers
	STA	DIESW	;rabbit is alive
	STA	TICTOC	;reset tictoc counter
	STA	VOL1	;start with no tictoc sound
	STA	VOL2	;start with no shuffle noise
	STA	IRQEN	;disable all IRQ interrupts
	LDX	#3	;set index value to 3
WINCZ	STA	WINC,X	;zero wall mover counter
	STA	SHOTX,X	;zero X missile location
	STA	SHOTY,X	;zero Y missile location
	STA	SINCX,X	;zero X missile increment
	STA	SINCY,X	;zero Y missile increment
	DEX		;next wall mover counter
	BPL	WINCZ	;more walls/missiles? Yes.
	TAX		;set index to zero
IM01	STA	MISL,X	;clear Missile area
	STA	PLR0,X	;clear Player 0, 1 area
	INX		;do next byte
	BNE	IM01	;done yet? No.
	LDA	#$FF	;turn on pixels
IM23	STA	PLR2,X	;set Player 2, 3 area
	INX		;do next byte
	BNE	IM23	;done yet? No.

;	------------------------------------------
;	Main program used to generate the display.
;	Actual game done entirely during display's
;	vertical blank processing routine.
;	------------------------------------------

HBARS	INX		;increment wall pointer
	TXA		;transfer pointer to Acc
	AND	#1	;mask off lowest bit
	TAX		;put back in X register
	LDA	BYLOC,X	;get wall vertical position
	LSR	A	;divide by 2, odd=carry set
	PHP		;save carry flag
VCHECK	CMP	VCOUNT	;compare with line counter
	BNE	VCHECK	;not yet!
	STA	WSYNC	;start at new line
	PLP		;get carry flag back
	BCC	ONELIN	;branch on even line number
	STA	WSYNC	;wait for next line
ONELIN	LDA	RANDOM	;random background color
	AND	#$F6	;max lum of 6
	STA	COLBK	;for horizontal walls
	LDY	#10	;let's have 10 lines of this
LINES	LDA	#0	;get a zero for overlap
	STA	GRP2,X	;background overlaps player
	STA	WSYNC	;wait for next line
	LDA	RANDOM	;random background color
	AND	#$F6	;max lum of 6
	STA	COLBK	;for horizontal walls
	DEY		;decrement line counter
	BNE	LINES	;10 lines done yet? No!
	LDA	COLOR4	;get original background
	STA	COLBK	;store in background
	LDA	LIVES	;more lives
	BEQ	HB1	;No. skip code
	LDA	DIESW	;a new life?
	BPL	HB1	;No.
	JMP	MORE	;Yes. more lives
HB1	LDA	CONSOL	;check for start switch
	AND	#$01	;mask off bit
	BNE	HBARS	;start? No.
	JMP	HARVEY	;restart game

;	-----------------------------------------
;	System timer #1 interrupt handler.
;	Used to speed up walls every 4.25 seconds.
;	-----------------------------------------

T1	LDA	TIM2ST	;get wall speed
	CMP	#2	;must stop at two
	BEQ	TIM1	;is it two? Yes.
	DEC	TIM2ST	;No, then decrement
TIM1	LDA	#1	;get 4.25 second cycle time
	STA	CDTMV1+1;reset timer #1
	RTS		;return

;	-------------------------------------------
;	System timer #2 interrupt handler.
;	Used to move walls and initiate wall noise.
;	-------------------------------------------

T2	LDA	TIM2ST	;get timer #2 value
	STA	CDTMV2	;reset timer #2
	INC	BYLOC	;move top wall down
	DEC	BYLOC+1	;move bottom wall up
	INC	BXLOC	;change left wall location
	LDA	BXLOC	;get new location
	STA	HPOSP2	;change player 2 position
	DEC	BXLOC+1	;change right wall location
	LDA	BXLOC+1	;get new location
	STA	HPOSP3	;change player 3 position
	INC	TICTOC	;increment TIC-TOC counter
	LDA	TICTOC	;get counter value
	AND	#1	;just need 0 or 1 value
	TAX		;use for index
	LDA	METRO,X	;get sound frequency
	STA	AUDF1	;change frequency
	LDA	#$08	;get volume value
	STA	VOL1	;save in volume counter
	RTS		;return

;	-------------------------------------------
;	Deferred vertical blank processing routine.
;	Here is where all the actual game playing
;	takes place. This could be quite long.
;	-------------------------------------------

VB	LDA	DIESW	;rabbit dying?
	BNE	VB0	;He sure is.
	LDA	LIVES	;any lives left?
	BNE	VB0	;There sure are.
	JSR	CLSCRN	;clear screen of numbers
	LDX	#0	;initialize X with zero
	STX	AUDC1	;stop tictoc sound
	STX	AUDC2	;stop dying sound
	STX	AUDC3	;stop gun noise
	STX	AUDC4	;stop number sound
	STX	CDTMV1	;shut off the two timers
	STX	CDTMV1+1;ditto.
	STX	CDTMV2	;same here.
GOPRT	LDA	GOMSG,X	;get a character
	BMI	PSINIT	;end of scring? Yes.
	STA	DISP+85,X;put on screen
	INX		;increment index
	JMP	GOPRT	;continue

PSINIT	LDX	#0	;zero the index
PSPRT	LDA	PSMSG,X	;get another character
	BMI	VBXIT	;end of string? Yes.
	STA	DISP+144,X;put on screen
	INX		;increment index
	JMP	PSPRT	;continue
VBXIT	JMP	VBX	;exit vertical blank
VB0	LDA	P0PL	;player/player collisions
	STA	P0PLT	;store in temp variable
	LDA	P0PF	;player to PF collisions
	STA	P0PFT	;store in temp variable
	LDA	NSOUND	;treasure sound counter
	BMI	NOSND	;end of sound? Yes.
	DEC	NSOUND	;decrement volume
	LSR	A	;divide volume by 2
	ORA	#$A0	;add pure tone
	STA	AUDC4	;change volume
NOSND	LDA	VOL1	;get tictoc volume value
	BMI	SND2	;if <0 we produce no sound
	DEC	VOL1	;decrement volume value
	ORA	#$C0	;mask on the distortion
	STA	AUDC1	;generate the tictoc sound
SND2	LDA	VOL2	;get shuffle volume
	BMI	SND3	;if <0 we produce no sound
	DEC	VOL2	;decrement volume value
	ORA	#$80	;mask on the distortion
	STA	AUDC2	;generate the shuffle noise
SND3	LDA	FREQ3	;get shot frequency
	INC	FREQ3	;increment shot frequency
	INC	FREQ3	;do it again
	INC	FREQ3	;and one last time
	STA	AUDF3	;change frequency (lower)
	LDA	DIESW	;is rabbit dying
	BEQ	TMOV1	;No. continue
	INC	DIESW	;Yes. 2 second die period
	INC	PCOLR0	;change rabbit colors
	INC	PCOLR0	;again
	LDA	PCOLR0	;get number
	ASL	A	;*2
	ASL	A	;*4
	ASL	A	;*8
	STA	AUDF2	;use as frequency
	LDA	#$88	;get distortion
	STA	AUDC2	;make sound
	JMP	VBX	;exit vertical blank

TMOV1	LDA	WINC	;check push wall up
	BEQ	TMOV2	;push up? No.
	DEC	WINC	;decrement push up counter
	LDA	BYLOC	;get top wall location
	CMP	#28	;compare with top of screen
	BEQ	TMOV2	;at top? Yes.
	DEC	BYLOC	;move wall up
TMOV2	LDA	WINC+1	;check push wall down
	BEQ	TMOV3	;push down? No.
	DEC	WINC+1	;decrement push down counter
	LDA	BYLOC+1	;get bottom wall location
	CMP	#204	;compare bottom of screen
	BEQ	TMOV3	;at bottom? Yes.
	INC	BYLOC+1	;move wall down
TMOV3	LDA	WINC+2	;check push wall left
	BEQ	TMOV4	;push left? No.
	DEC	WINC+2	;decrement push left counter
	LDA	BXLOC	;get left wall position
	STA	HPOSP2	;move left wall player
	CMP	#39	;check for left wall limit
	BEQ	TMOV4	;at limit? Yes.
	DEC	BXLOC	;move wall left
TMOV4	LDA	WINC+3	;check push wall right
	BEQ	TMOVX	;push right? No.
	DEC	WINC+3	;decrement push right counter
	LDA	BXLOC+1	;get right wall position
	STA	HPOSP3	;move right wall player
	CMP	#208	;check for right wall limit
	BEQ	TMOVX	;at limit? Yes.
	INC	BXLOC+1	;move wall right
TMOVX	LDA	#0	;get a zero
	STA	ATRACT	;poke out atract mode
	STA	XTEMP	;zero rabbit X increment
	STA	YTEMP	;zero rabbit Y increment
	LDA	STICK0	;get joystick value
	CMP	#$0F	;at center position?
	BEQ	CENTER	;Yes. skip code
	LDA	RTCLOK+2;get real time clock LSB
	AND	#$07	;at 1/7.5 second mark?
	BNE	CENTER	;No. skip code
	LDA	#$10	;get shuffle frequency
	STA	AUDF2	;set frequency register
	LDA	#$04	;get volume value
	STA	VOL2	;set shuffle volume
CENTER	LDA	STICK0	;get joystick value
	SEC		;set carry for subtract
	SBC	#5	;values 5-15 only
	ASL	A	;5-15 now 0,2,4,...
	TAX		;use for index
	LDA	RTCLOK+2;get real time clock LSB
	ROR	A	;divide by 2
	ROR	A	;divide by 4
	ROR	A	;divide by 8
	ROR	A	;carry set/reset at .13 sec
	LDA	PK1,X	;get rabbit picture LSB
	BCC	PICMVL	;other pic at .13 sec? No.
	LDA	PK2,X	;get alternate picture LSB
PICMVL	STA	PIC	;store LSB of pic address
	LDA	PK1+1,X	;get rabbit picture MSB
	BCC	PICMVH	;other pic at .13 sec? No.
	LDA	PK2+1,X	;get alternate picture MSB
PICMVH	STA	PIC+1	;store MSB of pic address
	LDX	#3	;count 3 downto 0
CHKSTK	LSR	STICK0	;shift bit into carry
	BCS	CHKNXT	;correct direction? No.
	LDA	STBLX,X	;check X movement direction
	BEQ	CHK0	;movement allowed? No.
	STA	XTEMP	;store X movement value
CHK0	LDA	STBLY,X	;check Y movement direction
	BEQ	CHKNXT	;movement allowed? No.
	STA	YTEMP	;store Y movement value
CHKNXT	DEX		;do next stick position
	BPL	CHKSTK	;done yet? No.
	LDA	P0PLT	;get player 0 collision
	CMP	#$0C	;left/right squeze?
	BNE	NOSQUE	;No. Check indvdual walls
	DEC	RNUM	;decrement lives display
	DEC	LIVES	;decrement lines counter
	INC	DIESW	;the rabbit has died switch
NOSQUE	AND	#$04	;check left wall collision
	BEQ	BMPRT	;hit left wall? No.
	INC	HARX	;Yes. Move rabbit to right
	LDA	#0	;get zero value
	STA	XTEMP	;stop rabbit X movement
BMPRT	LDA	P0PLT	;get player 0 collision
	AND	#$08	;check right wall collision
	BEQ	BMPUP	;hit right wall? No.
	DEC	HARX	;Yes. Move rabbit to left
	LDA	#0	;get zero value
	STA	XTEMP	;stop rabbit X movement
BMPUP	CLC		;clear carry for add
	LDA	BYLOC	;top wall Y location
	ADC	#4	;offset by 4
	LSR	A	;divide by 2
	CMP	HARY	;compare rabbit Y location
	BCC	BMPDN	;hit top wall? No.
	DEC	RNUM	;decrement lives display
	DEC	LIVES	;decrement lines counter
	INC	DIESW	;the rabbit has died switch
BMPDN	LDA	HARY	;get rabbit Y location
	ADC	#10	;offset by 10
	ASL	A	;multiply by 2
	CMP	BYLOC+1	;compare bottom wall Y
	BCC	NOBMP	;hit bottom wall? No.
	DEC	RNUM	;decrement lives display
	DEC	LIVES	;decrement lines counter
	INC	DIESW	;the rabbit has died switch
NOBMP	CLC		;clear carry for add
	LDA	HARX	;get rabbit X position
	ADC	XTEMP	;add X increment
	STA	HARX	;save new rabbit X position
	STA	HPOSP0	;position rabbit player 0
	CLC		;clear carry for add
	LDA	HARY	;get rabbit Y position
	ADC	YTEMP	;add Y increment
	STA	HARY	;save new rabbit Y position
	TAX		;use position as index
	LDY	#0	;initialize picture counter
MOVHAR	LDA	(PIC),Y	;get rabbit picture byte
	STA	PLR0,X	;store in player 0 area
	INX		;increment player pointer
	INY		;increment picture pointer
	CPY	#14	;check for end of picture
	BNE	MOVHAR	;at end? No.
	LDA	STRIG0	;get trigger value
	CMP	STRIGF	;compare with trigger flag
	STA	STRIGF	;save new trigger flag
	BCS	NOFIRE	;shot fired? No.
	LDA	XTEMP	;rabbit X increment
	ORA	YTEMP	;OR rabbit Y increment
	BNE	FIREGN	;rabbit stationary? No.
	INC	STRIGF	;set trigger flag to 1
	BNE	NOFIRE	;skip fire routine
FIREGN	LDA	#$40	;initialize frequency
	STA	FREQ3	;zero audio freq 3
	LDA	#$04	;shot volume + distortion
	STA	AUDC3	;enable volume 3
	INC	SHOTS	;increment shot pointer
	LDA	SHOTS	;get shot pointer
	AND	#3	;make it 0-3 only
	TAX		;use pointer for index
	LDA	XTEMP	;get rabbit X increment
	ASL	A	;make shot twice as fast
	STA	SINCX,X	;set missile X increment
	LDA	YTEMP	;get rabbit Y increment
	ASL	A	;make shot twice as fast
	STA	SINCY,X	;set missile Y increment
	CLC		;clear carry for add
	LDA	HARX	;get rabbit X position
	ADC	#3	;move to center X of rabbit
	STA	SHOTX,X	;shot initial X position
	LDA	HARY	;get rabbit Y position
	ADC	#8	;its move to center Y of rabbit
	STA	SHOTY,X	;shot initial Y position
NOFIRE	LDA	#0	;zero accumulator
	TAX		;zero X index
ERASES	STA	MISL,X	;zero all missiles
	INX		;next missile byte
	BPL	ERASES	;done? No.
	LDX	#3	;count 3 downto 0
PLOTS	LDA	SINCX,X	;get missile X increment
	ORA	SINCY,X	;OR missile Y increment
	BEQ	NOPLOT	;any movement? No.
	LDA	SHOTY,X	;missile Y position
	CLC		;clear carry for add
	ADC	SINCY,X	;add Y increment
	STA	SHOTY,X	;store new Y position
	TAY		;Y position now index
	ASL	A	;multiply by 2
	ADC	#2	;offset for compare
	CMP	BYLOC+1	;compare with bottom wall
	BCC	HITTP	;hit bottom wall? No.
	JSR	ZINCXY	;zero missile increments
	ADC	WINC+1	;add 8 to wall increment
	STA	WINC+1	;new bottom wall increment
	JMP	PLOTNH	;continue

HITTP	SBC	#12	;offset for bottom side
	CMP	BYLOC	;compare with top wall
	BCS	PLOTNH	;hit top wall? No.
	JSR	ZINCXY	;zero missile increments
	ADC	WINC	;add 8 to wall increment
	STA	WINC	;new top wall increment
PLOTNH	LDA	MISL,Y	;get missile byte
	ORA	MISMSK,X;OR missile mask
	STA	MISL,Y	;store new byte
	LDA	MISL+1,Y;get next missile byte
	ORA	MISMSK,X;OR missile mask
	STA	MISL+1,Y;store new next byte
	LDA	M0PF,X	;missile/playfield collision
	LDY	#0	;init Y register
MHPF	ROR	A	;collision?
	BCC	MHPF0	;No. No. No.
	JMP	MHIT	;Yes. Yes. Yes.
MHPF0	INY		;try next bit
	CPY	#4	;any more bits?
	BNE	MHPF	;Certainly! Yuk. Yuk.
	CLC		;clear carry for add
	LDA	SHOTX,X	;get missile X position
	ADC	SINCX,X	;add X increment
	STA	SHOTX,X	;store new X position
	STA	HPOSM0,X;position missile
	CMP	BXLOC+1	;compare missile with wall
	BCC	HITLF	;hit right wall? No.
	JSR	ZINCXY	;zero missile increments
	ADC	WINC+3	;add 8 to wall increment
	STA	WINC+3	;new wall increment
	JMP	NOPLOT	;continue

HITLF	SBC	#6	;offset for right side
	CMP	BXLOC	;compare with left wall
	BCS	NOPLOT	;hit left wall? No.
	JSR	ZINCXY	;zero missile increments
	ADC	WINC+2	;add 8 to wall increment
	STA	WINC+2	;new wall increment
NOPLOT	DEX		;next missile
	BMI	NOPL1	;missiles done? Yes.
	JMP	PLOTS	;continue loop

NOPL1	LDX	#3	;set up pointer
	LDA	#0	;zero accumulator
CHKMIS	ORA	SINCX,X	;OR in X increments
	ORA	SINCY,X	;OR in Y increments
	DEX		;decrement pointer
	BPL	CHKMIS	;at end? No.
	CMP	#0	;check shot increments
	BNE	NOSSND	;any increments? Yes.
	STA	AUDC3	;end shot sound
NOSSND	LDY	#0	;initialize Y index
MISHIT	LSR	P0PFT	;shift collision to carry
	BCC	MH1	;collision w/number? No.
	JSR	ERANUM	;erase the number
	LDA	VTBL,Y	;get value of number
	PHA		;save on stack
	JSR	PUTNUM	;put out a new number
	PLA		;get old number
	TAY		;use as counter value
	BEQ	SCX	;was it zero? Yes.
SCORER	LDX	#3	;point to score low digit
SC1	INC	SNUM,X	;increment digit
	LDA	SNUM,X	;get digit
	CMP	#'9'+$A1;past ATASCII '9'+color?
	BNE	SCY	;No. continue
	LDA	#'0'+$A0;reset digit
	STA	SNUM,X	;change score display
	DEX		;point to next digit
	BPL	SC1	;score rolled over? No.
SCY	DEY		;decrement value
	BNE	SCORER	;scoring done? No.
SCX	JMP	VBX	;exit routine

MH1	INY		;check next color digit
	CPY	#3	;done 0-2 yet?
	BNE	MISHIT	;No. continue
VBX	STA	HITCLR	;clear collision registers
	JMP	XITVBV	;exit deferred vertical blank

MHIT	TXA		;save X register
	PHA		;on stack
	JSR	ERANUM	;erase number hit and
	JSR	PUTNUM	;put a new one on screen
	PLA		;pull X register
	TAX		;from stack
	JMP	NOPLOT	;continue on

;	-------------------------
;	Commonly used subroutines
;	-------------------------

;	Clear missile display area

ZINCXY	LDA	#0	;get zero value
	STA	SINCX,X	;zero missile X increment
	STA	SINCY,X	;zero missile Y increment
	CLC		;clear carry for add
	LDA	#8	;get value for add
	RTS		;we return to the program

;	Clear the game playfield

CLSCRN	LDX	#200	;set 0-199 bytes
	LDA	#0	;to zero
CL0	STA	DISP-1,X;store in display
	DEX		;count down
	BNE	CL0	;past zero yet? No.
	RTS		;return to program

;	Put random number from 0-9 on screen at
;	a random location 0-199

PUTNUM	LDX	RANDOM	;get random number
	CPX	#200	;is number < 200?
	BCS	PUTNUM	;No. try another
	LDA	DISP,X	;see if space is occupied
	BNE	PUTNUM	;Yes. try again
PN0	LDA	RANDOM	;get another random number
	AND	#$0F	;limit it to 0-15
	CMP	#10	;is number < 10?
	BCS	PN0	;No. try another
	STA	VTBL,Y	;save number
	ORA	CTBL,Y	;OR with color
	STA	DISP,X	;put number on screen
	TXA		;move screen offset to A
	STA	ATBL,Y	;save screen offset
	RTS		;end of routine

;	Erase number from screen

ERANUM	LDA	#0	;get zero for blank
	LDX	ATBL,Y	;get # position on screen
	STA	DISP,X	;blank number on screen
	LDA	RANDOM	;get random number
	AND	#$1F	;mask off high bits
	ORA	#$10	;make it $10-$1F
	STA	AUDF4	;use as sound frequency
	LDA	#30	;initialize-
	STA	NSOUND	;volume counter
	RTS		;end of routine

;	----------------------------
;	Program tables and constants
;	----------------------------

MISMSK	DB	$03	;missile 0 mask
	DB	$0C	;missile 1 mask
	DB	$30	;missile 2 mask
	DB	$C0	;missile 3 mask

HARLF1	DB	0,0	;left view #1
	DB	$12,$0A
	DB	$3C,$74
	DB	$3C,$1C
	DB	$1E,$3E
	DB	$3F,$7E
HARLF2	DB	0,0	;left view #2
	DB	$0B,$0A
	DB	$3C,$74
	DB	$3C,$1C
	DB	$1E,$3E
	DB	$3E,$F7
HARRT1	DB	0,0	;right view #1
	DB	$48,$50
	DB	$3C,$2E
	DB	$3C,$38
	DB	$78,$7C
	DB	$FC,$7E
HARRT2	DB	0,0	;right view #2
	DB	$D0,$50
	DB	$3C,$2E
	DB	$3C,$38
	DB	$78,$7C
	DB	$7C,$EF
HARFR1	DB	0,0	;front view #1
	DB	$42,$24
	DB	$3C,$14
	DB	$3C,$18
	DB	$3C,$7E
	DB	$7E,$E7
HARFR2	DB	0,0	;front view #2
	DB	$42,$24
	DB	$3C,$28
	DB	$3C,$18
	DB	$3C,$7E
	DB	$7E,$E7
HARDN1	DB	0,0	;down view #1
	DB	$44,$24
	DB	$3C,$14
	DB	$3C,$18
	DB	$3C,$7E
	DB	$FE,$07
HARDN2	DB	0,0	;down view #2
	DB	$22,$24
	DB	$3C,$28
	DB	$3C,$18
	DB	$3C,$7E
	DB	$7F,$E0
HARUP1	DB	0,0	;up view #1
	DB	$44,$24
	DB	$3C,$3C
	DB	$3C,$18
	DB	$3C,$66
	DB	$FE,$07
HARUP2	DB	0,0	;up view #2
	DB	$22,$24
	DB	$3C,$3C
	DB	$3C,$18
	DB	$3C,$66
	DB	$7F,$E0
	DB	0,0

PK1	DW	HARRT1	;rabbit pictures set 1
	DW	HARRT1
	DW	HARRT1
	DW	0
	DW	HARLF1
	DW	HARLF1
	DW	HARLF1
	DW	0
	DW	HARDN1
	DW	HARUP1
	DW	HARFR1

PK2	DW	HARRT2	;rabbit pictures set 2
	DW	HARRT2
	DW	HARRT2
	DW	0
	DW	HARLF2
	DW	HARLF2
	DW	HARLF2
	DW	0
	DW	HARDN2
	DW	HARUP2
	DW	HARFR2

CTBL	DB	$10,$50	;color offset table
	DB	$90
METRO	DB	38,41	;tictoc tones
STBLX	DB	$01,$FF	;joystick X increments
	DB	$00,$00
STBLY	DB	$00,$00	;joystick Y increments
	DB	$01,$FF

;	---------------------
;	Variable Storage Area
;	---------------------

HARX	DS	1	;Harvey's X locatin
HARY	DS	1	;Harvey's Y location
BYLOC	DS	2	;horizontal wall Y locations
BXLOC	DS	2	;vertical wall X locations
VOL1	DS	1	;tictoc volume
VOL2	DS	1	;shuffle volume
FREQ3	DS	1	;shot frequency
NSOUND	DS	1	;pick number up sound
TICTOC	DS	1	;tictoc sound counter
TIM2ST	DS	1	;wall speed timer
WINC	DS	4	;wall mover counters
STRIGF	DS	1	;trigger compare register
XTEMP	DS	1	;temporary variable
YTEMP	DS	1	;temporary variable
P0PLT	DS	1	;player 0 collision shadow
P0PFT	DS	1	;PL to PF collision shadow
VTBL	DS	3	;value of #'s on screen
ATBL	DS	3	;screen offset to #'s
SHOTS	DS	1	;shot enable counter
LIVES	DS	1	;number of lives left
DIESW	DS	1	;rabbit dying switch
SHOTX	DS	4	;missile X location
SHOTY	DS	4	;missile Y location
SINCX	DS	4	;missile X increment
SINCY	DS	4	;missile Y increment
DISP	DS	200	;screen display area

	END	HARVEY
