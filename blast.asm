;BLAST!
;
	*=	$2000
;
CHARSET
	.BYTE	$00,$00,$00,$00,$00,$00,$00,$00
	.BYTE	$00,$1C,$1C,$1C,$1C,$00,$1C,$1C
	.BYTE	$00,$00,$3F,$3F,$3F,$3F,$3F,$3F
	.BYTE	$00,$00,$F8,$FC,$3E,$3F,$3F,$3E
	.BYTE	$3F,$3F,$3F,$3F,$3F,$3F,$3F,$3F
	.BYTE	$FC,$FC,$3E,$3F,$3F,$3E,$FC,$F8
	.BYTE	$00,$00,$FF,$FF,$FF,$FF,$FF,$FF
	.BYTE	$00,$00,$03,$07,$0F,$1F,$3F,$3F
	.BYTE	$00,$00,$F0,$F8,$FC,$FE,$3F,$3F
	.BYTE	$FF,$FF,$3F,$3F,$3F,$3F,$3F,$3F
	.BYTE	$00,$00,$0F,$1F,$3C,$3C,$1F,$0F
	.BYTE	$00,$00,$FF,$FF,$00,$00,$C0,$F0
	.BYTE	$00,$00,$0F,$0F,$0F,$0F,$0F,$0F
	.BYTE	$00,$00,$3F,$3F,$0F,$0F,$0F,$0F
	.BYTE	$00,$00,$FC,$FC,$F0,$F0,$F0,$F0
	.BYTE	$00,$00,$F0,$F0,$F0,$F0,$F0,$F0
	.BYTE	$00,$7F,$63,$63,$63,$67,$67,$7F
	.BYTE	$00,$1C,$0C,$0C,$0C,$1E,$1E,$1E
	.BYTE	$00,$7F,$03,$03,$7F,$60,$60,$7F
	.BYTE	$00,$7E,$06,$06,$7F,$07,$07,$7F
	.BYTE	$00,$70,$70,$70,$70,$77,$7F,$07
	.BYTE	$00,$7F,$60,$60,$7F,$07,$07,$7F
	.BYTE	$00,$7E,$66,$60,$7F,$63,$63,$7F
	.BYTE	$00,$7F,$67,$07,$0E,$1C,$1C,$1C
	.BYTE	$00,$3E,$36,$36,$7F,$77,$77,$7F
	.BYTE	$00,$7F,$63,$63,$7F,$07,$07,$07
	.BYTE	$00,$1C,$1C,$1C,$00,$1C,$1C,$1C
	.BYTE	$FC,$FE,$FF,$FF,$FF,$FF,$FE,$FC
	.BYTE	$0F,$0F,$00,$00,$0F,$0F,$0F,$0F
	.BYTE	$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F
	.BYTE	$F0,$F0,$F0,$F0,$F0,$F0,$F0,$F0
	.BYTE	$F0,$F0,$00,$00,$F0,$F0,$F0,$F0
	.BYTE	$00,$00,$08,$1C,$14,$55,$77,$5D
	.BYTE	$00,$3E,$36,$36,$7F,$77,$77,$77
	.BYTE	$00,$7E,$66,$66,$7F,$73,$73,$7F
	.BYTE	$00,$7F,$67,$60,$60,$60,$63,$7F
	.BYTE	$00,$7E,$63,$63,$73,$73,$73,$7E
	.BYTE	$00,$7F,$60,$60,$7F,$70,$70,$7F
	.BYTE	$00,$7F,$60,$60,$7F,$70,$70,$70
	.BYTE	$00,$7F,$63,$60,$70,$77,$73,$7F
	.BYTE	$00,$36,$36,$36,$7F,$77,$77,$77
	.BYTE	$00,$18,$18,$18,$1C,$1C,$1C,$1C
	.BYTE	$00,$03,$03,$03,$07,$67,$67,$7F
	.BYTE	$00,$33,$33,$33,$7C,$73,$73,$73
	.BYTE	$00,$30,$30,$30,$70,$70,$70,$7F
	.BYTE	$00,$7F,$4B,$4B,$6B,$6B,$6B,$6B
	.BYTE	$00,$73,$7B,$6F,$77,$77,$77,$77
	.BYTE	$00,$7F,$63,$63,$67,$67,$67,$7F
	.BYTE	$00,$7F,$63,$63,$7F,$70,$70,$70
	.BYTE	$00,$7F,$63,$63,$63,$63,$6F,$7C
	.BYTE	$00,$7E,$66,$66,$7F,$73,$73,$73
	.BYTE	$00,$7F,$60,$60,$7F,$03,$03,$7F
	.BYTE	$00,$7F,$1F,$1C,$1C,$1C,$1C,$1C
	.BYTE	$00,$63,$63,$63,$73,$73,$73,$7F
	.BYTE	$00,$63,$63,$63,$77,$76,$76,$7E
	.BYTE	$00,$43,$43,$43,$6B,$6B,$6B,$7F
	.BYTE	$00,$67,$67,$67,$3C,$73,$73,$73
	.BYTE	$00,$63,$63,$63,$7F,$1C,$1C,$1C
	.BYTE	$00,$7F,$73,$03,$7F,$70,$73,$7F
	.BYTE	$00,$1E,$18,$18,$18,$18,$1E,$00
	.BYTE	$00,$40,$60,$30,$18,$0C,$06,$00
	.BYTE	$00,$78,$18,$18,$18,$18,$78,$00
	.BYTE	$00,$08,$1C,$36,$63,$00,$00,$00
	.BYTE	$00,$00,$00,$00,$00,$00,$FF,$00
;
; Zero page equates
;
ADDER	=	$80
PTR	=	$82
EXPCOUNT	=	$89
ALCOUNT	=	$8A
SHIPX	=	$8B
MOTHERX	=	$8C
MOTHERDX	=	$8D
FORCEY	=	$8E
ROUND	=	$8F
XTAB	=	$90
YTAB	=	$9C
DXTAB	=	$A8
DYTAB	=	$B4
DSTAB	=	$C0	;STATUS
;
; OS equates
;
STRIG0	=	$0284
HPOSP0	=	$D000
M0PF	=	$D000
P0PF	=	$D004
HITCLR	=	$D01E
AUDF1	=	$D200	;Force field
AUDC1	=	$D201
AUDF2	=	$D202	;Laser
AUDC2	=	$D203
AUDF3	=	$D204	;Monster death
AUDC3	=	$D205
AUDF4	=	$D206	;Needle falling
AUDC4	=	$D207
RANDOM	=	$D20A
;
SCREEN	=	$1000
;
; game screen dl
;
MAINDL
	.BYTE	$70,$50,$4D
	.WORD	SCREEN
	.BYTE	$0D,$0D,$0D
	.BYTE	$0D,$0D,$0D,$0D
	.BYTE	$0D,$0D,$0D,$0D
	.BYTE	$0D,$0D,$0D,$0D
	.BYTE	$0D,$0D,$0D,$0D
	.BYTE	$0D,$0D,$0D,$0D
	.BYTE	$0D,$0D,$0D,$0D
	.BYTE	$0D,$0D,$0D,$0D
	.BYTE	$0D,$0D,$0D,$0D
	.BYTE	$0D,$0D,$0D,$0D
	.BYTE	$0D,$0D,$0D,$0D
	.BYTE	$0D,$0D,$0D,$0D
	.BYTE	$0D,$0D,$0D,$0D
	.BYTE	$0D,$0D,$0D,$0D
	.BYTE	$0D,$0D,$0D,$0D
	.BYTE	$0D,$0D,$0D,$0D
	.BYTE	$0D,$0D,$0D,$0D
	.BYTE	$0D,$0D,$0D,$0D
	.BYTE	$0D,$0D,$0D,$0D
	.BYTE	$0D,$0D,$0D,$0D
	.BYTE	$0D,$0D,$0D,$0D
	.BYTE	$0D,$0D,$0D,$0D
	.BYTE	$0D,$0D,$8D,0
	.BYTE	$47
	.WORD	SCORELN
	.BYTE	$41
	.WORD	MAINDL
;
; "GAME OVER" display list
;
GODL
	.BYTE	$70,$70,$70,$70
	.BYTE	$70,$70,$70,$70
	.BYTE	$70,$70,$70,$70
	.BYTE	$47
	.WORD	GOLN
	.BYTE	$41
	.WORD	GODL
;
; Title page dl
;
TITLEDL
	.BYTE	$70,$70,$F0
	.BYTE	$47
	.WORD	TITLEPG-20
	.BYTE	$07,$70,$06,$70
	.BYTE	$06,$70,$70,$70
	.BYTE	$70,$70,$07,$70
	.BYTE	$70,$07,$70
	.BYTE	$70,$07,$41
	.WORD	TITLEDL
;
; Score line
; (at bottom, in graphics 2)
; Ships at +7
; score at +17
;
SCORELN
	.SBYTE	"BLAST! @@  SCORE:000"
;
; Game over
;
GOLN	.SBYTE	"      GAME OVER     "
;
; Prelim. title page
; Last at +46, high at +55
; Speed at +72, skill at +92
;
	.BYTE	0,0,0,0,2,3,2,0,7,8,10,11,13,14,12,15,0,0,0,0
TITLEPG	.BYTE	0,0,0,0,4,5,4,6,4,9,2,27,29,30,28,31,0,0,0,0
	.SBYTE	"  BY STEVEN GRIMM   "
	.SBYTE	" LAST:000 HIGH:000  "
	.SBYTE	"     option slow    "
	.SBYTE	"     select easy    "
	.SBYTE	"press start to begin"
;
; Y tables for bitmap routine
;
TABLO
	.BYTE	0,40,80,120,160,200,240
	.BYTE	24,64,104,144,184,224
	.BYTE	8,48,88,128,168,208,248
	.BYTE	32,72,112,152,192,232
	.BYTE	16,56,96,136,176,216
	.BYTE	0,40,80,120,160,200,240
	.BYTE	24,64,104,144,184,224
	.BYTE	8,48,88,128,168,208,248
	.BYTE	32,72,112,152,192,232
	.BYTE	16,56,96,136,176,216
	.BYTE	0,40,80,120,160,200,240
	.BYTE	24,64,104,144,184,224
	.BYTE	8,48,88,128,168,208,248
	.BYTE	32,72,112,152,192,232
	.BYTE	16,56,96,136,176,216
TABHI
	.BYTE	0,0,0,0,0,0,0
	.BYTE	1,1,1,1,1,1
	.BYTE	2,2,2,2,2,2,2
	.BYTE	3,3,3,3,3,3
	.BYTE	4,4,4,4,4,4
	.BYTE	5,5,5,5,5,5,5
	.BYTE	6,6,6,6,6,6
	.BYTE	7,7,7,7,7,7,7
	.BYTE	8,8,8,8,8,8
	.BYTE	9,9,9,9,9,9
	.BYTE	10,10,10,10,10,10,10
	.BYTE	11,11,11,11,11,11
	.BYTE	12,12,12,12,12,12,12
	.BYTE	13,13,13,13,13,13
	.BYTE	14,14,14,14,14,14
WIDTH	=	$84
;
; Bitmap routine for Atari
;
; Enter:
; .x,.y screen coords to plot at
; PTR   pointer to bitmap:
;       height
;       width
;       pointer to shift 0
;       pointer to shift 1
;       pointer to shift 2
;       pointer to shift 3
;       start of data
;
PLOTMAP
	TXA
	LSR	A
	LSR	A
	CLC
	ADC	TABLO,Y
	STA	ADDER
	LDA	TABHI,Y
	ADC	#>SCREEN
	STA	ADDER+1
	TXA
	AND	#3
	ASL	A
	ADC	#2
	PHA
	LDY	#0
	LDA	(PTR),Y
	TAX
	INY
	LDA	(PTR),Y
	STA	WIDTH
	PLA
	TAY
	LDA	(PTR),Y
	PHA
	INY
	LDA	(PTR),Y
	STA	PTR+1
	PLA
	STA	PTR
	CLV
	BVC	?PM1.5
?PM1	LDA	ADDER
	CLC
	ADC	#40
	STA	ADDER
	BCC	?PM1.5
	INC	ADDER+1
?PM1.5	LDY	#0
?PM2	LDA	(PTR),Y
	STA	(ADDER),Y
	INY
	CPY	WIDTH
	BCC	?PM2
	TYA
	CLC
	ADC	PTR
	STA	PTR
	BCC	?PM3
	INC	PTR+1
?PM3	DEX
	BNE	?PM1
	RTS
;
; Erase bitmap - cheating
; method
;
ERASEBM	LDA	?PM2
	PHA
	LDA	?PM2+1
	PHA
	LDA	#$A9	;lda imm
	STA	?PM2
	LDA	#0
	STA	?PM2+1
	JSR	PLOTMAP
	PLA
	STA	?PM2+1
	PLA
	STA	?PM2
	RTS
PLAYER0	=	$3200
PLAYER1	=	$3280
PLAYER2	=	$3300
PLAYER3	=	$3380
;
; Player-missile routines.
; Includes player-missile init-
;  ialization and startup.
;
PMINIT	LDA	#[>PLAYER0]-2
	STA	$D407	;pmbase
	LDX	#0
	TXA
?PMI1	STA	PLAYER0,X
	STA	PLAYER2,X
	STA	PLAYER0-$80,X
	INX
	BNE	?PMI1
	LDA	#0
	STA	$D008	;sizep0
	STA	$D00A	;sizep2
	STA	$D00B	;sizep3
	LDA	#192
	STA	$D00C	;sizem
	LDA	#1
	STA	$D009	;sizep1
	LDA	#48
	STA	$D002	;hposp2
	LDA	#200
	STA	$D003	;hposp3
	LDA	#120
	STA	$D001	;hposp1
	LDA	#124
	STA	$D007	;hposm3
	LDA	#8
	STA	704
	LDA	#$88
	STA	705
	LDA	#$CC
	STA	706
	STA	707
	RTS
;
; Put up player's ship.
;
PUTSHIP
	LDY	#0
?PS2	LDA	PLAYER,Y
	STA	PLAYER0,X
	INX
	INY
	CPY	#8
	BCC	?PS2
	RTS
;
; Move mother ship one unit.
; X position of center is in
; MOTHERX.
;
MOVEMOM	LDA	MOTHERX
	CLC
	ADC	MOTHERDX
	STA	MOTHERX
	CMP	#10
	BCS	?MMOM1
	LDA	#1
	STA	MOTHERDX
?MMOM1	CMP	#144
	BCC	?MMOM2
	LDA	#-1
	STA	MOTHERDX
?MMOM2	LDA	MOTHERX
	CLC
	ADC	#44
	STA	$D007	;hposm3
	SEC
	SBC	#4
	STA	$D001	;hposp1
	JMP	ALIEN
;
; Plot mother ship in player 1
; with y-coord .y
;
PLOTMOM
	TYA
	PHA
	LDX	#0
?PMOM1	LDA	MOTHER,X
	STA	PLAYER1,Y
	INX
	INY
	CPX	#7
	BCC	?PMOM1
	PLA
	CLC
	ADC	#2
	TAY
	LDA	#0
	STA	MISSILES,Y
	LDA	#$C0
	STA	MISSILES+1,Y
	RTS
;
; Plot left and right force
; field generators in players
; at .y
;
PLOTGEN
	LDX	#0
?PGEN1	LDA	LEFTGEN,X
	STA	PLAYER2,Y
	LDA	RIGHTGEN,X
	STA	PLAYER3,Y
	INX
	INY
	CPX	#10
	BCC	?PGEN1
	RTS
;
; Plot up force field in color
; .a and at FORCEY
;
PLOTFIELD
	PHA
	LDY	FORCEY
	LDA	TABLO,Y
	STA	ADDER
	LDA	TABHI,Y
	CLC
	ADC	#>SCREEN
	STA	ADDER+1
	LDY	#38
	PLA
?PFIELD1	STA	(ADDER),Y
	DEY
	BNE	?PFIELD1
	RTS
;
; Put explosion number .x into
; player's ship area
;
PUTEXP
	LDA	TIMES7,X
	TAX
	LDY	#94
?PX1	LDA	SEXPLODE,X
	STA	PLAYER0,Y
	INX
	INY
	CPY	#101
	BCC	?PX1
	RTS
TIMES7	.BYTE	0,7,14,21,28,35,42,49,56,63
	.LOCAL
;
; Movement routines for the
; monsters.
;
?TEMP	.BYTE	0
NEEDLEX	.BYTE	0
NEEDLEY	.BYTE	0
NEEDLEF	.BYTE	0
?YT	=	$84
?XT	=	$85
;
; Move monster number .x
;
MOVE1
	LDA	XTAB,X
	STA	?XT
	LDA	YTAB,X
	STA	?YT
	LDA	DYTAB,X
	BMI	?M11
	INC	?YT
	LDA	?YT
	CMP	#83	;bottom
	BNE	?M12
	LDA	#-1
	STA	DYTAB,X
	BNE	?M12
?M11	DEC	?YT
	LDA	?YT
	CMP	FORCEY	;check field
	BNE	?M12
	LDA	#1
	STA	DYTAB,X
?M12	LDA	?XT
	CLC
	ADC	DXTAB,X
	STA	?XT
	CMP	#8
	BNE	?M13
	LDA	#1
	STA	DXTAB,X
?M13	CMP	#142	;rt side
	BCC	?M1X
	LDA	#-1
	STA	DXTAB,X
?M1X	LDA	?YT
	STA	YTAB,X
	LDA	?XT
	STA	XTAB,X
	RTS
;
; Get monster coords for bitmap
;
GETCOORD	LDA	YTAB,X
	TAY
	STX	?TEMP
	LDA	XTAB,X
	SEC
	SBC	#4
	TAX
	RTS
;
; Plot monster number .x as
; bitmap in (.y.a)
;
PLOTC	STA	PTR
	STY	PTR+1
	JSR	GETCOORD
	JSR	PLOTMAP
	LDX	?TEMP
	RTS
;
; Animate 12 monsters 1 cycle
; each.
;
CYCLE
	LDX	#11
?CYC1	LDA	DSTAB,X	;Status 0?
	BEQ	?CYC2
	BMI	?CYCM	;move if here
	AND	#$FE
	TAY		;get right
	ASL	A
	STA	AUDF3
	LDA	EXPLTAB,Y	;explosion
	PHA
	LDA	EXPLTAB+1,Y
	TAY
	PLA
	JSR	PLOTC	;next expl.
	INC	DSTAB,X
	LDA	DSTAB,X
	CMP	#16
	BCC	?CYC2
	JSR	KILLMON
	DEC	MONLEFT
	LDA	#0
	STA	AUDC3
	JMP	?CYC2
?CYCM	JSR	MOVE1	;move
	LDA	#<SQUARE
	LDY	#>SQUARE
	JSR	PLOTC	;draw
?CYC2	DEX
	BPL	?CYC1
	LDA	NEEDLEY	;Extra man here?
	BEQ	?CYCX	;No, go away
	AND	#7	;Yes, do next
	TAX		;sound
	LDA	NEEDLES,X
	STA	AUDF4
	LDX	#<NEEDLE	;Point to
	LDY	#>NEEDLE	;bitmap
	STX	PTR
	STY	PTR+1
	LDX	NEEDLEX
	INC	NEEDLEY	;Move it
	LDY	NEEDLEY	;Off the
	CPY	#89	;screen?
	BCC	?NEED1	;No, draw it
	JSR	ERASEBM	;Yes, erase
	LDA	#0	;And de-flag
	STA	NEEDLEY	;it.
	STA	AUDC4
?CYCX	RTS		;Exit here!!!
?NEED1	JMP	PLOTMAP
;
; Initialize monster .x at x-
; coord in .a
;
INITMON	STA	XTAB,X
	LDA	#10
	STA	YTAB,X
	LDA	MOTHERDX
	LDY	SKILL
	BEQ	?IMON1
	LDA	RANDOM
	AND	#1
	BNE	?IMON1
	LDA	#$FF
?IMON1	STA	DXTAB,X
	LDA	#1
	STA	DYTAB,X
	LDA	#$80
	STA	DSTAB,X	;status here
	INC	MONHERE
	RTS
;
; Kill monster number .x
;
KILLMON
	LDA	#<SQUARE	;erase it
	STA	PTR
	LDA	#>SQUARE
	STA	PTR+1
	JSR	GETCOORD
	JSR	ERASEBM
	LDX	?TEMP
	LDA	#0
	STA	DSTAB,X	;kill it
	DEC	MONHERE
?KM1	RTS
;
; Init a new wave of monsters
;
MONSTERS	.BYTE	0
MONLEFT	.BYTE	0
MONHERE	.BYTE	0
INITWAVE	LDA	#12
	STA	MONLEFT
	LDA	#0
	STA	NEEDLEF
	STA	MONSTERS
	STA	MONHERE
	LDX	#[16*5]-1
?IWV1	STA	XTAB,X
	DEX
	BPL	?IWV1
	RTS
;
; Put a monster on at interval
; of $A5 or $85 moves
;
ALIEN	DEC	ALCOUNT
	BNE	?ALX
	LDA	NEEDLEF
	BNE	?AL0
	LDA	MONSTERS
	CMP	#12
	BEQ	?AL0
	LDA	RANDOM
	AND	#7
	BNE	?AL0
	LDA	MOTHERX
	CLC
	ADC	#3
	STA	NEEDLEX
	LDA	#5
	STA	NEEDLEY
	STA	NEEDLEF
	LDA	#$A6
	STA	AUDC4
	BNE	?ALS
?AL0	LDA	MONHERE
	CMP	#6
	BCS	?ALX
	LDX	MONSTERS
	CPX	#12
	BCS	?ALX
	LDA	MOTHERX
	JSR	INITMON
	INC	MONSTERS
?ALS	LDA	#$A5
	LDX	SPEED
	BEQ	?ALP
	LDA	#$65
?ALP	STA	ALCOUNT
?ALX	RTS
NEEDLES	.BYTE	20,40,80,120,200,120,80,40
;
; Player ship move routines
; (also laser handling)
;
	.LOCAL
;
; Move player's ship one
; cycle based on joystick.
;
MOVESHIP	LDA	$027C	;left stick?
	BNE	?MSHIP1	;no, do next
	LDA	SHIPX	;can he go further?
	CMP	#8
	BEQ	?MSHIP1	;no, exit
	DEC	SHIPX	;yes, do it
?MSHIP1	LDA	$027D	;check for right
	BNE	?MSHIPX
	LDA	SHIPX
	CMP	#144
	BEQ	?MSHIPX
	INC	SHIPX
?MSHIPX	LDA	SHIPX
	CLC
	ADC	#48
	STA	$D000	;do the move
	RTS
;
; Move player's laser one cycle
; or check for fire if no laser
; is up
;
MISSILES	=	PLAYER0-$80
MOVELASER	LDA	LASERY
	BEQ	?CFIRE
	DEC	LASERY
	DEC	LASERY
	DEC	LASERY
	LDX	LASERY
	STX	AUDF2
	LDA	#3
	STA	MISSILES,X
	STA	MISSILES+1,X
	STA	MISSILES+2,X
	LDA	#0
	STA	MISSILES+6,X
	STA	MISSILES+7,X
	STA	MISSILES+8,X
	CPX	#26
	BCS	?LEXIT
	JSR	CLRLASER
?CFIRE	LDA	STRIG0
	BNE	?LEXIT
	LDA	SHIPX
	CLC
	ADC	#3
	STA	LASERX
	ADC	#48
	STA	$D004	;hposm0
	LDA	#94
	STA	LASERY
	LDA	#$C4
	STA	AUDC2
?LEXIT	RTS
;
; Clear out laser.
;
CLRLASER	LDX	LASERY
	LDA	#0
	STA	MISSILES,X
	STA	MISSILES+1,X
	STA	MISSILES+2,X
	STA	MISSILES+3,X
	STA	MISSILES+4,X
	STA	MISSILES+5,X
	STA	LASERY
	LDA	#0
	STA	$D203	;AUDC2
	RTS
LASERY	.BYTE	0
LASERX	.BYTE	0
SPEED	.BYTE	0
SKILL	.BYTE	0
;
; Routines for title page,
; initialization, and
; game startup.
;
	.LOCAL
;
; Set up play screen:
; 1. Clear screen memory.
; 2. Initialize players
; 3. Do display list
; 4. Setup DLI
;
PLAYSCRN	LDA	#>SCREEN
	STA	ADDER+1
	LDA	#<SCREEN
	STA	ADDER
	TAY
	LDX	#$0F
?PSCN1	STA	(ADDER),Y
	INY
	BNE	?PSCN1
	INC	ADDER+1
	DEX
	BNE	?PSCN1
	JSR	PMINIT
	LDA	#0
	STA	559
	JSR	VBWAIT
	LDA	#$FA
	STA	709	;FORCE FIELD
	LDA	#$A6
	STA	710	;ALIENS
	LDA	#$3C
	STA	708	;EXPLOSION
	LDA	#<MAINDL
	STA	560
	LDA	#>MAINDL
	STA	561
	LDA	#3
	STA	53277	;gractl
	LDA	#<PLAYDLI
	STA	$0200
	LDA	#>PLAYDLI
	STA	$0201
	JSR	$E465	;SIOINV
	LDA	#46
	STA	559
	RTS
;
; Display list interrupt for
; play screen
;
PLAYDLI	PHA
	LDA	#$86
	STA	$D40A	;wsync
	STA	$D01A
	LDA	#$0A
	STA	$D016
	PLA
	RTI
;
; Wait for vertical blank.
;
VBWAIT	LDA	$14
?VBW1	CMP	$14
	BEQ	?VBW1
	RTS
;
; Lower mother ship (for game
; startup) and init her vars
;
LOWERMOM	LDA	#0
	STA	MOTHERDX
	LDA	#$50
	STA	AUDF1
	LDA	#$48
	STA	AUDC1
?LMOM1	LDY	MOTHERDX
	JSR	PLOTMOM
	JSR	VBWAIT
	JSR	VBWAIT
	JSR	VBWAIT
	JSR	VBWAIT
	JSR	VBWAIT
	INC	MOTHERDX
	LDA	MOTHERDX
	CMP	#17
	BCC	?LMOM1
	LDA	#1
	STA	MOTHERDX
	LDA	#80
	STA	MOTHERX
	LDA	#0
	STA	AUDC1
	RTS
;
; Lower generators to the proper
; height and do fancy force
; field startup (with sound).
;
?FLEVL	.BYTE	0
LOWERFORCE
	JSR	CLRLASER
	LDX	ROUND
	LDA	FORCELEV,X
	STA	FORCEY
	LDA	#$A8
	STA	AUDC1
?LFOR1	LDA	?FLEVL
	STA	AUDF1
	SEC
	SBC	#5
	TAY
	JSR	PLOTGEN
	JSR	VBWAIT
	JSR	VBWAIT
	JSR	VBWAIT
	INC	?FLEVL
	LDA	?FLEVL
	SEC
	SBC	#11
	BMI	?LFOR1
	CMP	FORCEY
	BCC	?LFOR1
	BEQ	?LFOR1
	LDA	#$AA
	JSR	PLOTFIELD
	LDA	#$50
	STA	AUDF1
	LDX	#0
?LFOR2	LDA	FORCETAB,X
	STA	709
	ORA	#$60
	STA	AUDC1
	JSR	VBWAIT
	JSR	VBWAIT
	JSR	VBWAIT
	INX
	CPX	#9
	BCC	?LFOR2
	LDA	#$64	;Force field
	STA	AUDC1	;Background
	LDA	#$F0	;Sound effect
	STA	AUDF1
	RTS
FORCETAB	.BYTE	$02,$08,$0E,$0E,$0C,$0A,$08,$06,$04
FORCELEV	.BYTE	15,30,40,45,50,55,60,65,70,72
;
; Put up and init player ship
;
DOSHIP
	LDX	#94
	JSR	PUTSHIP
	LDA	#76
	STA	SHIPX
	LDA	#76+48
	STA	$D000
	JMP	CLRLASER
;
; Combine it all into the startup
; sequence.
;
STARTUP	LDX	#$7F
	LDA	#0
?S1	STA	$80,X
	DEX
	BPL	?S1
	STA	NOSHIPS
	JSR	SHIPSLFT
	JSR	PLAYSCRN
	JSR	CLRSCR
	JSR	LOWERMOM
	LDA	#0
	STA	?FLEVL
	STA	ROUND
	JSR	LOWERFORCE
	LDA	#2
	STA	NOSHIPS
	JSR	SHIPSLFT
	JSR	DOSHIP
	JSR	INITWAVE
	STA	$D01E	;hitclr
	JMP	MLOOP
;
; DLI routine for title page
;
TITLEDLI	PHA
	TXA
	PHA
	TYA
	PHA
	DEC	256
	LDY	#32
	LDX	256
?TDLI	STX	$D40A	;wsync
	STX	$D016
	INX
	DEY
	BPL	?TDLI
	PLA
	TAY
	PLA
	TAX
	PLA
	RTI
;
; Display title page and wait
; for START.
;
DOTITLE
	LDA	#>CHARSET
	STA	756
	LDA	#0
	STA	559
	STA	$D208	;AUDCTL
	STA	53277	;gractl
	JSR	VBWAIT
	LDA	#$FA
	STA	709
	LDA	#$A8
	STA	710
	LDA	#$C8
	STA	711
	LDA	#<TITLEDL
	STA	560
	LDA	#>TITLEDL
	STA	561
	LDA	#<TITLEDLI
	STA	$0200
	LDA	#>TITLEDLI
	STA	$0201
	LDA	#$C0
	STA	$D40E	;nmien
	JSR	PUTSKILL
	LDA	#42
	STA	559
?DTL1
	LDA	STRIG0
	BNE	?DTL1.5
	JMP	STARTUP
?DTL1.5	LDA	53279
	CMP	#6
	BNE	?DTL2
	JMP	STARTUP
?DTL2	CMP	#5
	BNE	?DTL3
	LDA	SKILL
	EOR	#1
	STA	SKILL
?DOCON	JSR	PUTSKILL
?WTREL	LDA	53279
	CMP	#7
	BNE	?WTREL
	JMP	?DTL1
?DTL3	CMP	#3
	BNE	?DTL1
	LDA	SPEED
	EOR	#1
	STA	SPEED
	BPL	?DOCON
;
; Put skill level and speed up
; on title page.
;
PUTSKILL
	LDA	SPEED
	ASL	A
	ASL	A
	ADC	#3
	TAX
	LDY	#3
?PSK1	LDA	XSPEED,X
	STA	TITLEPG+72,Y
	DEX
	DEY
	BPL	?PSK1
	LDA	SKILL
	ASL	A
	ASL	A
	ADC	#3
	TAX
	LDY	#3
?PSK2	LDA	XSKILL,X
	STA	TITLEPG+92,Y
	DEX
	DEY
	BPL	?PSK2
	RTS
XSPEED	.SBYTE	"slowfast"
XSKILL	.SBYTE	"easyhard"
;
; "You Win" sequence (...?)
;
WIN
	JSR	CLRLASER	;No laser
	LDA	#60
	STA	LASERY
?W0	JSR	VBWAIT	;Delay
	JSR	MOVEMOM
	JSR	MOVEMOM
	DEC	LASERY
	BPL	?W0
	LDA	#0	;Erase
	LDX	#255
?WE	STA	PLAYER2,X	;the
	DEX		;Generators
	BNE	?WE
	LDA	#8	;Thrust
	STA	AUDC1	;sound
	LDA	#24
	STA	AUDF1
	LDA	#97
	STA	LASERY	;Move ship up
?W1	LDX	LASERY
	JSR	PUTSHIP
	JSR	MOVEMOM
	JSR	MOVEMOM
	JSR	VBWAIT
	DEC	LASERY
	LDA	LASERY
	CMP	#22
	BNE	?W1
	LDA	#0
	STA	AUDC1
	LDA	SHIPX	;Line ship up
	SEC		;with middle
	SBC	#3	;of mother
	AND	#$FE
	STA	LASERY
?W2	JSR	MOVEMOM
	JSR	MOVEMOM
	JSR	VBWAIT
	LDA	MOTHERX
	CMP	LASERY
	BNE	?W2
	LDX	#$80
?W3	JSR	VBWAIT
	DEX
	BPL	?W3
	TXS		;Clear stack
	JMP	DHS
;
; Main loop inner cycle
;
MAINCYCLE	LDA	#0
	STA	$4D	;NO ATTRACT
?MC1	LDA	$D40B	;VCOUNT
	CMP	#30
	BNE	?MC1
	JSR	MOVEMOM
	JSR	MOVEMOM
?MC2	LDA	$D40B
	CMP	#105
	BCC	?MC2
	JSR	CYCLE
	JSR	HITMON
	LDA	#$AA
	JSR	PLOTFIELD
	LDA	MONLEFT
	BNE	?ML0
	JSR	NXTLEV
?ML0
	LDA	764
	CMP	#33
	BNE	?MCYCX
	LDA	#255
	STA	764
	LDA	#0
	STA	AUDC1
	STA	AUDC2
	STA	AUDC3
	STA	AUDC4
?ML1	LDA	764
	CMP	#33
	BNE	?ML1
	LDA	#255
	STA	764
	LDA	#$64
	STA	AUDC1
?MCYCX	RTS
;
; Real main loop
;
MLOOP	JSR	MAINCYCLE
	JSR	MOVESHIP
	JSR	MOVELASER
	JSR	HITSHIP
	JMP	MLOOP
;
; Scorekeeping and collision
; detection routines
;
	.LOCAL
;
; Check for missile-pf2
; collision.  If it's there,
; clear it, find out which
; monster is hit, and kill
; it.  Then decrement the
; monsters left counter.
;
HITMON	LDA	M0PF	;Did the laser
	AND	#4	;hit a monster?
	BEQ	?HMX	;no, exit
	STA	HITCLR	;clear collision
	LDX	#11	;check monsters
?HM0	LDA	LASERX	;to see which
	SEC		;one was hit
	SBC	XTAB,X
	CMP	#11	;(monsters are
	BCC	?HM2	; 9 wide)
?HM1	DEX		;check next one
	BPL	?HM0	;if possible
	LDA	NEEDLEY	;Was it the
	BEQ	?HMX	;needle?
	LDX	#<NEEDLE	;Yes!
	LDY	#>NEEDLE
	STX	PTR
	STY	PTR+1	;Erase it
	LDX	NEEDLEX
	LDY	NEEDLEY
	JSR	ERASEBM
	LDA	#0	;De-flag it
	STA	NEEDLEY
	STA	AUDC4	;De-noise it
	JSR	CLRLASER
	INC	NOSHIPS	;Extra man
	JSR	SHIPSLFT
	BNE	?HMX	;branch always
?HM2	LDA	LASERY	;Now check the
	SEC		;y-coordinate.
	SBC	#16	;x-coord is ok
	SBC	YTAB,X	;if it gets here.
	JSR	ABSVAL
	CMP	#10
	BCS	?HM1
	LDA	DSTAB,X	;and it must be
	BPL	?HM1	;alive too!
	LDA	#1	;We found it!
	STA	DSTAB,X	;start killing...
	LDA	XTAB,X
	CLC		;adjustment for
	ADC	#4	;bitmap size
	STA	XTAB,X
	JSR	ADDPTS	;give points
	JSR	CLRLASER	;and stop laser
	LDA	#8	;Death sound
	STA	AUDC3
	STA	AUDF3
?HMX	RTS
;
; Take the absolute value of .a
;
ABSVAL	CMP	#0	;Set up flags
	BPL	?ABSX	;Positive, exit
	EOR	#$FF	;Otherwise do
	CLC		;two's-complement
	ADC	#1	;negative
?ABSX	RTS
;
; Lower force field by 8 and
; prepare next level.
;
NXTLEV	LDA	#0	;erase the
	JSR	PLOTFIELD	;force field
	INC	ROUND	;next round
	LDA	ROUND
	CMP	#10	;Last one?
	BNE	?NL1	;No
	JMP	WIN	;Yes, game won
?NL1	JSR	LOWERFORCE	;lower gens.
	JMP	INITWAVE	;setup monsters
;
; Clear score
;
CLRSCR	LDA	#$10	;Put
	STA	SCORELN+17	;zeros
	STA	SCORELN+18	;everywhere
	STA	SCORELN+19
	RTS
;
; Add 1 to score
;
ADDSCR	LDX	#2	;Last digit
	SEC
?ADS1	LDA	SCORELN+17,X	;Add
	ADC	#0
	CMP	#26	;Over 10?
	BCC	?ADS2	;No
	LDA	#16
?ADS2	STA	SCORELN+17,X
	DEX
	BPL	?ADS1
	RTS
;
; Add value in .a to score
;
ADDA	TAY
?ADDA1	JSR	ADDSCR
	DEY
	BNE	?ADDA1
	RTS
;
; Add points for hitting alien
;
ADDPTS	LDX	ROUND
	LDA	VALUES,X
	JMP	ADDA
VALUES	.BYTE	1,2,3,4,5,6,8,10,15,20
;
; Check for player ship hit.
;
HITSHIP
	LDA	P0PF	;Ship hit?
	AND	#4
	BEQ	?HSX	;no, exit
	STA	HITCLR	;clear collision
	JSR	CLRLASER	;clear laser
	LDA	#0	;and start melting
	STA	EXPCOUNT	;player's ship
?HS0	JSR	MAINCYCLE
	JSR	MAINCYCLE	;move monsters
	JSR	MAINCYCLE	;and delay
	JSR	MAINCYCLE	;while melting
	JSR	MAINCYCLE	;the ship.
	LDX	EXPCOUNT
	JSR	PUTEXP	;next melt...
	INC	EXPCOUNT
	LDA	EXPCOUNT	;and keep going
	CMP	#10
	BCC	?HS0
	INC	EXPCOUNT	;Remove the
?HS.5	LDX	EXPCOUNT	;monsters
	JSR	KILLMON	;one by one
	DEC	EXPCOUNT
	BPL	?HS.5
	LDA	#0	;no more on...
	STA	MONHERE
	LDA	#12	;but don't do
	SEC		;the whole wave
	SBC	MONLEFT	;again!
	STA	MONSTERS
	DEC	NOSHIPS	;lose a ship
	LDA	NOSHIPS
	BMI	GOVER	;Game over!!!
	JSR	SHIPSLFT
	LDA	#76
	STA	SHIPX	;center ship
	LDA	#76+48
	STA	HPOSP0
	STA	HITCLR
	JMP	DOSHIP	;and plot it
?HSX	RTS
;
; Game over
;
GOVER	PLA
	PLA
	LDA	#0	;DMA off
	STA	559
	STA	AUDC1
	STA	AUDC2
	STA	AUDC3
	STA	AUDC4
	JSR	VBWAIT
	LDA	#<GODL	;Game Over
	STA	560	;display
	LDA	#>GODL	;(simple, but
	STA	561	;it'll do...)
DHS	LDX	#2
?GV1	LDA	SCORELN+17,X	;Update
	ORA	#$80	;Last
	STA	TITLEPG+46,X	;Score
	DEX		;display
	BPL	?GV1
?GV2	INX
	CPX	#3
	BEQ	?GV4
	LDA	TITLEPG+55,X	;Hi-score?
	CMP	TITLEPG+46,X
	BCC	?GV3	;Nope...
	BEQ	?GV2
	BNE	?GV4
?GV3	LDX	#2	;Yep...
?GV3.5	LDA	TITLEPG+46,X
	STA	TITLEPG+55,X
	DEX
	BPL	?GV3.5
?GV4
	LDA	#42
	STA	559
	LDA	#0
	STA	53277
	LDX	#$40	;Wait a bit
?GO1	JSR	VBWAIT
	DEX
	BNE	?GO1
	JMP	DOTITLE	;and go back
;
; Display ships left.
;
NOSHIPS	.BYTE	0
SHIPSLFT
	LDA	#$20	;Ship symb.
	LDX	#0
?SLF2	CPX	NOSHIPS
	BCC	?SLF3
	LDA	#0
?SLF3	STA	SCORELN+7,X
	INX
	CPX	#3
	BNE	?SLF2
	RTS
;
; Shapes for various items
; in game.
;
	.LOCAL
;
; First are the shapes that
; go in players.
; 1. Player ship
; 2. Mother ship
; 3. Left force field generator
; 4. Right  "     "       "
; 5-. Explosion data for ship
;     (10 cycles, 7 bytes each)
;
PLAYER	.BYTE	$18,$3C,$24,$A5,$A5,$E7,$BD,$00
MOTHER	.BYTE	$00,$18,$3C,$42,$5A,$A5,$FF
LEFTGEN	.BYTE	0,7,8,$10,$E0,$3C,$E0,$10,8,7
RIGHTGEN	.BYTE	0,$E0,$10,8,7,$3C,7,8,$10,$E0
SEXPLODE
	.BYTE	0,$5A,$3C,$A5,$A5,$E7,$BD
	.BYTE	0,$42,$3C,$3C,$A5,$E7,$BD
	.BYTE	0,0,$3C,$24,$BD,$E7,$7E
	.BYTE	0,0,0,$3C,$24,$FF,$FF
	.BYTE	0,0,0,0,$3C,$FF,$FF
	.BYTE	0,0,0,0,0,$7E,$FF
	.BYTE	0,0,0,0,0,$3C,$7E
	.BYTE	0,0,0,0,0,$18,$3C
	.BYTE	0,0,0,0,0,0,$18
	.BYTE	0,0,0,0,0,0,0
;
; Bitmaps for aliens.
;
SQUARE	.BYTE	7,4	;height,width
	.WORD	SHIFT1
	.WORD	SHIFT2
	.WORD	SHIFT3
	.WORD	SHIFT4
SHIFT1
	.WORD	0,0
	.BYTE	$00,$0F,$F0,$00
	.BYTE	$00,$33,$FC,$00
	.BYTE	$00,$3F,$CC,$00
	.BYTE	$00,$0F,$F0,$00
	.BYTE	$00,$30,$0C,$00
SHIFT2
	.WORD	0,0
	.BYTE	$00,$03,$FC,$00
	.BYTE	$00,$0C,$FF,$00
	.BYTE	$00,$0F,$F3,$00
	.BYTE	$00,$03,$FC,$00
	.BYTE	$00,$0C,$03,$00
SHIFT3
	.WORD	0,0
	.BYTE	$00,$00,$FF,$00
	.BYTE	$00,$03,$FC,$C0
	.BYTE	$00,$03,$3F,$C0
	.BYTE	$00,$00,$FF,$00
	.BYTE	$00,$03,$00,$C0
SHIFT4
	.WORD	0,0
	.BYTE	$00,$00,$3F,$C0
	.BYTE	$00,$00,$FF,$30
	.BYTE	$00,$00,$FC,$F0
	.BYTE	$00,$00,$3F,$C0
	.BYTE	$00,$00,$C0,$30
	.WORD	0,0
;
; Bitmap EXPL1
;
EXPL1	.BYTE	6,3
	.WORD	EXPL10,EXPL11,EXPL12,EXPL13
EXPL10
	.BYTE	$00,$00,$00
	.BYTE	$05,$50,$00
	.BYTE	$11,$54,$00
	.BYTE	$15,$44,$00
	.BYTE	$05,$50,$00
	.BYTE	$10,$04,$00
EXPL11
	.BYTE	$00,$00,$00
	.BYTE	$01,$54,$00
	.BYTE	$04,$55,$00
	.BYTE	$05,$51,$00
	.BYTE	$01,$54,$00
	.BYTE	$04,$01,$00
EXPL12
	.BYTE	$00,$00,$00
	.BYTE	$00,$55,$00
	.BYTE	$01,$15,$40
	.BYTE	$01,$54,$40
	.BYTE	$00,$55,$00
	.BYTE	$01,$00,$40
EXPL13
	.BYTE	$00,$00,$00
	.BYTE	$00,$15,$40
	.BYTE	$00,$45,$50
	.BYTE	$00,$55,$10
	.BYTE	$00,$15,$40
	.BYTE	$00,$40,$10
;
; Bitmap EXPL2
;
EXPL2	.BYTE	6,3
	.WORD	EXPL20,EXPL21,EXPL22,EXPL23
EXPL20
	.BYTE	$00,$00,$00
	.BYTE	$05,$50,$00
	.BYTE	$10,$54,$00
	.BYTE	$15,$04,$00
	.BYTE	$05,$50,$00
	.BYTE	$00,$00,$00
EXPL21
	.BYTE	$00,$00,$00
	.BYTE	$01,$54,$00
	.BYTE	$04,$15,$00
	.BYTE	$05,$41,$00
	.BYTE	$01,$54,$00
	.BYTE	$00,$00,$00
EXPL22
	.BYTE	$00,$00,$00
	.BYTE	$00,$55,$00
	.BYTE	$01,$05,$40
	.BYTE	$01,$50,$40
	.BYTE	$00,$55,$00
	.BYTE	$00,$00,$00
EXPL23
	.BYTE	$00,$00,$00
	.BYTE	$00,$15,$40
	.BYTE	$00,$41,$50
	.BYTE	$00,$54,$10
	.BYTE	$00,$15,$40
	.BYTE	$00,$00,$00
;
; Bitmap EXPL3
;
EXPL3	.BYTE	5,3
	.WORD	EXPL30,EXPL31,EXPL32,EXPL33
EXPL30
	.BYTE	$00,$00,$00
	.BYTE	$05,$50,$00
	.BYTE	$10,$14,$00
	.BYTE	$14,$04,$00
	.BYTE	$05,$50,$00
EXPL31
	.BYTE	$00,$00,$00
	.BYTE	$01,$54,$00
	.BYTE	$04,$05,$00
	.BYTE	$05,$01,$00
	.BYTE	$01,$54,$00
EXPL32
	.BYTE	$00,$00,$00
	.BYTE	$00,$55,$00
	.BYTE	$01,$01,$40
	.BYTE	$01,$40,$40
	.BYTE	$00,$55,$00
EXPL33
	.BYTE	$00,$00,$00
	.BYTE	$00,$15,$40
	.BYTE	$00,$40,$50
	.BYTE	$00,$50,$10
	.BYTE	$00,$15,$40
;
; Bitmap EXPL4
;
EXPL4	.BYTE	5,3
	.WORD	EXPL40,EXPL41,EXPL42,EXPL43
EXPL40
	.BYTE	$00,$00,$00
	.BYTE	$05,$50,$00
	.BYTE	$10,$04,$00
	.BYTE	$10,$04,$00
	.BYTE	$04,$10,$00
EXPL41
	.BYTE	$00,$00,$00
	.BYTE	$01,$54,$00
	.BYTE	$04,$01,$00
	.BYTE	$04,$01,$00
	.BYTE	$01,$04,$00
EXPL42
	.BYTE	$00,$00,$00
	.BYTE	$00,$55,$00
	.BYTE	$01,$00,$40
	.BYTE	$01,$00,$40
	.BYTE	$00,$41,$00
EXPL43
	.BYTE	$00,$00,$00
	.BYTE	$00,$15,$40
	.BYTE	$00,$40,$10
	.BYTE	$00,$40,$10
	.BYTE	$00,$10,$40
;
; Bitmap EXPL5
;
EXPL5	.BYTE	5,3
	.WORD	EXPL50,EXPL51,EXPL52,EXPL53
EXPL50
	.BYTE	$00,$00,$00
	.BYTE	$05,$50,$00
	.BYTE	$10,$04,$00
	.BYTE	$10,$04,$00
	.BYTE	$00,$00,$00
EXPL51
	.BYTE	$00,$00,$00
	.BYTE	$01,$54,$00
	.BYTE	$04,$01,$00
	.BYTE	$04,$01,$00
	.BYTE	$00,$00,$00
EXPL52
	.BYTE	$00,$00,$00
	.BYTE	$00,$55,$00
	.BYTE	$01,$00,$40
	.BYTE	$01,$00,$40
	.BYTE	$00,$00,$00
EXPL53
	.BYTE	$00,$00,$00
	.BYTE	$00,$15,$40
	.BYTE	$00,$40,$10
	.BYTE	$00,$40,$10
	.BYTE	$00,$00,$00
;
; Bitmap EXPL6
;
EXPL6	.BYTE	4,3
	.WORD	EXPL60,EXPL61,EXPL62,EXPL63
EXPL60
	.BYTE	$00,$00,$00
	.BYTE	$05,$50,$00
	.BYTE	$10,$04,$00
	.BYTE	$00,$00,$00
EXPL61
	.BYTE	$00,$00,$00
	.BYTE	$01,$54,$00
	.BYTE	$04,$01,$00
	.BYTE	$00,$00,$00
EXPL62
	.BYTE	$00,$00,$00
	.BYTE	$00,$55,$00
	.BYTE	$01,$00,$40
	.BYTE	$00,$00,$00
EXPL63
	.BYTE	$00,$00,$00
	.BYTE	$00,$15,$40
	.BYTE	$00,$40,$10
	.BYTE	$00,$00,$00
;
; Bitmap EXPL7
;
EXPL7	.BYTE	3,3
	.WORD	EXPL70,EXPL71,EXPL72,EXPL73
EXPL70
	.BYTE	$00,$00,$00
	.BYTE	$05,$50,$00
	.BYTE	$00,$00,$00
EXPL71
	.BYTE	$00,$00,$00
	.BYTE	$01,$54,$00
	.BYTE	$00,$00,$00
EXPL72
	.BYTE	$00,$00,$00
	.BYTE	$00,$55,$00
	.BYTE	$00,$00,$00
EXPL73
	.BYTE	$00,$00,$00
	.BYTE	$00,$15,$40
	.BYTE	$00,$00,$00
;
; Bitmap EXPL8
;
EXPL8	.BYTE	2,3
	.WORD	EXPL80,EXPL81,EXPL82,EXPL83
EXPL80
	.BYTE	$00,$00,$00
	.BYTE	$01,$40,$00
EXPL81
	.BYTE	$00,$00,$00
	.BYTE	$00,$50,$00
EXPL82
	.BYTE	$00,$00,$00
	.BYTE	$00,$14,$00
EXPL83
	.BYTE	$00,$00,$00
	.BYTE	$00,$05,$00
;
; Table of explosion addresses
;
EXPLTAB
	.WORD	EXPL1,EXPL2,EXPL3
	.WORD	EXPL4,EXPL5,EXPL6
	.WORD	EXPL7,EXPL8
;
; Bitmap NEEDLE
;
NEEDLE	.BYTE	13,4
	.WORD	NEEDLE0,NEEDLE1,NEEDLE2,NEEDLE3
NEEDLE0
	.BYTE	$00,$00,$00,$00
	.BYTE	$00,$FC,$00,$00
	.BYTE	$0C,$30,$C0,$00
	.BYTE	$03,$33,$00,$00
	.BYTE	$3C,$FC,$F0,$00
	.BYTE	$03,$9B,$00,$00
	.BYTE	$03,$9B,$00,$00
	.BYTE	$03,$9B,$00,$00
	.BYTE	$00,$EC,$00,$00
	.BYTE	$00,$EC,$00,$00
	.BYTE	$00,$30,$00,$00
	.BYTE	$00,$30,$00,$00
	.BYTE	$00,$30,$00,$00
NEEDLE1
	.BYTE	$00,$00,$00,$00
	.BYTE	$00,$3F,$00,$00
	.BYTE	$03,$0C,$30,$00
	.BYTE	$00,$CC,$C0,$00
	.BYTE	$0F,$3F,$3C,$00
	.BYTE	$00,$E6,$C0,$00
	.BYTE	$00,$E6,$C0,$00
	.BYTE	$00,$E6,$C0,$00
	.BYTE	$00,$3B,$00,$00
	.BYTE	$00,$3B,$00,$00
	.BYTE	$00,$0C,$00,$00
	.BYTE	$00,$0C,$00,$00
	.BYTE	$00,$0C,$00,$00
NEEDLE2
	.BYTE	$00,$00,$00,$00
	.BYTE	$00,$0F,$C0,$00
	.BYTE	$00,$C3,$0C,$00
	.BYTE	$00,$33,$30,$00
	.BYTE	$03,$CF,$CF,$00
	.BYTE	$00,$39,$B0,$00
	.BYTE	$00,$39,$B0,$00
	.BYTE	$00,$39,$B0,$00
	.BYTE	$00,$0E,$C0,$00
	.BYTE	$00,$0E,$C0,$00
	.BYTE	$00,$03,$00,$00
	.BYTE	$00,$03,$00,$00
	.BYTE	$00,$03,$00,$00
NEEDLE3
	.BYTE	$00,$00,$00,$00
	.BYTE	$00,$03,$F0,$00
	.BYTE	$00,$30,$C3,$00
	.BYTE	$00,$0C,$CC,$00
	.BYTE	$00,$F3,$F3,$C0
	.BYTE	$00,$0E,$6C,$00
	.BYTE	$00,$0E,$6C,$00
	.BYTE	$00,$0E,$6C,$00
	.BYTE	$00,$03,$B0,$00
	.BYTE	$00,$03,$B0,$00
	.BYTE	$00,$00,$C0,$00
	.BYTE	$00,$00,$C0,$00
	.BYTE	$00,$00,$C0,$00
;
	*=	$02E0
	.WORD	DOTITLE
	.END