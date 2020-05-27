;Player/Missile graphics exanple
;
;by Karl E. Wiegers
;

    ;.encoding "screencodeatari"


OPEN  = $03
ICCOM = $0342
ICBAL = $0344
ICBLL = $0348
ICAX1 = $034A
ICAX2 = $034B
CIOV = $E456
;
;PMG-related equates
;
PCOLR0 = $02C0
SDMCTL = $022F
HPOSP0 = $D000
SIZEP0 = $D008
GRACTL = $D01D
PMBASE = $D407
;
;some variables I need to use
;
SHAPE = $CB
PLYRSTRT = $CD
YPOSP0 = $0630
XPOSP0 = $0634
NBYTES = $0638
TOP =   $0639
BOTTOM = $063A
DIRECT = $063D
;
;PMG area of 2K begins at $3000;
;player images are stored in
;unused part of PMG area
;
PMG =   $3000
;
;*******************************
;  MAIN PROGRAM STARTS HERE
;*******************************
;
    ;*=  $5000 ; for ATASM
   .org $5000 ;for MADS

START

    CLD         ;binary mode
    JSR OPENSCREEN ;open screen

    LDX #0
    TXA
INIT1
    STA PMG+$0300,X ;zero out
    STA PMG+$0400,X ;player and
    STA PMG+$0500,X ;missile
    STA PMG+$0600,X ;parts of
    STA PMG+$0700,X ;PMG area
    INX
    BNE INIT1
    LDA #>PMG ;store address
    STA PMBASE   ;of PMG area
    LDA #0
    LDX #3
INIT2
    STA SIZEP0,X ;zero sizes,
    STA HPOSP0,X ;horizontal
    STA XPOSP0,X ;positions
    DEX         ;for all
    BNE INIT2   ;players
;
;load alien shape into player
;
    LDA #<ALIEN ;store address
    STA SHAPE ;of shape in
    LDA #>ALIEN ;page 8 bytes
    STA SHAPE+1
    CLC
    LDA #$04    ;store address
    ADC #>PMG ;where player
    STA PLYRSTRT+1 ;is to be
    LDA #180    ;stored into
    STA PLYRSTRT ;page 0 bytes
    STA YPOSP0  ;and variable
    JSR COPYPLAYER ;store image
;
;load car shape into player 1
;the same way as the alien
;
    LDA #<CAR
    STA SHAPE
    LDA #>CAR
    STA SHAPE+1
    CLC
    LDA #$05
    ADC #>PMG
    STA PLYRSTRT+1
    LDA #122
    STA PLYRSTRT
    STA YPOSP0+1
    JSR COPYPLAYER
;
;set up PMG environment
;
    LDA #30     ;top of alien
    STA TOP     ;movement area.
    LDA #200    ;bottom of alien
    STA BOTTOM  ;movement area.
    LDA #28     ;alien is yellow
    STA PCOLR0
    LDA #86     ;car is purple
    STA PCOLR0+1
    LDA #62     ;single-line PMG
    STA SDMCTL  ;resolution
    LDA #1      ;car is double
    STA SIZEP0+1 ;wide
    LDA #3      ;enable PMG
    STA GRACTL
    LDA #120    ;alien starts in
    STA HPOSP0  ;middle of scree
    STA XPOSP0
    LDA #1      ;initial direc-
    STA DIRECT  ;tion is up
;
;commence player movement:
;alien moves only vertically,
;car moves only horizontally

ACTION
    LDX #15     ;do nothing
    JSR DELAY   ;for a bit
    INC XPOSP0+1 ;move car 1
    LDA XPOSP0+1 ;position to
    STA HPOSP0+1 ;the right
    CLC
    LDA #$04    ;store initial
    ADC #>PMG ;RAM position
    STA PLYRSTRT+1 ;of alien in
    LDA YPOSP0  ;page bytes
    STA PLYRSTRT
;
;logic to figure out if alien is
;be moved up or down
;
    LDA DIRECT  ;current dir
    BNE CHKTOP  ;up, check top
CHKBOT
    LDA YPOSP0  ;is he at the
    CMP BOTTOM  ;bottom?
    BEQ UP      ;yes. move up
    BNE DOWN    ;no. move down
CHKTOP
    LDA YPOSP0  ;is he at the
    CMP TOP     ;top?
    BNE UP      ;no, move up
DOWN
    JSR MOVEDOWN ;move him down
    LDA #0      ;current direc-
    STA DIRECT  ;tion is down
    CLC         ;keep going
    BCC ACTION
UP
    JSR MOVEUP  ;move him up
    LDA #1      ;current direc-
    STA DIRECT  ;tion is up
    CLC         ;keep going
    BCC ACTION
;********************************
; END OF MAIN PROGRAM
;********************************
;
;
;********************************
;SUBROUTINES START HERE
;********************************
;
;open screen in Graphics 3
;
OPENSCREEN
    LDX #$60
    LDA #OPEN
    STA ICCOM,X
    LDA #<SCREEN
    STA ICBAL,X
    LDA #>SCREEN
    STA ICBAL+1,X
    LDA #12
    STA ICAX1,X
    LDA #3
    STA ICAX2,X
    JSR CIOV
    RTS
;
;copy player from data region
;to desired PMG location
;
COPYPLAYER
    LDY #0      ;get no. of
    LDA (SHAPE),Y ;bytes of
    STA NBYTES  ;player data
    INC NBYTES  ;to be moved
    LDY #1
PLOOP
    LDA (SHAPE),Y ;copy to PMG
    STA (PLYRSTRT),Y ;area
    INY         ;data area
    CPY NBYTES  ;all bytes yet?
    BNE PLOOP   ;no, keep going
    RTS         ;yes, stop
;
;do-nothing delay subroutine
;number in X-register deternines
;length of delay
;
DELAY
    LDY #0
DELAY2
    DEY
    BNE DELAY2
    DEX
    BNE DELAY
    RTS

;sub. to Move alien shape down
;one line (up one byte in RAM)

MOVEDOWN
    LDY ALIEN   ;get # bytes
LOOPDOWN
    LDA (PLYRSTRT),Y ; get a byte
    INY         ;store one
    STA (PLYRSTRT),Y ;byte higher
    DEY         ;point to
    DEY         ;lower byte
    BPL LOOPDOWN ;go until
    INC YPOSP0  ;new Y position
    RTS

;sub. to Move alien shape up
;one line (down one byte in RAM)

MOVEUP
    LDA ALIEN   ;# bytes to move
    STA NBYTES  ;is 1 more than
    INC NBYTES  ;# player bytes
    LDY #1
LOOPUP
    LDA (PLYRSTRT),Y ;get a byte
    DEY         ;store 1
    STA (PLYRSTRT),Y ;byte lower
    INY         ;point to
    INY         ;next one
    CPY NBYTES  ;done all?
    BNE LOOPUP  ;no, go on
    DEC YPOSP0  ;new Y position
    RTS
;
;data values needed
;
SCREEN .text 'S'
;
;data for player shapes are
;stored in unused portion of
;PMG area
;
   ;*= PMG ; for atasm
  .org PMG ;for MADS
;
;normal alien
;
ALIEN
    .BYTE 14,60,24,126,189,189
    .BYTE 189,189,60,50,36
    .BYTE 36,36,102,0
;
;car shape
;
CAR
    .BYTE 15,126,195,219,219
    .BYTE 91,219,219,219,219
    .BYTE 91,219,219,195,126,0

;    *=	$02E0 ; for atasm
   ;.org $2e0 ;for MADS
   .segment "Launcher"

	.WORD	START

