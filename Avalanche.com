*****************************
*                           *
* 'AVALANCHE'               *
* written by: TOMMY BENNETT *
*                           *
*****************************
;
;OS SYMBOLS !!!
;
COLPM0   =   $02C0   ;P/M COLORS
COLPM1   =   $02C1
COLPM2   =   $02C2
COLPM3   =   $02C3
COLPF0   =   $02C4   ;PLAYFIELD COLORS
COLPF1   =   $02C5
COLPF2   =   $02C6
COLPF3   =   $02C7
COLBK    =   $02C8
CHBASE   =   $02F4   ;CHAR. SET ADDRESS
HPOSP0   =   $D000   ;P/M HORIZONTAL
HPOSP1   =   $D001   ;REGISTERS
HPOSP2   =   $D002
HPOSP3   =   $D003
P0PF     =   $D004   ;COLLISION
P1PF     =   $D005   ;REGISTERS
P2PF     =   $D006
P3PF     =   $D007
P0PL     =   $D00C
P3PL     =   $D00F
GRACTL   =   $D01D   ;GRAPHICS CONTROL
HITCLR   =   $D01E   ;COLLISION CLEAR
WSYNC    =   $D40A   ;WAIT FOR SYNC
NMIEN    =   $D40E   ;INTERRUPT ENABLE
PRIOR    =   $026F   ;PRIORITY
DMACTL   =   $022F   ;DMA CONTROL
AUDF1    =   $D200   ;AUDIO
AUDC1    =   $D201   ;REGISTERS
AUDF2    =   $D202
AUDC2    =   $D203
AUDF3    =   $D204
AUDC3    =   $D205
AUDF4    =   $D206
AUDC4    =   $D207
AUDCTL   =   $D208
SETVBV   =   $E45C   ;VBLANK SET
XITVBV   =   $E462   ;VBLANK EXIT
SIOINV   =   $E465   ;SIO INIT
CONSOL   =   $D01F   ;CONSOLE KEYS
PCOLR2   =   $02C2   ;P/M COLOR
PCOLR3   =   $02C3   ;
STICK0   =   $0278   ;STICK
STRIG    =   $0284   ;STICK TRIGGER
RANDOM   =   $D20A   ;RANDOM #
ATRACT   =   $4D     ;ATTRACT MODE FLAG
PMBASE   =   $D407   ;P/M ADDRESS
DLISTL   =   $0230   ;DISPLAY...
DLISTH   =   $0231   ;LIST ADDR
PMAREA   =   $3800   ;P/M MEMORY
PLAY0    =   PMAREA+$0400
PLAY1    =   PMAREA+$0500
PLAY2    =   PMAREA+$0600
PLAY3    =   PMAREA+$0700
DISP     =   $3600   ;DISPLAY MEMORY
DISP1    =   DISP+20
DISP2    =   DISP+40
DISP3    =   DISP+60
DISP4    =   DISP+80
DISP5    =   DISP+100
DISP7    =   DISP+140
DISP22   =   DISP+440
CHSET    =   $3800   ;CHAR. SET ADDR
;
;PAGE 0 VARIABLES
;
         *=  $80
LO       *=  *+1     ;2-BYTE...
HI       *=  *+1     ;WORK ADDRESS
TIMER    *=  *+1     ;EVENT TIMER
LVL      *=  *+1     ;LEVEL #
OPT      *=  *+1     ;OPTION KEY FLAG
TOG      *=  *+1     ;EASY/HARD VALUE
PADCT    *=  *+1     ;JUMPING PAD INDEX
COLR     *=  *+1     ;COLOR WORK REG.
PNT      *=  *+1
TOM      *=  *+1     ;LIVES
FILE     *=  *+2     ;PAD COLOR POINTER
TIMES4   *=  *+1     ;PLOT WORK AREA
;
;USER SYMBOLS !!!
;
         *=  $0600
PCOL     *=  *+1     ;PL COL #
PROW     *=  *+1     ;PL ROW #
NUMSQ    *=  *+1     ;# OF SQ'S
TIME     *=  *+1     ;DELAY TIM
SCOL     *=  *+1     ;SNK COL #
SROW     *=  *+1     ;SNK ROW #
PXPOS    *=  *+1     ;PL XPOS
PYPOS    *=  *+1     ;PL YPOS
XPOSP1   *=  *+1     ;POSITIONS
XPOSP2   *=  *+1     ;OF
XPOSP3   *=  *+1     ;PLAYERS..
YPOSP1   *=  *+1     ;
YPOSP2   *=  *+1     ;
YPOSP3   *=  *+1     ;
COUNT1   *=  *+1     ;
COUNT2   *=  *+1     ;
COUNT3   *=  *+1     ;
COUNT4   *=  *+1     ;
LEVEL    *=  *+1     ;
ROUND    *=  *+1     ;
START    *=  *+1     ;
LENGTH   *=  *+1     ;
LENGTH3  *=  *+1
ADDNUM3  *=  *+1
PLAYER   *=  *+2
SCORE    *=  *+6     ;SCORE DIGITS
BACK     *=  *+1     ;PLAY END REASON
ADDNUM   *=  *+1
ADD      *=  *+1
SUM      *=  *+1     ;SCORE ADD VALUE
FALOFF   *=  *+1     ;FALL FLAG
DIRFLG   *=  *+1     ;DIRECTION FLAG
SO1FLG   *=  *+1     ;SOUND FLAGS
SO2FLG   *=  *+1
SO3FLG   *=  *+1
SO4FLG   *=  *+1
MOVFLG   *=  *+1     ;MOVE FLAG
WARN     *=  *+1
WARN1    *=  *+1
PITCH1   *=  *+1     ;PITCH FLG
PITCH2   *=  *+1     ;
PITCH3   *=  *+1     ;
PITCH4   *=  *+1     ;
DIRECT   *=  *+1     ;DIRECTION SAVE
DRP1     *=  *+1     ;DROP FLAGS
DRP2     *=  *+1
BAL1FLG  *=  *+1     ;ROCK FLAGS
BAL2FLG  *=  *+1
B1MOV    *=  *+1     ;ROCK MOV
B2MOV    *=  *+1     ;FLAG'S..
B3MOV    *=  *+1
B1DRP    *=  *+1
B2DRP    *=  *+1
B3DRP    *=  *+1
B1DIR    *=  *+1
B2DIR    *=  *+1
B3DIR    *=  *+1
B1DRW    *=  *+1
B2DRW    *=  *+1
B3DRW    *=  *+1
FNB1DRP  *=  *+1
FNB2DRP  *=  *+1
FNB3DRP  *=  *+1
MAN      *=  *+1     ;GREEN MAN
GRNFLG   *=  *+1     ;GREEN MAN PRESENT
OUTFLG2  *=  *+1
GRNDIR   *=  *+1     ;GREEN DIRECTION
GCOL     *=  *+1     ;GREEN MAN COLUMN
GROW     *=  *+1     ;GREEN MAN ROW
GRNDRP   *=  *+1     ;GREEN DROP FLAG
GRNMOV   *=  *+1     ;GREEN MOVE FLAG
GRNFNDRP *=  *+1     ;GREEN DROP FINISH
OUTFLG   *=  *+1
GRDIR    *=  *+1     ;GEORGE DIRECTION
GRGFLG   *=  *+1     ;GEORGE PRESENT
GRGDRP   *=  *+1     ;GEORGE DROP
FNGRDRP  *=  *+1     ;GEORGE DROP FINISH
GRGMOV   *=  *+1     ;GEORGE MOVE FLAG
HPOS     *=  *+3     ;TMP LOC..
TEMP     *=  *+1
TEMP1    *=  *+1
COL      *=  *+1     ;PLOT COLUMN
ROW      *=  *+1     ;PLOT ROW
;
;AVALANCHE CONTROL CODE
;
         *=   $2000
STRTIT   JSR SIOINV  ;INIT SOUNDS
         LDA #0      ;SET AUDIO CONTROL
         STA AUDCTL
         LDA #1      ;SET EASY MODE
         STA OPT
         LDA #174
         STA TOG
         JSR PMCLR
         JSR SETCHR  ;SET UP CHARSET
         JSR INILVL  ;SET LEVEL INFO
         JSR SCREEN  ;INIT SCREEN
         JSR SHOLIV  ;SHOW LIVES
         JSR SNDOFF  ;NO SOUNDS
         JSR ZEROSC  ;ZERO SCORE
         LDX #15     ;DISPLAY...
SETAUTH  LDA TITLE,X ;TITLE,
         STA DISP3+2,X
         LDA AUTHOR,X ;AUTHOR,
         STA DISP22+2,X
         LDA MAGMSG,X ;MAGAZINE
         STA DISP22+22,X
         DEX 
         BPL SETAUTH
CKSTRG   LDA STRIG   ;TRIG PRESSED?
         BNE NOSTRG  ;NO!
         JSR INILVL  ;INIT LEVEL
         JSR SCREEN  ;INIT SCREEN
         JSR SHOLIV  ;SHOW LIVES
         JSR ZEROSC  ;ZERO SCORE
         LDA #0      ;NO ATTRACT MODE
         STA ATRACT
         JMP READY   ;GO TO IT!
NOSTRG   LDA CONSOL  ;GET CONSOLE
         CMP #3      ;OPTION PRESSED?
         BNE SHODIF  ;NO!
         LDA TOG     ;GET DIFFICULTY
         CMP #174    ;NORMAL?
         BNE NORMAL  ;NO, SET NORMAL
         LDA #168    ;SET HARD
         STA TOG
         LDA #1
         BNE SETDIF
NORMAL   LDA #174    ;NORMAL DIFFICULTY
         STA TOG
         LDA #0
SETDIF   STA OPT     ;SAVE DIFF
         JSR STODIF  ;AND INITIALIZE
SHODIF   LDA TOG     ;GET DIFF CHAR
         STA DISP+9  ;SHOW ON SCREEN
         LDA #20     ;WAIT 20 JIFFIES
         JSR WAIT
         JMP CKSTRG  ;LOOP BACK
READY    JSR CLINE3  ;CLEAR SCREEN LINE 3
         JSR CLINE22 ;AND LINE 22
         LDA LEVEL   ;GET LEVEL
         ORA #$10
         STA DISP+18 ;SHOW ON SCREEN
         LDA ROUND   ;GET ROUND
         ORA #$10
         STA DISP1+18 ;SHOW ON SCREEN
         LDX #7      ;SHOW READY!
SHORDY   LDA RDYMSG,X
         STA DISP3+6,X
         DEX 
         BPL SHORDY
         LDA #120    ;WAIT 120 JIFFIES
         JSR WAIT
         JSR CLINE3  ;ERASE LINE 3
         LDA #20
         STA TIME
         LDX ROUND   ;GET ROUND #
         LDA R1SET,X ;AND SET COLORS
         STA DLI4C1+1
         LDA R2SET,X
         STA DLI4C2+1
         LDA R3SET,X
         STA DLI4C3+1
         LDA R4SET,X
         STA DLI4C4+1
         JSR SETLD   ;INIT DIFF FACTORS
         JSR GAME    ;GO TO MAIN GAME
         LDA #1      ;RESET START FLAG
         STA START
         JSR SNDOFF  ;TURN OFF SOUND
         LDA BACK    ;GET PLAY END REASON
         CMP #1      ;SCREEN COMPLETED?
         BEQ LVLEND  ;YES!
         JMP CKDED2  ;NO, CHECK DEATH
LVLEND   INC ROUND   ;NEXT ROUND
         JSR BONUS   ;DO BONUS
         JSR BONLIF  ;CHECK BONUS LIFE
         LDA #0      ;NO ATTRACT MODE
         STA ATRACT
         LDA ROUND   ;GET ROUND #
         CMP #5      ;ROUND 5?
         BNE NOTR5   ;NO!
         INC LEVEL   ;NEXT LEVEL!
         LDA #1      ;RESET ROUND #
         STA ROUND
         LDA LEVEL   ;SAVE LEVEL #
         STA LVL
         JSR SCREEN  ;SET SCREEN
         JMP NEWLVL  ;NEW LEVEL
NOTR5    LDA #0      ;0 # OF SQUARES
         STA NUMSQ
         JSR SCREEN  ;SET SCREEN
         JMP READY   ;WE'RE READY!
NEWLVL   JSR CLINE22 ;CLEAR LINE 22
         LDX #4      ;NEW LEVEL MESSAGE
SHOLVL   LDA LVMSG,X
         STA DISP22+7,X
         DEX 
         BPL SHOLVL
         LDA LEVEL   ;SHOW LEVEL #
         ORA #$10
         STA DISP22+13
         LDX #11     ;MAKE LEVEL SOUND
NLSND    LDA #150    ;SET SOUND,
         STA AUDF1
         LDA #168
         STA AUDC1
         LDA #28     ;SET COLORS
         STA DLI4C1+1
         LDA #136
         STA DLI4C2+1
         LDA #6      ;WAIT 6 JIFFIES
         JSR WAIT
         LDA #50     ;CHANGE SOUND
         STA AUDF1
         LDA #136    ;AND COLORS
         STA DLI4C1+1
         LDA #28
         STA DLI4C2+1
         LDA #6      ;WAIT AGAIN
         JSR WAIT
         DEX         ;MORE SOUNDS?
         BPL NLSND   ;YES!
         LDA #0      ;TURN OFF SOUND
         STA AUDC1
         JSR CLINE22 ;ERASE LINE 22
         LDA LEVEL   ;GET LEVEL #
         CMP #7      ;LEVEL 7?
         BNE NOT7    ;NO!
         LDA #6      ;MAKE IT 6 AGAIN
         STA LVL
NOT7     LDA #0      ;RESET PLAY FLAG
         STA BACK
         STA NUMSQ   ;AND # SQUARES
         JMP READY   ;GO PLAY!
CKDED2   CMP #2      ;HIT BY ROCK?
         BEQ DEAD2   ;YES!
         JMP CKDED3  ;NO, WE FELL.
DEAD2    DEC TOM     ;1 LESS LIFE
         LDX #15     ;DO DEATH SOUND
DEDSND   LDA #120    ;SET SOUND
         STA AUDF1
         TXA 
         ORA #$10
         STA AUDC1
         LDA #5      ;WAIT 5 JIFFIES
         JSR WAIT
         DEX         ;NEXT SOUND
         BPL DEDSND
         JMP CHKEND  ;CHECK END OF GAME
CKDED3   DEC TOM     ;1 LESS LIFE
         LDA #1      ;RESET PRIORITY
         STA PRIOR
CHKEND   JSR BONLIF  ;BONUS LIFE CHECK
         LDA TOM     ;MORE LIVES?
         BNE NOTEND  ;YES!
         LDX #8      ;NO, SHOW END MESSAGE
SHOEND   LDA ENDMSG,X
         STA DISP3+6,X
         DEX 
         BPL SHOEND
         JMP CKSTRG  ;GO CHECK RESTART
NOTEND   JSR SHOLIV  ;SHOW LIVES LEFT
         JMP READY   ;AND PLAY!
CLINE3   LDX #19     ;ERASE 3RD SCREEN LINE
         LDA #0
CL3LP    STA DISP3,X
         DEX 
         BPL CL3LP
         RTS 
CLINE22  LDX #39     ;ERASE LAST 2...
         LDA #0      ;SCREEN LINES
CL22LP   STA DISP22,X
         DEX 
         BPL CL22LP
         RTS 
WAIT     STA TIMER   ;SET TIMER
WAITLP   LDA TIMER   ;GET TIMER
         BNE WAITLP  ;NOT ZERO YET
         RTS         ;TIME'S UP!
SETCHR   LDX #0      ;COPY CHAR SET
MOVCHR   LDA $E000,X
         STA CHSET,X
         LDA $E100,X
         STA CHSET+$0100,X
         DEX 
         BNE MOVCHR
         LDX #47     ;AND CHANGE...
CHGCHR   LDA NEWCHR,X ;THE CHARACTERS...
         STA CHSET+24,X ;WE'RE USING!
         DEX 
         BPL CHGCHR
         LDA # >CHSET ;TURN ON...
         STA CHBASE  ;OUT CHAR SET
         LDA #62     ;TURN ON DMA
         STA DMACTL
         LDA # >DLIST ;POINT TO...
         STA DLISTH  ;OUR...
         LDA # <DLIST ;DISPLAY...
         STA DLISTL  ;LIST!
         LDA #3      ;TURN ON GRAPHICS
         STA GRACTL
         LDA # >PMAREA ;SET P/M AREA
         STA PMBASE
         LDA #38     ;SET COLORS
         STA COLPM0
         LDA #52
         STA COLPM1
         STA COLPM2
         STA COLPM3
         LDA #124    ;SET P/M POSITIONS
         STA HPOSP0
         LDA #116
         STA HPOSP1
         STA HPOSP2
         STA HPOSP3
         LDA #1      ;SET PRIORITY
         STA PRIOR
         LDA #15     ;SET MISC. COLORS
         STA COLPF0
         LDA #40
         STA COLPF1
         LDA #136
         STA COLPF2
         LDA #214
         STA COLPF3
         LDA # >DLI1 ;POINT TO DLI
         STA $0201
         LDA # <DLI1
         STA $0200
         LDX # >VBLANK ;SET VBLANK
         LDY # <VBLANK
         LDA #7
         JSR SETVBV
         LDA #0      ;CLEAR SCREEN
         TAX 
CLSCRN   STA DISP,X
         STA DISP+240,X
         INX 
         CPX #240
         BNE CLSCRN
         LDA #192    ;TURN ON DLI,
         STA NMIEN   ;VBLANK!
         RTS 
VBLANK   LDA TIMER   ;GET TIMER
         BEQ NOTIM   ;IT'S ZERO!
         DEC TIMER   ;DECREMENT TIMER
NOTIM    JMP XITVBV ;ALL DONE!
DLI1     PHA 
         LDA #$44    ;SET COLPF0
         STA WSYNC
         STA $D016
         LDA # >DLI2 ;POINT TO DLI #2
         STA $0201
         LDA # <DLI2
         STA $0200
         PLA 
         RTI 
DLI2     PHA 
DLI2C1   LDA #$58    ;SET COLPF1
         STA WSYNC
         STA $D017
         LDA # >DLI3 ;POINT TO DLI #3
         STA $0201
         LDA # <DLI3
         STA $0200
         PLA 
         RTI 
DLI3     PHA 
         LDA $CB     ;TOGGLE...
         STA WSYNC   ;FLASHING...
         CMP #$28    ;ARROW...
         BNE DLI3B   ;COLORS
         LDA #0
         STA $CB
         LDA $CC
         BPL DLI3A
         LDA #0
         STA $CC
         BEQ DLI3B
DLI3A    LDA #$8E
         STA $CC
DLI3B    LDA $CC
         STA $D016   ;PF 0
         INC $CB
         LDA # >DLI4 ;POINT TO DLI #4
         STA $0201
         LDA # <DLI4
         STA $0200
         PLA 
         RTI 
DLI4     PHA 
DLI4C1   LDA #$0E ;SET COLPF0
         STA WSYNC
         STA $D016
DLI4C2   LDA #$FC ;COLPF1
         STA $D017
DLI4C3   LDA #$92 ;COLPF2
         STA $D018
DLI4C4   LDA #$42 ;COLPF3
         STA $D019
         LDA # >DLI1 ;POINT TO DLI #1
         STA $0201
         LDA # <DLI1
         STA $0200
         PLA 
         RTI 
SHOLIV   LDA #70     ;MAN CHAR
         STA DISP2
         LDA #93     ;EQUAL SIGN
         STA DISP2+1
         LDA TOM     ;GET # LIVES,
         SEC         ;PUT ON SCREEN
         SBC #1
         ORA #$10
         STA DISP2+2
         RTS 
SCREEN   LDA # >[DISP+169] ;POINT TO...
         STA HI      ;PAD AREA...
         LDA # <[DISP+169] ;ON SCREEN
         STA LO
         LDA #1      ;AND SET UP PADS!
         STA PADCT
SETPAD   LDY PADCT
SPADLP   LDA PADATA,Y
         STA (LO),Y
         DEY 
         BPL SPADLP
         LDA PADCT
         CLC 
         ADC #2
         CMP #15
         BEQ PADEND
         STA PADCT
         LDA LO
         CLC 
         ADC #39
         STA LO
         LDA HI
         ADC #0
         STA HI
         JMP SETPAD
PADEND   JSR STODIF
         LDA #0      ;ERASE...
         STA DISP+18 ;LEVEL #
         STA DISP+38 ;ROUND #
         LDX #5      ;SHOW LVL/RND MESSAGES
SETLR    LDA LVLMSG,X
         STA DISP+12,X
         LDA RNDMSG,X
         STA DISP1+12,X
         DEX 
         BPL SETLR
         RTS 
ZEROSC   LDX #5   ;ZERO SCORE
ZSCLP    LDA #16
         STA DISP,X
         LDA CHGMSG,X ;SET CHANGE TO MSG
         STA DISP4,X
         DEX 
         BPL ZSCLP
         LDA #52     ;SET UP ARROWS...
         STA DISP5+2 ;AND COLOR INDICATOR
         LDA #47
         STA DISP5+3
         LDA #7
         STA DISP7+1
         LDA #67
         STA DISP7+2
         LDA #68
         STA DISP7+3
         LDA #8
         STA DISP7+4
         RTS 
INILVL   LDA #1      ;START AT...
         STA LEVEL   ;LEVEL 1,
         STA LVL
         STA ROUND   ;ROUND 1
         LDA #4      ;4 LIVES!
         STA TOM
         LDA #0      ;SET START FLAG
         STA START
         LDA #2      ;SET MISC VARIABLES
         STA ROW
         LDA #96
         STA COLR
         LDA #16
         STA PNT
         RTS 
SNDOFF   LDA #0      ;TURN OFF...
         STA AUDC1   ;SOUND CHANNEL 1
         STA AUDC2   ;SOUND CHANNEL 2
         STA AUDC3   ;SOUND CHANNEL 3
         STA AUDC4   ;SOUND CHANNEL 4
         RTS 
SETLD    LDA LVL     ;GET LEVEL
         CMP #1      ;LEVEL 1?
         BEQ L14     ;YES!
         CMP #4      ;LEVEL 4?
         BNE CL25    ;NO! CHECK 2/5
L14      LDA DLI4C2+1 ;SET COLOR
         STA DLI2C1+1
         RTS 
CL25     CMP #2      ;LEVEL 2?
         BEQ L25     ;YES!
         CMP #5      ;LEVEL 5?
         BNE L36     ;NO!
L25      LDA DLI4C3+1 ;SET COLOR
         STA DLI2C1+1
         RTS 
L36      LDA DLI4C4+1 ;SET COLOR
         STA DLI2C1+1
         RTS 
BONUS    LDX #20    ;PLAY MUSIC
MUSLP    LDA NOTE,X ;SET NOTE
         STA AUDF1
         LDA #$AA
         STA AUDC1
         LDA DUR,X   ;SET DURATION
         JSR WAIT    ;WAIT,
         JSR COLCYC  ;CYCLE COLORS
         DEX         ;MORE NOTES?
         BPL MUSLP   ;YES!
         LDX #60     ;DO DOWN-SLUR
MDOWN    STX AUDF1
         JSR COLCYC
         LDA #2
         JSR WAIT
         INX 
         INX 
         INX 
         CPX #81
         BCC MDOWN
MUP      STX AUDF1   ;NOW UP-SLUR
         JSR COLCYC
         LDA #2
         JSR WAIT
         DEX 
         DEX 
         DEX 
         CPX #57
         BNE MUP
         LDA #0      ;RESET BACKGND COLOR
         STA COLBK
         LDA #96
         STA COLR
         LDX #10     ;AND FADE OUT...
FADE     TXA         ;LAST NOTE
         ORA #$A0
         STA AUDC1
         LDA #4
         JSR WAIT
         DEX 
         BPL FADE
         LDA #0      ;SHUT OFF SOUND
         STA AUDC1
         LDX #9      ;SHOW BONUS MESSAGE
SHOBMS   LDA BONMSG,X
         STA DISP22+5,X
         DEX 
         BPL SHOBMS
         LDA SCORE+2 ;ADD 1000 POINTS
         CLC         ;TO SCORE
         ADC #1
         CMP #26
         BNE SHOSP2
         LDA SCORE+1
         CLC 
         ADC #1
         CMP #26
         BNE SHOSP2
         LDA SCORE+1
         CLC 
         ADC #1
         STA SCORE+1
         STA DISP+1
         LDA #16
SHOSP2   STA SCORE+2
         STA DISP+2
         LDA #200    ;WAIT 200 JIFFIES
         JSR WAIT
         RTS 
BONLIF   LDA DISP+1  ;GET SCORE
         CMP PNT     ;> BONUS AMT?
         BEQ BRRET   ;NO!
         BCS BONUSL  ;YES!
BRRET    RTS 
BONUSL   INC PNT     ;INC BONUS LEVEL
         INC TOM     ;1 MORE LIFE
         JSR SHOLIV  ;SHOW LIVES
         LDX #2      ;3 BONUS SOUNDS
         LDA #32     ;PITCH = 32
         STA AUDF1
BLS1     LDY #15     ;VOLUME 15
BLS2     TYA 
         ORA #$A0
         STA AUDC1
         LDA #3      ;LEAVE ON 3 JIFFIES
         JSR WAIT
         DEY         ;NEXT VOLUME
         BPL BLS2
         DEX         ;NEXT SOUND
         BPL BLS1
         LDA #0      ;TURN OFF SOUND
         STA AUDC1
         RTS 
STODIF   LDA OPT     ;GET DIFF FLAG
         STA OPTN1+1 ;STORE IN...
         STA OPTN2+1 ;PROGRAM
         LDA LEVEL   ;GET LEVEL
         CMP #3      ;LEVEL 3?
         BNE NOTL3   ;NO!
         LDA ROUND   ;GET ROUND
         CMP #1      ;ROUND 1?
         BEQ SET1    ;YES!
         CMP #3      ;ROUND 3?
         BNE NOTL3   ;NO!
SET1     LDA #0      ;SET DIFFICULTY
         STA OPTN2+1
DIFRTS   RTS 
NOTL3    LDA LEVEL   ;GET LEVEL #
         CMP #7      ;LEVEL 7?
         BNE NOTL7   ;NO!
         LDA #0      ;SET DIFF
         STA OPTN1+1
         RTS 
NOTL7    CMP #8      ;LEVEL 8?
         BEQ SET1    ;YES!
         CMP #9      ;LEVEL 9?
         BCC DIFRTS  ;NO!
         LDA #0      ;SET DIFF
         STA OPTN1+1
         BEQ SET1
COLCYC   LDA COLR    ;GET COLOR FLAG
         CLC         ;ADD 2
         ADC #2
         STA COLR    ;SAVE IT
         STA COLBK   ;AND SET BACKGND
         RTS 
;
;----------------
;START OF PROGRAM
;----------------
;
GAME     JSR SETUP   ;INIT.....
         JSR FIG1
;
;---------
;MAIN LOOP
;---------
;
MAIN     LDA BACK    ;BACK TO
         CMP #$00
         BEQ CHKSTK  ;CONTROLLER?
         RTS         ;yes...
CHKSTK   LDA MOVFLG  ;ALREADY
         CMP #1      ;MOVIN...
         BNE A1      ;NO!
         JSR MOVE.MAN ;YES, MOVE MAN
         JMP A2
A1       LDA STICK0  ;CHK STICK
         STA DIRECT  ;SAVE STICK POS
         JSR MOVE.MAN ;MOVE MAN
A2       JSR ROCK2   ;HANDLE ROCK 2
         LDA TEMP    ;GET ADVANCE FLAG
OPTN1    CMP #1      ;0/1 SETS DIFFICULTY
         BNE A6      ;NO ADVANCE!
         LDA #0      ;RESET ADV FLAG
         STA TEMP
         JSR ROCK3   ;HANDLE ROCK 3
         JMP A5      ;SKIP NEXT CODE
A6       LDA #1      ;SET ADV FLAG
         STA TEMP
A5       LDA TEMP1   ;GET ADV FLAG 2
OPTN2    CMP #1      ;0/1 SETS DIFFICULTY
         BNE A3      ;NO ADVANCE!
         LDA #0      ;RESET ADV FLAG 2
         STA TEMP1
         JSR ROCK1   ;HANDLE ROCK 1
         JMP A4
A3       LDA #1      ;SET ADVANCE FLAG
         STA TEMP1
A4       JSR SOUND   ;DO SOUNDS
         JSR CHECK   ;CHECK SQUARES HIT
         JSR CLEAR   ;RESET P/M COLLISION
         JSR DELAY   ;DELAY...
         JSR PL.PL   ;CHECK PLR-PLR COLL.
         JMP MAIN    ;GO AGAIN
;
;-------------------
;MOVE MAN SUBROUTINE
;-------------------
;
MOVE.MAN LDA SO1FLG  ;CHK SOUND
         CMP #1      ;FLG
         BNE CHECKDIR
         RTS 
;
CHECKDIR LDA DIRECT  ;GET STICK...
         CMP #9      ;DIRECTION
         BNE B1
         JMP DNLEFT0 ;DOWN & LEFT
B1       CMP #5
         BNE B2
         JMP DNRIGHT0 ;DOWN & RIGHT
B2       CMP #6
         BNE B3
         JMP UPRIGHT0 ;UP & RIGHT
B3       CMP #10
         BNE B4
         JMP UPLEFT0 ;UP & LEFT
B4       RTS 
;
;---------
;ROCK1 SUB
;---------
ROCK1    LDA SO2FLG  ;SOUND ON?
         CMP #1
         BNE C1      ;NO!
         RTS 
C1       LDA DRP1    ;DROPPING?
         CMP #80
         BEQ C11     ;NO!
         INC DRP1    ;NEXT DROP
         RTS 
C11      LDA B1MOV   ;MOVING...
         CMP #1
         BNE C2
         JMP MOVE1   ;YES...
C2       LDA B1DRP   ;DROPED??
         CMP #1
         BEQ C3      ;YES...
         LDA RANDOM  ;NOT YET..
         BMI C4
         RTS         ;DONT DROP
C4       LDA #1      ;SET DRP..
         STA B1DRP
         JSR BAL1DRW ;DRAW ROCK
C3       LDA FNB1DRP ;FINISHED..
         CMP #1
         BNE DROP1   ;NO...
         JMP GETDIR1
;
DROP1    JSR DOWN1   ;DROP...
         JSR DOWN1
         JSR DOWN1
         JSR DOWN1
         LDA YPOSP1  ;FINISHED..
         CMP #109
         BCS D1      ;YES...
         RTS         ;NO....
D1       LDA #1
         STA FNB1DRP ;SET FLG..
         STA SO2FLG  ;SOUND FLG
         LDA #$AF
         STA PITCH2  ;PITCH...
         RTS         ;RETURN...
;
GETDIR1  LDA #1      ;GET DIRECT
         STA B1MOV
         LDA RANDOM
         BMI E1
         LDA #0      ;0=DNRIGHT
         STA B1DIR
         JMP MOVE1
E1       LDA #1      ;1=DNLEFT
         STA B1DIR
;
MOVE1    LDA B1DIR   ;WHICH WAY?
         CMP #1      ;DNLEFT??
         BNE F1      ;NO....
         JMP DNLEFT1 ;YES...
F1       JMP DNRIGHT1
;
;----------
;ROCK 2 SUB
;----------
ROCK2    LDA SO3FLG  ;SOUND ON?
         CMP #1
         BNE G1      ;NO!
         RTS 
;
G1       LDA DRP2    ;DROPPING?
         CMP #40
         BEQ G11     ;NO!
         INC DRP2    ;INC DROP COUNT
         RTS 
G11      LDA GRNFLG  ;GRN MAN
         CMP #1      ;OUT....
         BNE G2
         JMP GREEN   ;YES...
G2       LDA BAL1FLG ;ROCK OUT??
         CMP #1
         BNE G3
         JMP MOVBAL2 ;YES...
G3       LDA ROUND   ;CAN GREEN
         CMP #2      ;COME OUT??
         BNE G4      ;NO...
         JMP GRNCAN  ;YES...
G4       CMP #4
         BEQ GRNCAN
         JMP MOVBAL2 ;NO....
;
GRNCAN   LDA MAN
         CMP #50
         BEQ MOVBAL2
         LDA OUTFLG2 ;ROCK COME
         CMP #2      ;TWICE....
         BCC MOVBAL2
         LDA RANDOM  ;GREEN OR
         BMI MOVBAL2 ;ROCK....
         INC MAN     ;IT'S GREEN MAN!
         JMP GREEN
;
MOVBAL2  LDA B2MOV   ;MOVING...
         CMP #1
         BNE H2      ;NO...
         JMP MOVE2   ;YES...
H2       LDA B2DRP   ;DROPPED??
         CMP #1
         BEQ H3      ;YES...
         LDA RANDOM  ;NOT YET...
         BMI H4
         RTS 
H4       LDA #1      ;SET DRP..
         STA B2DRP
         STA BAL1FLG
         INC OUTFLG2
         JSR BAL2DRW ;DRAW ROCK
H3       LDA FNB2DRP ;FINISHED..
         CMP #1
         BNE DROP2   ;NO...
         JMP GETDIR2
;
DROP2    JSR DOWN2   ;ADVANCE...
         JSR DOWN2   ;FOUR...
         JSR DOWN2   ;TIMES
         JSR DOWN2
         LDA YPOSP2  ;DONE DROPPING?
         CMP #109
         BCS I1      ;YES!
         RTS 
I1       LDA #1      ;FINISHED!
         STA FNB2DRP
         STA SO3FLG
         LDA #$AF    ;SET SOUND 3
         STA PITCH3
         RTS 
;
GETDIR2  LDA #1      ;ROCK 2 MOVING
         STA B2MOV
         LDA RANDOM  ;GET RANDOM DIR
         BMI J1
         LDA #0      ;IT'S DOWN & RIGHT!
         STA B2DIR
         JMP MOVE2   ;GO MOVE IT!
J1       LDA #1      ;IT'S DOWN & LEFT!
         STA B2DIR
;
MOVE2    LDA B2DIR   ;WHICH DIR
         CMP #1      ;DN & LEFT?
         BNE K1      ;NO!
         JMP DNLEFT2
K1       JMP DNRIGHT2
;
GREEN    LDA #1      ;SET GRNFLG
         STA GRNFLG
         LDA #0
         STA OUTFLG2
         LDA GRNMOV  ;MOVING?
         CMP #1
         BNE L1      ;NO!
         JMP MOVEGRN ;YES, MOVE IT!
L1       LDA GRNDRP  ;DROP YET?
         CMP #1
         BEQ L2      ;NO!
         LDA #1      ;SET FLG...
         STA GRNDRP  ;FOR DROP
         JSR GRN0    ;DRAW
L2       LDA GRNFNDRP ;DROP DONE?
         CMP #1
         BNE DROPGRN ;NO!
         JMP GEDIRGRN ;YES, GET DIRECTION
DROPGRN  JSR DOWN2   ;MOVE...
         JSR DOWN2   ;DOWN...
         JSR DOWN2   ;FOUR...
         JSR DOWN2   ;TIMES!
         LDA YPOSP2  ;DROP DONE?
         CMP #104
         BCS M1      ;YES!
         RTS 
M1       LDA #1      ;SET DROP DONE FLAG
         STA GRNFNDRP
         STA SO3FLG
         LDA #$AF    ;AND SOUND!
         STA PITCH3
         RTS 
;
GEDIRGRN LDA #1      ;SET GREEN MOVE FLAG
         STA GRNMOV
         INC GROW    ;INC GREEN ROW
         INC GROW
         LDA RANDOM  ;GET RANDOM COL MOVE
         BMI N1
         LDA #0      ;DOWN & RIGHT
         STA GRNDIR
         INC GCOL    ;INCREMENT COLUMN
         JSR GRN0    ;DRAW FACING RIGHT
         JMP MOVEGRN ;AND MOVE HIM!
N1       LDA #1      ;DOWN & LEFT
         STA GRNDIR
         DEC GCOL    ;DEC COLUMN
         JSR GRN1    ;DRAW FACING LEFT
;
MOVEGRN  LDA GRNDIR  ;GET DIRECTION
         CMP #1      ;DOWN & LEFT?
         BNE O1      ;NO!
         JMP DNLEFT2 ;MOVE IT!
O1       JMP DNRIGHT2 ;DITTO!
;
;----------
;ROCK 3 SUB
;----------
ROCK3    LDA SO4FLG  ;SOUND ON?
         CMP #1
         BNE P1      ;NO!
         RTS 
P1       LDA GRGFLG  ;GEORGE ON?
         CMP #1
         BNE P2      ;NO!
         JMP GEORGE  ;HANDLE GEORGE
P2       LDA BAL2FLG ;ROCK 2 OUT?
         CMP #1
         BNE P3      ;NO!
         JMP MOVBAL3 ;MOVE ROCK 3
P3       LDA ROUND   ;GET ROUND
         CMP #3      ;ROUND 3/4?
         BCS GRGCAN  ;YES, BRING OUT GEORGE!
         JMP MOVBAL3 ;MOVE ROCK 3!
;
GRGCAN   LDA OUTFLG  ;CAN GEORGE...
         CMP #2      ;COME OUT?
         BCC MOVBAL3 ;NO, DO ROCK 3
         LDA RANDOM  ;GET RANDOM CHANCE...
         BMI MOVBAL3 ;NO, HE CAN'T
         JMP GEORGE  ;COME ON, GEORGE!
;
MOVBAL3  LDA B3MOV   ;ROCK 3 MOVING?
         CMP #1
         BNE Q2      ;NO!
         JMP MOVE3   ;MOVE IT!
Q2       LDA B3DRP   ;ROCK 3 DROPPING?
         CMP #1
         BEQ Q3      ;YES!
         LDA RANDOM  ;READY TO DROP?
         BMI Q4      ;YES!
         RTS 
Q4       LDA #1      ;SET DROP FLAG
         STA B3DRP
         STA BAL2FLG
         INC OUTFLG  ;INC GEORGE CHANCE
         JSR BAL3DRW ;DRAW ROCK 3
Q3       LDA FNB3DRP ;IS ROCK 3...
         CMP #1      ;DROP COMPLETE?
         BNE DROP3   ;NO!
         JMP GETDIR3 ;YES, GET DIRECTION
;
DROP3    JSR DOWN3   ;MOVE...
         JSR DOWN3   ;DOWN...
         JSR DOWN3   ;FOUR...
         JSR DOWN3   ;TIMES
         LDA YPOSP3  ;DROP DONE?
         CMP #109
         BCS R1      ;YES!
         RTS 
R1       LDA #1      ;SET DROP...
         STA FNB3DRP ;FINISH FLAG
         STA SO4FLG
         LDA #$AF    ;AND SOUND!
         STA PITCH4
         RTS 
;
GETDIR3  LDA #1      ;SET ROCK 3 MOVE FLAG
         STA B3MOV
         LDA RANDOM  ;GET RANDOM CHANCE
         BMI S1
         LDA #0      ;DOWN & RIGHT!
         STA B3DIR
         JMP MOVE3   ;MOVE IT
S1       LDA #1      ;DOWN & LEFT!
         STA B3DIR
;
MOVE3    LDA B3DIR   ;GET ROCK 3 DIRECTION
         CMP #1      ;DOWN & LEFT?
         BNE T1      ;NO!
         JMP DNLEFT3 ;MOVE IT!
T1       JMP DNRIGHT3 ;DITTO!
;
GEORGE   LDA #1      ;SET...
         STA GRGFLG  ;GEORGE FLAG
         LDA GRGMOV  ;GEORGE MOVING?
         CMP #1
         BNE U1      ;NO!
         JMP MOVGRG  ;GO MOVE HIM!
U1       LDA GRGDRP  ;GEORGE DROPPING?
         CMP #1
         BEQ U2      ;YES!
         LDA #1      ;OK, START...
         STA GRGDRP  ;GEORGE DROP
         JSR GEORGE0 ;GEORGE FACING LEFT
U2       LDA FNGRDRP ;GEORGE DROP DONE?
         CMP #1
         BNE DROPGRG ;NO, DROP HIM!
         JMP GETDRGRG ;GET GEORGE DIRECTION
;
DROPGRG  JSR DOWN3   ;MOVE GEORGE...
         JSR DOWN3   ;DOWN...
         JSR DOWN3   ;FOUR...
         JSR DOWN3   ;TIMES!
         LDA YPOSP3  ;DROP DONE?
         CMP #98
         BCS V1      ;YES!
         RTS 
V1       LDA #1      ;SET GEORGE'S DROP...
         STA FNGRDRP ;DONE FLAG
         STA SO4FLG
         LDA #$AF    ;SET SOUND
         STA PITCH4
         RTS 
;
GETDRGRG LDA #1      ;SET GEORGE...
         STA GRGMOV  ;MOVING FLAG
         LDA PCOL    ;GET DIRECTION...
         CMP SCOL    ;BASED ON PLAYER POS.
         BCS RIGHT   ;GO RIGHT!
         LDA PROW    ;GET UP/DOWN
         CMP SROW
         BEQ W1      ;UP!
         BCC W1      ;UP!
         JSR GEORGE0 ;FACING LEFT & DOWN
         DEC SCOL    ;MOVE LEFT
         INC SROW    ;MOVE DOWN...
         INC SROW    ;2 TIMES
         LDA #0      ;0 = DOWN & LEFT
         STA GRDIR
         JMP MOVGRG  ;MOVE GEORGE!
W1       JSR GEORGE2 ;FACING LEFT & UP
         DEC SCOL    ;MOVE LEFT
         DEC SROW    ;MOVE UP...
         DEC SROW    ;2 TIMES
         LDA #2      ;2 = UP & LEFT
         STA GRDIR
         JMP MOVGRG  ;MOVE GEORGE!
RIGHT    LDA PROW    ;GET UP/DOWN
         CMP SROW
         BEQ X1      ;UP!
         BCC X1      ;UP!
         JSR GEORGE1 ;FACING RIGHT & DOWN
         INC SCOL    ;MOVE RIGHT
         INC SROW    ;MOVE DOWN...
         INC SROW    ;2 TIMES
         LDA #1      ;1 = RIGHT & DOWN
         STA GRDIR
         JMP MOVGRG  ;MOVE GEORGE!
X1       JSR GEORGE3 ;FACING RIGHT & UP
         INC SCOL    ;MOVE RIGHT
         DEC SROW    ;MOVE UP...
         DEC SROW    ;2 TIMES
         LDA #3      ;3 = RIGHT & UP
         STA GRDIR
;
MOVGRG   LDA GRDIR   ;GET GEORGE DIRECTION
         CMP #0      ;DOWN & LEFT?
         BNE Y1      ;NO!
         JMP DNLEFT3
Y1       CMP #1      ;DOWN & RIGHT?
         BNE Y2      ;NO!
         JMP DNRIGHT3
Y2       CMP #2      ;UP & LEFT?
         BNE Y3      ;NO!
         JMP UPLEFT3
Y3       JMP UPRIGHT3
;
;----------------
;SOUND SUBROUTINE
;----------------
;
SOUND    LDA SO1FLG  ;SOUND 1 ON?
         CMP #1
         BEQ Z1      ;YES!
         JMP SO2     ;NO, DO SOUND 2
Z1       LDA PITCH1  ;GET SOUND 1 PITCH
         STA AUDC1
         DEC PITCH1  ;NEXT PITCH
         LDA PITCH1  ;GET PITCH
         CMP #$A0    ;ALL DONE?
         BEQ Z2      ;YES!
         JMP SO2
Z2       LDA #0      ;TURN OFF...
         STA AUDC1   ;SOUND 1,
         STA SO1FLG  ;SOUND 1 FLAG,
         STA MOVFLG  ;MOVEMENT FLAG
         LDA #8
         STA COUNT1
         LDA P0PF    ;MAN ON SQUARE?
         CMP #0
         BNE GETLEVEL ;YES!
         JSR FALL    ;UH-OH, HE FELL!
         RTS         ;HE'S OK
;
GETLEVEL JSR UPDATMAN ;MOVE MAN
         LDA LEVEL   ;GO TO...
         CMP #1      ;APPROPRIATE...
         BNE AA1     ;LEVEL HANDLER!
         JMP LEVEL1
AA1      CMP #2
         BNE AA2
         JMP LEVEL2
AA2      CMP #3
         BNE AA4
         JMP LEVEL3
AA4      CMP #4
         BNE AA5
         JMP LEVEL4
AA5      CMP #5
         BNE AA6
         JMP LEVEL5
AA6      CMP #6
         BNE AA7
         JMP LEVEL6
AA7      CMP #7
         BNE AA8
         JMP LEVEL3
AA8      JMP LEVEL6
;
LEVEL1   LDA P0PF    ;HIT
         CMP #1      ;PLAYFIELD 0?
         BNE BB1     ;NO...
         INC NUMSQ   ;YES-INCREMENT SQUARES
         JSR PLAYFLD1 ;CHANGE IT TO PF1
BB1      JMP SO2
;
LEVEL2   LDA P0PF    ;HIT
         CMP #1      ;PLAYFIELD 0?
         BNE CC1     ;NO...
         JSR PLAYFLD1 ;CHANGE IT TO PF1
         JMP SO2     ;AND PROCEED
CC1      CMP #2      ;PLAYFIELD 1?
         BNE CC2     ;NO...
         INC NUMSQ   ;1 MORE SQUARE
         JSR PLAYFLD2 ;CHANGE IT TO PF2!
CC2      JMP SO2     ;AND PROCEED
;
LEVEL4   LDA P0PF    ;HIT PLAYFIELD 0?
         CMP #1
         BNE DD1     ;NO...
         INC NUMSQ   ;1 MORE SQUARE!
         JSR PLAYFLD1 ;CHANGE TO PF1
         JMP SO2     ;PROCEED!
DD1      DEC NUMSQ   ;DEDUCT SQUARE!
         JSR PLAYFLD0 ;BACK TO PF0
         JMP SO2     ;AND GO ON.
;
LEVEL3   LDA P0PF    ;HIT PLAYFIELD 0?
         CMP #1
         BNE EE1     ;NO...
         JSR PLAYFLD1 ;CHANGE TO PF1
         JMP SO2     ;AND PROCEED
EE1      CMP #2      ;HIT PLAYFIELD 2?
         BNE EE2     ;NO...
         JSR PLAYFLD2 ;CHANGE TO PF2
         JMP SO2     ;AND PROCEED
EE2      CMP #4      ;HIT PLAYFIELD 2?
         BNE SO2     ;NO...
         INC NUMSQ   ;1 MORE SQUARE
         JSR PLAYFLD3 ;CHANGE TO PF3
         JMP SO2     ;AND PROCEED
;
LEVEL5   LDA P0PF    ;HIT PLAYFIELD 0?
         CMP #1
         BNE FF1     ;NO...
         JSR PLAYFLD1 ;CHANGE TO PF1
         JMP SO2     ;PROCEED
FF1      CMP #2      ;HIT PLAYFIELD 1?
         BNE FF2     ;NO...
         INC NUMSQ   ;1 MORE SQUARE
         JSR PLAYFLD2 ;CHANGE TO PF2
         JMP SO2     ;PROCEED
FF2      DEC NUMSQ   ;1 LESS SQUARE
         JSR PLAYFLD1 ;CHANGE TO PF1
         JMP SO2     ;PROCEED
;
LEVEL6   LDA P0PF    ;HIT PLAYFIELD 0?
         CMP #1
         BNE GG1     ;NO...
         JSR PLAYFLD1 ;CHANGE TO PF1
         JMP SO2     ;PROCEED
GG1      CMP #2      ;HIT PLAYFIELD 1?
         BNE GG2     ;NO...
         JSR PLAYFLD2 ;CHANGE TO PF2
         JMP SO2     ;PROCEED
GG2      CMP #4      ;HIT PLAYFIELD 2?
         BNE GG3     ;NO...
         INC NUMSQ   ;1 MORE SQUARE
         JSR PLAYFLD3 ;CHANGE TO PF3
         JMP SO2     ;PROCEED
GG3      DEC NUMSQ   ;1 LESS SQUARE
         JSR PLAYFLD2 ;CHANGE TO PF2
;
SO2      LDX #0      ;ROCK 1
         LDY #0
         JSR BALCHK  ;SEE IF IT FELL
         LDA FALOFF  ;DID IT FALL?
         CMP #1
         BEQ HH1     ;YES!
         JMP SO3     ;NO, PROCEED
HH1      LDY YPOSP1  ;ERASE ROCK 1
         LDX #0
         TXA 
HH2      STA PLAY1,Y
         INX 
         INY 
         CPX #10
         BNE HH2
         LDA #0      ;RESET DROP FLAG
         STA DRP1
         LDX #0      ;CLR OTHER FLAGS
         JSR CLRFLG
;
SO3      LDA GRNFLG  ;GREEN MAN ACTIVE?
         CMP #1
         BNE II99    ;NO!
         JMP GRNCHK  ;SEE IF HE FELL
II99     LDX #1      ;ROCK 2
         LDY #2
         JSR BALCHK  ;SEE IF IT FELL
         LDA FALOFF  ;DID ROCK 2 FALL?
         CMP #1
         BEQ II1     ;YES!
         JMP SO4     ;NO, PROCEED
II1      LDY YPOSP2  ;ERASE ROCK 2
         LDX #0
         TXA 
II2      STA PLAY2,Y
         INX 
         INY 
         CPX #10
         BNE II2
         LDA #0      ;RESET DROP FLAG
         STA DRP2
         STA BAL1FLG
         LDX #1      ;AND OTHER FLAGS
         JSR CLRFLG
;
SO4      LDA GRGFLG  ;GEORGE ACTIVE?
         CMP #1
         BEQ GRGCHK  ;YES!
         LDX #2      ;CHECK ROCK 3
         LDY #4
         JSR BALCHK  ;SEE IF IT FELL
         LDA FALOFF  ;DID IT FALL?
         CMP #1
         BEQ JJ1     ;YES!
         RTS 
JJ1      LDY YPOSP3  ;ERASE ROCK 3
         LDX #0
         TXA 
JJ2      STA PLAY3,Y
         INY 
         INX 
         CPX #10
         BNE JJ2
         LDA #0      ;CLEAR ROCK 3 FLAG
         STA BAL2FLG
         LDX #2      ;AND OTHER FLAGS
         JSR CLRFLG
         RTS 
;
GRGCHK   LDA SO4FLG  ;SOUND ON?
         CMP #1
         BEQ KK1     ;YES!
         RTS 
KK1      LDA PITCH4  ;SET VOLUME
         STA AUDC4
         DEC PITCH4  ;NEXT VOLUME
         LDA PITCH4  ;SOUND DONE?
         CMP #$A0
         BEQ KK2     ;YES!
         RTS 
KK2      LDA P3PF    ;DID GEORGE...
         CMP #0      ;HIT PF?
         BNE KK3     ;YES!
         LDA #5      ;ADD 500 POINTS...
         STA SUM     ;TO SCORE
         JSR ADD200
         JSR RESET   ;RESET GEORGE
         RTS 
KK3      LDA #0      ;ZERO...
         STA AUDC4   ;SOUND 4,
         STA SO4FLG  ;SOUND 4 FLAG
         STA GRGMOV  ;GEORGE MOVE FLAG
         LDA #8
         STA COUNT4
         RTS 
;
GRNCHK   LDA SO3FLG  ;SOUND 3 ON?
         CMP #1
         BEQ LL1     ;YES!
         JMP SO4     ;NO, DO SOUND 4
LL1      LDA PITCH3  ;SET SOUND 3 VOLUME
         STA AUDC3
         DEC PITCH3  ;NEXT VOLUME
         LDA PITCH3  ;SOUND 3 DONE?
         CMP #$A0
         BEQ LL2     ;YES!
         JMP SO4     ;NO, DO SOUND 4
LL2      LDA #0      ;TURN OFF SOUND 3
         STA AUDC3
         LDA P2PF    ;DID GREEN MAN...
         CMP #0      ;HIT PLAYFIELD?
         BNE GOBACK  ;YES!
HITGRN   JSR ERASEGRN ;GREEN MAN GONE
         LDA #0      ;RESET GREEN MAN
         STA GRNDRP
         STA GRNFNDRP
         STA GRNFLG
         STA GRNMOV
         STA SO3FLG
         STA DRP2
         LDA #10     ;RESET ROW
         STA GROW
         LDA #8      ;RESET COLUMN
         STA GCOL
         STA COUNT3
         LDA #45
         STA YPOSP2
         LDA #116
         STA HPOSP2
         STA XPOSP2
         RTS 
GOBACK   LDA #0      ;RESET SOUND 3
         STA SO3FLG
         STA GRNMOV
         LDA #8
         STA COUNT3
         LDA P2PF    ;DID GREEN HIT PF0?
         CMP #1
         BNE MM4     ;NO!
         RTS 
MM4      JSR DECNUM  ;DEC # SQUARES
         LDA # <PF0  ;CHANGE TO PF0
         STA FILE
         LDA # >PF0
         STA FILE+1
         LDA GCOL    ;SET COLUMN
         STA COL
         LDA GROW    ;AND ROW
         STA ROW
         JSR CHANGE  ;CHANGE IT!
         RTS 
DECNUM   LDA LEVEL ;GET LEVEL
         CMP #1
         BEQ NN1     ;LEVEL 1
         CMP #2
         BEQ NN2     ;LEVEL 2
         CMP #3
         BEQ NN4     ;LEVEL 3
         CMP #4
         BEQ NN1     ;LEVEL 4
         CMP #5
         BEQ NN2     ;LEVEL 5
         JMP NN4     ;LEVEL 6
;
NN1      LDA P2PF    ;HIT PF1?
         CMP #2
         BEQ DECR    ;YES!
         RTS 
NN2      LDA P2PF    ;HIT PF2?
         CMP #4
         BEQ DECR    ;YES!
         RTS 
NN4      LDA P2PF    ;HIT PF3?
         CMP #8
         BEQ DECR    ;YES!
         RTS 
DECR     DEC NUMSQ   ;1 LESS SQUARE
         RTS 
BALCHK   LDA SO2FLG,X ;SOUND 2 ON?
         CMP #1
         BEQ OO1     ;YES!
         RTS 
OO1      LDA PITCH2,X ;SET VOLUME
         STA AUDC2,Y
         DEC PITCH2,X ;NEXT VOLUME
         LDA PITCH2,X ;ALL DONE?
         CMP #$A0
         BEQ OO2     ;YES!
         RTS 
OO2      LDA #0      ;TURN OFF...
         STA AUDC2,Y ;SOUND 2
         LDA P1PF,X  ;DID ROCK...
         CMP #0      ;HIT PF?
         BNE OO3     ;YES!
         LDA #1      ;UH-OH!  IT FELL!
         STA FALOFF  ;SET FALL FLAG
         RTS 
OO3      LDA #0      ;RESET SOUND FLAG
         STA SO2FLG,X
         STA B1MOV,X
         LDA #8
         STA COUNT2,X
         RTS 
;
CLRFLG   LDA #$00    ;RESET MISC FLAGS
         STA B1MOV,X
         STA SO2FLG,X
         STA B1DRP,X
         STA FNB1DRP,X
         STA FALOFF
         LDA #8
         STA COUNT2,X
         LDA #45
         STA YPOSP1,X
         LDA HPOS,X
         STA HPOSP1,X
         STA XPOSP1,X
         RTS 
;
UPDATMAN LDA DIRECT  ;GET DIR...
         CMP #9
         BEQ PP1     ;DOWN & LEFT
         CMP #5
         BEQ PP2     ;DOWN & RIGHT
         CMP #6
         BEQ PP4     ;UP & RIGHT
         CMP #10
         BEQ PP3     ;UP & LEFT
         RTS 
;
PP1      DEC PCOL    ;MOVE LEFT
         INC PROW    ;MOVE DOWN...
         INC PROW    ;2 TIMES
         RTS 
PP2      INC PCOL    ;MOVE RIGHT
         INC PROW    ;MOVE DOWN...
         INC PROW    ;2 TIMES
         RTS 
PP3      DEC PCOL    ;MOVE LEFT
         DEC PROW    ;MOVE UP...
         DEC PROW    ;2 TIMES
         RTS 
PP4      INC PCOL    ;MOVE RIGHT
         DEC PROW    ;MOVE UP...
         DEC PROW    ;2 TIMES
         RTS 
;
PCUBPOS  LDA PCOL    ;SAVE SQUARE POS.
         STA COL
         LDA PROW
         STA ROW
         RTS 
;
;-----
;DELAY
;-----
DELAY    LDX #$FF    ;TIME DELAY
QQ1      LDY TIME
QQ2      DEY 
         BNE QQ2
         DEX 
         BNE QQ1
         RTS 
;
;-------------
;SETUP ROUTINE
;-------------
;
SETUP    LDA START   ;INIT ALL?
         CMP #$00
         BNE PART    ;NO...
         LDA #$00    ;YES...
         STA NUMSQ
         LDA #$10    ;RESET
         LDX #0      ;SCORE...
RESET1   STA SCORE,X
         INX 
         CPX #$06
         BNE RESET1
;
PART     LDA #$00    ;SET FLG'S
         LDX #0      ;TO ZERO..
SETZERO  STA BACK,X
         INX 
         CPX #100
         BNE SETZERO
         LDA #$08    ;SET COUNT
         STA COUNT1
         STA COUNT2
         STA COUNT3
         STA COUNT4
;
         LDA #9      ;SET PLAYER
         STA PCOL    ;COLUMN &
         LDA #8      ;ROW...
         STA PROW
;
         LDA #10     ;SET GEORGE
         STA SCOL    ;&GREEN
         STA SROW    ;COLUMN...
         STA GROW
         LDA #8
         STA GCOL
;
         LDA #124    ;PM DATA..
         STA PXPOS
         STA HPOSP0
         LDA #85
         STA PYPOS
         LDA #116
         STA XPOSP1
         STA XPOSP2
         STA HPOSP1
         STA HPOSP2
         STA HPOS
         STA HPOS+1
         LDA #132
         STA XPOSP3
         STA HPOS+2
         STA HPOSP3
         LDA #45
         STA YPOSP1
         STA YPOSP2
         STA YPOSP3
;
         CLC         ;SET UP...
         LDA #170    ;SOUND...
         STA AUDF1   ;FREQUENCIES
         ADC #10
         STA AUDF2
         ADC #10
         STA AUDF3
         ADC #10
         STA AUDF4
;
         LDA #$01    ;CLR COLLISIONS
         STA HITCLR
;
PMCLR    LDA #$00    ;ERASE P/M
         LDX #$FF    ;MEMORY
ERASEMEM STA PLAY0,X
         STA PLAY1,X
         STA PLAY2,X
         STA PLAY3,X
         DEX 
         BNE ERASEMEM
         RTS         ;RETURN...
;
;---------------
;FIGURES FOR MAN
;---------------
;
FIG1     LDA DIRFLG  ;GET MOVE DIRECTION
         CMP #9      ;DOWN & LEFT?
         BEQ RR2     ;YES!
         LDY PYPOS   ;DRAW FIGURE 1
         LDX #0
RR1      LDA FIG1DAT,X
         STA PLAY0,Y
         INY 
         INX 
         CPX #16
         BNE RR1
RR2      RTS 
;
FIG2     LDA DIRFLG  ;GET MOVE DIRECTION
         CMP #5      ;DOWN & RIGHT?
         BEQ SS2     ;YES!
         JSR ERASEMAN ;ERASE MAN
         LDY PYPOS   ;DRAW FIGURE 2
         LDX #0
SS1      LDA FIG2DAT,X
         STA PLAY0,Y
         INY 
         INX 
         CPX #16
         BNE SS1
SS2      RTS 
;
FIG3     LDA DIRFLG  ;GET DIRECTION
         CMP #10     ;UP & LEFT?
         BEQ TT2     ;YES!
         JSR ERASEMAN ;ERASE MAN
         LDY PYPOS   ;DRAW FIGURE 3
         LDX #0
TT1      LDA FIG3DAT,X
         STA PLAY0,Y
         INY 
         INX 
         CPX #15
         BNE TT1
TT2      RTS 
;
FIG4     LDA DIRFLG  ;GET DIRECTION
         CMP #6      ;UP & RIGHT?
         BEQ UU2     ;YES!
         JSR ERASEMAN ;ERASE MAN
         LDY PYPOS   ;DRAW FIGURE 4
         LDX #0
UU1      LDA FIG4DAT,X
         STA PLAY0,Y
         INY 
         INX 
         CPX #15
         BNE UU1
UU2      RTS 
GRN0     JSR ERASEGRN ;ERASE GREEN MAN
         LDY YPOSP2  ;DRAW GREEN MAN...
         LDX #$00    ;FACING RIGHT
VV1      LDA GRN1DAT,X
         STA PLAY2,Y
         INX 
         INY 
         CPX #13
         BNE VV1
         JSR SETGRN  ;SET GREEN PARAMETERS
         RTS 
;
GRN1     JSR ERASEGRN ;ERASE GREEN MAN
         LDY YPOSP2  ;DRAW GREEN MAN...
         LDX #0      ;FACING LEFT
WW1      LDA GRN2DAT,X
         STA PLAY2,Y
         INY 
         INX 
         CPX #13
         BNE WW1
         JSR SETGRN  ;SET GREEN PARAMETERS
         RTS 
;
ERASEGRN LDY YPOSP2 ;ERASE GREEN MAN
         LDX #0
         TXA 
XX1      STA PLAY2,Y
         INX 
         INY 
         CPX #15
         BNE XX1
         RTS 
;
SETGRN   LDA #13     ;GREEN 13 LINES TALL
         STA LENGTH
         LDA #11
         STA ADDNUM
         LDA #198    ;AND HE'S GREEN!
         STA PCOLR2
         RTS 
;
;
;ERASE MAN SUB
;
ERASEMAN LDY PYPOS
         LDX #$00
         LDA #$00
YY1      STA PLAY0,Y
         INY 
         INX 
         CPX #20
         BNE YY1
         RTS 
;
;FIGURES FOR GEORGE !!
;
GEORGE0  JSR ERASEGRG ;ERASE GEORGE
         LDY YPOSP3  ;DRAW GEORGE...
         LDX #0      ;IN POSISION 0
ZZ1      LDA GRG0DAT,X
         STA PLAY3,Y
         INY 
         INX 
         CPX #18
         BNE ZZ1
         JSR SETGRG  ;SET GEORGE PARAMETERS
         RTS 
;
GEORGE1  JSR ERASEGRG ;ERASE GEORGE
         LDY YPOSP3  ;DRAW GEORGE...
         LDX #0      ;IN POSITION 1
AAA1     LDA GRG1DAT,X
         STA PLAY3,Y
         INY 
         INX 
         CPX #18
         BNE AAA1
         RTS 
;
GEORGE2  JSR ERASEGRG ;ERASE GEORGE
         LDY YPOSP3  ;DRAW GEORGE...
         LDX #0      ;IN POSITION 2
BBB1     LDA GRG2DAT,X
         STA PLAY3,Y
         INY 
         INX 
         CPX #18
         BNE BBB1
         RTS 
;
GEORGE3  JSR ERASEGRG ;ERASE GEORGE
         LDY YPOSP3  ;DRAW GEORGE...
         LDX #0      ;IN POSITION 3
CCC1     LDA GRG3DAT,X
         STA PLAY3,Y
         INY 
         INX 
         CPX #18
         BNE CCC1
         RTS 
;
SETGRG   LDA #19     ;GEORGE 19 LINES TALL
         STA LENGTH3
         LDA #16
         STA ADDNUM3
         LDA #86     ;GEORGE PURPLE!
         STA PCOLR3
         RTS 
;
ERASEGRG LDY YPOSP3 ;ERASE GEORGE
         LDX #0
         TXA 
DDD1     STA PLAY3,Y
         INY 
         INX 
         CPX #20
         BNE DDD1
         RTS 
;
;-----------------
;CHANGE SQUARE SUB
;-----------------
;
CHANGE   LDA ROW     ;GET ROW,
         STA LO      ;SAVE IN...
         LDA #0      ;MULT AREA
         STA HI
         ASL LO      ;*2
         ASL LO      ;*4
         LDA LO      ;SAVE *4 VALUE
         STA TIMES4
         ASL LO      ;*8
         ASL LO      ;*16
         ROL HI
         LDA LO      ;+*4 = *20
         CLC 
         ADC TIMES4
         STA LO
         LDA HI
         ADC #0
         STA HI
         LDA LO      ;NOW ADD COLUMN
         CLC 
         ADC COL
         STA LO
         LDA HI
         ADC #0
         STA HI
         LDA LO      ;NOW DISPLAY START
         CLC 
         ADC # <DISP
         STA LO
         LDA HI
         ADC # >DISP
         STA HI
         LDY #1
         LDA (FILE),Y ;GET RIGHT OF SQUARE
         STA (LO),Y  ;PUT ON SCREEN
         DEY 
         LDA (FILE),Y ;GET LEFT OF SQUARE
         STA (LO),Y  ;PUT ON SCREEN
         RTS         ;ALL DONE!
;
;-------------
;FALL OFF SUB
;-------------
FALL     LDA #$04    ;SET PRIOR
         STA PRIOR
         LDA #2
         STA TIME
         JSR TURNOFF
         LDA #$AA
         STA AUDC1
EEE1     LDA PYPOS   ;GET YPOS
         STA AUDF1   ;MAKE SO...
         CMP #240    ;OFF SCR...
         BEQ ENDLP   ;YES...
         JSR DOWN0   ;NO...
         JSR DELAY   ;DELAY...
         JMP EEE1    ;DO AGAIN
ENDLP    LDA #$6F
         STA AUDC1
         CLC 
         LDA #130
FFF1     STA AUDF1
         ADC #1
         JSR DELAY
         CMP #210
         BNE FFF1
         LDA #$00
         STA AUDF1
         STA AUDC1
         LDA #3      ;3=FALL
         STA BACK
         RTS 
;---------
;DRAW ROCK
;---------
BAL1DRW  LDY YPOSP1  ;DRAW ROCK 1
         LDX #$00
GGG1     LDA BALDAT,X
         STA PLAY1,Y
         INY 
         INX 
         CPX #10
         BNE GGG1
         RTS 
;
BAL2DRW  LDY YPOSP2  ;DRAW ROCK 2
         LDX #0
HHH1     LDA BALDAT,X
         STA PLAY2,Y
         INX 
         INY 
         CPX #10
         BNE HHH1
         LDA #10     ;SET ROCK PARAMS
         STA LENGTH  ;(INSTEAD OF...
         LDA #8      ;GREEN MAN)
         STA ADDNUM
         LDA #52
         STA PCOLR2
         RTS 
;
BAL3DRW  LDY YPOSP3  ;DRAW ROCK 3
         LDX #0
III1     LDA BALDAT,X
         STA PLAY3,Y
         INY 
         INX 
         CPX #10
         BNE III1
         LDA #10     ;SET ROCK PARAMS
         STA LENGTH3 ;(INSTEAD OF...
         LDA #8      ;GEORGE!)
         STA ADDNUM3
         LDA #52
         STA PCOLR3
         RTS 
;
;-------------
;MOVEMENT SUBS
;-------------
;
DNLEFT0  JSR FIG1    ;SHAPE...
         LDA #1
         STA MOVFLG
         JSR LEFT0   ;MOVE...
         JSR DOWN0
         JSR DOWN0
         DEC COUNT1
         BNE JJJ1
         JSR SETFLG0 ;RETURN
JJJ1     RTS 
;
DNRIGHT0 JSR FIG2    ;SHAPE...
         LDA #1
         STA MOVFLG
         JSR RIGHT0  ;MOVE...
         JSR DOWN0
         JSR DOWN0
         DEC COUNT1  ;DONE...
         BNE KKK1
         JSR SETFLG0 ;RETURN
KKK1     RTS 
;
UPLEFT0  JSR FIG3    ;SHAPE...
         LDA #1
         STA MOVFLG
         JSR LEFT0   ;MOVE...
         JSR UP0
         JSR UP0
         DEC COUNT1  ;DONE???
         BNE LLL1
         JSR SETFLG0 ;SETFLG...
LLL1     RTS 
;
UPRIGHT0 JSR FIG4    ;SHAPE...
         LDA #1
         STA MOVFLG
         JSR RIGHT0  ;MOVE...
         JSR UP0
         JSR UP0
         DEC COUNT1  ;DONE???
         BNE MMM1
         JSR SETFLG0
MMM1     RTS 
;
LEFT0    DEC PXPOS   ;MOVE MAN LEFT
         LDA PXPOS
         STA HPOSP0
         RTS 
;
RIGHT0   INC PXPOS   ;MOVE MAN RIGHT
         LDA PXPOS
         STA HPOSP0
         RTS 
;
UP0      LDY PYPOS   ;MOVE MAN UP
         LDX #$00
NNN1     LDA PLAY0,Y
         STA PLAY0-1,Y
         INX 
         INY 
         CPX #17
         BNE NNN1
         DEC PYPOS
         RTS 
;
DOWN0    LDX #0      ;MOVE MAN DOWN
         CLC 
         LDA PYPOS
         ADC #14
         TAY 
OOO1     LDA PLAY0,Y
         STA PLAY0+1,Y
         DEY 
         INX 
         CPX #17
         BNE OOO1
         INC PYPOS
         RTS 
;
;ROCK 1 MOVEMENT
;
DNLEFT1  JSR LEFT1   ;MOVE LEFT,
         JSR DOWN1   ;MOVE DOWN...
         JSR DOWN1   ;2 TIMES
         DEC COUNT2
         BNE PPP1
         LDX #0
         JSR SETFLG  ;SET UP SOUND
PPP1     RTS 
;
DNRIGHT1 JSR RIGHT1  ;MOVE RIGHT,
         JSR DOWN1   ;MOVE DOWN...
         JSR DOWN1   ;2 TIMES
         DEC COUNT2
         BNE QQQ1
         LDX #0
         JSR SETFLG  ;SET UP SOUND
QQQ1     RTS 
;
LEFT1    DEC XPOSP1  ;MOVE ROCK 1 LEFT
         LDA XPOSP1
         STA HPOSP1
         RTS 
;
RIGHT1   INC XPOSP1  ;MOVE ROCK 1 RIGHT
         LDA XPOSP1
         STA HPOSP1
         RTS 
;
;
DOWN1    LDX #0     ;MOVE PLAYER 1 DOWN
         CLC 
         LDA YPOSP1
         ADC #8
         TAY 
RRR1     LDA PLAY1,Y
         STA PLAY1+1,Y
         DEY 
         INX 
         CPX #10
         BNE RRR1
         INC YPOSP1
         RTS 
;
;
;ROCK 2 MOVEMENT
;
;SAME AS ROCK 1, BUT FOR ROCK 2
;
DNLEFT2  JSR LEFT2
         JSR DOWN2
         JSR DOWN2
         DEC COUNT3
         BNE SSS1
         LDX #1
         JSR SETFLG
SSS1     RTS 
;
DNRIGHT2 JSR RIGHT2
         JSR DOWN2
         JSR DOWN2
         DEC COUNT3
         BNE TTT1
         LDX #1
         JSR SETFLG
TTT1     RTS 
;
LEFT2    DEC XPOSP2
         LDA XPOSP2
         STA HPOSP2
         RTS 
;
RIGHT2   INC XPOSP2
         LDA XPOSP2
         STA HPOSP2
         RTS 
;
DOWN2    LDX #0
         CLC 
         LDA YPOSP2
         ADC ADDNUM
         TAY 
UUU1     LDA PLAY2,Y
         STA PLAY2+1,Y
         DEY 
         INX 
         CPX LENGTH
         BNE UUU1
         INC YPOSP2
         RTS 
;
;ROCK 3 MOVEMENT
;
;SAME AS ROCK 1, BUT FOR ROCK 3
;
DNLEFT3  JSR LEFT3
         JSR DOWN3
         JSR DOWN3
         DEC COUNT4
         BNE VVV1
         LDX #2
         JSR SETFLG
VVV1     RTS 
;
DNRIGHT3 JSR RIGHT3
         JSR DOWN3
         JSR DOWN3
         DEC COUNT4
         BNE WWW1
         LDX #2
         JSR SETFLG
WWW1     RTS 
;
UPLEFT3  JSR LEFT3
         JSR UP3
         JSR UP3
         DEC COUNT4
         BNE XXX1
         LDX #2
         JSR SETFLG
XXX1     RTS 
;
UPRIGHT3 JSR RIGHT3
         JSR UP3
         JSR UP3
         DEC COUNT4
         BNE YYY1
         LDX #2
         JSR SETFLG
YYY1     RTS 
;
LEFT3    DEC XPOSP3
         LDA XPOSP3
         STA HPOSP3
         RTS 
;
RIGHT3   INC XPOSP3
         LDA XPOSP3
         STA HPOSP3
         RTS 
;
UP3      LDY YPOSP3
         LDX #0
ZZZ1     LDA PLAY3,Y
         STA PLAY3-1,Y
         INY 
         INX 
         CPX LENGTH3
         BNE ZZZ1
         DEC YPOSP3
         RTS 
;
DOWN3    LDX #0
         CLC 
         LDA YPOSP3
         ADC ADDNUM3
         TAY 
AAAA1    LDA PLAY3,Y
         STA PLAY3+1,Y
         DEY 
         INX 
         CPX LENGTH3
         BNE AAAA1
         INC YPOSP3
         RTS 
;
SETFLG0  LDA #1  ;SET FLG
         STA SO1FLG
         STA MOVFLG
         LDA #$AF
         STA PITCH1  ;PITCH...
         LDA DIRECT
         STA DIRFLG
         RTS 
;
SETFLG   LDA #1
         STA SO2FLG,X
         LDA #$AF
         STA PITCH2,X ;PITCH...
         RTS 
;
PLAYFLD0 LDA # <PF0 ;POINT TO...
         STA FILE    ;COLOR 0 SQUARE
         LDA # >PF0
DOSQUARE STA FILE+1
         JSR ADD25   ;ADD 25 POINTS
         JSR PCUBPOS ;GET CUBE POS
         JSR CHANGE  ;CHANGE COLOR
         RTS 
;
PLAYFLD1 LDA # <PF1 ;POINT TO...
         STA FILE    ;COLOR 1 SQUARE
         LDA # >PF1
         JMP DOSQUARE ;DO MISC STUFF
;
PLAYFLD2 LDA # <PF2 ;POINT TO...
         STA FILE    ;COLOR 2 SQUARE
         LDA # >PF2
         JMP DOSQUARE ;DO MISC STUFF
;
PLAYFLD3 LDA # <PF3 ;POINT TO...
         STA FILE    ;COLOR 3 SQUARE
         LDA # >PF3
         JMP DOSQUARE ;ETC.
;
CLEAR    LDA #$01  ;RESET COLLISIONS
         STA HITCLR
         RTS 
;
TURNOFF  LDA #$00    ;NO AUDIO...
         STA AUDC2   ;ON CHANNELS...
         STA AUDF2   ;2, 3, 4!
         STA AUDC3
         STA AUDF3
         STA AUDC4
         STA AUDF4
         RTS 
;
PL.PL    LDA P0PL    ;DID MAN...
         CMP #1      ;HIT PLAYER 0?
         BCC BBBB1   ;NO!
         CMP #4      ;HIT PLAYER 2?
         BNE BBBB2   ;NO!
         LDA GRNFLG  ;GREEN MAN ACTIVE?
         CMP #1
         BNE BBBB2   ;NO!
         JSR HITGRN  ;CLOBBER GREEN MAN!
         LDA #2      ;AWARD 200 POINTS!
         STA SUM
         JSR ADD200
         JMP BBBB1
BBBB2    LDA P0PL    ;DID MAN HIT...
         CMP #8      ;PLAYER 3?
         BNE BBBB8   ;NO!
         LDA GRGFLG  ;GEORGE ACTIVE?
         CMP #1
         BEQ BBBB1   ;YES!
BBBB8    LDA WARN1
         CMP #4
         BEQ BBBB7
         INC WARN1
         RTS 
BBBB7    LDA #2      ;DEATH DUE TO...
         STA BACK    ;GEORGE!
         RTS 
BBBB1    LDA #0
         STA WARN1
         LDA GRGFLG
         CMP #1
         BNE RET
         LDA P3PL
         CMP #1
         BNE BBBB5
         LDA WARN
         CMP #4
         BEQ BBBB6
         INC WARN
         RTS 
BBBB6    LDA #2
         STA BACK
         RTS 
BBBB5    LDA #0
         STA WARN
         LDA P3PL
         CMP #2
         BCC RET
         CMP #4
         BNE RESET
         LDA GRNFLG
         CMP #1
         BEQ RET
RESET    JSR ERASEGRG ;ERASE GEORGE
         LDA #0      ;CLEAR GEORGE...
         STA GRGFLG  ;VARIABLES
         STA SO4FLG
         STA FNGRDRP
         STA GRGDRP
         STA OUTFLG
         STA GRGMOV
         LDA #10
         STA SCOL
         STA SROW
         LDA #8
         STA COUNT4
         LDA #45
         STA YPOSP3
         LDA #132
         STA XPOSP3
         STA HPOSP3
RET      RTS 
;
;
CHECK    LDA NUMSQ   ;GET SQUARES HIT
         CMP #28     ;ALL DONE?
         BNE CCCC1   ;NO!
         LDA #1      ;ROUND COMPLETED!
         STA BACK
CCCC1    RTS 
;
;---------------
;SCORE ROUTINES
;---------------
ADD25    LDY #5      ;ADD 25 POINTS
         CLC         ;TO SCORE
         LDA SCORE,Y
         ADC #5
         CMP #$1A
         BNE DDDD1
         LDA #$10
         STA DISP,Y
         STA SCORE,Y
         DEY 
         LDA SCORE,Y
         CLC 
         ADC #1
         STA SCORE,Y
         JMP DDDD2
DDDD1    LDA #$15
         STA DISP,Y
         STA SCORE,Y
         DEY 
DDDD2    LDA SCORE,Y
         CLC 
         ADC #2
         CMP #$1A
         BEQ DDDD3
         STA DISP,Y
         STA SCORE,Y
         RTS 
DDDD3    LDA #$10
         STA DISP,Y
         STA SCORE,Y
         DEY 
         LDA SCORE,Y
         CLC 
         ADC #1
         CMP #$1A
         BEQ DDDD3
         STA DISP,Y
         STA SCORE,Y
         RTS 
;
ADD200   LDY #3      ;ADD SUM * 100...
         CLC         ;TO SCORE
         LDA SCORE,Y
         ADC SUM
         CMP #$1A
         BCC EEEE1
EEEE2    SEC 
         SBC #$1A
         STA ADD
EEEE3    CLC 
         LDA #$10
         ADC ADD
         STA DISP,Y
         STA SCORE,Y
         LDA #0
         STA ADD
         DEY 
         CLC 
         LDA SCORE,Y
         ADC #1
         CMP #$1A
         BEQ EEEE3
EEEE1    STA DISP,Y
         STA SCORE,Y
         RTS 
;
;CHARACTER IMAGES
;(MAN, GREEN MAN, GEORGE, ROCKS)
;
FIG1DAT  .BYTE 12,30,63,43,43,63
         .BYTE 43,55,30,30,18,18,27
         .BYTE 54,108,72
FIG2DAT  .BYTE 48,120,252,212,212
         .BYTE 252,212,236,120,120,72
         .BYTE 72,216,108,54,18
FIG3DAT  .BYTE 14,31,55,55,31,15
         .BYTE 31,31,14,10,46,62,27
         .BYTE 13,4
FIG4DAT  .BYTE 112,248,236,236,248
         .BYTE 240,248,248,112,80,116
         .BYTE 124,216,176,32
GRN1DAT  .BYTE 160,80,40,60,126,106
         .BYTE 126,118,60,60,36,54
GRN2DAT  .BYTE 5,10,20,60,126,86
         .BYTE 126,110,60,60,36,108
GRG0DAT  .BYTE 12,30,30,255,43
         .BYTE 43,255,255,45,51,63
         .BYTE 30,18,18,27,54,108,0
GRG1DAT  .BYTE 48,120,120,255,212,212
         .BYTE 255,255,180,204,252,120
         .BYTE 72,72,216,108,54,0
GRG2DAT  .BYTE 12,30,30,255,47
         .BYTE 47,255,127,47,31,63
         .BYTE 30,18,18,126,54,27,0
GRG3DAT  .BYTE 48,120,120,255,244
         .BYTE 244,255,254,244,248,252
         .BYTE 120,72,72,126,108,216,0
BALDAT   .BYTE 24,60,126,255,255
         .BYTE 255,126,60,24,0
;
;SQUARES !!!
;
PF0      .BYTE $03,$04
PF1      .BYTE $43,$44
PF2      .BYTE $83,$84
PF3      .BYTE $C3,$C4
;
;DISPLAY LIST
;
DLIST    .BYTE $70,$70,$70,$46
         .WORD DISP
         .BYTE 6,6,$86,6,$86,$86,$86,6,6,6
         .BYTE 6,6,6,6,6,6,6,6,6,6
         .BYTE 6,6,6,$41
         .WORD DLIST
RDYMSG   .SBYTE +$80,"READY %%"
LVMSG    .SBYTE "LeVeL"
ENDMSG   .SBYTE +$80,"GAME OVER"
CHGMSG   .SBYTE "CHANGE"
LVLMSG   .SBYTE +$80,"level:"
RNDMSG   .SBYTE +$80,"round:"
BONMSG   .SBYTE +$80,"BONUS"
         .SBYTE " 1000"
TITLE    .SBYTE "    AVALANCHE   "
AUTHOR   .SBYTE "BY TOMMY BENNETT"
MAGMSG   .SBYTE +$80,"ANALOG COMPUTING"
;
;MISC. DATA
;
R1SET    .BYTE 0,15,90,4,156
R2SET    .BYTE 0,134,246,12,146
R3SET    .BYTE 0,26,164,118,84
R4SET    .BYTE 0,196,66,34,102
;
;CHAR SET DATA
;
NEWCHR   .BYTE 3,15,63,127,63,15,3,0
         .BYTE 192,240,252,254,252,240,192,0
         .BYTE 0,6,12,24,48,0,96,0
         .BYTE 12,30,63,43,63,30,18,54
         .BYTE 8,12,126,127,126,12,8,0
         .BYTE 16,48,126,254,126,48,16,0
;
;JUMPING PADS
;
PADATA   .BYTE 3,4,3,4,3,4,3,4
         .BYTE 3,4,3,4,3,4
;
;MUSIC DATA
;
NOTE     .BYTE 60,47,0,47,60,72,60,0
         .BYTE 72,64,72,64,72,64,0,81
         .BYTE 72,81,72,81,72
DUR      .BYTE 11,14,7,11,7,7,7,7
         .BYTE 7,7,7,7,7,7,7,7
         .BYTE 7,7,7,7,7
