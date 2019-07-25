        *= $2000
;
; *** BATTLE IN THE B RING ***
;
;ZERO PAGE VARIABLES
;
PBL0     =   $B0
PBL1     =   $B1
PBL2     =   $B2
PBH2     =   $B3
PBH0     =   $B4
PBH1     =   $B5
XP0      =   $B6
XP1      =   $B7
XP2      =   $B8
XP3      =   $B9
PMVL     =   $BA
PMVH     =   $BB
MBL0     =   $BC
MBL1     =   $BD
MBL2     =   $BE
XM0      =   $BF
XM1      =   $C0
XM3      =   $C1
MBL      =   $C2
MBH      =   $C3
STDIR    =   $C4
MISDIR   =   $C6
XREG     =   $C8
SCRL0    =   $C9
SCRL1    =   $CA
SCRL2    =   $CB
SCRL3    =   $CC
MATH     =   $CD
INTL     =   $CE
INTH     =   $CF
;
;PAGE SIX VARIABLES
;
CHINV    =   $06DB
ADENS    =   $06DC
ASPEED   =   $06DD
SCFLAG   =   $06DE
YMENU    =   $06DF
EXCNTR   =   $06E0
LICNTR   =   $06E2
ROCNTR   =   $06E4
EDCNTR   =   $06E6
TCCNTR   =   $06E8
SSCNTR   =   $06E9
RRCNTR   =   $06EB
ESCNTR   =   $06EC
BOCNTR   =   $06EE
DECNTR   =   $06F0
MXCNTR   =   $06F1
LIPOS    =   $06F2
;
;SYSTEM EQUATES
;
CHBAS    =   $02F4
SDMCTL   =   $022F
SDLSTL   =   $0230
SDLSTH   =   $0231
STICK0   =   $0278
STRIG0   =   $0284
STRIG1   =   $0285
PCOLR0   =   $02C0
COLOR0   =   $02C4
PCOLR3   =   $02C3
PCOLR1   =   $02C1
HPOSP0   =   $D000
HPOSP1   =   $D001
HPOSP2   =   $D002
HPOSP3   =   $D003
HPOSM0   =   $D004
HPOSM1   =   $D005
HPOSM2   =   $D006
HPOSM3   =   $D007
M0PL     =   $D008
M3PL     =   $D00B
P0PL     =   $D00C
CONSOL   =   $D01F
HITCLR   =   $D01E
GRACTL   =   $D01D
CHACTL   =   $D401
HSCROL   =   $D404
PMBASE   =   $D407
WSYNC    =   $D40A
AUDF1    =   $D200
AUDC1    =   $D201
AUDF2    =   $D202
AUDC2    =   $D203
AUDF3    =   $D204
AUDC3    =   $D205
AUDCTL   =   $D208
RANDOM   =   $D20A
NMIEN    =   $D40E
PRIOR    =   $D01B
SKCTL    =   $D20F
SETVBV   =   $E45C
XITVBV   =   $E462
CDTMV3   =   $021C
CDTMV4   =   $021E
VDSLST   =   $0200
CDTMA1   =   $0226
CDTMA2   =   $0228
ATRACT   =   $4D
;
;GAME SET-UP BEGINS
;
         CLD 
         LDX #3
COLLP    LDA PFCOL,X ;set
         STA COLOR0,X ;playfield
         LDA MSEL,X  ;colors
         STA ADENS,X
         DEX 
         BPL COLLP
         LDA #0
         STA AUDCTL  ;initialize
         LDA #3      ;sounds
         STA SKCTL
         JMP MENU
DLIRTN   PHA 
         LDA SCRL1
         STA HSCROL
         LDA #DL1&$FF
         STA VDSLST
         PLA 
         RTI 
DL1      PHA 
         LDA SCRL3
         STA HSCROL
         LDA #DL2&$FF
         STA VDSLST
         PLA 
         RTI 
DL2      PHA 
         LDA #2      ;turns
         STA WSYNC   ;characters
         STA CHACTL  ;right side
         LDA #DL3&$FF ;up bottom
         STA VDSLST  ;screen half
         PLA 
         RTI 
DL3      PHA 
         LDA SCRL1
         STA HSCROL
         LDA #DL4&$FF
         STA VDSLST
         PLA 
         RTI 
DL4      PHA 
         LDA SCRL0
         STA HSCROL
         LDA #DLIRTN&$FF
         STA VDSLST
         PLA 
         RTI 
;
;SCROLL ROUTINE-TIMER 1-FOR TOPMOST
;AND BOTTOMMOST RINGS
;
SCROLL   LDA #1
         LDY ASPEED
         LDX #0      ;set system
         JSR SETVBV  ;timer 1
         LDA SCRL0
         CMP #9
         BNE DECC9
         RTS 
DECC9    DEC SCRL0   ;scroll value
         LDA SCRL0   ;for top and
         BEQ PSCRL   ;bottom rings
         RTS 
PSCRL    LDA #8      ;reset scroll
         STA SCRL0   ;value
         LDX #15
         LDA $0605   ;check for
         CMP #106    ;wraparound
         BEQ PFLIP   ;flip
         CLC 
         ADC #1      ;flip to next
         JMP HLOOP   ;display byte
PFLIP    LDA #0
HLOOP    STA $0602,X ;store new
         ORA #128    ;low bytes in
         STA $0633,X ;display list
         EOR #128
         DEX 
         DEX 
         DEX 
         BNE HLOOP
         RTS 
;
;SCROLL ROUTINE-TIMER 2-FOR TWO
;INNER RINGS AND LIGHTNING
;
SCRLL    LDA #2 ;scroll
         LDX #0      ;routine same
         LDY ASPEED  ;as timer 1
         DEY 
         JSR SETVBV
         LDA SCRL0
         CMP #9
         BNE DECCA
         RTS 
DECCA    DEC SCRL1
         LDA SCRL1
         BEQ HSCRL
         LDA XP2
         BEQ T2XIT
         DEC XP2     ;change
         LDA XP2     ;lightning
         STA HPOSP2  ;position
         LDX LICNTR  ;value of
         LDY #24     ;light. shape
LILOOP   LDA LIGHT,X ;change light.
         STA (PBL2),Y ;shape
         INX 
         DEY 
         BPL LILOOP
         STX LICNTR
         CPX #75     ;light. over?
         BNE T2XIT
         LDX #0      ;turn off
         STX LICNTR  ;lightning
         STX HPOSP2
         STX XP2
T2XIT    RTS 
HSCRL    LDA #8
         STA SCRL1
         LDX #12
         LDA $0615
         CMP #106
         BEQ PFLIP3
         CLC 
         ADC #1
         JMP MLINE
PFLIP3   LDA #0
MLINE    STA $0612,X
         ORA #128
         STA $0626,X
         EOR #128
         DEX 
         DEX 
         DEX 
         BNE MLINE
         LDA XP2
         BNE T2EXIT
         LDA RANDOM
         AND #15
         STA MATH
         CLC 
         ADC #2
         CLC 
         ADC $061E   ;random gap
         LDY #2      ;asteroid
LOCLI    CMP LIPOS,Y ;position
         BEQ PUTLI
         DEY         ;check for
         BPL LOCLI   ;asteroid
         RTS 
PUTLI    LDA MATH
         ASL A       ;calculate
         ASL A       ;initial
         ASL A       ;lightning
         CLC         ;position
         ADC #56
         STA XP2     ;store pos.
         STA HPOSP2
         LDA #200    ;lightning
         STA AUDF1   ;zap sound
         STA AUDC1
         LDA #4
         STA CDTMV4
T2EXIT   RTS 
;
;VERTICAL BLANK ROUTINE
;SCROLLS ROCKET, ANIMATES FLAME
;
VBRTN    LDA #192
         STA NMIEN   ;enable dli
         LDA CHINV
         STA CHACTL  ;invert upper
         LDA SCRL0   ;screen half
         STA HSCROL  ;scroll for
         LDA SCRL2   ;first ring
         CMP #16
         BNE ROAR
         JMP XITVBV
ROAR     LDA RRCNTR  ;time to inc.
         BEQ FLAMCK  ;volume of
         CMP #136    ;rocket roar?
         BEQ FLAMCK
         INC RRCNTR
         LDA RRCNTR
         STA AUDC2
FLAMCK   INC SCRL2
         LDA SCRL2   ;time to
         AND #1      ;scroll?
         BEQ GFLAM
         JMP XITVBV
GFLAM    DEC SCRL3
         LDA SCRL2
         AND #15
         STA SCRL2
         LSR A
         TAX         ;get flame
         LDA FLTAB,X ;shape
         STA $1024   ;display
         LDA XP3
         BEQ OUTCK
         DEC XP3     ;change hot
         LDA XP3     ;tail pos.
         STA HPOSP3
OUTCK    LDA SCRL3
         BEQ SCRLH
         JMP XITVBV
SCRLH    LDA #8
         STA SCRL3
         LDA $0622   ;rocket on
         CMP #11     ;screen?
         BNE ROOFF
         LDX #224    ;yes put hot
         STX XP3     ;tail
         STX AUDF2   ;start sound
         LDX #129
         STX AUDC2
         STX RRCNTR
ROOFF    CMP #36     ;rocket off
         BNE CKROM   ;screen?
         LDX #0      ;turn off
         STX AUDF2   ;rocket roar
         STX AUDC2
         STX RRCNTR
CKROM    LDX XM3     ;missile in
         CPX #0      ;use?
         BNE FLIPCK  ;yes go on
         CLC         ;no
         CMP #13     ;rocket on
         BCC FLIPCK  ;screen?
         CLC 
         CMP #30
         BCS FLIPCK
         SEC 
         SBC #13     ;calculate
         ASL A       ;initial
         ASL A       ;missile pos.
         ASL A
         STA MATH
         LDA #204
         SEC 
         SBC MATH
         STA MATH    ;store pos.
         LDX #0
ROMLOOP  CLC         ;saucer in
         LDA PBL0,X  ;gap?
         CMP #107
         BCC TRYAG
         CLC 
         CMP #130
         BCS TRYAG
         CLC 
         LDA XP0,X   ;in front of
         CMP MATH    ;rocket?
         BCC STM3    ;yes
TRYAG    INX 
         CPX #2
         BNE ROMLOOP
         JMP FLIPCK
STM3     LDA MATH    ;fire
         STA XM3     ;missiles
         STA HPOSM3
         LDA #38     ;missile
         STA AUDF1   ;sound
         LDA #142
         STA AUDC1
         LDA #5
         STA CDTMV4
FLIPCK   LDA $0622
         CMP #63
         BEQ PFLIP5
         CLC 
         ADC #1
         JMP MLINE3
PFLIP5   LDA #0
MLINE3   STA $0622
         STA $0625
VBOUT    JMP XITVBV
;
;MAIN PROGRAM BEGINS HERE
;
PROG     LDX #31     ;zero out
         LDA #0      ;zero page+
CLZLOOP  STA PBL0,X  ;page 6
         STA EXCNTR,X ;variables
         DEX 
         BPL CLZLOOP
         LDA #9      ;no scroll
         STA SCRL0   ;until ready
         LDA #16     ;to play
         STA SCRL2
         LDA #4
         STA CHINV
         LDA #0
         TAX 
         TAY 
         LDA #24
         STA PMBASE  ;pm graphics
         LDA #27     ;location
         STA MBH     ;missiles
         LDA #28
         STA PBH0    ;player 0
         LDA #29
         STA PBH1    ;player 1
         LDA #30
         STA PBH2    ;player 2
         LDA #224
         STA INTH
         LDA #18     ;character
         STA PMVH    ;set on
         STA CHBAS   ;page 18
         LDA #0
         STA PMVL
         STA INTL
         TAX 
         TAY 
DWNLD    LDA (INTL),Y ;download rom
         STA (PMVL),Y ;characters
         INY 
         BNE DWNLD
         INC PMVH
         INC INTH
         INX 
         CPX #2
         BNE DWNLD
         DEC PMVH
         DEC PMVH
         LDY #0
         LDA #8
         STA PMVL
CHLOOP   LDA CHTAB,Y ;load data for
         STA (PMVL),Y ;asteroid
         INY         ;characters
         CPY #120
         BNE CHLOOP
         LDX #0
         LDY #208
         STX PMVL
C2LOOP   LDA C2TAB,X ;load data for
         STA (PMVL),Y ;rocket
         INX         ;characters
         CPX #56
         BEQ RESET
         INY 
         BNE C2LOOP
         INC PMVH
         JMP C2LOOP
RESET    LDX #77
         LDY #0
         STY SDMCTL
DLOOP    LDA GDLIST,X ;load game
         STA $0600,X ;display
         DEX         ;list onto
         BPL DLOOP   ;page six
         LDA #6      ;tell comp.
         STY SDLSTL  ;where dlist
         STA SDLSTH  ;is
         LDA $0606
         STA PMVH
         STY PMVL
         TYA 
         TAX 
CLOOP    STA (PMVL),Y ;clear
         INY         ;display
         BNE CLOOP   ;area
         INC PMVH
         INX 
         CPX #11
         BNE CLOOP
         LDX #0
         LDA $0606
         STA PMVH
         LDA ADENS
         STA INTH
         STX PMVL
RANDC    LDA RANDOM  ;color for
         AND #3      ;asteroid
         TAY         ;character
         LDA COLOR,Y
         STA INTL
RANDP    CLC 
         LDY RANDOM  ;random
         CPY #107    ;position
         BCS RANDP
         LDA (PMVL),Y
         CMP #0      ;occupied?
         BNE RANDP   ;yes go back
RANDA    LDA RANDOM  ;random
         AND #15     ;asteroid
         BEQ RANDA   ;character
         ORA INTL
         STA (PMVL),Y ;store in
         INX         ;display
         CPX INTH    ;line done?
         BNE RANDC
         LDX #0
         CLC 
         LDA PMVL
         ADC #128    ;do next line
         STA PMVL
         BCC ASKIP
         INC PMVH
ASKIP    LDA PMVH
         CMP $061F
         BNE AENDCK
         LDY INTH
         DEY 
         DEY 
         DEY 
         STY INTH
AENDCK   CMP $0626   ;all lines
         BNE RANDC   ;done?
         LDA $061F
         STA PMVH
RANDC2   LDA RANDOM  ;same as
         AND #3      ;above but
         TAY         ;for
         LDA COLOR,Y ;asteroids
         STA INTL    ;across gap
         LDA RANDOM  ;from each
         AND #3      ;other for
         TAY         ;lightning
         LDA COLOR,Y
         STA INTH
RANDP2   CLC 
         LDA RANDOM
         BEQ RANDP2
         CMP #105
         BCS RANDP2
         STA PMVL
         STA LIPOS,X
         LDY #0
         LDA (PMVL),Y
         BNE RANDP2
RANDA2   LDA RANDOM
         AND #15
         BEQ RANDA2
         ORA INTL
         STA (PMVL),Y
RANDA3   LDA RANDOM
         AND #15
         BEQ RANDA3
         ORA INTH
         LDY #128
         STA (PMVL),Y
         INX 
         CPX #3
         BNE RANDC2
         LDA #0
         LDX #18
CLRAST   STA $0700,X ;clear lines
         STA $0780,X ;saucer start
         DEX         ;positions
         BPL CLRAST
         LDY #20
         LDA $0606
         STA PMVH
         STA INTH
         LDA #107
         STA INTL
         INX 
         STX PMVL
WLOOP    LDA (PMVL),Y ;wraparound
         STA (INTL),Y ;display
         DEY         ;area for
         BPL WLOOP   ;continuous
         LDY #20     ;scrolling
         INX 
         LDA PMVL
         CLC 
         ADC #128
         STA PMVL
         BCC WSKIP1
         INC PMVH
WSKIP1   LDA INTL
         CLC 
         ADC #128
         STA INTL
         BCC WSKIP2
         INC INTH
WSKIP2   CPX #18     ;finished?
         BNE WLOOP   ;no go back
         LDY #3
ROLOOP   LDA ROTAB,Y ;load rocket
         STA $1020,Y ;data into
         DEY         ;display area
         BPL ROLOOP
         LDA #16
         STA $0664   ;initialize
         STA $066E   ;scores
         LDA #0
         TAX 
         STA $0663
         STA $066D
         LDA #24
         STA PMVH
         TXA 
         STA PMVL
         TAY 
CLRPMG   STA (PMVL),Y ;clear pm
         INY         ;graphics
         BNE CLRPMG  ;area
         INC PMVH
         INX 
         CPX #8
         BNE CLRPMG
         LDX #5
         LDA #0
ZLOOP    STA HPOSP2,X ;iniialize
         DEX         ;player/
         BPL ZLOOP   ;missile
         LDA #108
         STA PBL2
         LDA #3      ;set up
         STA GRACTL  ;graphics
         LDA #62     ;dma
         STA SDMCTL
         STA HITCLR  ;clr collis.
         LDA #120    ;initialize
         STA HPOSP1  ;saucer
         STA XP1     ;positions
         STA HPOSP0
         STA XP0
         LDA #196
         STA PBL1
         LDA #35
         STA PBL0
         STA PMVL
         LDA PBH0
         STA PMVH
         LDA PBL1
         STA INTL
         LDA PBH1
         STA INTH
         LDY #7
LDPLYRS  LDA PLSHP,Y ;load
         STA (PMVL),Y ;player
         STA (INTL),Y ;data into
         DEY         ;pm area
         BPL LDPLYRS
         INC INTH
         INC INTH
         LDY #116
         LDA #0
         STA INTL
         LDA #1
LDTAIL   STA (INTL),Y ;load hot
         INY         ;rocket
         CPY #124    ;tail
         BNE LDTAIL
         LDY #112
         LDA #192
         STA (MBL),Y
         LDY #127
         STA (MBL),Y
         LDX #3
PCLOOP   LDA PCOL,X  ;set playr
         STA PCOLR0,X ;colors
         DEX 
         BPL PCLOOP
         LDA #8      ;initialize
         STA HSCROL  ;scroll
         STA SCRL1   ;settings
         STA SCRL3
         STA CONSOL
         STA STDIR+1
         LDA #9
         STA STDIR
;
;SET SYSTEM TIMERS,
;VERT. BLANK AND DLI ROUTINES
;
         LDA #SCROLL&$FF ;timer 1
         STA CDTMA1
         LDA #SCROLL/256
         STA CDTMA1+1
         LDA #1
         LDX #0
         LDY #4
         JSR SETVBV
         LDA #SCRLL&$FF ;timer 2
         STA CDTMA2
         LDA #SCRLL/256
         STA CDTMA2+1
         LDA #2
         LDX #0
         LDY #3
         JSR SETVBV
         LDA #7
         LDX #VBRTN/256 ;vertical
         LDY #VBRTN&$FF ;blank
         JSR SETVBV
         LDA #DLIRTN/256
         STA VDSLST+1
         LDA #DLIRTN&$FF
         STA VDSLST
         LDA #192    ;dli
         STA NMIEN
         LDA #1      ;set pmg
         STA PRIOR   ;priority
STLOOP   LDA STRIG0  ;check
         BNE SB2CK   ;triggers
         JMP GETDEL  ;for game
SB2CK    LDA STRIG1  ;start
         BNE STLOOP
GETDEL   LDA #15
         STA CDTMV3
DSTLOOP  LDA CDTMV3
         BNE DSTLOOP
         STA SCRL2   ;allow
         LDA #8      ;scrolling
         STA SCRL0
MLOOP    LDA #1      ;game prog
         STA CDTMV3  ;begins
         INC XREG    ;move timer
         LDA XREG    ;playr index
         AND #1
         TAX 
         STA XREG
         LDA XP0,X   ;check for
         BNE TAILCK  ;dead player
         JMP INCM
TAILCK   LDA SCRL2   ;check for
         CMP #16     ;missile
         BNE EXPCK   ;collision
         INC TCCNTR  ;with rocket
         LDA TCCNTR  ;tail
         AND #31     ;time to
         STA TCCNTR  ;cool tail?
         BNE EXPCK   ;no go on
         LDA PCOLR3
         CMP #148
         BEQ EXPCK
         DEC PCOLR3  ;cool tail
EXPCK    LDA EXCNTR,X ;check count
         BEQ BOUNCK  ;for player
         INC EDCNTR,X ;explosion
         LDA EDCNTR,X
         AND #3      ;time to
         STA EDCNTR,X ;change exp?
         BNE EXLCK   ;no go on
         LDY SNDX,X  ;change sound
         LDA ESCNTR,X ;get sound
         CMP #128    ;finished?
         BEQ EXSNOFF ;yes off
         DEC ESCNTR,X ;no make
         LDA ESCNTR,X ;changes
         STA AUDC3,Y
         JMP EXLCK
EXSNOFF  LDA #0      ;turn sound
         STA AUDF3,Y ;off
         STA AUDC3,Y
         STA ESCNTR,X
EXLCK    LDA PCOLR0,X ;change
         CMP #159    ;color
         BEQ BLINC
         INC PCOLR0,X
         INC PCOLR0,X
         INC PCOLR0,X
         JMP INCM
BLINC    LDA EDCNTR,X
         AND #1
         BEQ BLJUMP
         JMP INCM
BLJUMP   JMP BLPL
BOUNCK   LDA BOCNTR,X ;check for
         BEQ RMCK    ;bounce
         JMP REBOUND
RMCK     LDA M3PL    ;check for
         BEQ PLPLCK  ;collision
         LDY #0      ;with
         STY XM3     ;rocket's
         STY HPOSM3  ;missiles
         STY HITCLR
         CMP #4
         BEQ PLPLCK
         TAX 
         DEX 
         STX MBL
         LDY #6
         JSR MOVPLYR
         LDX MBL
         JSR EXPLO
         LDX XREG
PLPLCK   LDA P0PL,X  ;check for
         BEQ MPFCK   ;player/
         CMP #4      ;player
         BNE PL8CK   ;collisions
         JMP PBLPL
PL8CK    CMP #8      ;hit hot
         BNE DOTWO   ;tail?
         LDA PCOLR3
         CMP #148
         BEQ YOTHER
         JMP PBLPL   ;yes kill
YOTHER   LDY OTHER,X ;no tail
         LDA XP0,Y   ;cool game
         STA HITCLR  ;over
         BNE IJUMP
         JMP ENDIT
IJUMP    JMP INCM
DOTWO    JMP BLBOTH  ;kill both
MPFCK    LDA HPOSP0,X ;check for
         BEQ MPLCK   ;missile/
         JSR MISEXP  ;playfield
         JSR EXSOUND ;collisions
         JSR TOM     ;missile off
MPLCK    LDA M0PL,X  ;check for
         BEQ PLPFCK  ;missile/
         CMP #4      ;player
         BNE M8CK    ;collisions
         JSR TOM
         JMP PLPFCK
M8CK     CMP #8      ;hit tail?
         BNE PLEX    ;no go on
         JSR TOM     ;yes stop
         LDA #16     ;rocket
         STA SCRL2
         LDA #0
         STA $1024
         STA AUDF2
         STA AUDC2
         JMP PLPFCK
PLEX     LDY MISDIR,X ;hit saucer
         TAX 
         DEX 
         LDA EXCNTR,X ;dead yet?
         BEQ MSCOR   ;no score it
         JMP INCM    ;yes
MSCOR    JSR MOVPLYR ;move plyr
         TXA 
         LSR A
         TAX 
         JSR EXPLO   ;add score
         LDX XREG
         JSR MISEXP
         JSR TOM     ;missile off
PLPFCK   LDA HPOSM0,X ;check for
         BEQ STRCK   ;player/
         STA HITCLR  ;playfield
         JSR EXSOUND ;collisions
         LDA SCFLAG  ;scoring?
         BNE REBOUND ;no go on
         JSR EXPLO   ;yes score
REBOUND  INC BOCNTR,X ;bounce
         LDA BOCNTR,X ;plyr off
         CMP #4      ;rocks?
         BNE RUBBER  ;yes
         LDA #0      ;no end
         STA BOCNTR,X ;bounce
RUBBER   LDA STDIR,X ;bounce plyr
         TAY 
         LDA BOUNCE,Y
         CMP #6
         BNE DOTAY
         CLC 
         LDA PBL0,X
         CMP #117
         LDA #4
         BCS DOTAY
         LDA #5
DOTAY    TAY 
         JSR MOVPLYR
         JMP INCM
STRCK    LDA STRIG0,X ;check
         BNE STIK    ;triggers
         STA ATRACT  ;no attract
         LDA XM0,X   ;missile
         BNE STIK    ;already in
         JMP MISL    ;use?
STIK     LDA STICK0,X ;check
         CMP #15     ;joysticks
         BNE GSTIK   ;no move
         JSR ROTOR
         JMP INCM
GSTIK    SEC         ;yes
         SBC #5      ;get
         TAY         ;movement
         STA STDIR,X ;index
         JSR MOVPLYR
         JMP INCM
MOVPLYR  LDA XP0,X
         CLC 
         ADC PXDIR,Y ;check limits
         CMP #193
         BEQ RAISE
         CMP #47
         BEQ RAISE
STORX    STA HPOSP0,X ;player
         STA XP0,X   ;horiz. move
RAISE    LDA PBH0,X
         STA PMVH
         LDA PBL0,X
         CLC 
         ADC PYDIR,Y
         CMP #197
         BEQ ROTOR
         CMP #34
         BEQ ROTOR
         STA PMVL
         STA PBL0,X
         LDY #7
PLOOP    LDA PLSHP,Y ;player
         STA (PMVL),Y ;vert. move
         DEY 
         BPL PLOOP
         INC ROCNTR,X
         LDA ROCNTR,X
         AND #7
         STA ROCNTR,X
         TAY 
         LDA ROTATE,Y
         LDY #4
         STA (PMVL),Y ;rotate
         LDA SSCNTR,X ;saucer
         BEQ DOROT   ;center
         RTS 
DOROT    LDA ROCNTR,X
         AND #1
         TAY 
         LDA SNDX,X
         TAX 
         LDA MSAUSND,Y ;moving
         STA AUDF3,X ;saucer
         LDA #165    ;sound
         STA AUDC3,X
         RTS 
ROTOR    LDA PBL0,X  ;slower
         STA PMVL    ;stationary
         LDA PBH0,X  ;rotate
         STA PMVH
         INC ROCNTR,X
         LDA ROCNTR,X
         AND #15
         STA ROCNTR,X
         LSR A
         TAY 
         LDA ROTATE,Y
         LDY #4
         STA (PMVL),Y
         LDA SSCNTR,X
         BEQ DOROT2
         RTS 
DOROT2   LDA ROCNTR,X
         AND #3
         LSR A
         TAY 
         LDA SNDX,X
         TAX 
         LDA SSAUSND,Y
         STA AUDF3,X ;stationary
         LDA #165    ;sound
         STA AUDC3,X
         RTS 
INCM     LDA XM0     ;check
         BEQ CKM1    ;missile 0
         LDX #0      ;movement
         JSR GDIR
CKM1     LDA XM1     ;check
         BEQ CKM3    ;missile 1
         LDX #1      ;movement
         JSR GDIR
CKM3     LDA XM3     ;check
         BEQ NEXIT   ;missile 2
         DEC XM3     ;movement
         LDA XM3
         STA HPOSM3
NEXIT    LDA CDTMV4  ;check sound
         BNE BUTCK   ;timer
         STA AUDF1
         STA AUDC1
BUTCK    LDA CONSOL  ;check
         CMP #7      ;console
         BEQ SHOTSND
         JMP ENDIT
SHOTSND  LDA SSCNTR  ;check shot
         BEQ SHOTSND2 ;sound
         LDX #0      ;counter
         JSR INCSHOT
SHOTSND2 LDA SSCNTR+1
         BEQ TOMEX
         LDX #1
         JSR INCSHOT
TOMEX    LDA MBL2    ;check for
         BEQ EXIT    ;end of
         INC MXCNTR  ;missile
         LDA MXCNTR  ;explosion
         AND #3
         STA MXCNTR
         BNE EXIT
         LDA MBL2
         STA MBL
         LDA #0
         STA HPOSM2
         STA MBL2
         LDY #4
TOMLOOP  LDA (MBL),Y
         EOR MXSHP,Y
         STA (MBL),Y
         DEY 
         BPL TOMLOOP
EXIT     LDA CDTMV3  ;check
         BNE EXIT    ;move timer
         JMP MLOOP   ;start over
INCSHOT  INC SSCNTR,X ;change shot
         INC SSCNTR,X ;sound
         LDA SSCNTR,X
         CMP #48
         BEQ ENDSHOT
         LDY SNDX,X
         STA AUDF3,Y
         RTS 
ENDSHOT  LDA #0      ;turn off
         STA SSCNTR,X ;shot sound
         RTS 
MISEXP   LDA MBL2    ;check miss.
         BEQ DOEXP   ;explosion
         RTS         ;in use
DOEXP    LDA XM0,X ;load
         STA HPOSM2  ;missile
         LDA MBL0,X  ;explosion
         SEC         ;data
         SBC #2
         STA MBL2
         STA MBL
         LDY #4
MIXLOOP  LDA (MBL),Y
         ORA MXSHP,Y
         STA (MBL),Y
         DEY 
         BPL MIXLOOP
         RTS 
MISL     CLC         ;determine
         LDA XP0     ;missile
         CMP XP1     ;direction
         LDA MDIR1,X
         BCC GETDIR
         LDA MDIR2,X
GETDIR   STA MISDIR,X
         LDY SNDX,X
         LDA #8
         STA AUDF3,Y
         STA SSCNTR,X
         LDA #139
         STA AUDC3,Y
         LDY MISDIR,X
         LDA XP0,X   ;initial
         CLC         ;missile
         ADC MSPOS,Y ;position
         STA XM0,X
         LDA PBL0,X
         CLC 
         ADC #5
         STA MBL0,X
         STA MBL
         LDY #0
         LDA (MBL),Y ;load
         ORA MSSHP,X ;missile
         STA (MBL),Y ;data
         JMP STIK
EXPLO    JSR EXSOUND
         LDY SCORE,X
         LDA $0664,Y ;get score
         CLC 
         ADC #1      ;add one
         CMP #26     ;10 yet?
         BEQ NEXP    ;yes kill
         STA $0664,Y ;no store
         RTS 
NEXP     LDA #16
         STA $0664,Y
         LDA #17
         STA $0663,Y
         PLA         ;pull return
         PLA         ;address
PBLPL    JSR EXSOUND
         LDY SNDX,X
         LDA #200    ;start
         STA AUDF3,Y ;explosion
         LDA #143    ;sound
         STA AUDC3,Y
         STA ESCNTR,X
         LDA #144    ;change
         STA PCOLR0,X ;color
BLPL     LDA PBL0,X
         STA PMVL
         LDA PBH0,X
         STA PMVH
         STX MBL
         LDA EXCNTR,X
         TAX 
         LDY #7
BLO1     LDA EXSHP,X ;load
         STA (PMVL),Y ;explosion
         INX         ;shape
         DEY 
         BPL BLO1
         CPX #64     ;finished?
         BEQ EXOFF
         TXA 
         LDX MBL
         STA EXCNTR,X ;store data
         JMP INCM    ;number
EXOFF    LDA #0      ;turn off
         LDX XREG    ;explosion
         STA EXCNTR,X
         STA HPOSP0,X ;player off
         STA XP0,X   ;screen
         STA PBL0,X
         STA HITCLR
         LDY SNDX,X
         STA AUDF3,Y
         STA AUDC3,Y
         INC DECNTR
         LDA DECNTR
         CMP #2      ;both dead?
         BNE GOBACK  ;no go back
         JMP ENDIT   ;game over
GOBACK   JMP INCM
EXSOUND  LDA #200    ;collision
         STA AUDF1   ;sound
         LDA #142
         STA AUDC1
TIMER    LDA #5      ;set sound
         STA CDTMV4  ;timer
         RTS 
BLBOTH   JSR EXSOUND ;saucers
         LDX #0      ;collided
         LDY #0      ;kill both
         LDA #158
         STA PCOLR0
         STA PCOLR1
         LDA PBL1
         STA PMVL
         LDA PBH1
         STA PMVH
         LDA PBH0
         STA PBL1
BLO3     LDA EXSHP,X
         STA (PMVL),Y
         STA (PBL0),Y
         INX 
         INY 
         CPY #8
         BNE BLO3
         LDA #2
         STA CDTMV4
         LDY #0
TIMCKB   LDA CDTMV4
         BNE TIMCKB
         CPX #64
         BNE BLO3
         JMP ENDIT   ;game over
GDIR     LDY MISDIR,X ;get
         LDA XM0,X   ;direction
         CLC 
         ADC PXDIR,Y
         CMP #220    ;check
         BEQ TOM     ;limits
MXLCK    CMP #40
         BEQ TOM
         STA XM0,X   ;move missile
         STA HPOSM0,X
         RTS 
TOM      LDA #0      ;turn off
         STA HPOSM0,X ;missile
         STA XM0,X
         STA HITCLR
         TAY 
         LDA MBL0,X
         STA MBL
         LDA (MBL),Y
         EOR MSSHP,X
         STA (MBL),Y
         RTS 
ENDIT    LDA #30
         STA CDTMV3
ENTCK    LDA CDTMV3
         BNE ENTCK
         LDY #7
ENDLP    STA HPOSP0,Y ;all plyrs
         STA AUDF1,Y ;off screen
         DEY         ;sound off
         BPL ENDLP
         LDA #16     ;stop
         STA SCRL2   ;scrolls
         LDA #9
         STA SCRL0
         JMP MENU
;
;ASTEROID CHARACTER DATA
;
CHTAB
         .BYTE 0,24,56,127,126,24,60,32
         .BYTE 0,28,126,127,60,24,0
         .BYTE 0,0,16,60,120,8,0,0
         .BYTE 0,0,24,126,62,124,100,0
         .BYTE 24,62,124,60,24,126,60,120
         .BYTE 0,96,124,56,60,126,6,0
         .BYTE 28,60,30,60,126,126,56,0
         .BYTE 0,0,16,56,28,0,0,0
         .BYTE 0,0,24,32,0,0,0,0
         .BYTE 0,0,56,126,24,48,0,0
         .BYTE 0,0,0,24,60,126,120,0
         .BYTE 0,60,62,30,124,56,32,0
         .BYTE 0,0,0,0,63,110,52,0
         .BYTE 0,24,120,60,62,28,0,0
         .BYTE 0,124,62,60,28,62,120,0
;
;SAUCER SHAPE
;
PLSHP
         .BYTE 0,16,56,254,254,254,56,0
;
;EXPLOSION SHAPES
;
EXSHP
         .BYTE 0,8,64,24,254,170,254,48
         .BYTE 4,128,36,128,126,170,253,16
         .BYTE 0,36,0,82,44,41,60,64
         .BYTE 36,0,145,8,66,42,74,16
         .BYTE 34,145,0,16,129,82,0,146
         .BYTE 137,32,128,1,64,2,128,81
         .BYTE 64,1,0,128,0,0,65,128
         .BYTE 0,0,0,0,0,0,0,0
PLINE    .BYTE 0,0,$30,$2C,$39,$32
         .BYTE 0,$11,0,0,0,0,$30,$2C,$39
         .BYTE $32,0,$12,0,0
;
;MOVEMENT INDEXES
;
PXDIR    .BYTE 1,1,1,0,255,255,255,0,0,0
PYDIR    .BYTE 1,255,0,0,1,255,0,0,1,255
;
;BOUNCE MOVEMENT INDEXES
;
BOUNCE   .BYTE 1,0,6,0,5,4,2,0,9,8
MSPOS    .BYTE 0,0,9,0,0,0,254
COLOR    .BYTE 0,64,128,192
;
;ROCKET CHARACTER DATA
;
C2TAB    .BYTE 255,63,31,0,0,0,0,0
         .BYTE 255,255,255,0,0,0,0,0
         .BYTE 255,255,255,31,15,7,3,7
         .BYTE 254,254,222,2,0,0,0,0
         .BYTE 252,248,240,224,0,0,0,0
         .BYTE 254,252,248,240,0,0,0,0
         .BYTE 248,240,224,192,0,0,0,0
;
;MISSILE MOVEMENT INDEXES
;
MDIR1    .BYTE 2,6
MDIR2    .BYTE 6,2
ROTAB    .BYTE 154,27,28,221
FLTAB    .BYTE 159,158,160,0,0,0,0,0
;
;LIGHTNING SHAPE DATA
;
LIGHT    .BYTE 16,8,16,24,8,16,8,16,8
         .BYTE 8,16,8,16,16,16,24,8
         .BYTE 16,8,8,4,8,16,8,16
         .BYTE 8,16,16,8,16,8,16,16,24
         .BYTE 8,16,8,16,8,8,16,8
         .BYTE 16,8,8,24,16,16,8,8
         .BYTE 4,16,8,8,16,8,16,8,4
         .BYTE 8,16,32,32,24,8,16,12
         .BYTE 4,8,16,8,16,16,8,8
SCORE    .BYTE 0,10
OTHER    .BYTE 1,0
;
;ROTATING SAUCER CENTER DATA
;
ROTATE   .BYTE 126,190,222,238,246,250,252,254
SNDX     .BYTE 0,2
MSAUSND  .BYTE 160,170
SSAUSND  .BYTE 180,190
MSSHP    .BYTE 3,12
MXSHP    .BYTE 32,16,48,48,32,16
PCOL     .BYTE 202,70,158,158
MSEL     .BYTE 10,4,0,0
PFCOL    .BYTE 40,37,68,121
;
;DISPLAY LIST INTERRUPT ALLOWS
;RINGS TO SCROLL INDIVIDUALLY
;
;GAME DISPLAY LIST
;
GDLIST   .BYTE 112,112,112,32,86,0,7
         .BYTE 86,0,8,86,0,9,86,0,10
         .BYTE 86,0,11,128,86,0,12,86,0,13
         .BYTE 86,0,14,86,0,15,176
         .BYTE 214,0,16,86,0,16,176
         .BYTE 86,128,15,86,128,14
         .BYTE 86,128,13,86,128,12,128
         .BYTE 86,128,11,86,128,10
         .BYTE 86,128,9,86,128,8
         .BYTE 86,128,7,70
         .WORD PLINE
         .BYTE 70,96,6,32,65,0,6
;
;MENU DISPLAY LIST
;
MDLIST   .BYTE 112,112,112,112,71
         .WORD TITL
         .BYTE 7,112,70
         .WORD AUTH
         .BYTE 112,112,71
         .WORD COLLISY
         .BYTE 71
         .WORD SCORY
         .BYTE 112,71
         .WORD RINGD
         .BYTE 71
         .WORD LOW
         .BYTE 112,71
         .WORD RINGS
         .BYTE 71
         .WORD SLOW
         .BYTE 112,65
         .WORD MDLIST
TITL     .BYTE 0,0,0,0,0,$62,$61,$74
         .BYTE $74,$6C,$65,0,$69,$6E,0,0
         .BYTE 0,0,0,0,0,0,0,0,0,$74,$68
         .BYTE $65,0,$62,0,$72,$69,$6E
         .BYTE $67,0,0
AUTH     .BYTE 0,0,0,34,57,0,44,37,55,0
         .BYTE 52,40,47,45,41,52,51
;
;MENU SELECTIONS
;
RINGD    .BYTE 0,0,0,0,$F2,$E9,$EE,$E7
         .BYTE 0,$E4,$E5,$EE,$F3,$E9,$F4,$F9
RINGS    .BYTE 0,0,0,0,0,$F2,$E9,$EE,$E7
         .BYTE 0,$F3,$F0,$E5,$E5,$E4
LOW      .BYTE 0,0,0,0,0,0,0,0,$AC,$AF,$B7
         .BYTE 0,0
MEDIUM   .BYTE 0,0,0,0,0,0,0,$AD,$A5,$A4
         .BYTE $A9,$B5,$AD
HIGH     .BYTE 0,0,0,0,0,0,0,0,$A8,$A9,$A7
         .BYTE $A8,0
SLOW     .BYTE 0,0,0,0,0,0,0,0,$B3,$AC,$AF,$B7
FAST     .BYTE 0,0,0,0,0,0,0,0,$A6,$A1,$B3
         .BYTE $B4,0,0,0,0
RINGDY   .BYTE 0,0,0,0,$32,$29,$2E,$27
         .BYTE 0,$24,$25,$2E,$33,$29,$34,$39
RINGSY   .BYTE 0,0,0,0,0,$32,$29,$2E,$27
         .BYTE 0,$33,$30,$25,$25,$24
COLLIS   .BYTE 0,0,0,0,0,$E3,$EF,$EC,$EC
         .BYTE $E9,$F3,$E9,$EF,$EE,$F3
COLLISY  .BYTE 0,0,0,0,0,$23,$2F,$2C
         .BYTE $2C,$29,$33,$29,$2F,$2E,$33
SCORY    .BYTE 0,0,0,0,0,0,0,$B3,$A3,$AF
         .BYTE $B2,$A9,$AE,$A7,0
SCORN    .BYTE 0,0,0,0,0,$AE,$AF,$AE,$B3
         .BYTE $A3,$AF,$B2,$A9,$AE,$A7,0,0,0,0,0
MENU     LDA #0
         STA SDMCTL
         LDY YMENU
         LDA #224
         STA CHBAS
         LDA #2
         STA CHINV
         LDA #MDLIST&$FF
         LDX #MDLIST/256
         STA SDLSTL
         STX SDLSTH
         LDA #62
         STA SDMCTL
CONCK    LDA CONSOL
         CMP #6
         BNE OPTCK
         STY YMENU
         LDA #20
         JSR BELL
         JMP PROG
OPTCK    CMP #3
         BNE SELCK
         CPY #1
         BEQ OPT1
         CPY #2
         BEQ OPT2
         LDA #COLLIS&$FF
         LDX #COLLIS/256
         STA MDLIST+15
         STX MDLIST+16
         LDA #RINGDY&$FF
         LDX #RINGDY/256
         STA MDLIST+22
         STX MDLIST+23
         JMP OPOUT
OPT1     LDA #RINGD&$FF
         LDX #RINGD/256
         STA MDLIST+22
         STX MDLIST+23
         LDA #RINGSY&$FF
         LDX #RINGSY/256
         STA MDLIST+29
         STX MDLIST+30
         JMP OPOUT
OPT2     LDA #RINGS&$FF
         LDX #RINGS/256
         STA MDLIST+29
         STX MDLIST+30
         LDA #COLLISY&$FF
         LDX #COLLISY/256
         STA MDLIST+15
         STX MDLIST+16
OPOUT    INY 
         CPY #3
         BNE JBELL
         LDY #0
JBELL    LDA #40
         JSR BELL
         JMP CONCK
SELCK    CMP #5
         BNE CONCK
         CPY #1
         BEQ SEL1
         CPY #2
         BEQ SEL2
         LDA SCFLAG
         BEQ NOSCOR
         LDA #0
         STA SCFLAG
         LDA #SCORY&$FF
         LDX #SCORY/256
         STA MDLIST+18
         STX MDLIST+19
         JMP SELOUT
NOSCOR   LDA #1
         STA SCFLAG
         LDA #SCORN&$FF
         LDX #SCORN/256
         STA MDLIST+18
         STX MDLIST+19
         JMP SELOUT
SEL1     LDA ADENS
         CMP #10
         BEQ MEDSEL
         CMP #12
         BEQ HISEL
         LDA #10
         STA ADENS
         LDA #LOW&$FF
         LDX #LOW/256
         STA MDLIST+25
         STX MDLIST+26
         JMP SELOUT
MEDSEL   LDA #12
         STA ADENS
         LDA #MEDIUM&$FF
         LDX #MEDIUM/256
         STA MDLIST+25
         STX MDLIST+26
         JMP SELOUT
HISEL    LDA #14
         STA ADENS
         LDA #HIGH&$FF
         LDX #HIGH/256
         STA MDLIST+25
         STX MDLIST+26
         JMP SELOUT
SEL2     LDA ASPEED
         CMP #4
         BEQ FASTSEL
         LDA #4
         STA ASPEED
         LDA #SLOW&$FF
         LDX #SLOW/256
         STA MDLIST+32
         STX MDLIST+33
         JMP SELOUT
FASTSEL  LDA #3
         STA ASPEED
         LDA #FAST&$FF
         LDX #FAST/256
         STA MDLIST+32
         STX MDLIST+33
SELOUT   LDA #30
         JSR BELL
         JMP CONCK
BELL     STA AUDF1
         LDA #175
         STA AUDC1
         LDA #15
         STA CDTMV3
BTIME    LDA CDTMV3
         ORA #160
         STA AUDC1
         EOR #160
         BNE BTIME
         STA AUDF1
         STA AUDC1
         RTS 
