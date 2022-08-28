 ;.OPT NOEJECT
;MAPSCROLL   VERSION 1.9
;
;This program sets up a map using a special character set.
;It displays this map in graphics mode 2.
;Using the joystick, the user can smoothly scroll over the map.
;This program must be orged on a page boundary.
;The page number is stored on page 6 by the program;
;the programmer must modify lines 490,1730,3490, and 4640
;whenever the program is re-orged.
;
;Page zero RAM
;
 ;*=$CB
        ORG $CB
DLSTPT  .word 0 ;*=*+2 ;Zero page pointer to display list
MAPLO   .byte 0 ;*=*+1 ;Used only during initialization
MAPHI   .byte 0 ;*=*+1 ;Used only during initialization
;
VVBLKD=$0224 ;Deferred vertical blank interrupt vector
DLSTLO=$0230 ;Existing OS pointer to display list
DLSTHI=$0231
TXTMSC=$0294
COLOR0=$02C4
COLOR1=$02C5
COLOR2=$02C6
COLOR3=$02C7
COLOR4=$02C8
CHBAS=$02F4
STICK=$0278 ;OS value of joystick port 0
RANDOM=$D20A ;Hardware random number generator
HSCROLL=$D404 ;ANTIC horizontal scroll register
VSCROLL=$D405 ;ANTIC vertical scroll register
NMIEN=$D40E
CHBASE=$D409 ;ANTIC version of CHBAS
SETVBV=$E45C
XITVBV=$E462
;
;Page 6 usage
;
 ;*=$0600
    ORG $0600
;
BASE    .byte 0 ; *=*+1 ;Saves starting page # of module
OFFLO   .byte 0 ;*=*+1 ;How far to offset new LMS value
OFFHI   .byte 0 ; *=*+1
XPOSL   .byte 0 ; *=*+1 ;Horizontal position of
XPOSH   .byte 0 ; *=*+1 ;upper left corner of screen window
YPOSL   .byte 0 ; *=*+1 ;Vertical position of
YPOSH   .byte 0 ; *=*+1 ;upper left corner of screen window
 ;*=$6000 ;Change this to relocate
    org $6000
;First comes 512 bytes of new character set
;Make sure it's exactly 512 bytes long!
;Put in zeros if necessary.
;
;Each line has one character (8 bytes)
;
 .BYTE $00,$20,$70,$F8,$00,$08,$1C,$3E
 .BYTE $00,$08,$1C,$3E,$00,$20,$70,$F8
 .BYTE $00,$03,$04,$08,$10,$38,$7C,$FE
 .BYTE $00,$00,$08,$1C,$3E,$7F,$00,$00
 .BYTE $00,$00,$08,$1C,$3E,$00,$00,$00
 .BYTE $00,$00,$00,$00,$00,$00,$00,$00
 .BYTE $00,$00,$00,$00,$00,$00,$00,$00
 .BYTE $00,$00,$00,$00,$00,$00,$00,$00
 .BYTE $00,$00,$00,$00,$00,$00,$00,$00
 .BYTE $00,$00,$00,$00,$00,$00,$00,$00
 .BYTE $00,$00,$00,$00,$00,$00,$00,$00
 .BYTE $00,$00,$00,$00,$00,$00,$00,$00
 .BYTE $00,$00,$00,$00,$00,$00,$00,$00
 .BYTE $00,$00,$00,$00,$00,$00,$00,$00
 .BYTE $00,$00,$00,$00,$00,$00,$00,$00
 .BYTE $00,$00,$00,$00,$00,$00,$00,$00
 .BYTE $10,$01,$98,$42,$09,$95,$40,$08
 .BYTE $24,$A0,$05,$08,$60,$13,$84,$28
 .BYTE $08,$14,$28,$81,$55,$80,$12,$20
 .BYTE $08,$20,$94,$09,$32,$88,$22,$08
 .BYTE $24,$18,$43,$10,$AC,$81,$10,$0C
 .BYTE $24,$28,$40,$96,$41,$B8,$02,$20
 .BYTE $08,$A0,$19,$A2,$10,$42,$04,$30
 .BYTE $00,$00,$00,$00,$00,$00,$00,$00
 .BYTE $00,$00,$00,$00,$00,$00,$00,$00
 .BYTE $00,$00,$00,$00,$00,$00,$00,$00
 .BYTE $00,$00,$00,$00,$00,$00,$00,$00
 .BYTE $00,$00,$00,$00,$00,$00,$00,$00
 .BYTE $00,$00,$00,$00,$00,$00,$00,$00
 .BYTE $00,$00,$00,$00,$00,$00,$00,$00
 .BYTE $00,$00,$00,$00,$00,$00,$00,$00
 .BYTE $00,$00,$00,$00,$00,$00,$00,$00
 .BYTE $00,$18,$3C,$7E,$7E,$3E,$18,$00
 .BYTE $00,$02,$67,$7F,$7F,$3E,$3C,$18
 .BYTE $00,$30,$38,$3C,$1E,$0E,$0C,$00
 .BYTE $00,$00,$00,$00,$00,$00,$00,$00
 .BYTE $00,$00,$00,$00,$00,$00,$00,$00
 .BYTE $00,$00,$00,$00,$00,$00,$00,$00
 .BYTE $00,$00,$00,$00,$00,$00,$00,$00
 .BYTE $00,$00,$00,$00,$00,$00,$00,$00
 .BYTE $00,$00,$00,$00,$00,$00,$00,$00
 .BYTE $00,$00,$00,$00,$00,$00,$00,$00
 .BYTE $00,$00,$00,$00,$00,$00,$00,$00
 .BYTE $00,$00,$00,$00,$00,$00,$00,$00
 .BYTE $00,$00,$00,$00,$00,$00,$00,$00
 .BYTE $00,$00,$00,$00,$00,$00,$00,$00
 .BYTE $00,$00,$00,$00,$00,$00,$00,$00
 .BYTE $00,$00,$00,$00,$00,$00,$00,$00
 .BYTE $5A,$00,$5B,$5B,$00,$DA,$40,$02
 .BYTE $44,$16,$00,$B4,$B2,$00,$36,$10
 .BYTE $69,$00,$4D,$2D,$00,$68,$2D,$00
 .BYTE $50,$00,$D3,$5B,$00,$D9,$1B,$00
 .BYTE $00,$00,$00,$00,$00,$00,$00,$00
 .BYTE $00,$00,$00,$00,$00,$00,$00,$00
 .BYTE $00,$00,$00,$00,$00,$00,$00,$00
 .BYTE $00,$00,$00,$00,$00,$00,$00,$00
 .BYTE $00,$00,$00,$00,$00,$00,$00,$00
 .BYTE $00,$00,$00,$00,$00,$00,$00,$00
 .BYTE $00,$00,$00,$00,$00,$00,$00,$00
 .BYTE $00,$00,$00,$00,$00,$00,$00,$00
 .BYTE $00,$00,$00,$00,$00,$00,$00,$00
 .BYTE $00,$00,$00,$00,$00,$00,$00,$00
 .BYTE $00,$00,$00,$00,$00,$00,$00,$00
 .BYTE $00,$00,$00,$00,$00,$00,$00,$00
;The display list goes here; it is 43 bytes long.
;For simplicity I reserve 64 bytes for you.
    ;ORG *+64
DLIST  .DS 64

;
;This next area is reserved for the text window
;I reserved 192 bytes but only 160 bytes are used
    ;org *+192
RSVD    .DS 192
;
;The map data goes here.
;I reserve 8 pages (2K) for the map data.
;To change the size of the map you must change this allocation
;
    ;ORG *+$800
    ;.DS $800
MAP     .DS $800
;Next I reserve 1 page for terrain frequencies.
;The desired frequency of each terrain type is encoded here.
;This data is only useful for randomly generated maps
;
 .BYTE $30,$30,$02,$30,$30,$00,$00,$00
 .BYTE $00,$00,$00,$00,$00,$00,$00,$00
 .BYTE $00,$00,$00,$00,$00,$00,$00,$00
 .BYTE $00,$00,$00,$00,$00,$00,$00,$00
 .BYTE $00,$00,$00,$00,$00,$00,$00,$00
 .BYTE $00,$00,$00,$00,$00,$00,$00,$00
 .BYTE $00,$00,$00,$00,$00,$00,$00,$00
 .BYTE $00,$00,$00,$00,$00,$00,$00,$00
 .BYTE $00,$00,$00,$00,$00,$00,$00,$00
 .BYTE $00,$00,$00,$00,$00,$00,$00,$00
 .BYTE $40,$40,$40,$40,$40,$40,$40,$00
 .BYTE $00,$00,$00,$00,$00,$00,$00,$00
 .BYTE $00,$00,$00,$00,$00,$00,$00,$00
 .BYTE $00,$00,$00,$00,$00,$00,$00,$00
 .BYTE $00,$00,$00,$00,$00,$00,$00,$00
 .BYTE $00,$00,$00,$00,$00,$00,$00,$00
 .BYTE $00,$00,$00,$00,$00,$00,$00,$00
 .BYTE $00,$00,$00,$00,$00,$00,$00,$00
 .BYTE $00,$00,$00,$00,$00,$00,$00,$00
 .BYTE $00,$00,$00,$00,$00,$00,$00,$00
 .BYTE $08,$08,$08,$00,$00,$00,$00,$00
 .BYTE $00,$00,$00,$00,$00,$00,$00,$00
 .BYTE $00,$00,$00,$00,$00,$00,$00,$00
 .BYTE $00,$00,$00,$00,$00,$00,$00,$00
 .BYTE $00,$00,$00,$00,$00,$00,$00,$00
 .BYTE $00,$00,$00,$00,$00,$00,$00,$00
 .BYTE $00,$00,$00,$00,$00,$00,$00,$00
 .BYTE $00,$00,$00,$00,$00,$00,$00,$00
 .BYTE $00,$00,$00,$00,$00,$00,$00,$00
 .BYTE $00,$00,$00,$00,$00,$00,$00,$00
 .BYTE $04,$04,$04,$04,$00,$00,$00,$00
 .BYTE $00,$00,$00,$00,$00,$00,$FF,$FF
;
;This is the beginning of the initialization program
;JSR here to run this module
;

START
 LDA #$60 ;Change this operand to relocate program
 STA BASE ;Save for future reference
;
;Now set up new display list
;
 CLC
 ADC #$02
 STA DLSTPT+1
 LDA #$00
 STA DLSTPT
;
 LDY #$00
 LDA #$70 ;'Skip 8 lines' opcode
 STA (DLSTPT),Y
 INY
 STA (DLSTPT),Y
 INY
 STA (DLSTPT),Y ;Start by skipping 24 lines
 INY
 LDX #$0A ;set up ten display list instructions
 LDA #$00
 STA OFFLO ;map data stored starting at BASE+$300
 LDA #$03
 STA OFFHI
MAKEDL LDA #$77 ;Mode 2 line with
 STA (DLSTPT),Y ;HSCROLL, VSCROLL, and LMS bits set
 INY
 LDA OFFLO
 STA (DLSTPT),Y ;New LMS low byte
 INY
 LDA BASE
 CLC
 ADC OFFHI
 STA (DLSTPT),Y ;New LMS high byte
 INY
 LDA OFFLO
 CLC
 ADC #$40 ;This operand sets total width of map
 STA OFFLO
 BCC Y1
 INC OFFHI
Y1 DEX
 BNE MAKEDL
;
 DEY ;back up three bytes for correction
 DEY
 DEY
 LDA #$57 ;no vertical scrolling for this mode byte
 STA (DLSTPT),Y
 INY
 INY
 INY
 LDA #$80 ;This generates a display list interrupt
 STA (DLSTPT),Y
 INY
 LDA #$42
 STA (DLSTPT),Y
 INY
 LDA #$40
 STA (DLSTPT),Y
 INY
 LDA BASE
 CLC
 ADC #$02
 STA (DLSTPT),Y
 INY
 LDA #$02
 STA (DLSTPT),Y
 INY
 STA (DLSTPT),Y
 INY
 STA (DLSTPT),Y
 INY
 LDA #$41
 STA (DLSTPT),Y
 INY
 LDA #$00
 STA (DLSTPT),Y
 INY
 LDA BASE
 CLC
 ADC #$02
 STA (DLSTPT),Y
;
;Display list is in now.
;Now turn ANTIC onto it.
;
 LDA #$00
 STA DLSTLO
 LDA DLSTPT+1
 STA DLSTHI
;
 LDA BASE
 STA CHBAS ;This turns on new character set
;
 LDA #$11 ;Set up colors
 STA COLOR4
 LDA #$0C
 STA COLOR3
 LDA #$C8
 STA COLOR1
;
 LDA #$00 ;Set up pointers to map data
 STA MAPLO
 LDA BASE
 CLC
 ADC #$03
 STA MAPHI
 ADC #$08
 STA DLSTPT+1 ;Use DLSTPT as a new pointer
;
;This section randomly generates a map.
;It is unnecessary if you use a fixed map.
;
 LDX #$08
LOOP LDY RANDOM
 LDA (DLSTPT),Y
 BEQ LOOP
 CMP RANDOM
 BCC LOOP
 TYA
 LDY #$00
 STA (MAPLO),Y
 INC MAPLO
 BNE LOOP
 INC MAPHI
 DEX
 BNE LOOP
;
;Initialize position of map
;
 LDA #$B0
 STA XPOSL
 LDA #$01
 STA XPOSH
 LDA #$00
 STA YPOSL
 STA YPOSH
;
 LDA DLSTLO ;Restore display list pointer
 STA DLSTPT
 LDA DLSTHI
 STA DLSTPT+1
;
;Now turn BASIC onto text window
;
 LDA #$40
 STA TXTMSC
 LDA BASE
 CLC
 ADC #$02
 STA TXTMSC+1
;
;Now enable deferred vertical blank interrupt
;
 LDY #$00
 LDA BASE
 CLC
 ADC #$0E
 TAX ;Set up for interrupt enabling routine
 LDA #$07
 JSR SETVBV
 LDA #$00 ;This is DLI vector (low byte)
 STA $0200
 LDA BASE
 CLC
 ADC #$0F ;This is DLI vector (high byte)
 STA $0201
 LDA #$C0
 STA NMIEN ;Turn interrupts on

SPIN   JMP SPIN
 RTS ;Finished
;
;From here to $6E00 is expansion area
;This is the vertical blank interrupt routine
;It reads the joystick and scrolls the screen
;
 ;*=$6E00
    ORG $6E00
 LDA #$00
 STA OFFLO
 STA OFFHI ;zero the offset
 LDA STICK ;get joystick reading
 PHA ;save it on stack for other bit checks
 AND #$04 ;joystick left?
 BNE CHKRT ;no, move on
 LDA XPOSL ;yes, check for left edge
 BNE X1
 LDX XPOSH
 BEQ CHKUP ;at left edge, move on
X1 SEC ;decrement x-coordinate
 SBC #$01
 BCS X2
 DEC XPOSH
X2 STA XPOSL
 AND #$07
 STA HSCROLL ;fine scroll
 CMP #$07 ;scroll overflow?
 BNE CHKUP ;no, move on
 INC OFFLO ;yes, mark it for offset
 CLV
 BVC CHKUP ;no point in checking for joystick right
CHKRT PLA ;get back joystick byte
 PHA ;save it again
 AND #$08 ;joystick right?
 BNE CHKUP ;no, move on
 LDA XPOSL
 CMP #$B0
 BNE X3
 LDX XPOSH ;right edge of map?
 BNE CHKUP ;yes, move on
X3 CLC ;no, increment x-coordinate
 ADC #$01
 STA XPOSL
 BCC X4
 INC XPOSH
X4 AND #$07
 STA HSCROLL ;fine scroll
 BNE CHKUP ;scroll overflow? if not, move on
 DEC OFFLO ;yes, set up offset for character scroll
 DEC OFFHI
CHKUP PLA ;joystick up?
 LSR
 PHA
 BCS CHKDN ;no, ramble on
 LDA YPOSL ;yes
 CMP #$60
 BNE X6
 LDX YPOSH ;top edge of map?
 BNE CHKDN ;yes, shuffle on
X6 CLC ;no, increment y-coordinate
 ADC #$01
 BCC X7
 INC YPOSH
X7 STA YPOSL
 AND #$0F
 STA VSCROLL ;fine scroll
 BNE CHKDN ;scroll overflow? If not, amble on
 LDA OFFLO ;yes, set up offset for character scroll
 CLC
 ADC #$40
 STA OFFLO
 LDA OFFHI
 ADC #$00
 STA OFFHI
CHKDN PLA ;joystick down?
 LSR
 BCS CHGDL ;no, trudge on
 LDA YPOSL
 BNE X8
 LDX YPOSH ;bottom of map?
 BEQ CHGDL ;yes, drift on
X8 SEC ;no, decrement y-coordinate
 SBC #$01
 STA YPOSL
 BCS X9
 DEC YPOSH
X9 AND #$0F
 STA VSCROLL ;fine scroll
 CMP #$0F ;scroll overflow?
 BNE CHGDL ;no, move on
 LDA OFFLO ;yes, mark offset
 SEC
 SBC #$40
 STA OFFLO
 LDA OFFHI
 SBC #$00
 STA OFFHI
;
;In this loop we add the offset values to the existing
;LMS addresses of all display lines.
;This scrolls the characters.
;
CHGDL LDY #$04
DLOOP LDA (DLSTPT),Y
 CLC
 ADC OFFLO
 STA (DLSTPT),Y
 INY
 LDA (DLSTPT),Y
 ADC OFFHI
 STA (DLSTPT),Y
 INY
 INY
 CPY #$22
 BNE DLOOP
 JMP XITVBV ;exit vertical blank routine
;
;From here to $6F00 is expansion RAM
;
;
;This DLI routine changes the character set for the text window
;
 ;*=$6F00
    ORG $6F00
DLISRV PHA
 LDA #$E0
 STA CHBASE
 PLA
 RTI

    ORG $02E0
    .WORD START
