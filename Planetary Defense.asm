;
; File: PLANET1.M65
;
    .OPT NO LIST
; ------------------
; ANALOG Computing's
; PLANETARY  DEFENSE
; ------------------
;
; by Charles Bachand
;   and Tom Hudson
;
; Written with OSS MAC/65
;
; ------------------
; Hardware Registers
; ------------------
;
HPOSP0 = $D000  ;P0 horizontal
HPOSM0 = $D004  ;M0 horizontal
P0PF =  $D004   ;P0-PField coll.
M0PL =  $D008   ;M0-PLayer coll.
GRAFP0 = $D00D  ;PM graphics
COLPF0 = $D016  ;PF color 0
GRACTL = $D01D  ;graphic control
HITCLR = $D01E  ;clear hit reg
CONSOL = $D01F  ;console buttons
AUDF1 = $D200   ;frequency 1
AUDC1 = $D201   ;volume 1
AUDCTL = $D208  ;audio control
RANDOM = $D20A  ;random numbers
DMACTL = $D400  ;DMA control
PMBASE = $D407  ;PM base address
WSYNC = $D40A   ;wait hor. sync
NMIEN = $D40E   ;interrupt reg.
ATRACT = $4D    ;attract flag
;
; ------------------------
; Operating System Vectors
; ------------------------
;
SETVBV = $E45C  ;set v.blank
XITVBV = $E462  ;exit v.blank
SIOINV = $E465  ;serial I/O init
;
; ----------------
; Shadow Registers
; ----------------
;
VDSLST = $0200  ;DLI vector
SDMCTL = $022F  ;DMA control
SDLSTL = $0230  ;DList pointer
GPRIOR = $026F  ;gr. priority
PADDL0 = $0270  ;paddle 0
PADDL1 = $0271  ;paddle 1
STICK0 = $0278  ;joystick 0
PTRIG0 = $027C  ;paddle trig 0
PTRIG1 = $027D  ;paddle trig 1
STRIG0 = $0284  ;stick trig 0
PCOLR0 = $02C0  ;player colors
COLOR0 = $02C4  ;playfield "
CH  =   $02FC   ;keyboard char
;
; -------------------
; Page Zero Registers
; -------------------
;
    *=  $80     ;top of page 0
;
INDEX *= *+2    ;temp index
INDX1 *= *+2    ;temp index
INDX2 *= *+2    ;temp index
COUNT *= *+1    ;temp register
TEMP *= *+1     ;temp register
SATEMP *= *+1   ;temp register
SCNT *= *+1     ;orbit index
LO  *=  *+1     ;plot low byte
HI  *=  *+1     ;plot high byte
DEADTM *= *+1   ;death timer
EXPTIM *= *+1   ;explosion timer
BOMTIM *= *+1   ;bomb timer
SATPIX *= *+1   ;sat. pic cntr
CURX *= *+1     ;cursor x
CURY *= *+1     ;cursor y
FROMX *= *+1    ;vector from X
FROMY *= *+1    ;vector from Y
TOX *=  *+1     ;vector to X
TOY *=  *+1     ;vector to Y
SATX *= *+1     ;satellite x
SATY *= *+1     ;satellite y
XHOLD *= *+1    ;x reg hold area
LASTRG *= *+1   ;last trigger
LEVEL *= *+1    ;level number
BLEVEL *= *+1   ;binary level #
LIVES *= *+1    ;lives left
SCORE *= *+3    ;score digits
SCOADD *= *+3   ;score inc.
SHOBYT *= *+1   ;digit hold
SHCOLR *= *+1   ;digit color
SATLIV *= *+1   ;satellite flag
BOMVL *= *+1    ;bomb value low
BOMVH *= *+1    ;bomb value high
SAUVAL *= *+1   ;saucer value
GAMCTL *= *+1   ;game ctrl flag
DLICNT *= *+1   ;DLI counter
SAUCER *= *+1   ;saucer flag
SAUTIM *= *+1   ;image timer
SAUCHN *= *+1   ;saucer chance
BOMBWT *= *+1   ;bomb wait time
BOMCOL *= *+1   ;bomb collis flg
DEVICE *= *+1   ;koala pad sw
PLNCOL *= *+1   ;planet color
PAUSED *= *+1   ;pause flag
AVG *=  *+2     ;average
PTR *=  *+2     ;queue pointer
SSSCNT *= *+1   ;saucer snd cnt
EXSCNT *= *+1   ;expl. snd count
ESSCNT *= *+1   ;enemy shot snd
PSSCNT *= *+1   ;player shot snd
TITLE *= *+1    ;title scrn flag
PENFLG *= *+1   ;pen up/dwn flg
EXPCNT *= *+1   ;explosion counter
NEWX *= *+1     ;explosion x
NEWY *= *+1     ;explosion y
PLOTCLR *= *+1  ;plot/erase flag
COUNTR *= *+1   ;explosion index
PLOTX *= *+1    ;plot x coord
PLOTY *= *+1    ;plot y coord
HIHLD *= *+1    ;plot work area
LOHLD *= *+1    ;plot work area
BOMBS *= *+1    ;bombs to come
BOMTI *= *+1    ;bomb speeds
VXINC *= *+1    ;vector x hold
VYINC *= *+1    ;vector y hold
LR  *=  *+1     ;vector left/right hold
UD  *=  *+1     ;vector up/down hold
DELTAX *= *+1   ;vector work area
DELTAY *= *+1   ;vector work area
XQ  *=  *+5     ;x queue
YQ  *=  *+5     ;y queue
SL  *=  *+5     ;samples lo
SH  *=  *+5     ;samples hi
;
; ----------------------------
; Screen + Player/Missile Area
; ----------------------------
;
SCRN =  $3000   ;screen area
PPOS =  SCRN+1935 ;planet pos
;
PM  =   $00
MISL =  PM+$0300 ;missiles
PLR0 =  MISL+$0100 ;player 0
PLR1 =  PLR0+$0100 ;player 1
PLR2 =  PLR1+$0100 ;player 2
PLR3 =  PLR2+$0100 ;player 3
;
ORBX =  $1E00   ;orbit X
ORBY =  $1F00   ;orbit Y
;
; -------------
; Start of game
; -------------
;
    *=  $2000
;
; ------------------
; Intro Display List
; ------------------
;
TLDL .BYTE $70,$70,$70,$70
    .BYTE $70,$70,$70,$70
    .BYTE $70,$46
    .WORD MAGMSG
    .BYTE $70,7,$70,6
    .BYTE $10,6,$70,$70
    .BYTE 6,$20,6,$40
    .BYTE 6,$41
    .WORD TLDL
;
; ------------------
; Intro Message Text
; ------------------
;
MAGMSG .SBYTE " ANALOG CO"
    .SBYTE "MPUTING'S "
    .SBYTE +$40," PLANETARY"
    .SBYTE +$40,"  DEFENSE "
    .SBYTE +$80," BY CHARLE"
    .SBYTE +$80,"S BACHAND "
    .SBYTE +$C0,"   AND TOM"
    .SBYTE +$C0," HUDSON   "
    .SBYTE +$40," KOALA PAD"
    .SBYTE +$40," - SELECT "
    .SBYTE +$C0," JOYSTICK "
    .SBYTE +$C0,"--- START "
    .SBYTE "  OR PRESS"
    .SBYTE " TRIGGER  "
;
; -----------------
; Game Display List
; -----------------
;
GLIST .BYTE $70,$70,$46
    .WORD SCOLIN
    .BYTE $4D
    .WORD SCRN
    .BYTE $8D,$8D,$8D,$8D
    .BYTE $8D,$8D,$8D,$8D
    .BYTE $8D,$8D,$8D,$8D
    .BYTE $8D,$8D,$8D,$8D
    .BYTE $8D,$8D,$8D,$8D
    .BYTE $8D,$8D,$8D,$8D
    .BYTE $8D,$8D,$8D,$8D
    .BYTE $8D,$8D,$8D,$8D
    .BYTE $8D,$8D,$8D,$8D
    .BYTE $8D,$8D,$8D,$8D
    .BYTE $8D,$8D,$8D,$8D
    .BYTE $8D,$8D,$8D,$8D
    .BYTE $8D,$8D,$8D,$8D
    .BYTE $8D,$8D,$8D,$8D
    .BYTE $8D,$8D,$8D,$8D
    .BYTE $8D,$8D,$8D,$8D
    .BYTE $8D,$8D,$8D,$8D
    .BYTE $8D,$8D,$8D,$8D
    .BYTE $8D,$8D,$8D,$8D
    .BYTE $8D,$8D,$8D,$8D
    .BYTE $8D,$8D,$8D,$8D
    .BYTE $8D,$8D,$8D,$8D
    .BYTE $8D,$8D,$8D,$8D
    .BYTE $8D,$8D,$8D,$41
    .WORD GLIST
;
; ------------------------
; Display the Intro Screen
; ------------------------
;
PLANET CLD      ;clear decimal
    LDA #$00    ;get zero
    STA NMIEN   ;display off
    LDX #$7F    ;set index
CLPG0 STA $80,X ;clr top page 0
    DEX         ;dec pointer
    BNE CLPG0   ;done? No.
    INC TITLE   ;title on flag
    LDA #$FF    ;get $FF
    STA LIVES   ;set dead
    STA GAMCTL  ;game control
    STA ESSCNT  ;no enemy shots
    STA PSSCNT  ;no player shots
    JSR SNDOFF  ;no sound on 123
    STA AUDC1+6 ;turn off snd 4
    LDA #$C4    ;medium green
    STA COLOR0  ;score color
    LDA #$84    ;medium blue
    STA COLOR0+1 ;text color
    LDA #$0A    ;bright white
    STA COLOR0+2 ;shot color
    LDA #$98    ;light blue
    STA COLOR0+3 ;text color
    LDA # <DLI  ;set DLI vector
    STA VDSLST  ;low byte
    LDA # >DLI  ;set DLI vector
    STA VDSLST+1 ;high byte
    LDA #$C0    ;enable Display
    STA NMIEN   ;List Interrupts
    LDA #$32    ;PM DMA off
    STA DMACTL  ;DMA control
    STA SDMCTL  ;and shadow reg
    LDA #0      ;get zero
    STA GRACTL  ;graphics ctrl
    STA AUDCTL  ;reset audio
    LDX #4      ;5 PM registers
NOPM STA GRAFP0,X ;clr register
    DEX         ;dec index
    BPL NOPM    ;done? No.
    JSR SIOINV  ;init sound
    LDA # <TLDL ;DL addr low
    STA SDLSTL  ;DL pntr low
    LDA # >TLDL ;DL addr high
    STA SDLSTL+1 ;DL pntr high
    LDX # >VBLANK ;vblank high
    LDY # <VBLANK ;vblank low
    LDA #7      ;deferred
    JSR SETVBV  ;set vblank
    LDA #60     ;one second
    STA DEADTM  ;dead time
;
; --------------------------
; Check console and triggers
; --------------------------
;
START LDA DEADTM ;look dead time
    BNE START   ;alive? No.
CCHK LDA PTRIG0 ;paddle trig 0
    EOR PTRIG1  ;mask w/PTRIG1
    BNE PDEV    ;pushed? Yes.
    LDA STRIG0  ;stick trig
    BEQ PDEV    ;pushed? Yes.
    LDA CONSOL  ;get console
    AND #3      ;do START/SELECT
    CMP #3      ;test buttons
    BEQ CCHK    ;any pushed? No.
    AND #1      ;mask off START
PDEV STA DEVICE ;device switch
RELWT LDA #10   ;1/6 second
    STA DEADTM  ;dead time
RELWT2 LDA DEADTM ;debounce!
    BNE RELWT2  ;time up? No.
    LDA CONSOL  ;get console
    CMP #7      ;keys released?
    BNE RELWT   ;No. loop until
;
; ---------------------------
; Clear PM Area and Playfield
; ---------------------------
;
    LDA # >SCRN ;scrn addr high
    STA INDEX+1 ;pointer high
    LDA #0      ;get zero
    STA INDEX   ;pointer low
    LDX #15     ;16 pages 0..15
    TAY         ;use as index
CL0 STA (INDEX),Y ;clear ram
    INY         ;next byte
    BNE CL0     ;page done? No.
    INC INDEX+1 ;next page
    DEX         ;page counter
    BPL CL0     ;scrn done? No.
    LDX #0      ;now clear P/m
CLPM STA MISL,X ;clear missiles
    STA PLR0,X  ;clear plyr 0
    STA PLR1,X  ;clear plyr 1
    STA PLR2,X  ;clear plyr 2
    STA PLR3,X  ;clear plyr 3
    DEX         ;done 256 bytes?
    BNE CLPM    ;no, loop back!
    LDA # <GLIST ;Point to the
    STA SDLSTL  ;game display
    LDA # >GLIST ;list to show
    STA SDLSTL+1 ;the playfield.
    LDA # >PM   ;PM address high
    STA PMBASE  ;into hardware
    LDA #$3E    ;enable single
    STA SDMCTL  ;line resolution
    STA DMACTL  ;DMA control
    LDA #3      ;enable player
    STA GRACTL  ;and missile DMA
    LDA #$11    ;set up
    STA GPRIOR  ;P/M priority
    LDA #0      ;get zero
    STA TITLE   ;title off
;
; ---------------
; Draw The Planet
; ---------------
;
    LDA # <PPOS ;planet pos high
    STA INDX1   ;pointer #1 low
    STA INDX2   ;pointer #2 low
    LDA # >PPOS ;planet pos high
    STA INDX1+1 ;pointer #1 high
    STA INDX2+1 ;pointer #2 high
    LDX #0      ;table pointer
DP0 LDY #0      ;index pointer
DP1 LDA DPTBL,X ;table value
    BNE DP2     ;done? No.
    JMP SETUP   ;continue
DP2 BMI DPRPT   ;repeat? Yes.
    STA (INDX1),Y ;put values
    STA (INDX2),Y ;onto screen
    INY         ;inc index pntr
    INX         ;inc table pntr
    JMP DP1     ;continue
;
; -------------------
; Repeat Byte Handler
; -------------------
;
DPRPT ASL A     ;shift byte
    STA TEMP    ;new line flag
    ASL A       ;NL bit -> carry
    ASL A       ;color -> carry
    LDA #$55    ;color 1 bits
    BCS FILL1   ;color 1? Yes.
    LDA #0      ;get background
FILL1 PHA       ;save color byte
    LDA DPTBL,X ;table value
    AND #$0F    ;mask 4 bits
    STA COUNT   ;save as count
    PLA         ;restore color
FILL2 STA (INDX1),Y ;put bytes
    STA (INDX2),Y ;onto screen
    INY         ;inc index
    DEC COUNT   ;dec byte count
    BNE FILL2   ;done? No.
    INX         ;inc table index
    LDA TEMP    ;get flag
    BPL DP1     ;new line? No.
    SEC         ;set carry
    LDA INDX1   ;Yes. get low
    SBC #40     ;subtract 40
    STA INDX1   ;new low
    BCS DPN1    ;overflow? No.
    DEC INDX1+1 ;decrement high
DPN1 CLC        ;clear carry
    LDA INDX2   ;get low
    ADC #40     ;add 40
    STA INDX2   ;new low
    BCC DP0     ;overflow? No.
    INC INDX2+1 ;increment high
    JMP DP0     ;continue
;
; ----------------
; Planet Draw Data
; ----------------
;
DPTBL .BYTE $EA,$EA,$EA,$EA
    .BYTE $EA,$15,$A8,$54
    .BYTE $C1,$15,$A8,$54
    .BYTE $C1,$05,$A8,$50
    .BYTE $C1,$05,$A8,$50
    .BYTE $C1,$01,$A8,$40
    .BYTE $C1,$81,$E8,$81
    .BYTE $15,$A6,$54,$C1
    .BYTE $81,$05,$A6,$50
    .BYTE $C1,$81,$01,$A6
    .BYTE $40,$C1,$82,$E6
    .BYTE $82,$05,$A4,$50
    .BYTE $C1,$83,$E4,$84
    .BYTE $E2,0
;
; -------------------------
; Setup Orbiter Coordinates
; -------------------------
;
SETUP LDX #64   ;do 65 bytes
    LDY #0      ;quad 2/4 offset
SU1 CLC         ;clear carry
    LDA #96     ;center Y
    ADC OYTBL,X ;add offset Y
    STA ORBY+$40,Y ;quad-2 Y
    STA ORBY+$80,X ;quad-3 Y
    LDA #80     ;center X
    ADC OXTBL,X ;add offset X
    STA ORBX,X  ;quad-1 X
    STA ORBX+$40,Y ;quad-2 X
    SEC         ;set carry
    LDA #80     ;center X
    SBC OXTBL,X ;sub offset X
    STA ORBX+$80,X ;quad-3 X
    STA ORBX+$C0,Y ;quad-4 X
    LDA #96     ;center Y
    SBC OYTBL,X ;sub offset Y
    STA ORBY,X  ;quad-1 Y
    STA ORBY+$C0,Y ;quad-4 Y
    INY         ;quad 2/4 offset
    DEX         ;quad 1/3 offset
    BPL SU1     ;done? No.
    JMP INIT    ;continue
;
; ---------------------------
; Orbiter X,Y Coordinate Data
; ---------------------------
;
OXTBL .BYTE 0,1,2,2,3
    .BYTE 4,5,5,6,7
    .BYTE 8,9,9,10,11
    .BYTE 12,12,13,14,14
    .BYTE 15,16,16,17,18
    .BYTE 18,19,20,20,21
    .BYTE 21,22,23,23,24
    .BYTE 24,25,25,26,26
    .BYTE 27,27,27,28,28
    .BYTE 29,29,29,30,30
    .BYTE 30,30,31,31,31
    .BYTE 31,31,32,32,32
    .BYTE 32,32,32,32,32
;
OYTBL .BYTE 54,54,54,54,54
    .BYTE 54,54,54,53,53
    .BYTE 53,52,52,52,51
    .BYTE 51,50,50,49,49
    .BYTE 48,47,47,46,45
    .BYTE 44,44,43,42,41
    .BYTE 40,39,38,38,37
    .BYTE 36,35,33,32,31
    .BYTE 30,29,28,27,26
    .BYTE 24,23,22,21,20
    .BYTE 18,17,16,15,13
    .BYTE 12,11,9,8,7
    .BYTE 5,4,3,1,0
;
; ----------------------
; Display list interrupt
; ----------------------
;
DLI PHA         ;save Acc
    TXA         ;X --> Acc
    PHA         ;save X register
    INC DLICNT  ;inc counter
    LDA DLICNT  ;get counter
    AND #$07    ;only 3 bits
    TAX         ;use as index
    LDA DLIBRT,X ;planet bright
    ORA PLNCOL  ;planet color
    STA WSYNC   ;start of scan
    STA COLPF0  ;color planet
    LDA #$8C    ;bright blue
    STA COLPF0+1 ;shot color
    PLA         ;restore X
    TAX         ;Acc --> X
    PLA         ;restore Acc
    RTI         ;return
;
DLIBRT .BYTE 0,2,4,6 ;planet
    .BYTE 8,6,4,2 ;brightness
;
; ----------------------
; Vertical blank routine
; ----------------------
;
VBLANK CLD      ;clear decimal
    LDX SAUCER  ;saucer flag as
    LDA P3COLR,X ;index 0 or 1
    STA PCOLR0+3 ;saucer color
    LDA #5      ;get 5
    STA DLICNT  ;reset DLI count
    LDA #$C0    ;enable
    STA NMIEN   ;DLI's
    LDA CH      ;keyboard char
    CMP #$21    ;space bar?
    BNE PCHK    ;No. skip it
    LDA PAUSED  ;pause flag
    EOR #$FF    ;invert it
    STA PAUSED  ;save pause flag
    LDA #$FF    ;get $FF
    STA CH      ;reset keyboard
PCHK LDA PAUSED ;pause flag
    BEQ NOPAU   ;paused? No.
    LDA #0      ;get zero
    LDX #7      ;do 8 bytes
NOSND STA AUDF1,X ;zero sound
    DEX         ;dec index
    BPL NOSND   ;done? No.
    JMP XITVBV  ;exit VBLANK
NOPAU LDA TITLE ;title flag
    BNE NOCYC   ;title? Yes.
    LDA COLOR0+2 ;No. get color
    CLC         ;clear carry
    ADC #$10    ;next color
    STA COLOR0+2 ;explosion col.
NOCYC LDA EXSCNT ;explosion cnt
    BEQ NOPAU2  ;any? No.
    LSR A       ;count/2
    LSR A       ;count/4
    STA AUDC1+6 ;explo volume
    LDA #40     ;explosion
    STA AUDF1+6 ;explo frequency
    DEC EXSCNT  ;dec count
NOPAU2 LDA GAMCTL ;game control
    BPL CURSOR  ;cursor? Yes.
    JMP TIMERS  ;No. skip
;
; --------------
; Cursor handler
; --------------
;
CURSOR LDY CURY ;get y pos
    LDX #5      ;clear 6 bytes
ERACUR LDA #$0F ;now clear out
    AND MISL-3,Y ;old cursor
    STA MISL-3,Y ;graphics,
    INY         ;next Y position
    DEX         ;dec count
    BPL ERACUR  ;loop until done
    LDA STICK0  ;read joystick
    LDX CURX    ;get X value
    LDY CURY    ;get Y value
    LSR A       ;shift right
    BCS NOTN    ;North? No.
    DEY         ;move cursor up
    DEY         ;two scan lines
NOTN LSR A      ;shift right
    BCS NOTS    ;South? No.
    INY         ;cursor down
    INY         ;two scan lines
NOTS LSR A      ;shift right
    BCS NOTW    ;West? No.
    DEX         ;cursor left
NOTW LSR A      ;shift right
    BCS NOTE    ;East? No.
    INX         ;cursor right
NOTE CPX #48    ;too far left?
    BCC BADX    ;Yes. skip next
    CPX #208    ;too far right?
    BCS BADX    ;Yes. skip next
    STX CURX    ;No. it's ok!
BADX CPY #32    ;too far up?
    BCC BADY    ;Yes. skip next
    CPY #224    ;too far down?
    BCS BADY    ;Yes. skip next
    STY CURY    ;No. it's ok!
BADY LDA DEVICE ;KOALA switch
    BEQ NKOALA  ;KOALA PAD?
    JSR KOALA   ;Yes. do it
NKOALA LDA PENFLG ;koala pen flg
    BNE TIMERS  ;pen up? Yes.
    LDX #5      ;6 bytes...
    LDY CURY    ;get cursor Y
SHOCUR LDA CURPIC,X ;cursor pic
    ORA MISL-3,Y ;mask missiles
    STA MISL-3,Y ;store missiles
    INY         ;next scan line
    DEX         ;dec count
    BPL SHOCUR  ;done? No.
    LDX CURX    ;get x position,
    DEX         ;1 less for...
    STX HPOSM0+3 ;missile 3
    INX         ;2 more for...
    INX         ;missile 2
    STX HPOSM0+2 ;save position
;
; -----------------------
; Handle timers and orbit
; -----------------------
;
TIMERS LDA BOMBWT ;bomb wait cnt
    BEQ NOBWT   ;wait over? Yes.
    DEC BOMBWT  ;dec count
NOBWT LDA DEADTM ;death timer
    BEQ NOTIM0  ;zero? yes.
    DEC DEADTM  ;decrement it!
NOTIM0 LDA EXPTIM ;exp timer
    BEQ NOTIM1  ;zero? Yes.
    DEC EXPTIM  ;decrement it!
NOTIM1 LDA BOMTIM ;get bomb time
    BEQ NOTIM2  ;zero? Yes.
    DEC BOMTIM  ;dec bomb time
NOTIM2 LDA GAMCTL ;game control
    BPL NOTOVR  ;game over? No.
    JMP XITVBV  ;exit VBLANK
NOTOVR LDA SATLIV ;get satellite
    BEQ NOSAT   ;alive? No.
    INC SCNT    ;inc count
    LDY SCNT    ;orbit index
    CLC         ;clear carry
    LDA ORBX,Y  ;get X coord
    STA SATX    ;save Pfield x
    ADC #47     ;X offset
    STA HPOSM0+1 ;horizontal pos
    ADC #2      ;+2 offset for
    STA HPOSM0  ;right side
    LDA ORBY,Y  ;get Y coord
    LSR A       ;divide by 2
    STA SATY    ;for playfield
    ROL A       ;restore for PM
    ADC #36     ;screen offset
    TAX         ;use as index
    INC SATPIX  ;next sat. image
    LDA SATPIX  ;get number
    AND #$08    ;use bit 3
    TAY         ;use as index
    LDA #8      ;do 8 bytes
    STA SATEMP  ;save count
SSAT LDA MISL,X ;missile graphic
    AND #$F0    ;mask off 1,2
    ORA SATSH,Y ;add sat shape
    STA MISL,X  ;put player #1
    DEX         ;dec position
    INY         ;dec index
    DEC SATEMP  ;dec count
    BNE SSAT    ;done? No.
NOSAT LDA SAUCER ;saucer flag
    BEQ SOUNDS  ;saucer? No.
    LDY BOMBY+3 ;saucer Y pos
    DEY         ;-1
    DEY         ;-2
    LDX #9      ;10 scan lines
SSAULP CPY #32  ;above top?
    BCC NXTSP   ;Yes. skip it
    CPY #223    ;below bottom?
    BCS NXTSP   ;Yes. skip it
    LDA SAUPIC,X ;saucer image
    STA PLR3,Y  ;store player 3
NXTSP DEY       ;next scan line
    DEX         ;dec index
    BPL SSAULP  ;done? No.
    LDA BOMBX+3 ;saucer X pos
    STA HPOSP0+3 ;move it
    INC SAUTIM  ;saucer time
    LDA SAUTIM  ;get counter
    LSR A       ;/2
    AND #$03    ;use only 0..3
    TAX         ;as X index
    LDA SAUMID,X ;saucer middle
    STA SAUPIC+4 ;put in
    STA SAUPIC+5 ;saucer image
SOUNDS LDX PSSCNT ;shot sound
    BPL DOS1    ;shot? Yes.
    LDA #0      ;No. get zero
    STA AUDC1   ;volume for shot
    BEQ TRYS2   ;skip next
DOS1 LDA #$A6   ;shot sound vol
    STA AUDC1   ;set hardware
    LDA PLSHOT,X ;shot sound
    STA AUDF1   ;frequency
    DEC PSSCNT  ;dec shot snd
TRYS2 LDX ESSCNT ;enemy shots
    BPL DOS2    ;shots? Yes.
    LDA #0      ;No. get zero
    STA AUDC1+2 ;into volume
    BEQ TRYS3   ;skip rest
DOS2 LDA #$A6   ;shot sound vol
    STA AUDC1+2 ;set hardware
    LDA ENSHOT,X ;shot sound
    STA AUDF1+2 ;frequency
    DEC ESSCNT  ;dec shot snd
TRYS3 LDA SAUCER ;saucer flag
    BEQ NOS3    ;saucer? No.
    LDA BOMBY+3 ;saucer Y pos
    CMP #36     ;above top?
    BCC NOS3    ;Yes. skip
    CMP #231    ;below bottom?
    BCC DOS3    ;No. make sound
NOS3 LDA #0     ;get zero
    STA AUDC1+4 ;no saucer snd
    BEQ VBDONE  ;skip next
DOS3 INC SSSCNT ;inc saucer cnt
    LDX SSSCNT  ;saucer count
    CPX #12     ;at limit?
    BMI SETS3   ;No. skip next
    LDX #0      ;get zero
    STX SSSCNT  ;zero saucer cnt
SETS3 LDA #$A8  ;saucer volume
    STA AUDC1+4 ;set hardware
    LDA SAUSND,X ;saucer sound
    STA AUDF1+4 ;set hardware
VBDONE JMP XITVBV ;continue
;
; ---------------------
; Satellite shape table
; ---------------------
;
SATSH .BYTE 0,0,0,$0A
    .BYTE $04,$0A,0,0
    .BYTE 0,0,0,$04
    .BYTE $0A,$04,0,0
;
;
; File: D:PLANET2.M65
;
; ----------------
; Initialize Misc.
; ----------------
;
INIT LDA #0     ;zero out..
    STA SCORE   ;score byte 0
    STA SCORE+1 ;score byte 1
    STA SCORE+2 ;score byte 2
    STA DEADTM  ;dead timer
    STA PAUSED  ;pause flag
    STA EXPCNT  ;expl. counter
    STA SAUCER  ;no saucer
    STA BLEVEL  ;bomb level
    LDX #11     ;no bombs!
CLRACT STA BOMACT,X ;deactivate
    DEX         ;next bomb
    BPL CLRACT  ;done? No.
    LDX #19     ;zero score line
INISLN LDA SCOINI,X ;get byte
    STA SCOLIN,X ;put score line
    DEX         ;next byte
    BPL INISLN  ;done? No.
    LDA #$01    ;get one
    STA LEVEL   ;game level
    STA SATLIV  ;live satellite
    LDA #4      ;get 4
    STA LIVES   ;number of lives
    LDA #$0C    ;set explosion
    STA COLOR0+2 ;brightness
    LDA #$34    ;medium red
    STA PCOLR0  ;bomb 0 color
    STA PCOLR0+1 ;bomb 1 color
    STA PCOLR0+2 ;bomb 2 color
    LDA #127    ;center screen X
    STA CURX    ;cursor X pos
    LDA #129    ;center screen Y
    STA CURY    ;cursor Y pos
    LDA #1      ;get one
    STA GAMCTL  ;game control
    JSR SHOSCO  ;display score
    LDA #$54    ;graphic-LF of
    STA SCRN+1939 ;planet center
    LDA #$15    ;graphic-RT of
    STA SCRN+1940 ;planet center
    STA HITCLR  ;reset collision
;
; ----------------------
; Set up level variables
; ----------------------
;
SETLVL JSR SHOLVL ;show level
    LDX BLEVEL  ;bomb level
    LDA INIBOM,X ;bombs / level
    STA BOMBS   ;bomb count
    LDA INIBS,X ;bomb speed
    STA BOMTI   ;bomb timer
    LDA INISC,X ;% chance of
    STA SAUCHN  ;saucer in level
    LDA INIPC,X ;planet color
    CMP #$FF    ;level >14?
    BNE SAVEPC  ;No. skip next
    LDA RANDOM  ;random color
    AND #$F0    ;mask off lum.
SAVEPC STA PLNCOL ;planet color
    LDA INIBVL,X ;bomb value low
    STA BOMVL   ;save it
    LDA INIBVH,X ;bomb value hi
    STA BOMVH   ;save it
    LDA INISV,X ;saucer value
    STA SAUVAL  ;save that too
    CPX #11     ;at level 11?
    BEQ SAMLVL  ;Yes. skip next
    INC BLEVEL  ;inc bomb level
SAMLVL SED      ;decimal mode
    LDA LEVEL   ;game level #
    CLC         ;clear carry
    ADC #1      ;add one
    STA LEVEL   ;save game level
    CLD         ;clear decimal
;
; -----------------
; Main program loop
; -----------------
;
LOOP LDA PAUSED ;game paused?
    BNE LOOP    ;Yes. loop here
    LDA #0      ;get zero
    STA ATRACT  ;attract mode
    LDA GAMCTL  ;game done?
    BPL CKCORE  ;No. check core
    LDA EXPCNT  ;Yes. expl count
    BNE CKCORE  ;count done? No.
    JMP ENDGAM  ;The End!
;
; --------------------------
; Check planet core for hit!
; --------------------------
;
CKCORE LDA SCRN+1939 ;center LF
    AND #$03    ;RT color clock
    CMP #$03    ;explosion colr?
    BEQ PLDEAD  ;Yes. go dead
    LDA SCRN+1940 ;center RT
    AND #$C0    ;LF color clock
    CMP #$C0    ;explosion colr?
    BNE PLANOK  ;No. skip next
;
; ---------------
; Planet is Dead!
; ---------------
;
PLDEAD LDA #0   ;get zero
    STA BOMBS   ;zero bombs
    STA SATLIV  ;satelite dead
    LDA #$FF    ;get #$FF
    STA LIVES   ;no lives left
    STA GAMCTL  ;game control
    JSR SNDOFF  ;no sound
;
; -------------
; Check console
; -------------
;
PLANOK LDA CONSOL ;get console
    CMP #7      ;any pressed?
    BEQ NORST   ;No. skip next
    JMP PLANET  ;restart game!
;
; -----------------
; Projectile firing
; -----------------
;
NORST JSR BOMINI ;try new bomb
    LDA SATLIV  ;satellite stat
    BEQ NOTRIG  ;alive? No.
    LDA STRIG0  ;get trigger
    CMP LASTRG  ;same as last VB
    BEQ NOTRIG  ;Yes. skip next
    STA LASTRG  ;No. save trig
    CMP #0      ;pressed?
    BNE NOTRIG  ;No. skip next
    JSR PROINI  ;strt projectile
NOTRIG JSR BOMADV ;advance bombs
    LDA EXPTIM  ;do explosion?
    BNE NOEXP   ;no!
    JSR CHKSAT  ;satellite ok?
    JSR CHKHIT  ;any hits?
    JSR EXPHAN  ;handle expl.
    JSR PROADV  ;advance shots
    LDA SAUCER  ;saucer flag
    BEQ RESTIM  ;saucer? No.
    JSR SSHOOT  ;Yes. let shoot
RESTIM LDA #1   ;get one
    STA EXPTIM  ;reset timer
NOEXP LDA BOMBS ;# bombs to go
    BNE LOOP    ;any left? Yes.
    LDA GAMCTL  ;game control
    BMI LOOP    ;dead? Yes.
    LDA BOMACT  ;bomb 0 status
    ORA BOMACT+1 ;bomb 1 status
    ORA BOMACT+2 ;bomb 2 status
    ORA BOMACT+3 ;bomb 3 status
    BEQ JSL     ;any bombs? No.
    JMP LOOP    ;Yes. continue
JSL JMP SETLVL  ;setup new level
;
; ------------------------
; Initiate a new explosion
; ------------------------
;
NEWEXP LDA #64  ;1.07 seconds
    STA EXSCNT  ;expl sound cnt
    INC EXPCNT  ;one more expl
    LDY EXPCNT  ;use as index
    LDA NEWX    ;put X coord
    STA XPOS,Y  ;into X table
    LDA NEWY    ;put Y coord
    STA YPOS,Y  ;into Y table
    LDA #0      ;init to zero
    STA CNT,Y   ;explosion image
RT1 RTS         ;return
;
; ------------------------------
; Main explosion handler routine
; ------------------------------
;
EXPHAN LDA #0   ;init to zero
    STA COUNTR  ;zero counter
RUNLP INC COUNTR ;nxt explosion
    LDA EXPCNT  ;get explosion #
    CMP COUNTR  ;any more expl?
    BMI RT1     ;No. return
    LDX COUNTR  ;get index
    LDA #0      ;init plotclr
    STA PLOTCLR ;0 = plot block
    LDA CNT,X   ;expl counter
    CMP #37     ;all drawn?
    BMI DOPLOT  ;No. do it
    INC PLOTCLR ;1 = erase block
    SEC         ;set carry
    SBC #37     ;erase cycle
    CMP #37     ;erase done?
    BMI DOPLOT  ;No. erase block
    TXA         ;move index
    TAY         ;to Y register
;
; ---------------------------
; Repack explosion table, get
; rid of finished explosions
; ---------------------------
;
REPACK INX      ;next explosion
    CPX EXPCNT  ;done?
    BEQ RPK2    ;No. repack more
    BPL RPKEND  ;Yes. exit
RPK2 LDA XPOS,X ;get X position
    STA XPOS,Y  ;move back X
    LDA YPOS,X  ;get Y position
    STA YPOS,Y  ;move back Y
    LDA CNT,X   ;get count
    STA CNT,Y   ;move back count
    INY         ;inc index
    BNE REPACK  ;next repack
RPKEND DEC EXPCNT ;dec pointers
    DEC COUNTR  ;due to repack
    JMP RUNLP   ;continue
DOPLOT INC CNT,X ;inc pointer
    TAY         ;exp phase in Y
    LDA XPOS,X  ;get X-coord
    CLC         ;clear carry
    ADC COORD1,Y ;add X offset
    STA PLOTX   ;save it
    CMP #160    ;off screen?
    BCS RUNLP   ;Yes. don't plot
    LDA YPOS,X  ;get Y-coord
    ADC COORD2,Y ;add Y offset
    STA PLOTY   ;save it
    CMP #96     ;off screen?
    BCS RUNLP   ;Yes. don't plot
    JSR PLOT    ;get plot addr
    LDA PLOTCLR ;erase it?
    BNE CLEARIT ;Yes. clear it
    LDA PLOTBL,X ;get plot bits
    ORA (LO),Y  ;alter display
PUTIT STA (LO),Y ;and replot it!
    JMP RUNLP   ;exit
CLEARIT LDA ERABIT,X ;erase bits
    AND (LO),Y  ;turn off pixel
    JMP PUTIT   ;put it back
;
; ------------------------
; Dedicated multiply by 40
; with result in LO and HI
; ------------------------
;
PLOT LDA PLOTY  ;get Y-coord
    ASL A       ;shift it left
    STA LO      ;save low *2
    LDA #0      ;get zero
    STA HI      ;init high byte
    ASL LO      ;shift low byte
    ROL HI      ;rotate high *4
    ASL LO      ;shift low byte
    LDA LO      ;get low byte
    STA LOHLD   ;save low *8
    ROL HI      ;rotate high *8
    LDA HI      ;get high byte
    STA HIHLD   ;save high *8
    ASL LO      ;shift low byte
    ROL HI      ;rotate high *16
    ASL LO      ;shift low byte
    ROL HI      ;rotate high *32
    LDA LO      ;get low *32
    CLC         ;clear carry
    ADC LOHLD   ;add low *8
    STA LO      ;save low *40
    LDA HI      ;get high *32
    ADC HIHLD   ;add high *8
    STA HI      ;save high *40
;
; -----------------------------
; Get offset into screen memory
; -----------------------------
;
    LDA # <SCRN ;screen addr lo
    CLC         ;clear carry
    ADC LO      ;add low offset
    STA LO      ;save addr low
    LDA # >SCRN ;screen addr hi
    ADC HI      ;add high offset
    STA HI      ;save addr hi
    LDA PLOTX   ;mask PLOTX for
    AND #3      ;the plot bits,
    TAX         ;place in X..
    LDA PLOTX   ;get PLOTX and
    LSR A       ;divide
    LSR A       ;by 4
    CLC         ;and add to
    ADC LO      ;plot address
    STA LO      ;for final plot
    BCC PLOT1   ;address.
    INC HI      ;overflow? Yes.
PLOT1 LDY #0    ;zero Y register
    RTS         ;return
;
; ----------------
; Bomb initializer
; ----------------
;
BOMINI LDA BOMBWT ;bomb wait time
    BNE NOBINI  ;done? No.
    LDA BOMBS   ;more bombs?
    BNE CKLIVE  ;Yes. skip RTS
NOBINI RTS      ;No. return
CKLIVE LDX #3   ;find..
CKLVLP LDA BOMACT,X ;an available..
    BEQ GOTBOM  ;bomb? Yes.
    DEX         ;No. dec index
    BPL CKLVLP  ;done? No.
    RTS         ;return
GOTBOM LDA #1   ;this one is..
    STA BOMACT,X ;active now
    DEC BOMBS   ;one less bomb
    LDA #0      ;zero out all..
    STA BXHOLD,X ;vector X hold
    STA BYHOLD,X ;vector Y hold
    LDA GAMCTL  ;game control
    BMI NOSAUC  ;saucer possible?
;
; --------------
; Saucer handler
; --------------
;
    CPX #3      ;Yes. bomb #3?
    BNE NOSAUC  ;No. skip next
    LDA RANDOM  ;random number
    CMP SAUCHN  ;compare chances
    BCS NOSAUC  ;put saucer? No.
    LDA #1      ;Yes. get one
    STA SAUCER  ;enable saucer
    LDA RANDOM  ;random number
    AND #$03    ;range: 0..3
    TAY         ;use as index
    LDA STARTX,Y ;saucer start X
    CMP #$FF    ;random flag?
    BNE SAVESX  ;No. use as X
    JSR SAURND  ;random X-coord
    ADC #35     ;add X offset
SAVESX STA FROMX ;from X vector
    STA BOMBX,X ;init X-coord
    LDA STARTY,Y ;saucer start Y
    CMP #$FF    ;random flag?
    BNE SAVESY  ;No. use as Y
    JSR SAURND  ;random Y-coord
    ADC #55     ;add Y offset
SAVESY STA FROMY ;from Y vector
    STA BOMBY,X ;init Y-coord
    LDA ENDX,Y  ;saucer end X
    CMP #$FF    ;random flag?
    BNE SAVEEX  ;No. use as X
    LDA #230    ;screen right
    SEC         ;offset so not
    SBC FROMY   ;to hit planet
SAVEEX STA TOX  ;to X vector
    LDA ENDY,Y  ;saucer end Y
    CMP #$FF    ;random flag?
    BNE SAVEEY  ;No. use as Y
    LDA FROMX   ;use X for Y
SAVEEY STA TOY  ;to Y vector
    JMP GETBV   ;skip next
;
; ------------
; Bomb handler
; ------------
;
NOSAUC LDA RANDOM ;random number
    BMI BXMAX   ;coin flip
    LDA RANDOM  ;random number
    AND #1      ;make 0..1
    TAY         ;use as index
    LDA BMAXS,Y ;top/bottom tbl
    STA BOMBY,X ;bomb Y-coord
SETRBX LDA RANDOM ;random number
    CMP #250    ;compare w/250
    BCS SETRBX  ;less than? No.
    STA BOMBX,X ;bomb X-coord
    JMP BOMVEC  ;skip next
BXMAX LDA RANDOM ;random number
    AND #1      ;make 0..1
    TAY         ;use as index
    LDA BMAXS,Y ;0 or 250
    STA BOMBX,X ;bomb X-coord
SETRBY LDA RANDOM ;random number
    CMP #250    ;compare w/250
    BCS SETRBY  ;less than? No.
    STA BOMBY,X ;bomb Y-coord
BOMVEC LDA BOMBX,X ;bomb X-coord
    STA FROMX   ;shot from X
    LDA BOMBY,X ;bomb Y-coord
    STA FROMY   ;shot from Y
    LDA #128    ;planet center
    STA TOX     ;shot to X-coord
    STA TOY     ;shot to Y-coord
GETBV JSR VECTOR ;calc shot vect
;
; ---------------------
; Store vector in table
; ---------------------
;
    LDA LR      ;bomb L/R flag
    STA BOMBLR,X ;bomb L/R table
    LDA UD      ;bomb U/D flag
    STA BOMBUD,X ;bomb U/D table
    LDA VXINC   ;velocity X inc
    STA BXINC,X ;Vel X table
    LDA VYINC   ;velocity Y inc
    STA BYINC,X ;Vel Y table
    RTS         ;return
;
; -----------------------------
; Saucer random generator 0..99
; -----------------------------
;
SAURND LDA RANDOM ;random number
    AND #$7F    ;0..127
    CMP #100    ;compare w/100
    BCS SAURND  ;less than? No.
    RTS         ;return
;
; --------------------
; Saucer shoot routine
; --------------------
;
SSHOOT LDA RANDOM ;random number
    CMP #6      ;2.3% chance?
    BCS NOSS    ;less than? No.
    LDX #7      ;7 = index
    LDA PROACT,X ;projectile #7
    BEQ GOTSS   ;active? No.
    DEX         ;6 = index
    LDA PROACT,X ;projectile #6
    BEQ GOTSS   ;active? No.
NOSS RTS        ;return, no shot
;
; --------------------
; Enable a saucer shot
; --------------------
;
GOTSS LDA #48   ;PF center, Y
    STA TOY     ;shot to Y-coord
    LDA #80     ;PF center X
    STA TOX     ;shot to X-coord
    LDA BOMBX+3 ;saucer x-coord
    SEC         ;set carry
    SBC #44     ;PF offset
    STA FROMX   ;shot from X
    STA PROJX,X ;X-coord table
    CMP #160    ;screen X limit
    BCS NOSS    ;on screen? No.
    LDA BOMBY+3 ;saucer Y-coord
    SBC #37     ;PF offset
    LSR A       ;2 scan lines
    STA FROMY   ;shot from Y
    STA PROJY,X ;Y-coord table
    CMP #95     ;screen Y limit
    BCS NOSS    ;on screen? No.
    LDA #13     ;shot snd time
    STA ESSCNT  ;emeny snd count
    JMP PROVEC  ;continue
;
; ----------------------
; Projectile initializer
; ----------------------
;
PROINI LDX #5   ;6 projectiles
PSCAN LDA PROACT,X ;get status
    BEQ GOTPRO  ;active? No.
    DEX         ;Yes. try again
    BPL PSCAN   ;done? No.
    RTS         ;return
;
; -----------------
; Got a projectile!
; -----------------
;
GOTPRO LDA #13  ;shot snd time
    STA PSSCNT  ;player sht snd
    LDA SATX    ;satellite X
    STA FROMX   ;shot from X
    STA PROJX,X ;proj X table
    LDA SATY    ;satellite Y
    STA FROMY   ;shot from Y
    STA PROJY,X ;proj Y table
    LDA CURX    ;cursor X-coord
    SEC         ;set carry
    SBC #48     ;playfld offset
    STA TOX     ;shot to X-coord
    LDA CURY    ;cursor Y-coord
    SEC         ;set carry
    SBC #32     ;playfld offset
    LSR A       ;2 line res
    STA TOY     ;shot to Y-coord
PROVEC JSR VECTOR ;compute vect
    LDA VXINC   ;X increment
    STA PXINC,X ;X inc table
    LDA VYINC   ;Y increment
    STA PYINC,X ;Y inc table
    LDA LR      ;L/R flag
    STA PROJLR,X ;L/R flag table
    LDA UD      ;U/D flag
    STA PROJUD,X ;U/D flag table
    LDA #1      ;active
    STA PROACT,X ;proj status
RT2 RTS         ;return
;
; --------------------
; Bomb advance handler
; --------------------
;
BOMADV LDA BOMTIM ;bomb timer
    BNE RT2     ;time up? No.
    LDA LIVES   ;any lives?
    BPL REGBT   ;Yes. skip next
    LDA #1      ;speed up bombs
    BNE SETBTM  ;skip next
REGBT LDA BOMTI ;get bomb speed
SETBTM STA BOMTIM ;reset timer
    LDX #3      ;check 4 bombs
ADVBLP LDA BOMACT,X ;bomb on?
    BEQ NXTBOM  ;No. try next
    JSR ADVIT   ;advance bomb
    LDA LIVES   ;any lives left?
    BPL SHOBOM  ;Yes. skip next
    JSR ADVIT   ;No. move bombs
    JSR ADVIT   ;4 times faster
    JSR ADVIT   ;than normal
;
; --------------------------
; We've now got updated bomb
; coordinates for plotting!
; --------------------------
;
SHOBOM LDA BOMBY,X ;bomb Y-coord
    CLC         ;clear carry
    ADC #2      ;bomb center off
    STA INDX1   ;save it
    LDA #0      ;get zero
    STA LO      ;init low byte
    TXA         ;index to Acc
    ORA # >PLR0 ;mask w/address
    STA HI      ;init high byte
    STX INDX2   ;X temp hold
    CPX #3      ;saucer slot?
    BNE NOTSAU  ;No. skip next
    LDA SAUCER  ;saucer in slot?
    BNE NXTBOM  ;Yes. skip bomb
NOTSAU LDY BOMBLR,X ;L/R flag
    LDA #17     ;do 17 bytes
    STA TEMP    ;set counter
    LDX BPSTRT,Y ;start position
    LDY INDX1   ;bomb Y pos
BDRAW CPY #32   ;off screen top?
    BCC NOBDRW  ;Yes. skip next
    CPY #223    ;screen bottom?
    BCS NOBDRW  ;Yes. skip next
    LDA BOMPIC,X ;bomb picture
    STA (LO),Y  ;put in PM area
NOBDRW DEY      ;PM index
    DEX         ;picture index
    DEC TEMP    ;dec count
    BNE BDRAW   ;done? No.
    LDX INDX2   ;restore X
    LDA BOMBX,X ;bomb X-coord
    STA HPOSP0,X ;player pos
NXTBOM DEX      ;more bombs?
    BPL ADVBLP  ;yes!
    RTS         ;all done!
;
; --------------------------
; Projectile advance handler
; --------------------------
;
PROADV LDX #11  ;do 8: 11..4
PADVLP LDA BOMACT,X ;active?
    BEQ NXTPRO  ;No. skip next
    LDA BOMBX,X ;bomb X-coord
    STA PLOTX   ;plotter X
    LDA BOMBY,X ;bomb Y-coord
    STA PLOTY   ;plotter Y
    STX XHOLD   ;X-reg temporary
    JSR PLOT    ;calc plot addr
    LDA (LO),Y  ;get plot byte
    AND ERABIT,X ;erase bit
    STA (LO),Y  ;replace byte
    LDX XHOLD   ;restore X
    JSR ADVIT   ;advance proj
    LDA BOMBX,X ;bomb X-coord
    CMP #160    ;off screen?
    BCS KILPRO  ;Yes. kill it
    STA PLOTX   ;plotter X
    LDA BOMBY,X ;bomb Y-coord
    CMP #96     ;off screen?
    BCS KILPRO  ;Yes. kill it
    STA PLOTY   ;plotter Y
    JSR PLOT    ;calc plot addr
    LDA PLOTBL,X ;get plot mask
    AND (LO),Y  ;chk collision
    BEQ PROJOK  ;No. plot it
    LDX XHOLD   ;restore X
    LDA PLOTX   ;proj X-coord
    STA NEWX    ;explo X-coord
    LDA PLOTY   ;proj Y-coord
    STA NEWY    ;explo Y-coord
    JSR NEWEXP  ;set off explo
KILPRO LDA #0   ;get zero
    STA BOMACT,X ;kill proj
    JMP NXTPRO  ;skip next
PROJOK LDA PLOTBL,X ;plot mask
    LDX XHOLD   ;restore X
    AND PROMSK,X ;mask color
    ORA (LO),Y  ;add playfield
    STA (LO),Y  ;replace byte
NXTPRO DEX      ;next projectile
    CPX #3      ;proj #3 yet?
    BNE PADVLP  ;No. continue
    RTS         ;return
;
;
; File: D:PLANET3.M65
;
; ----------------------
; Check satellite status
; ----------------------
;
CHKSAT LDA DEADTM ;satellite ok?
    BEQ LIVE    ;No. skip next
CHKSX RTS       ;return
LIVE LDA LIVES  ;lives left?
    BMI CHKSX   ;No. exit
    LDA #1      ;get one
    STA SATLIV  ;set alive flag
    LDA M0PL    ;did satellite
    ORA M0PL+1  ;hit any bombs?
    BEQ CHKSX   ;No. exit
    LDA #0      ;get zero
    STA SATLIV  ;kill satellite
    STA SCNT    ;init orbit
    LDX LIVES   ;one less life
    STA SCOLIN+14,X ;erase life
    DEC LIVES   ;dec lives count
    BPL MORSAT  ;any left? Yes.
    LDA #255    ;lot of bombs
    STA BOMBS   ;into bomb count
    STA GAMCTL  ;end game
    JSR SNDOFF  ;no sound 1 2 3
MORSAT LDA SATX ;sat X-coord
    STA NEWX    ;explo X-coord
    LDA SATY    ;sat Y-coord
    STA NEWY    ;explo Y-coord
    JSR NEWEXP  ;set off explo
    LDA #80     ;init sat X
    STA SATX    ;sat X-coord
    LDA #21     ;init sat Y
    STA SATY    ;sat Y-coord
    LDX #0      ;don't show the
CLRSAT LDA MISL,X ;satellite pic
    AND #$F0    ;mask off sat
    STA MISL,X  ;restore data
    DEX         ;dec index
    BNE CLRSAT  ;done? No.
    LDA #$FF    ;4.25 seconds
    STA DEADTM  ;till next life!
    RTS         ;return
;
; ------------------
; Check console keys
; ------------------
;
ENDGAM JSR SNDOFF ;no sound 123
ENDGLP LDA STRIG0 ;stick trigger
    AND PTRIG0  ;mask w/paddle 0
    AND PTRIG1  ;mask w/paddle 1
    BEQ ENDGL1  ;any pushed? No.
    LDA CONSOL  ;chk console
    CMP #7      ;any pushed?
    BEQ ENDGLP  ;No. loop here
ENDGL1 JMP PLANET ;restart game
;
; -------------------------
; Turn off sound regs 1 2 3
; -------------------------
;
SNDOFF LDA #0   ;zero volume
    STA AUDC1   ;to sound #1
    STA AUDC1+2 ;sound #2
    STA AUDC1+4 ;sound #3
    RTS         ;return
;
; -----------------------
; Check for hits on bombs
; -----------------------
;
CHKHIT LDX #3   ;4 bombs 0..3
    LDA SAUCER  ;saucer enabled?
    BEQ CHLOOP  ;No. skip next
    LDA #0      ;get zero
    STA BOMCOL  ;collision count
    LDA GAMCTL  ;game over?
    BMI NOSCOR  ;Yes. skip next
    LDA BOMBX+3 ;saucer X-coord
    CMP #39     ;off screen lf?
    BCC NOSCOR  ;Yes. kill it
    CMP #211    ;off screen rt?
    BCS NOSCOR  ;Yes. kill it
    LDA BOMBY+3 ;saucer Y-coord
    CMP #19     ;off screen up?
    BCC NOSCOR  ;Yes. kill it
    CMP #231    ;off screen dn?
    BCS NOSCOR  ;Yes. kill it
CHLOOP LDA #0   ;get zero
    STA BOMCOL  ;collision count
    LDA P0PF,X  ;playf collision
    AND #$05    ;w/shot+planet
    BEQ NOBHIT  ;hit either? No.
    INC BOMCOL  ;Yes. inc count
    AND #$04    ;hit shot?
    BEQ NOSCOR  ;No. skip next
    LDA GAMCTL  ;game over?
    BMI NOSCOR  ;Yes. skip next
    LDA #2      ;1/30th second
    STA BOMBWT  ;bomb wait time
    CPX #3      ;saucer player?
    BNE ADDBS   ;No. skip this
    LDA SAUCER  ;saucer on?
    BEQ ADDBS   ;No. this this
    LDA SAUVAL  ;saucer value
    STA SCOADD+1 ;point value
    JMP ADDIT   ;add to score
;
; -----------------------
; Add bomb value to score
; -----------------------
;
ADDBS LDA BOMVL ;bomb value low
    STA SCOADD+2 ;score inc low
    LDA BOMVH   ;bomb value high
    STA SCOADD+1 ;score inc high
ADDIT STX XHOLD ;save X register
    JSR ADDSCO  ;add to score
    LDX XHOLD   ;restore X
NOSCOR LDA #0   ;get zero
    STA BOMACT,X ;kill bomb
    LDY BOMBLR,X ;L/R flag
    LDA BOMBX,X ;bomb X-coord
    SEC         ;set carry
    SBC BXOF,Y  ;bomb X offset
    STA NEWX    ;plotter X-coord
    LDA BOMBY,X ;bomb Y-coord
    SEC         ;set carry
    SBC #40     ;bomb Y offset
    LSR A       ;2 line res.
    STA NEWY    ;plotter Y-coord
    LDA SAUCER  ;saucer?
    BEQ EXPBOM  ;No. explode it
    CPX #3      ;bomb player?
    BNE EXPBOM  ;Yes. explode it
    LDA #0      ;get zero
    STA SAUCER  ;kill saucer
    JSR CLRPLR  ;clear player
    LDA GAMCTL  ;game over?
    BMI NOBHIT  ;Yes. skip next
EXPBOM JSR CLRPLR ;clear player
    LDA BOMCOL  ;collisions?
    BEQ NOBHIT  ;No. skip this
    JSR NEWEXP  ;init explosion
NOBHIT DEX      ;dec index
    BPL CHLOOP  ;done? No.
    STA HITCLR  ;reset collision
    RTS         ;return
;
; -------------------------
; Advance bombs/projectiles
; -------------------------
;
ADVIT LDA BXHOLD,X ;bomb X-sum
    CLC         ;clear carry
    ADC BXINC,X ;add X-increment
    STA BXHOLD,X ;replace X-sum
    LDA #0      ;get zero
    ROL A       ;carry = 1
    STA DELTAX  ;X-delta
    LDA BYHOLD,X ;bomb Y-sum
    ADC BYINC,X ;add Y-increment
    STA BYHOLD,X ;replace Y-sum
    LDA #0      ;get zero
    ROL A       ;carry = 1
    STA DELTAY  ;Y-delta
    LDA BOMBLR,X ;bomb L/R flag
    BEQ ADVLFT  ;go left? Yes.
    LDA BOMBX,X ;bomb X-coord
    ADC DELTAX  ;add X-delta
    JMP ADVY    ;skip next
ADVLFT LDA BOMBX,X ;bomb X-coord
    SEC         ;set carry
    SBC DELTAX  ;sub X-delta
ADVY STA BOMBX,X ;save X-coord
    LDA BOMBUD,X ;bomb U/D flag
    BEQ ADVDN   ;go down? Yes.
    LDA BOMBY,X ;bomb Y-coord
    SEC         ;set carry
    SBC DELTAY  ;sub Y-delta
    JMP ADVEND  ;skip next
ADVDN LDA BOMBY,X ;bomb Y-coord
    CLC         ;clear carry
    ADC DELTAY  ;add Y-delta
ADVEND STA BOMBY,X ;save Y-coord
    RTS         ;return
;
; --------------------------
; Clear out player indicated
; by the X register!
; --------------------------
;
CLRPLR LDA #0   ;move player...
    STA HPOSP0,X ;off screen,
    TAY         ;init index
    TXA         ;get X
    ORA # >PLR0 ;mask w/address
    STA HI      ;plr addr high
    TYA         ;Acc = 0
    STA LO      ;plr addr low
CLPLP STA (LO),Y ;zero player
    DEY         ;dec index
    BNE CLPLP   ;done? No.
    RTS         ;return
;
; -----------------------
; Calculate target vector
; -----------------------
;
VECTOR LDA #0   ;get zero
    STA LR      ;going left
    LDA FROMX   ;from X-coord
    CMP TOX     ;w/to X-coord
    BCC RIGHT   ;to right? Yes.
    SBC TOX     ;get X-diff
    JMP VECY    ;skip next
RIGHT INC LR    ;going right
    LDA TOX     ;to X-coord
    SEC         ;set carry
    SBC FROMX   ;get X-diff
VECY STA VXINC  ;save difference
    LDA #1      ;get one
    STA UD      ;going up flag
    LDA FROMY   ;from Y-coord
    CMP TOY     ;w/to Y-coord
    BCC DOWN    ;down? Yes.
    SBC TOY     ;get Y-diff
    JMP VECSET  ;skip next
DOWN DEC UD     ;going down flag
    LDA TOY     ;to Y-coord
    SEC         ;set carry
    SBC FROMY   ;get Y-diff
VECSET STA VYINC ;are both
    ORA VXINC   ;distances 0?
    BNE VECLP   ;No. skip next
    LDA #$80    ;set x increment
    STA VXINC   ;to default.
VECLP LDA VXINC ;X vector incre
    BMI VECEND  ;>127? Yes.
    LDA VYINC   ;Y vector incre
    BMI VECEND  ;>127? Yes.
    ASL VXINC   ;times 2 until
    ASL VYINC   ;one is >127
    JMP VECLP   ;continue
VECEND RTS      ;return
;
; ------------
; Add to score
; ------------
;
ADDSCO LDY #0   ;init index
    SED         ;decimal mode
    CLC         ;clear carry
    LDX #2      ;do 3 bytes
ASCLP LDA SCORE,X ;get score
    ADC SCOADD,X ;add bomb value
    STA SCORE,X ;save score
    STY SCOADD,X ;zero value
    DEX         ;next byte
    BPL ASCLP   ;done? No.
    CLD         ;clear decimal
;
; ----------
; Show score
; ----------
;
SHOSCO LDA #$10 ;put color 0
    STA SHCOLR  ;in hold area
    LDX #1      ;2nd line char
    LDY #0      ;digits 1,2
SSCOLP LDA SCORE,Y ;get digits
    JSR SHOBCD  ;show 'em
    INX         ;advance score
    INX         ;line pointer
    INY         ;next 2 digits
    CPY #3      ;done 6?
    BNE SSCOLP  ;no!
    RTS         ;all done!
;
; -----------------
; Show level number
; -----------------
;
SHOLVL LDY #$50 ;use color 2
    STY SHCOLR  ;save it
    LDA LEVEL   ;get level #
    LDX #11     ;12th char on line
;
; -----------------
; Show 2 BCD digits
; -----------------
;
SHOBCD STA SHOBYT ;save digits
    AND #$0F    ;get lower digit
    ORA SHCOLR  ;add color
    STA SCOLIN+1,X ;show it
    LDA SHOBYT  ;get both again
    LSR A       ;mask...
    LSR A       ;off...
    LSR A       ;upper...
    LSR A       ;digit
    ORA SHCOLR  ;add color
    STA SCOLIN,X ;show it!
    RTS         ;and exit.
;
; -------------------
; KOALA PAD interface
; -------------------
;
; The following filtering
; algorithm is used:
;
; Given 5 points S1,S2,S3,S4,S5
;
; R1=S1+S2+S2+S3
; R2=S2+S3+S3+S4
; R3=S3+S4+S4+S5
;
; AVG=(R1+R2+R2+R3)/16
;
; This reduces to:
;
; AVG=(S1+S2*4+S3*6+S4*4+S5)/16
;
; ---------------------------
; Rotate points through queue
; ---------------------------
;
KOALA LDX #4    ;do 5 bytes
ROT LDA XQ-1,X  ;move X queue
    STA XQ,X    ;up one byte
    LDA YQ-1,X  ;move Y queue
    STA YQ,X    ;up one byte
    DEX         ;dec count
    BNE ROT     ;done? No.
;
; --------------------
; Clear out the cursor
; --------------------
;
    LDY CURY    ;get Y coord
    LDX #5      ;do 6 bytes
CCURS LDA MISL,Y ;get missiles
    AND #$F0    ;mask off low
    STA MISL,Y  ;put back
    DEX         ;dec count
    BPL CCURS   ;done? No.
;
; ---------------------------
; Insert new point into queue
; ---------------------------
;
    LDA #1      ;pen up flag
    STA PENFLG  ;set pen up
    LDA PADDL0  ;X input
    STA XQ      ;put in queue
    CMP #5      ;screen boundary
    BCC KOALAX  ;on screen? No.
    LDA PADDL1  ;Y input
    STA YQ      ;put in queue
    CMP #5      ;screen boundary
    BCC KOALAX  ;on screen? No.
;
; ---------------------
; Filter the X-Y queues
; ---------------------
;
    LDA # <XQ   ;queue addr low
    STA PTR     ;pointer low
    LDA # >XQ   ;queue addr high
    STA PTR+1   ;pointer high
    JSR FILTER  ;filter X data
    BCS KOALAX  ;good data? No.
    ADC #16     ;X offset
    CMP #48     ;far left?
    BCS FLF     ;No. skip
    LDA #48     ;screen left
FLF CMP #208    ;far right?
    BCC FRT     ;No. skip
    LDA #207    ;screen right
FRT STA CURX    ;put X coord
    LDA # <YQ   ;queue addr low
    STA PTR     ;pointer low
    LDA # >YQ   ;queue addr high
    STA PTR+1   ;pointer high
    JSR FILTER  ;filter Y data
    BCS KOALAX  ;good data? No.
    ADC #16     ;Y offset
    CMP #32     ;above top?
    BCS FUP     ;No. skip
    LDA #32     ;screen top
FUP CMP #224    ;below bottom?
    BCC FDN     ;No. skip
    LDA #223    ;screen bottom
FDN STA CURY    ;put Y coord
;
; ----------------------
; Paddle trigger handler
; ----------------------
;
    LDA PTRIG0  ;paddle trig 0
    EOR PTRIG1  ;EOR w/PTRIG1
    EOR #1      ;inverse data
    STA STRIG0  ;put in STRIG0
    LDA #0      ;pen down flag
    STA PENFLG  ;set pen down
KOALAX RTS      ;continue
;
; ----------------------------
; Filter algorithm, initialize
; ----------------------------
;
FILTER LDA #0   ;get zero
    LDX #4      ;do 5 bytes
FILC STA SH,X   ;high byte table
    DEX         ;dec count
    BPL FILC    ;done? No.
    STA AVG     ;average low
    STA AVG+1   ;average high
    TAY         ;xero in Y
    LDX #1      ;one in X
;
; -----------------------
; Process the X-Y samples
; -----------------------
;
    LDA (PTR),Y ;get S1
    STA SL,Y    ;save low byte
    INY         ;inc pointer
    JSR MUL4    ;process S2
    LDA (PTR),Y ;get S3
    ASL A       ;times 2
    ROL SH,X    ;rotate carry
    ADC (PTR),Y ;add = times 3
    BCC FIL2    ;overflow? No.
    INC SH,X    ;inc high byte
FIL2 ASL A      ;times 6
    ROL SH,X    ;rotate carry
    STA SL,X    ;save low byte
    INX         ;inc pointer
    INY         ;inc pointer
    JSR MUL4    ;process S4
    LDA (PTR),Y ;get S5
    STA SL,Y    ;save low byte
;
; -------------
; Total samples
; -------------
;
    LDX #4      ;add 5 elements
ALOOP LDA SL,X  ;get low byte
    ADC AVG     ;add to average
    STA AVG     ;save low byte
    LDA SH,X    ;get high byte
    ADC AVG+1   ;add to average
    STA AVG+1   ;save high byte
    DEX         ;dec pointer
    BPL ALOOP   ;done? No.
;
; ------------------
; Divide total by 16
; ------------------
;
    LDX #4      ;shift 4 bits
    LDA AVG     ;get lo byte
DIV16 LSR AVG+1 ;rotate high
    ROR A       ;rotate low
    DEX         ;dec count
    BNE DIV16   ;done? No.
    TAX         ;save Acc
;
; --------------------------
; Compare average with DELTA
; --------------------------
;
    LDY #4      ;5 byte table
MEAN SEC        ;set carry
    SBC (PTR),Y ;compare points
    BCS POSI    ;negative? No.
    EOR #$FF    ;negate byte and
    ADC #1      ;+1 = ABS value
POSI CMP #24    ;within DELTA?
    BCS FAIL    ;No. abort
    TXA         ;get Acc again
    DEY         ;dec pointer
    BPL MEAN    ;done? No.
FAIL RTS        ;exit
;
; ----------------
; Multply Acc by 4
; ----------------
;
MUL4 LDA (PTR),Y ;get S2
    ASL A       ;times 2
    ROL SH,X    ;rotate carry
    ASL A       ;times 4
    ROL SH,X    ;rotate carry
    STA SL,X    ;save low byte
    INX         ;inc pointer
    INY         ;inc pointer
    RTS         ;return
;
; ----------
; Data areas
; ----------
;
BMAXS .BYTE 0,250 ;bomb limits
BOMPIC .BYTE 0,0,0,0,0,0,$DC,$3E
    .BYTE $7E,$3E,$DC,0,0,0,0
    .BYTE 0,0,$76,$F8,$FC
    .BYTE $F8,$76,0,0,0,0,0,0
BPSTRT .BYTE 27,16
BXOF .BYTE 47,42
CURPIC .BYTE $40,$40,$A0,$A0
    .BYTE $40,$40
P3COLR .BYTE $34,$F8
SAUPIC .BYTE 0,0,$18,$7E,0,0
    .BYTE $7E,$18,0,0
SAUMID .BYTE $92,$49,$24,$92
STARTX .BYTE 40,$FF,210,$FF
STARTY .BYTE $FF,20,$FF,230
ENDX .BYTE $FF,210,$FF,40
ENDY .BYTE 20,$FF,230,$FF
;
; ---------------------
; Explosion data tables
; ---------------------
;
PLOTBL .BYTE $C0,$30,$0C,$03
ERABIT .BYTE $3F,$CF,$F3,$FC
PROMSK .BYTE 0,0,0,0
    .BYTE $FF,$FF,$FF,$FF
    .BYTE $FF,$FF,$AA,$AA
COORD1 .BYTE 0,1,255,0,255,1
    .BYTE 0,2,255,254,0,1
    .BYTE 0,254,2,1,1,255
    .BYTE 0,2,254,255,3,0
    .BYTE 253,254,3,2,255,254
    .BYTE 1,255,3,253,1,253,2
COORD2 .BYTE 0,0,1,255,0,1
    .BYTE 1,0,255,1,2,255
    .BYTE 254,255,1,2,254,2
    .BYTE 3,255,0,254,1,253
    .BYTE 0,254,255,2,3,2
    .BYTE 253,253,0,1,3,255,254
;
; ------------------
; Initial score line
; ------------------
;
SCOINI .BYTE $00,$00,$00,$00
    .BYTE $00,$00,$00,$00
    .BYTE $6C,$76,$6C,$00
    .BYTE $00,$00,$CA,$CA
    .BYTE $CA,$CA,$CA,$00
;
; ------------
; Level tables
; ------------
;
INIBOM .BYTE 10,15,20,25,20,25
    .BYTE 15,20,25,20,25,30
INIBS .BYTE 12,11,10,9,8,7
    .BYTE 7,6,5,5,4,3
INISC .BYTE 0,10,50,90,50,80
    .BYTE 40,60,100,80,120,125
INIPC .BYTE $20,$30,$40,$50,$60
    .BYTE $70,$80,$A0,$B0,$C0
    .BYTE $D0,$FF
INIBVH .BYTE 0,0,0,0,0,0
    .BYTE 0,0,0,$01,$01,$01
INIBVL .BYTE $10,$20,$30,$40,$50
    .BYTE $60,$70,$80,$90,$00
    .BYTE $10,$20
INISV .BYTE 0,1,1,1,2,2
    .BYTE 3,3,3,4,4,4
;
; ----------
; Sound data
; ----------
;
PLSHOT .BYTE 244,254,210,220
    .BYTE 176,186,142,152,108
    .BYTE 118,74,84,40,50
ENSHOT .BYTE 101,96,85,80,69,64
    .BYTE 53,48,37,32,21,16,5,0
SAUSND .BYTE 10,11,12,14,16,17
    .BYTE 18,17,16,14,12,11
;
; -----------------
; Program variables
; -----------------
;
XPOS *= *+20    ;all expl. x's
YPOS *= *+20    ;all expl. y's
CNT *=  *+20    ;all expl. counts
BOMACT *= *+4   ;bomb active flags
PROACT *= *+8   ;proj. active flags
BOMBX *= *+4    ;bomb x positions
PROJX *= *+8    ;proj. x positions
BOMBY *= *+4    ;bomb y positions
PROJY *= *+8    ;proj. y positions
BXINC *= *+4    ;bomb x vectors
PXINC *= *+8    ;proj. x vectors
BYINC *= *+4    ;bomb y vectors
PYINC *= *+8    ;proj. y vectors
BXHOLD *= *+12  ;b/p hold areas
BYHOLD *= *+12  ;b/p hold areas
BOMBLR *= *+4   ;bomb left/right
PROJLR *= *+8   ;proj. left/right
BOMBUD *= *+4   ;bomb up/down
PROJUD *= *+8   ;proj. up/down
SCOLIN *= *+20  ;score line
;
; --------------
; End of program
; --------------
;
    .END
