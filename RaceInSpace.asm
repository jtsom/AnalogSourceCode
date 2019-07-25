;   +---------------+
;   | RACE IN SPACE |
;   +---------------+
;
; Written by Charles Bachand
;
ORIGIN	=	$1000
;
; Game Playfield Area
; -------------------
;
DRAM	=	ORIGIN+$1000
MRAM	=	DRAM+$1900
ASTR	=	PAGES*512+DRAM
ASTL	=	PAGES*256+ASTR
;
; Player/Missile Area
; -------------------
;
	*=	$0800
;
PM	*=	*+$0180	;blank space
PMM	*=	*+$80	;missiles
PM0	*=	*+$80	;player 0
PM1	*=	*+$80	;player 1
PM2	*=	*+$80	;player 2
PM3	*=	*+$80	;player 3
;
; System Equates
; --------------
;
TRAM	=	PM	;PM blank space
CHBAS	=	$02F4	;char base reg
CH	=	$02FC	;last key press
VSCROL	=	$D405	;vertical scroll
NMIEN	=	$D40E	;interrupt ctrl
VDSLST	=	$0200	;DLI vector
SDMCTL	=	$022F	;DMA enable
SDLSTL	=	$0230	;display list
COLOR0	=	$02C4	;color reg 0
COLOR1	=	$02C5	;color reg 1
COLOR2	=	$02C6	;color reg 2
COLPF1	=	$D017	;color playfld 1
DLI	=	$80	;DLI flag
ATRACT	=	77	;attract mode
RTCLOK	=	20	;real time clock
PCOLR0	=	$02C0	;player color 0
PCOLR1	=	$02C1	;player color 1
PCOLR2	=	$02C2	;player color 2
PCOLR3	=	$02C3	;player color 3
GPRIOR	=	$026F	;priority
SIZEP2	=	$D00A	;size player 2
SIZEP3	=	$D00B	;size player 3
HPOSP0	=	$D000	;pos player 0
HPOSP2	=	$D002	;pos player 2
HPOSP3	=	$D003	;pos player 3
HPOSM0	=	$D004	;pos missile 0
SIZEM	=	$D00C	;missile size
VDELAY	=	$D01C	;vertical delay
GRACTL	=	$D01D	;graphics ctrl
CONSOL	=	$D01F	;console keys
PMBASE	=	$D407	;P/M base addr
AUDF1	=	$D200	;audio freq 1
AUDF2	=	$D202	;audio freq 2
AUDF3	=	$D204	;audio freq 3
AUDF4	=	$D206	;audio freq 4
AUDC1	=	$D201	;audio volume 1
AUDC2	=	$D203	;audio volume 2
AUDC3	=	$D205	;audio volume 3
AUDC4	=	$D207	;audio volume 4
AUDCTL	=	$D208	;audio control
SKCTL	=	$D20F	;serial ctrl
RANDOM	=	$D20A	;random number
STRIG	=	$0284	;joystick trig 0
STICK	=	$0278	;joystick 0
PAGES	=	$06	;scrn block size
P0PF	=	$D004	;P0/PF collision
P1PF	=	$D005	;P1/PF collision
M0PL	=	$D008	;M0/PL collision
M1PL	=	$D009	;M1/PL collision
P0PL	=	$D00C	;P0/PL collision
P1PL	=	$D00D	;P1/PL collision
HITCLR	=	$D01E	;collision clear
PACTL	=	$D302	;port A control
;
; Page Zero equates
; -----------------
;
	*=	$80
;
SELPNT	*=	*+2	;menu select pnt
CONSAV	*=	*+1	;console save
CLOCK	*=	*+1	;local clock
SLINE	*=	*+1	;scroll line cnt
VOLUME	*=	*+1	;intro volume
DIRSW	*=	*+1	;vol direction
OPTION	*=	*+1	;OPTION key indx
OPTSW	*=	*+1	;OPTION switch
TRIG	*=	*+1	;Trigger option
DENS	*=	*+1	;starfield dens
SHIP	*=	*+1	;ship type
COME	*=	*+1	;comet enabled
UNIV	*=	*+1	;inverse univ
SOFSET	*=	*+1	;SELECT offset
TEMP	*=	*+4	;temp registers
GRPAGE	*=	*+2	;screen pointer 
GRP1	*=	*+2	;asteroid left
GRP2	*=	*+2	;asteroid right
GRP20P	*=	*+2	;scrn pntr -20
GRPX	*=	*+2	;player gr pntr
GRPM	*=	*+2	;missile gr pntr
FLASHC	*=	*+1	;univ flash cntr
FLASHF	*=	*+1	;univ flash flag
REVF	*=	*+1	;inv univ flag
HPOS	*=	*+1	;comet H pos
HDIR	*=	*+1	;comet H dir
HINC	*=	*+1	;comet H speed
VPOS	*=	*+1	;comet V pos
VDIR	*=	*+1	;comet V dir
VINC	*=	*+1	;comet V speed
DEAD	*=	*+2	;dead ship flg
COMETF	*=	*+1	;comet set flag
CSOUND	*=	*+1	;comet snd cntr
UNIVS	*=	*+1	;universe sound
ENDGAM	*=	*+1	;game over flag
SCORES	*=	*+2	;game scores
TRIGN	*=	*+2	;processed trigs
TRIGS	*=	*+2	;last triggers
ROTATE	*=	*+1	;rotate index
SCLOCK	*=	*+1	;score snd timer
VDEL	*=	*+1	;vert delay
MISSLE	*=	*+2	;shot flags
ROWAC	*=	*+2	;shot row acc
DELTAR	*=	*+2	;shot delta row
ENDPT	*=	*+2	;shot end point
ROWCRS	*=	*+2	;shot row cursor
ROWINC	*=	*+2	;shot row inc
COLAC	*=	*+2	;shot column acc
DELTAC	*=	*+2	;delta column
COLCRS	*=	*+2	;column cursor
COLINC	*=	*+2	;shot column inc
COUNTR	*=	*+2	;shot delta cnt
NEWCOL	*=	*+1	;shot end column
NEWROW	*=	*+1	;shot end row
OLDCOL	*=	*+1	;shot old column
OLDROW	*=	*+1	;shot old row
TEMPM	*=	*+1	;shot temporary
M0PLS	*=	*+2	;M0 col shadow
XPLR	*=	*+2	;ship X coords
YPLR	*=	*+2	;ship Y coords
;
	*=	ORIGIN
;
; Redefined Character Set Data
; ----------------------------
;
CHARS	.BYTE	0,0,0,0,0,0,0,0
	.BYTE	0,0,0,0,$7B,50,50,50
	.BYTE	0,0,0,0,$60,$A0,$A0,32
	.BYTE	0,$7E,66,66,$7E,66,66,0
	.BYTE	0,$7E,64,64,64,64,$7E,0
	.BYTE	0,$7C,70,70,70,70,$7C,0
	.BYTE	0,$7E,64,$7C,64,64,$7E,0
	.BYTE	0,$7E,64,$7C,64,64,64,0
	.BYTE	0,$7E,64,64,78,66,$7E,0
	.BYTE	0,66,66,$7E,66,66,66,0
	.BYTE	0,$7E,24,24,24,24,$7E,0
	.BYTE	0,64,64,64,64,64,$7E,0
	.BYTE	0,$7E,66,66,66,66,66,0
	.BYTE	0,$7E,66,66,$7E,64,64,0
	.BYTE	0,$7E,66,66,$7E,76,70,0
	.BYTE	0,$7E,24,24,24,24,24,0
	.BYTE	0,66,66,66,90,90,$7E,0
	.BYTE	0,66,66,$7E,24,24,24,0
	.BYTE	$7E,$81,$BD,$A1
	.BYTE	$A1,$BD,$81,$7E
	.BYTE	0,$7E,66,66,66,66,$7E,0
	.BYTE	0,8,8,8,8,8,8,0
	.BYTE	0,$7E,2,$7E,64,64,$7E,0
	.BYTE	0,$7E,2,$7E,2,2,$7E,0
	.BYTE	0,66,66,$7E,2,2,2,0
	.BYTE	0,$7E,64,$7E,2,2,$7E,0
	.BYTE	0,$7E,64,$7E,66,66,$7E,0
	.BYTE	0,$7E,2,2,2,2,2,0
	.BYTE	0,$7E,66,$7E,66,66,$7E,0
	.BYTE	0,$7E,66,$7E,2,2,$7E,0
	.BYTE	0,0,0,0,0,0,0,0
	.BYTE	24,36,90,0,0,0,0,0
	.BYTE	0,0,24,60,60,24,0,0
	.BYTE	0,0,0,60,$7E,$7E,$7E,60
	.BYTE	0,0,0,0,$7E,$FF,$FF,$FF
	.BYTE	0,0,0,0,0,60,$7E,$7E
	.BYTE	0,0,0,0,0,0,24,60
	.BYTE	0,0,0,0,0,0,0,24
	.BYTE	0,0,0,0,0,0,0,0
	.BYTE	0,0,0,0,0,0,0,0
	.BYTE	0,0,0,0,0,0,0,0
	.BYTE	60,0,0,0,0,0,0,0
	.BYTE	$FF,$FF,$FF,$7E,0,0,0,0
	.BYTE	$7E,$7E,60,0,0,0,0,0
	.BYTE	60,24,0,0,0,0,0,0
	.BYTE	24,0,0,0,0,0,0,0
	.BYTE	0,24,24,24,24,60,$7E,90
	.BYTE	24,24,24,60
	.BYTE	$7E,$FF,$DB,0
	.BYTE	0,0,0,0,0,0,0,0
	.BYTE	0,66,66,66,66,66,$7E,0
	.BYTE	0,0,24,24,0,24,24,0
	.BYTE	0,66,66,66,66,36,24,0
	.BYTE	0,$7E,90,90,66,66,66,0
	.BYTE	0,70,76,$78,88,76,70,0
	.BYTE	$FF,$FF,$FF,$FF
	.BYTE	$FF,$FF,$FF,$FF
	.BYTE	$7E,66,66,0,66,66,$7E,0
	.BYTE	2,2,2,0,2,2,2,0
	.BYTE	62,2,2,60,64,64,$7C,0
	.BYTE	62,2,2,60,2,2,62,0
	.BYTE	66,66,66,60,2,2,2,0
	.BYTE	$7C,64,64,60,2,2,62,0
	.BYTE	$7C,64,64,60,66,66,$7E,0
	.BYTE	62,2,2,0,2,2,2,0
	.BYTE	$7E,66,66,60,66,66,$7E,0
	.BYTE	$7E,66,66,60,2,2,62,0
;
; Introduction Display List
; -------------------------
;
DISPI	.BYTE	$70,$67
DADR	.WORD	DRAM
	.BYTE	$27,$27,$27,$27
	.BYTE	$27,$27,$27,$27
	.BYTE	$27,$27,$27,$27
	.BYTE	$27,$07,$41+DLI
	.WORD	DISPI
;
; Game Options Display List
; -------------------------
;
DISPO	.BYTE	$70,$70,$70,$46
	.WORD	OPTMSG
	.BYTE	$07,$46
	.WORD	SB
	.BYTE	$46
	.WORD	OL1
	.BYTE	$06,$06,$46
	.WORD	SB
	.BYTE	$46
	.WORD	OL2
	.BYTE	$46
DOT	.WORD	TOPT
	.BYTE	$46
	.WORD	SB
	.BYTE	$46
	.WORD	OL3
	.BYTE	$46
DOD	.WORD	DOPT
	.BYTE	$46
	.WORD	SB
	.BYTE	$46
	.WORD	OL4
	.BYTE	$46
DOS	.WORD	SOPT
	.BYTE	$46
	.WORD	SB
	.BYTE	$46
	.WORD	OL5
	.BYTE	$46
DOC	.WORD	COPT
	.BYTE	$46
	.WORD	SB
	.BYTE	$46
	.WORD	OL6
	.BYTE	$46
DOU	.WORD	UOPT
	.BYTE	$46
	.WORD	SB
	.BYTE	$46
	.WORD	OPTMSG
	.BYTE	$41
	.WORD	DISPO
;
; Game Playfield Display List
; ---------------------------
;
DISPG	.BYTE	$70,$70,$70,$4F
	.WORD	DRAM
	.DBYTE	15,15,15,15,15,15,15
	.DBYTE	15,15,15,15,15,15,15
	.DBYTE	15,15,15,15,15,15,15
	.DBYTE	15,15,15,15,15,15,15
	.DBYTE	15,15,15,15,15,15,15
	.DBYTE	15,15,15,15,15,15,15
	.DBYTE	15,15,15,15,15,15,15
	.DBYTE	15,15,15,15,15,15,15
	.DBYTE	15,15,15,15,15,15,15
	.DBYTE	15,15,15,15,15,15,15
	.DBYTE	15,15,15,15,15
	.BYTE	$70,$30,$47+DLI
	.WORD	TRAM
	.BYTE	$30,$42
	.WORD	ANALOG
	.BYTE	$41
	.WORD	DISPG
;
; Flying saucer in Intro Data
; ---------------------------
;
SAUCER	.BYTE	$18,$7E,$7E,$FF
	.BYTE	$FF,$7E,$7E,$18
WINDOW	.BYTE	$00,$00,$00,$55
	.BYTE	$55,$00,$00,$00
;
; Redefined Char Set Equates
; --------------------------
;
TMC	=	1
AC	=	3
CC	=	4
DC	=	5
EC	=	6
FC	=	7
GC	=	8
HC	=	9
IC	=	10
LC	=	11
NC	=	12
PC	=	13
RC	=	14
TC	=	15
WC	=	16
YC	=	17
CRC	=	18
N0C	=	19
BC	=	N0C+8
OC	=	N0C
SC	=	OC+5
SMK	=	N0C+10
SMK2	=	SMK+8
SHC	=	SMK2+8
MT	=	SHC+2
UC	=	MT+1
COLC	=	UC+1
VC	=	COLC+1
MC	=	VC+1
KC	=	MC+1
BX	=	KC+$41
N7C	=	KC+2
;
; Introduction Title Data
; -----------------------
;
TITLE	.BYTE	21,AC,NC,AC,LC
	.BYTE	OC,GC,$FF,36,MC
	.BYTE	AC,GC,AC,N0C+2,IC
	.BYTE	NC,EC,$FF,68
	.BYTE	+$40,PC,RC,EC,SC
	.BYTE	+$40,EC,NC,TC,SC
	.BYTE	$FF,97
	.BYTE	+$80,RC,AC,CC,EC,0
	.BYTE	+$80,IC,NC,0,SC,PC
	.BYTE	+$80,AC,CC,EC
	.BYTE	TMC,TMC+1,$FF,131
	.BYTE	+$40,WC,RC,IC,TC,TC,EC
	.BYTE	+$40,NC,0,BC,YC
	.BYTE	$FF,160
	.BYTE	+$C0,CC,HC,AC,RC,LC,EC
	.BYTE	+$C0,SC,0,0,BC,AC,CC
	.BYTE	+$C0,HC,AC,NC,DC
	.BYTE	$FF,197,CRC,0
	.BYTE	N0C+1,N0C+9,N0C+8
	.BYTE	N0C+4,$FF,230
	.BYTE	+$80,SHC,0,0,SHC
	.BYTE	$FF,246
	.BYTE	+$40,SHC+1,0,0,SHC+1
	.BYTE	$FF
;
; PRESS OPTION Message Data
; -------------------------
;
PMSG	.BYTE	0,0,0,0,0,0,0,0,0
	.BYTE	+$C0,PC,RC,EC,SC,SC
	.BYTE	+$C0,0,OC,PC,TC,IC
	.BYTE	+$C0,OC,NC,0,0
	.BYTE	0,0,0,0,0,0,0,0,0
;
; Options Screen Data
; -------------------
;
OPTMSG	.BYTE	BX,BX,BX,BX,BX,BX,BX,BX
	.BYTE	BX,BX,BX,BX,BX,BX,BX,BX
	.BYTE	BX,0,OC,PC,TC,IC,OC,NC
	.BYTE	SC
	.BYTE	+$C0,0,0,TC,COLC
TIMOPT	.BYTE	+$80,N0C+3,0
OL1	.BYTE	BX,0
	.BYTE	+$40,OC,PC,TC,IC
	.BYTE	+$40,OC,NC,COLC,0
	.BYTE	+$80,LC,EC,FC,TC,0
	.BYTE	BX,BX,0
	.BYTE	+$40,SC,EC,LC,EC,CC
	.BYTE	+$40,TC,COLC
	.BYTE	+$C0,RC,IC,GC,HC,TC,0
	.BYTE	BX,BX,0
	.BYTE	+$40,SC,TC,AC,RC,TC
	.BYTE	+$40,COLC
	.BYTE	0,0,PC,LC,AC,YC,0
OL2	.BYTE	BX,0,TC,RC,IC,GC,GC,EC
	.BYTE	RC,COLC,0,0,0,0,0,BX
OL3	.BYTE	BX,0
	.BYTE	+$80,DC,EC,NC,SC,IC,TC
	.BYTE	+$80,YC,COLC,0,0
	.BYTE	0,0,0,BX
OL4	.BYTE	BX,0
	.BYTE	+$80,SC,HC,IC,PC,SC
	.BYTE	+$80,COLC
	.BYTE	0,0,0,0,0,0,0,BX
OL5	.BYTE	BX,0
	.BYTE	+$80,CC,OC,MC,EC,TC
	.BYTE	+$80,SC,COLC
	.BYTE	0,0,0,0,0,0,BX
OL6	.BYTE	BX,0
	.BYTE	+$80,UC,NC,IC,VC
	.BYTE	+$80,EC,RC,SC,EC,COLC
	.BYTE	0,0,0,0,BX
SB	.BYTE	BX,0,0,0,0,0,0,0
	.BYTE	0,0,0,0,0,0,0
TOPT	.BYTE	BX,0,0,0,0
	.BYTE	+$C0,NC,OC,0,EC,FC,FC
	.BYTE	+$C0,EC,CC,TC,0
TOPT2	.BYTE	BX,0,0,0,0,0,0
	.BYTE	+$C0,SC,HC,IC,EC
	.BYTE	+$C0,LC,DC,SC,0
TOPT3	.BYTE	BX,0,0,0,0,0
	.BYTE	+$C0,MC,IC,SC,SC
	.BYTE	+$C0,IC,LC,EC,SC,0
TOPT4	.BYTE	BX,0,0,0
	.BYTE	+$C0,WC,AC,RC,PC,0
	.BYTE	+$C0,DC,RC,IC,VC,EC,0
DOPT	.BYTE	BX,0,0,0,0,0
	.BYTE	+$C0,SC,TC,AC,NC
	.BYTE	+$C0,DC,AC,RC,DC,0
DOPT2	.BYTE	BX,0,0,0,0,0,0,0
	.BYTE	+$C0,DC,OC,UC,BC,LC
	.BYTE	+$C0,EC,0
DOPT3	.BYTE	BX,0,0,0,0,0,0,0
	.BYTE	+$C0,TC,RC,IC,PC,LC
	.BYTE	+$C0,EC,0
DOPT4	.BYTE	BX,0,0,0,0,0,0,0,0
	.BYTE	+$C0,SC,UC,PC,EC,RC,0
SOPT	.BYTE	BX,0,0,0,0,0,0
	.BYTE	+$C0,RC,OC,CC,KC
	.BYTE	+$C0,EC,TC,SC,0
SOPT2	.BYTE	BX,0,0,0,0,0,0
	.BYTE	+$C0,SC,AC,UC,CC,EC
	.BYTE	+$C0,RC,SC,0
COPT	.BYTE	BX,0,0,0,0,0
	.BYTE	+$C0,DC,IC,SC,AC
	.BYTE	+$C0,BC,LC,EC,DC,0
COPT2	.BYTE	BX,0,0,0,0,0,0
	.BYTE	+$C0,EC,NC,AC,BC
	.BYTE	+$C0,LC,EC,DC,0
UOPT	.BYTE	BX,0,0,0,0,0
	.BYTE	+$C0,PC,OC,SC,IC
	.BYTE	+$C0,TC,IC,VC,EC,0
UOPT2	.BYTE	BX,0,0,0,0,0
	.BYTE	+$C0,NC,EC,GC,AC,TC
	.BYTE	+$C0,IC,VC,EC
	.BYTE	0,BX
ANALOG	.BYTE	0,0,0,0,CC,OC,PC,YC
	.BYTE	RC,IC,GC,HC,TC,0
	.BYTE	CRC,0,AC,NC,AC,LC
	.BYTE	OC,GC,0,MC,AC,GC,AC
	.BYTE	N0C+2,IC,NC,EC,0,N0C+1
	.BYTE	N0C+9,N0C+8,N0C+4
	.BYTE	0,0,0,0
TRAMI	.BYTE	0,0,N0C,N0C,0,0,0
TRAMC	.BYTE	+$C0,N7C+3,COLC,N7C
	.BYTE	+$C0,N7C,SMK+7,N7C
	.BYTE	0,0,0,N0C,N0C,0,0
TRAMN	.BYTE	3,0,0,0,0
NUMMSK	.BYTE	$1F,$1E,$1A,$18
	.BYTE	$1D,$1B,$33,$35,$30
MISMSK	.BYTE	$FC,$F3
MISIMA	.BYTE	3,0,3,1,1,1,1,3
	.BYTE	0,3,2,3,2,2,3,2
MIMAGE	.BYTE	0,0,0,0
MCMSK	.BYTE	$0E,$0D
LADR	.WORD	DOD,DOS,DOC,DOU,DOT
MADR	.WORD	TOPT,TOPT2,TOPT3,TOPT4
	.WORD	DOPT,DOPT2,DOPT3,DOPT4
	.WORD	SOPT,SOPT2,COPT
	.WORD	COPT2,UOPT,UOPT2
SELMSK	.BYTE	3,3,1,1,1
SELMS2	.BYTE	0,4,4,2,2
SHIPS	.BYTE	0,$18,$3C,$3C,$18
	.BYTE	$5A,$7E,$5A,$42
	.BYTE	0,$18,$7E,$DB
	.BYTE	$7E,0,0,0,0,0
ROTMSK	.BYTE	$B6,$6D,$DB,$B6
VDMSK	.BYTE	$10,$20,$01,$02
XSTRT	.BYTE	88,160
SCPNT	.BYTE	3,17
SCNOTE	.BYTE	$50,$30
PCOLRS	.BYTE	$C4,$34
COMETM	.BYTE	0,$3C,$7E,$7E
	.BYTE	$FF,$FF,$FF,$FF,$FF
	.BYTE	$FF,$7E,$7E,$3C,0
CE3K	.BYTE	$C6,$46,$F6,$66,$26
CE3KN	.BYTE	$6C,$A2,$51,$40,$48
;
; DLI Routine
; -----------
;
DLIVEC	PHA		;save Acc
	INC	CLOCK	;increment clock
	LDA	RTCLOK	;system clock
	ASL	A	;times 2
	AND	#$CE	;mask color
	STA	PCOLR2	;saucer color
	PLA		;restore Acc
	RTI		;return
;
; Console Checker
; ---------------
;
CONC	LDA	CONSOL	;get console
	TAY		;to Y register
	EOR	CONSAV	;only different
	AND	CONSAV	;pressed keys
	STY	CONSAV	;save current
	CMP	#4	;OPTION test
	RTS		;return
;
; Beep Routine
; ------------
;
BUZZER	STA	AUDF2	;buzzer freq
	LDA	#$A4	;pure tone
	STA	AUDC2	;in tone 2
	LDY	#$C0	;beep counter
BZ	DEX		;decrement X
	BNE	BZ	;zero yet? No.
	STX	ATRACT	;poke attract
	DEY		;decrement Y
	BNE	BZ	;tone done? No.
	STY	AUDC2	;Yes. turn off
	RTS		;return
;
; Flying Saucer Routine
; ---------------------
;
DELAY	LDX	#0	;get zero
	LDA	#$A4	;pure tone
	STA	AUDC1	;enable tone 1
	STA	AUDC2	;enable tone 2
DL1	LDA	#$12	;1/5 sec count
DL2	CMP	CLOCK	;compare clock
	BNE	DL2	;match? No.
	JSR	CONC	;check console
	BNE	DL3	;OPTION key? No.
	PLA		;Yes. pull RTS
	PLA		;addr from stack
	JMP	STOPTS	;options menu
DL3	LDA	#0	;get zero
	STA	CLOCK	;init clock
	INX		;inc saucer pos
	TXA		;move to Acc
	STA	HPOSP3	;move saucer
	AND	#$FC	;window movement
	STA	HPOSP2	;do windows
	LSR	A	;times 2
	LSR	A	;times 4
	LSR	A	;times 8
	TAY		;index to displa
	LDA	PMSG,Y	;get text
	STA	DRAM+313,Y	;on screen
	TXA		;saucer position
	ASL	A	;times 2
	ASL	A	;times 4
	ASL	A	;times 8
	ASL	A	;times 16
	ASL	A	;times 32 whew!
	EOR	#$F0	;inverse hi bits
	STA	AUDF1	;saucer sound
	CLC		;clear carry
	ADC	#2	;weird sound
	STA	AUDF2	;with resonance
	TXA		;saucer position
	BNE	DL1	;off screen? No.
	STA	AUDC2	;sound 2 off
	STA	VOLUME	;saucer volume
	RTS		;return
;
; Move All P/M Off Screen
; -----------------------
;
CLRPM	LDX	#7	;8 objects 0-7
	LDA	#0	;zero position
CPM	STA	HPOSP0,X	;move P/M
	DEX		;decrement count
	BPL	CPM	;done? No.
	RTS		;return
;
; Turn Off All Sound
; ------------------
;
AUDOFF	LDA	#0	;get zero
	STA	AUDC1	;sound 1 off
	STA	AUDC2	;sound 2 off
	STA	AUDC3	;sound 3 off
	STA	AUDC4	;sound 4 off
	RTS		;return
;
; Program Execution Starts Here
; -----------------------------
;
RIS	LDA	#$3C	;cassette off
	STA	PACTL	;poke hardware
	LDA	# <DOT	;density lo
	STA	SELPNT	;select point lo
	LDA	# >DOT	;density hi
	STA	SELPNT+1	;select pnt hi
	LDA	#0	;init sound
	STA	AUDCTL	;audio control
	LDX	#YPLR+1-CONSAV
I1	STA	CONSAV,X	;zero flags
	DEX		;decrement index
	BPL	I1	;done? No.
;
; System Reset Returns Here
; -------------------------
;
INTRO	LDA	#$29	;value to enable
	STA	SDMCTL	;narrow playfld
	LDA	#3	;value to turn
	STA	SKCTL	;off 2-tome mode
	LDA	# >MRAM	;high byte of
	STA	PMBASE	;P/M address
	LDA	#2	;value to
	STA	GRACTL	;enable players
	LDA	# <DLIVEC	;DLI addr lo
	STA	VDSLST	;DLI vector lo
	LDA	# >DLIVEC	;DLI addr hi
	STA	VDSLST+1	;DLI vector hi
	LDA	#$C0	;value to
	STA	NMIEN	;enable DLI's
	LDA	# >CHARS	;addr of
	STA	CHBAS	;character set
	LDA	#$C6	;value for
	STA	COLOR1	;medium green
	LDA	#$94	;value for
	STA	COLOR2	;dark blue
	LDA	#$04	;value for
	STA	PCOLR3	;dark grey
	LDA	#1	;value - player
	STA	SIZEP2	;double width
	STA	SIZEP3	;players set
	STA	GPRIOR	;PL has priority
	JSR	CLRPM	;remove PLayers
	STA	REVF	;rev screen flag
	STA	DIRSW	;sound direction
	JSR	AUDOFF	;sound off
	TAX		;zero index
I2	STA	DRAM,X	;clear display
	STA	DRAM+256,X	;page 2
	STA	DRAM+512,X	;page 3
	STA	MRAM+512,X	;player 2+3
	DEX		;decrement index
	BNE	I2	;done? No.
	LDX	#7	;move 8 bytes
I3	LDA	WINDOW,X	;saucer windows
	STA	MRAM+$0228,X	;player 2
	LDA	SAUCER,X	;saucer ship
	STA	MRAM+$02A8,X	;player 3
	DEX		;decrement index
	BPL	I3	;saucer done? No.
;
; Print Text Onto Display
; -----------------------
;
PTITL	INX		;increment index
	LDA	TITLE,X	;get text
	BEQ	STITL	;byte zero? Yes.
	TAY		;display index
P2	INX		;inc text index
	LDA	TITLE,X	;get text
	CMP	#$FF	;EOL flag
	BEQ	PTITL	;EOL? Yes.
	STA	DRAM+256,Y	;on screen
	INY		;inc displa indx
	JMP	P2	;continue
;
; Scroll Text For Intro
; ---------------------
;
STITL	LDA	# <DISPI	;DL addr lo
	STA	SDLSTL	;DL pntr lo
	LDA	# >DISPI	;DL addr hi
	STA	SDLSTL+1	;DL pntr hi
	LDA	# >DRAM	;screen top hi
	STA	DADR+1	;DL LMS hi
	LDA	#0	;get zero
	STA	DADR	;DL LMS lo
	STA	ATRACT	;poke attract
	STA	VOLUME	;clear volume
S1	LDA	#$10	;16/60 sec count
S2	BIT	CLOCK	;check clock
	BEQ	S2	;time up? No.
	JSR	CONC	;console keys
	BNE	S2A	;OPTION key? No.
	JMP	STOPTS	;option menu
S2A	LDA	#0	;get zero
	STA	CLOCK	;reset clock
	INC	SLINE	;inc scroll cnt
	LDA	SLINE	;scroll count
	CLC		;clear carry
	ADC	DADR	;screen addr lo
	EOR	DIRSW	;sound direction
	STA	AUDF1	;rocket sound
	LDA	SLINE	;scroll count
	AND	#7	;use only 0..7
	ADC	#SMK+$C0	;smoke offset
	STA	DRAM+518	;put below both
	STA	DRAM+521	;rocket ships
	ADC	#8	;botm smk offset
	STA	DRAM+534	;put below top
	STA	DRAM+537	;smoke of ships
	LDA	SLINE	;scroll count
	CMP	#16	;check overflow?
	BNE	S3	;No. continue
	LDA	#0	;get zero
	STA	SLINE	;reset count
	STA	VSCROL	;vertical scroll
	INC	VOLUME	;raise volume
	LDA	DIRSW	;sound direction
	EOR	VOLUME	;EOR with volume
	ORA	#$80	;rough sounding
	STA	AUDC1	;rocket sound
	LDA	DADR	;DL LMS lo
	CLC		;clear carry
	ADC	#16	;line width
	STA	DADR	;new DL LMS lo
	BCC	S3	;overflow? No.
	INC	DADR+1	;inc LMS hi
	LDA	#2+>DRAM	;cmp scrn end
	CMP	DADR+1	;with LMS hi
	BNE	S4	;at end? No.
	JMP	INTRO	;Yes. do intro
S4	JSR	DELAY	;flying saucer
	LDA	#$20	;value for
	STA	AUDF1	;reset frequency
	LDA	#$8F	;full volume
	STA	AUDC1	;reset tone
	LDA	#$0F	;reverse sound
	STA	DIRSW	;sound direction
S3	LDA	SLINE	;scroll count
	STA	VSCROL	;vertical scroll
	JMP	S1	;continue
;
; Game Option Menu Routine
; ------------------------
;
STOPTS	LDA	CLOCK	;allow one VBLANK
STP	CMP	CLOCK	;period to go by
	BEQ	STP	;before start
	LDA	#$21	;value for
	STA	SDMCTL	;narrow playfld
	LDA	# <DISPO	;DL addr lo
	STA	SDLSTL	;displa list lo
	LDA	# >DISPO	;DL addr hi
	STA	SDLSTL+1	;displa list hi
	JSR	SCRCLR	;clr inv Univ
	JSR	CLRPM	;clear players
	STA	ATRACT	;poke attract
	STA	GRACTL	;no players
	JSR	AUDOFF	;sound off
	STA	FLASHF	;clr flash flag
	STA	REVF	;clr inv flag
	LDA	#$94	;color value for
	STA	COLOR2	;medium blue
	LDA	#4	;five notes 0-4
	STA	TEMP+3	;same index
STS	LDX	TEMP+3	;get index
	LDA	CE3K,X	;get color
	STA	COLOR1	;change color
	LDA	CE3KN,X	;get note
	JSR	BUZZER	;play note
	DEC	TEMP+3	;dec index
	BPL	STS	;done? No.
ST1	LDA	CH	;check keyboard
	AND	#$3F	;mask CTRL/SHIFT
	LDX	#9	;check for 0-9
ST1A	CMP	NUMMSK-1,X	;cmp keycode
	BEQ	ST1B	;numeric? Yes.
	DEX		;decrement index
	BNE	ST1A	;done? No.
	BEQ	ST1C	;Yes. continue
ST1B	TXA		;index is number
	STA	TRAMN	;store time
	CLC		;clear carry
	ADC	#N0C+$80	;display offset
	STA	TIMOPT	;show time opt
	TXA		;number again
	ADC	#N7C+$C0	;2nd char set
	STA	TRAMC	;game score line
	LDA	#$FF	;clear the
	STA	CH	;keyboard buffer
	TXA		;number again
	ASL	A	;times 2
	ASL	A	;times 4
	EOR	#$3F	;inverse here to
	JSR	BUZZER	;number sound
ST1C	JSR	CONC	;check console
	LSR	A	;check START key
	BCC	ST2	;START key? No.
	JMP	PLAYGM	;Yes. play game
;
; SELECT Key Handler
; ------------------
;
ST2	LSR	A	;check SELECT
	BCC	ST3	;SELECT key? No.
	LDA	#$30	;Yes. do SELECT
	JSR	BUZZER	;key noise
	LDX	OPTION	;opt to change
	INC	TRIG,X	;inc option byte
	LDA	TRIG,X	;get option byte
	AND	SELMSK,X	;mask overflow
	STA	TRIG,X	;save opt byte
	ORA	SOFSET	;SELECT offset
	ASL	A	;times 2
	TAX		;use as X index
	LDY	#0	;zero Y index
	LDA	MADR,X	;text addr lo
	STA	(SELPNT),Y	;LMS byte lo
	INY		;inc Y index
	LDA	MADR+1,X	;text addr hi
	STA	(SELPNT),Y	;LMS byte hi
	JMP	ST1	;continue
;
; OPTION Key Handler
; ------------------
;
ST3	LSR	A	;check OPTION
	BCC	ST1	;OPTION key? No.
	LDA	#$10	;Yes. do OPTION
	JSR	BUZZER	;key sound
	LDX	#1	;reset text flag
ST4	STX	OPTSW	;option switch
	LDA	OPTION	;option counter
	ASL	A	;times 2
	ASL	A	;times 4
	ASL	A	;times 8
	ASL	A	;times 16
	TAX		;use as index
	LDY	#13	;do 14 bytes
ST4A	LDA	#$80	;get sign bit
	EOR	OL2+1,X	;flip sign
	STA	OL2+1,X	;save byte
	INX		;increment index
	DEY		;decrement count
	BPL	ST4A	;done? No.
	LDA	OPTSW	;option switch
	BNE	ST4B	;flipping done?
	JMP	ST1	;Yes. continue
ST4B	INC	OPTION	;inc option cntr
	LDA	OPTION	;option counter
	ASL	A	;times 2
	TAX		;use as index
	LDA	LADR-2,X	;DL LMS addr lo
	STA	SELPNT	;select pntr lo
	LDA	LADR-1,X	;DL LMS addr hi
	STA	SELPNT+1	;select pntr hi
	LDX	OPTION	;option counter
	LDA	SELMS2,X	;offset table
	ADC	SOFSET	;present offset
	STA	SOFSET	;new offset
	LDX	#0	;get zero
	LDA	OPTION	;option counter
	CMP	#5	;range: 0..4
	BNE	ST4	;overflow? No.
	STX	OPTION	;reset counter
	STX	SOFSET	;reset offset
	JMP	ST4	;continue
;
; Asteroid Field Initializer
; --------------------------
; Initialize pointers
; -------------------
;
LDGRRT	LDA	# <ASTR	;asteroid right
	STA	GRPAGE	;field addr lo
	TAY		;use as index
	LDA	# >ASTR	;asteroid right
	STA	GRPAGE+1	;field addr hi
	LDA	#PAGES	;# of 256 byte
	STA	TEMP+2	;blocks to move
	RTS		;return
;
; Generate Asteroid Field Bytes
; -----------------------------
;
RANWRD	LDA	#2	;# 4-bit nibbles
	STA	TEMP	;save counter
RANW0	CPX	RANDOM	;with density
	ROL	TEMP+1	;carry to bit 0
	ASL	TEMP+1	;to bit 1
	ASL	TEMP+1	;to bit 2
	ASL	TEMP+1	;to bit 3
	DEC	TEMP	;nibble count
	BNE	RANW0	;byte done? No.
	LDA	TEMP+1	;move byte to
	STA	(GRPAGE),Y	;graphic area
	RTS		;return
;
; Fill Workspace With Graphics
; ----------------------------
;
RANFIL	JSR	LDGRRT	;init pointers
	ASL	TEMP+2	;blocks times 2
	LDX	DENS	;get density
RANF0	JSR	RANWRD	;make starfield
	INY		;inc block index
	BNE	RANF0	;block done? No.
	INC	GRPAGE+1	;inc page pntr
	DEC	TEMP+2	;dec block cntr
	BNE	RANF0	;done? No.
;
; Shift ASTR Space To Right
; -------------------------
;
	DEC	GRPAGE+1	;dec page pntr
	LDA	#PAGES	;get block count
	STA	TEMP+2	;store count
RANF1	DEY		;dec index
	LDA	(GRPAGE),Y	;asteroid byte
	LSR	A	;force to odd
	STA	(GRPAGE),Y	;replace byte
	TYA		;exam index
	BNE	RANF1	;index=0? No.
	DEC	GRPAGE+1	;back up pntr
	DEC	TEMP+2	;decrement count
	BNE	RANF1	;Done? No.
	RTS		;return
;
; Ship Scoring Routine
; --------------------
;
SCORE	LDY	#10	;clr top 16 bytes
SC0	STA	PM0,Y	;of player 0
	STA	PM1,Y	;and player 1
	DEY		;decrement index
	BPL	SC0	;done? No.
	LDA	XSTRT,X	;start position
	STA	XPLR,X	;to player pos
	STA	HPOSP0,X	;set hardware
SCOREM	TXA		;save X to Acc
	PHA		;push Acc
	LDA	SCPNT,X	;score Y pos
	TAX		;use as index
	INC	TRAM,X	;increment score
	LDA	TRAM,X	;get score byte
	CMP	#N0C+10	;value over 9?
	BCC	SC1	;No. skip
	LDA	#N0C	;get zero char
	STA	TRAM,X	;to 1's position
	INC	TRAM-1,X	;inc 10's pos
SC1	PLA		;pull Acc
	TAX		;get X indx back
	LDA	SCNOTE,X	;score sound
	STA	AUDF3	;set frequency
	LDA	#$AE	;loud sound
	STA	AUDC3	;set volume
	LDA	#3	;value for
	STA	SCLOCK	;sound duration
	DEC	SCORES,X	;dec max score
	BNE	SC2	;from 99 to zero
	LDA	#0	;99 points so
	STA	ENDGAM	;end the game
SC2	LDA	#$FF	;value to return
	STA	HITCLR	;clear collision
	RTS		;return
;
; Ship Graphics Rotation
; ----------------------
;
ROTOR	TXA		;move X to Acc
	PHA		;save X
	LDA	CLOCK	;get clock
	ROR	A	;test bit 0
	BCS	RT2	;bit=1? Yes.
	DEC	ROTATE	;rotation index
	BPL	RT1	;rotate<0? No.
	LDA	#2	;reset value for
	STA	ROTATE	;rotation index
RT1	LDX	ROTATE	;get index
	LDA	ROTMSK,X	;spinner graphic
	STA	SHIPS+12	;saucer section
	AND	#$3C	;mask for rocket
	STA	SHIPS+2	;rocket upper
	LDA	ROTMSK+1,X	;next seq
	AND	#$3C	;mask for rocket
	STA	SHIPS+3	;rocket lower
	LDA	CLOCK	;get clock again
	AND	#$0E	;missile mask
	TAX		;use as index
	LDA	MISIMA,X	;missile image
	STA	MIMAGE+1	;image buffer
	LDA	MISIMA+1,X	;missile pic+1
	STA	MIMAGE+2	;image buffer+1
RT2	PLA		;pull Acc
	TAX		;restore X
	RTS		;return
;
; Countdown Timer Handler
; -----------------------
;
TIMER	DEC	TRAM+24	;1/10 sec timer
	BPL	TMX	;time up? No.
	LDA	#5	;Yes. value to
	STA	TRAM+24	;reset timer
	LDA	SCLOCK	;tic sound clock
	BEQ	RT3	;tic done? Yes.
	DEC	SCLOCK	;dec tic clock
	JMP	RT4	;continue
;
RT3	STA	AUDC3	;tic sound off
RT4	DEC	TRAM+12	;1/10 sec displa
	DEC	TRAM+23	;1/10 sec cntr
	BPL	TMX	;1 sec done? No.
	LDA	#N7C+$C9	;value to reset
	STA	TRAM+12	;1/10 sec displa
	LDA	#9	;value to reset
	STA	TRAM+23	;1/10 sec cntr
	LDA	SCLOCK	;sound clock
	BNE	RT5	;in use? Yes.
	LDA	#$A4	;value for
	STA	AUDC3	;pure tone
	LDA	#$40	;value for
	STA	AUDF3	;medium freq
RT5	DEC	TRAM+10	;one's display
	DEC	TRAM+22	;one's counter
	BPL	TMX	;10 sec up? No.
	LDA	#N7C+$C9	;value to reset
	STA	TRAM+10	;one's display
	LDA	#9	;value to reset
	STA	TRAM+22	;one's counter
	DEC	TRAM+9	;ten's display
	DEC	TRAM+21	;ten's counter
	BPL	TMX	;minute up? No.
	LDA	#N7C+$C5	;value to reset
	STA	TRAM+9	;ten's display
	LDA	#5	;value to reset
	STA	TRAM+21	;ten's counter
	DEC	TRAM+7	;minute display
	DEC	TRAM+20	;minute counter
TMX	PHP		;save flags
	LDA	SCLOCK	;if score sound
	ORA	COUNTR	;or missile 0/1
	ORA	COUNTR+1	;active?
	BNE	TMXX	;Yes. skip next
	LDA	DEAD	;either ship 0
	AND	DEAD+1	;or ship 1
	BEQ	TMXX	;dead? Yes.
	LDA	MISSLE	;OR flags for
	ORA	MISSLE+1	;projectiles
	BEQ	TMXX	;any active? No.
	LDA	#$28	;projectile snd
	STA	AUDC3	;to hardware
	LDA	CLOCK	;60 cycle clock
	LSR	A	;make 30 cycles
	AND	#$07	;only 0..7
	ORA	#8	;8..15
	STA	AUDF3	;boomerang sound
TMXX	PLP		;restore flags
	RTS		;return
;
; Collision Handler
; -----------------
;
SMASH	LDA	M1PL	;missile 1 to
	AND	#1	;player 0 ship
	BNE	HITP0	;collision? Yes.
	LDA	P0PF	;player 0 to
	AND	#4	;playfield 2 or
	ORA	P0PL	;to any player
	BEQ	PLR1	;collision? No.
	LDA	TRIGN	;trigger option
	CMP	#1	;shield in use?
	BEQ	PLR1	;Yes. ship safe
HITP0	LDA	#0	;value for ship
	STA	DEAD	;being shot down
PLR1	LDA	M0PL	;missile 0 to
	AND	#2	;player 1 ship
	BNE	HITP1	;collision? Yes.
	LDA	P1PF	;player 1 to
	AND	#4	;playfield 2 or
	ORA	P1PL	;to any player
	BEQ	HITX	;collision? No.
	LDA	TRIGN+1	;trigger option
	CMP	#1	;shield in use
	BEQ	HITX	;Yes. ship safe
HITP1	LDA	#0	;value for ship
	STA	DEAD+1	;being shot down
HITX	RTS		;return
;
; Space Boomerang Handler
; -----------------------
;
MISFLY	LDA	MISSLE,X	;missile status
	BNE	HITX	;active? Yes.
	LDA	TRIGN,X	;trigger value
	CMP	#2	;shots enabled
	BEQ	MISF	;Yes. continue
	STA	TRIGS,X	;put shadow
	RTS		;return
;
; Set up Launch Coordinates
; -------------------------
;
MISF	CMP	TRIGS,X	;compare shadow
	BEQ	HITX	;same? Yes.
	STA	TRIGS,X	;put shadow
	STA	MISSLE,X	;enable missile
	CLC		;clear carry
	LDA	XPLR,X	;ship X coord
	ADC	#2	;get ship center
	STA	OLDCOL	;X plot coord
	STA	COLCRS,X	;shot current X
	LDA	YPLR,X	;ship Y coord
	STA	OLDROW	;Y plot coord
	INC	OLDROW	;ship top
	STA	ROWCRS,X	;shot current Y
	INC	ROWCRS,X	;plot coord
	TXA		;player index
	BEQ	MIS1	;player 0? Yes.
;
; Player 0 is target
; ------------------
;
	LDA	XPLR	;enemy X coord
	ADC	#2	;ship center
	STA	NEWCOL	;destination X
	LDA	YPLR	;enemy Y coord
	JMP	MIS2	;skip next
;
; Player 1 is target
; ------------------
;
MIS1	LDA	XPLR+1	;enemy X coord
	ADC	#2	;ship center
	STA	NEWCOL	;destination X
	LDA	YPLR+1	;enemy Y coord
MIS2	STA	NEWROW	;destination Y
	INC	NEWROW	;ship top
	LDA	#1	;init value for
	STA	ROWINC,X	;Y increment
	STA	COLINC,X	;X increment
	SEC		;set carry
	LDA	NEWROW	;Y to coord
	SBC	OLDROW	;Y from coord
	STA	DELTAR,X	;delta Y
	BCS	MIS3	;shot down? Yes.
	LDA	#$FF	;value = -1
	STA	ROWINC,X	;move up
	EOR	DELTAR,X	;get absolute
	STA	DELTAR,X	;value for
	INC	DELTAR,X	;delta Y
MIS3	SEC		;set carry
	LDA	NEWCOL	;X to coord
	SBC	OLDCOL	;X from coord
	STA	DELTAC,X	;delta X
	BCS	MIS4	;to right? Yes.
	LDA	#$FF	;value = -1
	STA	COLINC,X	;move left
	EOR	DELTAC,X	;get absolute
	STA	DELTAC,X	;value for
	INC	DELTAC,X	;delta X
MIS4	LDA	#0	;init value for
	STA	COLAC,X	;X accumulator
	STA	ROWAC,X	;Y accumulator
	LDA	DELTAC,X	;get delta X
	STA	ENDPT,X	;line length
	LDA	#$0F	;init value for
	STA	COUNTR,X	;draw iteration
	LDA	DELTAR,X	;get delta Y
	CMP	ENDPT,X	;bigger than
	BCC	MIS5	;delta X? No.
	STA	ENDPT,X	;store new value
	LSR	A	;delta Y / 2
	STA	COLAC,X	;X coord Acc
	RTS		;return
;
MIS5	LDA	ENDPT,X	;get delta X
	LSR	A	;divide by 2
	STA	ROWAC,X	;Y coord Acc
	RTS		;return
;
; Game Interrupt Service Routine
; ------------------------------
;
GISR	PHA		;save Acc
	JSR	SMASH	;test collisions
	JSR	ROTOR	;animate ships
	INC	CLOCK	;increment clock
	CLC		;clear carry
	LDA	UNIVS	;universe sound
	ADC	#$30	;change sound
	STA	UNIVS	;replace sound
	STA	AUDF2	;make sound
	LDA	ENDGAM	;game end flag
	BNE	GI7	;game over? No.
	JMP	GI99	;end it now!
;
; Ship Noise Generation
; ---------------------
;
GI7	LDA	#8	;medium grey
	STA	COLPF1	;set color
	TXA		;move X to Acc
	PHA		;save X
	LDX	#15	;neutral stick
	LDA	DEAD	;player 0 status
	BNE	GI70	;dead? No.
	STX	STICK	;stick to center
GI70	LDA	DEAD+1	;player 1 status
	BNE	GI71	;dead? No.
	STX	STICK+1	;stick to center
GI71	LDA	STICK	;check if either
	AND	STICK+1	;stick pushed by
	CMP	#15	;comparing w/15
	LDA	#$81	;rumble noise
	BCS	GI03	;both 15? Yes.
	LDA	TRIGN	;trigger opt 0
	ORA	TRIGN+1	;trigger opt 1
	CMP	#3	;warp speed test
	LDA	#$88	;loud warp sound
	BCS	GI03	;warp? Yes.
	LDA	#$84	;med engine roar
GI03	STA	AUDC4	;make engine snd
	LDA	#24	;warp frequency
	BCS	GI30	;warp? Yes.
	LDA	#32	;normal rockets
GI30	STA	AUDF4	;set frequency
	LDX	#0	;init value for
	STX	VDEL	;vertical delay
	INX		;make X = 1
	LDA	M0PL	;missile 0 to
	STA	M0PLS	;PL collisions
	LDA	M0PL+1	;missile 1 to
	STA	M0PLS+1	;PL collisions
	LDA	TRIGN	;trigger opt 0
	ORA	TRIGN+1	;trigger opt 1
	CMP	#1	;check shields
	BNE	MOVE2	;shields on? No.
	LDA	RANDOM	;random number
	AND	#$1F	;only 0..31
	ORA	#$20	;only 32..63
	STA	AUDF4	;shield sound
	LDA	#$A6	;value for
	STA	AUDC4	;shield volume
MOVE2	JSR	TRIGR	;read trigger
	LDA	DEAD,X	;player status
	BEQ	MOVEX	;dead? Yes.
	LDA	TRIGN,X	;trigger value
	CMP	#1	;shields in use?
	BEQ	MOVEX	;Yes. skip next
	JSR	MISFLY	;move missile
	LDA	CLOCK	;get clock value
	ROR	A	;bit 0 to carry
	BCC	MOVE2X	;even? Yes.
	LDA	TRIGN,X	;trigger value
	CMP	#3	;warp drive?
	BNE	MOVEX	;No. skip next
;
; Joystick Handler
; ----------------
;
MOVE2X	LSR	STICK,X	;check joystick
	BCS	MOVED	;stick up? No.
	DEC	YPLR,X	;move ship up
MOVED	LSR	STICK,X	;check joystick
	BCS	MOVEL	;stick down? No.
	INC	YPLR,X	;move ship down
MOVEL	LDA	SHIP	;get ship type
	BEQ	MOVEX	;U/D rocket? Yes.
	LSR	STICK,X	;check joystick
	BCS	MOVER	;stick left? No.
	DEC	XPLR,X	;move ship left
MOVER	LSR	STICK,X	;check joystick
	BCS	MOVEX	;stick right? No.
	INC	XPLR,X	;move ship right
MOVEX	LDA	XPLR,X	;ship X coord
	CMP	#$30	;past left
	BCS	MOVEX3	;border? No.
	LDA	#$30	;set to border
MOVEX3	CMP	#$C8	;past right
	BCC	MOVEX4	;border? No.
	LDA	#$C7	;set to border
MOVEX4	STA	XPLR,X	;save X coord
	STA	HPOSP0,X	;position ship
	STY	TEMP+3	;save Y
	LDA	DEAD,X	;ship status
	BMI	MOVX4	;alive? Yes.
	LDA	CLOCK	;get clock value
	ROR	A	;test bit 0
	BCS	MOV4	;clock odd? Yes.
	ASL	A	;restore clock
	AND	#$F6	;max 7 brightness
	STA	PCOLR0,X	;make ship color
	LDA	SCLOCK	;score snd count
	BNE	MOV4	;sound on? Yes.
	LDA	CLOCK	;get clock value
	AND	#$07	;make 0..7
	ORA	#$C8	;make $C8..$CF
	STA	AUDC3	;sound volume
	LDA	RANDOM	;random number
	AND	#$1F	;make 0..31
	ORA	#$20	;make 32..63
	STA	AUDF3	;weird sound
MOV4	INC	YPLR,X	;move ship down
MOVX4	LDA	YPLR,X	;ship Y coord
	BNE	MOVEX6	;screen top? No.
	JSR	SCORE	;increment score
MOVEX6	CMP	#192	;screen bottom?
	BCC	MOVEX5	;No. skip next
	LDA	DEAD,X	;ship status
	BNE	MOVX6	;ship dead? No.
	LDA	XPLR,X	;ship X coord
	CMP	XSTRT,X	;compare w/start
	BEQ	MOVX6A	;equal? Yes.
	INC	XPLR,X	;move ship right
	BCC	MOVX6	;ok? Yes. else
	DEC	XPLR,X	;move ship left
	DEC	XPLR,X	;move ship left
	BNE	MOVX6	;skip next
MOVX6A	LDA	#$FF	;value for
	STA	DEAD,X	;working ship
	STA	HITCLR	;clr collisions
	LDA	PCOLRS,X	;value for
	STA	PCOLR0,X	;ship color
	LDA	SCLOCK	;score snd clock
	BNE	MOVX6	;sound on? Yes.
	STA	AUDC3	;zero sound
MOVX6	LDA	#191	;value for
MOVEX5	STA	YPLR,X	;init Y coord
	CPX	#1	;ship 1?
	ROR	A	;carry=1 if Yes.
	STA	GRPX	;PM graphic pntr
	BCC	MOVEX7	;coord even? Yes.
	LDA	VDEL	;vertical delay
	ORA	VDMSK,X	;delay mask
	STA	VDEL	;new V.delay
MOVEX7	TXA		;move X to Acc
	PHA		;save X
	CLC		;clear carry
	LDA	DEAD,X	;ship status
	BEQ	MOVX7A	;ship dead? Yes.
	LDA	RANDOM	;random number
	AND	#$0F	;make 0..15
	ORA	PCOLRS,X	;add ship color
	STA	PCOLR0,X	;new ship color
	LDA	TRIGN,X	;check trigger
	CMP	#1	;for shields
	SEC		;set carry
	BEQ	MOVX7A	;shields? Yes.
	CLC		;clear carry
	LDA	PCOLRS,X	;ship color
	STA	PCOLR0,X	;set color
MOVX7A	LDY	#9	;do 10 bytes
	LDX	#9	;rocket offset
	LDA	SHIP	;get ship type
	BEQ	MOVEXD	;rocket? Yes.
	LDX	#18	;saucer offset
MOVEXD	LDA	SHIPS,X	;ship graphic
	BCC	MVXD	;shields on? No.
	AND	RANDOM	;shield effect
MVXD	STA	(GRPX),Y	;put ship
	DEX		;graphic index
	DEY		;PM index
	BPL	MOVEXD	;done? No.
	PLA		;pull X
	TAX		;move Acc to X
	LDA	MISSLE,X	;missile status
	BEQ	MVXDM	;active? No.
	LDY	#1	;missile launcher
	LDA	#0	;no shot graphic
	STA	(GRPX),Y	;put ship
MVXDM	LDY	TEMP+3	;restore Y index
	DEX		;next ship
	BMI	MOVEX0	;done? Yes.
	JMP	MOVE2	;No. continue
MOVEX0	LDA	VDEL	;V.delay shadow
	STA	VDELAY	;vertical delay
	LDA	ENDGAM	;game status
	BEQ	MOVXE2	;game over? Yes.
	JSR	TIMER	;decrement time
	BPL	GI9	;time up? No.
	LDA	#N7C+$C0	;zero graphic
	STA	TRAM+7	;minutes display
	STA	TRAM+9	;10 sec display
	STA	TRAM+10	;seconds display
	STA	TRAM+12	;.1 sec display
MOVXE2	LDA	#121	;goto attract
	STA	ATRACT	;in 30 seconds
	LDA	#0	;get zero
	STA	ENDGAM	;end game
	STA	AUDC3	;sound off
	STA	AUDC4	;sound off
;
; Comet Mover Routine
; -------------------
;
GI9	PLA		;pull X
	TAX		;move Acc to X
GI99	LDA	HINC	;comet H speed
	AND	CLOCK	;mask with clock
	BEQ	GI91	;move comet? Yes.
GI90	PLA		;restore Acc
	RTI		;return
GI91	LDA	COMETF	;comet status
	BEQ	GI90	;active? No.
	TYA		;move Y to Acc
	PHA		;save Y
	TXA		;move X to Acc
	PHA		;save X
	LDA	HPOS	;comet H coord
	AND	VINC	;and w/V speed
	BNE	GI5	;move vert? No.
	LDA	VPOS	;comet V coord
	CLC		;clear carry
	ADC	VDIR	;add V direction
	AND	#$7F	;make 0..127 only
	STA	VPOS	;replace V coord
;
; Draw Comet Graphics
; -------------------
;
GI5	LDY	#13	;do 14 bytes
	LDX	VPOS	;comet V coord
GI0	LDA	RANDOM	;random number
	AND	COMETM,Y	;mask w/comet
	STA	PM2,X	;put player 2
	LDA	RANDOM	;random number
	AND	COMETM,Y	;do same thing
	STA	PM3,X	;put player 3
	INX		;inc player addr
	TXA		;move X to Acc
	AND	#$7F	;make 0..127
	TAX		;replace X
	DEY		;dec byte count
	BPL	GI0	;pic done? No.
	LDA	RANDOM	;random number
	AND	#$F0	;color only
	ORA	#$04	;brightness 4
	STA	PCOLR2	;player 2 color
	LDA	RANDOM	;random number
	AND	#$F0	;color only
	ORA	#$08	;brightness 8
	STA	PCOLR3	;player 3 color
	CLC		;clear carry
	LDA	HPOS	;comet H coord
	ADC	HDIR	;add H direction
	STA	HPOS	;new H coord
	STA	HPOSP2	;player 2 H pos
	STA	HPOSP3	;player 3 H pos
	STA	COMETF	;non 0 = enabled
;
; Generate Comet Sound
; --------------------
;
	INC	CSOUND	;comet snd freq
	LDA	ENDGAM	;game status
	BEQ	GIS	;game over? Yes.
	LDA	CSOUND	;comet snd freq
	CMP	#125	;value < 125
	BCS	GI2	;No. skip next
	LSR	A	;freq/2
	LSR	A	;freq/4
	STA	AUDF1	;set frequency
	CMP	#$18	;past peak?
	BCC	GI2	;No. skip next
	EOR	#$9F	;reverse volume
GIS	STA	AUDC1	;set volume
GI2	PLA		;pull X
	TAX		;move Acc to X
	PLA		;pull Y
	TAY		;move Acc to Y
	PLA		;pull Acc
	RTI		;return
;
; Joystick Trigger Processor
; --------------------------
;
TRIGR	LDA	STRIG,X	;get trigger
	LSR	A	;move to carry
	BCS	TRIGX	;pressed? No.
	LDA	TRIG	;trigger option
TRIGX	AND	DEAD,X	;ship status
	CMP	TRIGN,X	;same as last?
	BEQ	TRIG2	;Yes. skip next
	STA	HITCLR	;clr collisions
TRIG2	STA	TRIGN,X	;trig option
;
; Missile Mover Routine
; ---------------------
;
	LDA	MISSLE,X	;missile status
	BEQ	MMX	;fired? No.
	LDA	ROWCRS,X	;missile Y coord
	BNE	MM0	;zero? No.
	STA	MISSLE,X	;disable missile
MMX	RTS		;return
;
MM0	CLC		;clear carry
	LDA	DELTAR,X	;add delta Y
	ADC	ROWAC,X	;to Y Acc
	STA	ROWAC,X	;new Y Acc
	CMP	ENDPT,X	;cmp w/endpoint
	BCC	MM1	;change Y? No.
	SBC	ENDPT,X	;sub endpoint
	STA	ROWAC,X	;new Y Acc value
	CLC		;clear carry
	LDA	ROWINC,X	;add shot Y inc
	ADC	ROWCRS,X	;to Y coord
	STA	ROWCRS,X	;new Y coord
MM1	CLC		;clear carry
	LDA	DELTAC,X	;add delta X
	ADC	COLAC,X	;to X Acc
	STA	COLAC,X	;new X Acc
	CMP	ENDPT,X	;cmp w/endpoint
	BCC	MMP	;change X? No.
	SBC	ENDPT,X	;sub endpoint
	STA	COLAC,X	;new X Acc value
	CLC		;clear carry
	LDA	COLINC,X	;add shot X inc
	ADC	COLCRS,X	;to X coord
	STA	COLCRS,X	;new X coord
MMP	LDA	COUNTR,X	;iteration cnt
	BEQ	MMP1	;cnt done? Yes.
	LSR	A	;cnt div 2
	ORA	#$88	;weird sound
	STA	AUDC3	;make sound FX
	LDA	COUNTR,X	;get cnt again
	EOR	#$0F	;very weird FX
	ASL	A	;times 2
	ASL	A	;times 4
	ASL	A	;times 8
	STA	AUDF3	;set frequency
	DEC	COUNTR,X	;decrement cnt
MMP1	LDA	COLCRS,X	;shot X coord
	STA	HPOSM0,X	;PM horiz pos
	LDA	ROWCRS,X	;shot Y coord
	LSR	A	;2 line res
	BCC	MM00	;even line? Yes.
	PHA		;save PM Y coord
	LDA	VDEL	;VDELAY shadow
	ORA	VDMSK+2,X	;odd scan line
	STA	VDEL	;new shadow val
	PLA		;restore Y coord
MM00	ORA	# <PMM	;missiles start
	STA	GRPM	;set pointer lo
	LDA	M0PLS,X	;test if shot hit
	AND	MCMSK,X	;comet or other
	BNE	MME	;ship? Yes.
	LDA	COLCRS,X	;shot Y coord
	BEQ	MME	;off scrn? Yes.
	TYA		;move Y to Acc
	PHA		;save Y
	LDY	#3	;4 pic bytes
MM01	LDA	(GRPM),Y	;current pic
	AND	MISMSK,X	;erase old pic
	STA	TEMPM	;save temp
	LDA	MIMAGE,Y	;new pic data
	CPX	#1	;player 1 shot?
	BNE	MM03	;No. skip next
	ASL	A	;shift byte two
	ASL	A	;bits to left
MM03	ORA	TEMPM	;add saved data
	STA	(GRPM),Y	;new shot pic
	DEY		;dec pic index
	BPL	MM01	;pic done? No.
	PLA		;restore Y
	TAY		;move Acc to Y
	RTS		;return
;
; Erase Current Shot
; ------------------
;
MME	LDA	#0	;get zero value
	STA	MISSLE,X	;kill shot
	TYA		;move Y to Acc
	PHA		;save Y
	LDY	#3	;do 4 bytes
MME2	LDA	(GRPM),Y	;old shot pic
	AND	MISMSK,X	;erase shot
	STA	(GRPM),Y	;replace pic
	DEY		;next byte
	BPL	MME2	;done? No.
	LDA	M0PLS,X	;cmp collisions
	AND	MCMSK,X	;w/all but own
	BEQ	MME3	;score point? No.
	JSR	SCOREM	;inc score
MME3	PLA		;pull Y
	TAY		;move Acc to Y
	RTS		;return
;
; Initialize Playfield
; --------------------
;
PLAYGM	JSR	AUDOFF	;turn snd off
	STA	HITCLR	;clr collisions
	LDA	#$FF	;value for
	STA	DEAD	;ship 1 alive
	STA	DEAD+1	;ship 2 alive
	LDA	#$40	;value to
	STA	NMIEN	;enable VBI's
	LDA	#PAGES*2	;pages to zero
	STA	TEMP+2	;save in counter
	LDA	# <DRAM	;display addr lo
	STA	GRPAGE	;display pntr lo
	LDA	# >DRAM	;display addr hi
	STA	GRPAGE+1	;displa pntr hi
	LDA	# >PMM	;PM addr hi
	STA	GRPM+1	;PM pointer hi
	LDA	#$21	;value for
	STA	GPRIOR	;mulit-color PL
	STA	AUDF4	;engine sound
	LDA	#1	;value for
	STA	SIZEP2	;double width
	STA	SIZEP3	;comets enabled
	STA	ENDGAM	;game on
	LDA	#99	;max score value
	STA	SCORES	;player 1
	STA	SCORES+1	;player 2
	LDX	#24	;move 25 bytes
PLA3	LDA	TRAMI,X	;from TRAMI
	STA	TRAM,X	;to TRAM
	DEX		;dec index
	BPL	PLA3	;done? No.
	LDA	# >PM0	;player addr hi
	STA	GRPX+1	;pntr hi byte
	JSR	SCRCLR	;clear inverse
	LDA	#$05	;value for
	STA	SIZEM	;missile sizes
	LDA	#0	;get zero
	STA	HPOS	;comet X coord
	STA	FLASHF	;inverse flag
	STA	COMETF	;comet flag
	STA	ATRACT	;attract mode
	STA	SCLOCK	;score sound
	STA	MISSLE	;missile 0 flag
	STA	MISSLE+1	;missile 1 flag
	TAY		;zero Y index
PLA0	STA	(GRPAGE),Y	;scrn byte=0
	INY		;inc Y index
	BNE	PLA0	;page done? No.
	INC	GRPAGE+1	;do next page
	DEC	TEMP+2	;page count
	BNE	PLA0	;all done? No.
	LDA	#191	;init Y coord of
	STA	YPLR	;ship 1
	STA	YPLR+1	;ship 2
	TYA		;get zero
PLA1	STA	PMM,Y	;zero missiles
	STA	PM0,Y	;player 0+1
	STA	PM2,Y	;player 2+3
	INY		;next byte
	BNE	PLA1	;page done? No.
	JSR	RANFIL	;put asteroids
	LDX	#1	;do 2 players
PLA11	LDA	XSTRT,X	;ship X start
	STA	HPOSP0,X	;set hardware
	STA	XPLR,X	;and shadow
	DEX		;next ship
	BPL	PLA11	;done? No.
	INX		;make it a one
	STX	COLOR2	;black
	STX	TEMP+1	;zero temporary
	LDA	#$2E	;value for
	STA	SDMCTL	;P/M enable
	STA	COLOR1	;bright orange
	LDA	# >PM	;set up P/M
	STA	PMBASE	;base address
	LDA	#3	;value to
	STA	GRACTL	;enable P/M
	LDA	#$C4	;green for
	STA	PCOLR0	;first ship
	LDA	#$34	;red/orange for
	STA	PCOLR1	;second ship
	LDA	# <GISR	;DLI addr lo
	STA	VDSLST	;DLI pntr lo
	LDA	# >GISR	;DLI addr hi
	STA	VDSLST+1	;DLI pntr hi
	LDA	# <DISPG	;DL addr lo
	STA	SDLSTL	;DL pntr lo
	LDA	# >DISPG	;DL addr hi
	STA	SDLSTL+1	;DL pntr hi
	LDA	#$C0	;value to
	STA	NMIEN	;enable DLI's
;
; Game Loops Here, Loops Here...
; ------------------------------
;
ASHIFT	JSR	LDGRRT	;set up pointers
	ROR	TEMP+1	;get saved carry
	BCC	ART0	;bit #1=0? Yes.
	LDA	(GRPAGE),Y	;get byte
	ORA	#$80	;set high bit
	CLC		;clear carry
	BCC	ART2	;skip next
ART0	LDA	(GRPAGE),Y	;get byte
ART2	ROR	A	;rotate right
	STA	(GRPAGE),Y	;replace byte
	INY		;next byte
	BNE	ART0	;page done? No.
	INC	GRPAGE+1	;inc page addr
	DEC	TEMP+2	;dec page count
	BNE	ART0	;pages done? No.
	LDA	#PAGES	;pages to rotate
	STA	TEMP+2	;put someplace
	LDA	# <ASTL	;area to shift
	STA	GRPAGE	;gr pntr lo
	LDA	#PAGES-1+>ASTL	;hi addr
	STA	GRPAGE+1	;gr pntr hi
ALF1	DEY		;dec Y index
	LDA	(GRPAGE),Y	;get graphic
	ROL	A	;move to left
	STA	(GRPAGE),Y	;replace byte
	TYA		;test Y index
	BNE	ALF1	;Zero? No.
	DEC	GRPAGE+1	;dec hi addr
	DEC	TEMP+2	;dec page count
	BNE	ALF1	;pages done? No.
	ROL	TEMP+1	;save carry bit
	STA	GRP1	;zero low bytes
	STA	GRP2	;of these three
	STA	GRPAGE	;page zero pntrs
	LDA	# >ASTL	;scrn lf addr hi
	STA	GRP1+1	;scrn fl pntr hi
	LDA	# >ASTR	;scrn rt addr hi
	STA	GRP2+1	;scrn rt pntr hi
	LDA	# >DRAM	;display addr hi
	STA	GRPAGE+1	;displa pntr hi
	LDA	# <DRAM-20	;w/offset lo
	STA	GRP20P	;offset pntr lo
	LDA	# >DRAM-20	;w/offset hi
	STA	GRP20P+1	;offset pntr hi
	LDX	#76	;76 scan lines
ORA0	LDY	#19	;do 20 bytes
ORA1	LDA	(GRP1),Y	;to left field
	ORA	(GRP2),Y	;to right field
	STA	(GRPAGE),Y	;lf half scrn
	STA	(GRP20P),Y	;rt half scrn
	DEY		;dec index
	BPL	ORA1	;line done? No.
	LDA	GRP1	;lf field lo
	CLC		;clear carry
	ADC	#20	;20 byte offset
	STA	GRP1	;do next line of
	STA	GRP2	;asteroid fields
	BCC	ORA2	;overflow? No.
	INC	GRP1+1	;inc left, right
	INC	GRP2+1	;asteroid pntrs
ORA2	CLC		;clear carry
	LDA	GRPAGE	;graphic addr lo
	ADC	#40	;line offset
	STA	GRPAGE	;new lo addr
	BCC	ORA3	;overflow? No.
	INC	GRPAGE+1	;inc hi addr
ORA3	CLC		;clear carry
	LDA	GRP20P	;gr addr2 lo
	ADC	#40	;line offset
	STA	GRP20P	;new lo addr2
	BCC	ORA4	;overflow? No.
	INC	GRP20P+1	;inc high addr2
ORA4	DEX		;decrement index
	BNE	ORA0	;done? No.
	JSR	CONC	;check console
	BCC	FLASH	;OPTION key? No.
	JMP	STOPTS	;run option menu
;
; Inverse Universe Handler
; ------------------------
;
FLASH	ROR	A	;START -> carry
	BCC	FL0	;START pressed?
	JMP	PLAYGM	;Yes. restart
FL0	LDA	UNIV	;univ flag
	BEQ	COMET	;inverse? No.
	LDA	FLASHF	;flash flag
	BEQ	TRYFLA	;flash on? No.
	JSR	REVSCR	;flash screen
	DEC	FLASHC	;decrement count
	LDA	ENDGAM	;game over flag
	BEQ	FL1	;game over? Yes.
	LDA	FLASHC	;flash count
	LSR	A	;make volume
	ORA	#$A0	;make pure tone
FL1	STA	AUDC2	;universe sound
	LDA	FLASHC	;flash count
	BEQ	FLAEND	;done? Yes.
	ASL	A	;times 2
	ASL	A	;times 4
	ASL	A	;times 8
	EOR	#$FF	;flip bits
	STA	UNIVS	;save univ sound
	BNE	COMET	;continue
;
SCRCLR	LDA	REVF	;reverse flag
	ROR	A	;check bit 0
	BCC	SC9	;zero? Yes.
REVSCR	LDX	#4	;do colors 0..4
REV0	LDA	#$0F	;flip brightness
	EOR	COLOR0,X	;of colors
	STA	COLOR0,X	;replace values
	DEX		;decrement index
	BPL	REV0	;done? No.
	DEC	REVF	;clear flag
SC9	RTS		;return
;
TRYFLA	LDA	RANDOM	;random number
	AND	#$3F	;make 0..63
	BNE	COMET	;do flash? No.
	JSR	REVSCR	;Yes. flash scrn
	LDA	#$1F	;value for
	STA	FLASHC	;flash count
	STA	FLASHF	;flash flag
	BNE	COMET	;continue
;
FLAEND	STA	FLASHF	;flash univ off
	STA	AUDC2	;flash sound off
;
; Comet Mover
; -----------
;
COMET	LDA	COME	;comet flag
	BEQ	COMETX	;comets? No.
	LDA	COMETF	;comet on flag
	BEQ	TRYCOM	;on? No.
COMETX	JMP	ASHIFT	;continue
;
TRYCOM	LDA	RANDOM	;random number
	AND	#$3F	;make 0..63
	BNE	COMETX	;enable? No.
	STA	HINC	;comet H speed=0
	TAX		;initialize X=0
TRY0	STA	PM2,X	;clr players 2+3
	DEX		;decrement index
	BNE	TRY0	;done? No.
	STA	HPOSP2	;zero players 23
	STA	HPOSP3	;horizontal pos
	STA	CSOUND	;zero comet snd
TRY5	LDA	RANDOM	;random number
	AND	#3	;make 0..3
	CMP	#3	;allow only 0..2
	BCS	TRY5	;3? Yes, repeat
	STA	VDIR	;save 0..2
	DEC	VDIR	;make -1..1
	LDA	RANDOM	;random number
	AND	#3	;make 0..3
	TAX		;use as index
	LDA	#$1F	;init increment
TRY6	LSR	A	;divide by 2
	DEX		;decrement index
	BPL	TRY6	;done? No.
	STA	VINC	;vert increment
	LDA	ENDGAM	;end game flag
	BEQ	TRY7	;game over? Yes.
	LDA	#$88	;No. make sound
TRY7	STA	AUDC1	;comet sound
	LDA	RANDOM	;random number
	AND	#$3F	;make 0..63
	ADC	#16	;sorta 16..79
	STA	VPOS	;vert start pos
	LDX	#$FE	;value -2
	STX	COMETF	;comet on flag
	LDA	RANDOM	;random number
	BPL	TRY1	;flip a coin!
	LDX	#$02	;value +2
TRY1	STX	HDIR	;horiz direction
	LDA	RANDOM	;random number
	BPL	COMETX	;another coin!
	INC	HINC	;change speed
	JMP	ASHIFT	;continue
;
; Relocate program
; ----------------
;
RELOC	LDA	#$20	;$2000 load addr
	STA	GRP1+1	;from pntr hi
	LDA	#$10	;to $1000 addr
	STA	GRP2+1	;to pntr hi
	TAX		;move 16 pages
	LDA	#0	;value for
	STA	GRP1	;from pntr lo
	STA	GRP2	;to pntr lo
	TAY		;zero index
REL0	LDA	(GRP1),Y	;from byte
	STA	(GRP2),Y	;to byte
	DEY		;dec index
	BNE	REL0	;page done? No.
	INC	GRP1+1	;inc from hi
	INC	GRP2+1	;inc to hi
	DEX		;page count
	BNE	REL0	;done? No.
	JMP	RIS	;run program
;
	*=	$02E0	;RUN address
	.WORD	RELOC+$1000
;
	.END
