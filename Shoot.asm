    ;-*-MIDAS-*-
            .ENABLE LC
        .NLIST SEQ
        .TITLE SHOOT
        .SBTTL by John H. Palevich
;
;
;       "Shoot" -- inspired by the Atari VCS "Air Sea Battle" cartridge.
;
;       Feel free to modify & give away.  Don't even think of selling this.
;       O.K.  If you want to assemble this on your Atari, you'll have to
; change some things around.  Most changes can be inferred from looking
; at the code that this assembler produced and figuring out what you'd
; have to type to get the Atari to do the same thing.
;
;       Some hints, though:
;               ^       means /256
;               .=      means *=
;               .ASCII  means .BYTE
;                 (in expressions) means the value of the program counter
;
;               Lables shouldn't have ':'s.
;
;       Colleen Operating System Equate File
;

CHRORG  =       $E000   ;CHARACTER SET
VECTBL  =       $E400   ;VECTOR TABLE
VCTABL  =       $E480   ;RAM VECTOR INITIAL VALUE TABLE
CIOORG  =       $E4A6   ;CENTRAL I/O HANDLER
INTORG  =       $EC05   ;INTERRUPT HANDLER
SIOORG  =       $E344   ;SERIAL I/O HANDLER
DSKORG  =       $E0FA   ;DISK HANDLER
PRNORG  =       $EE7B   ;PRINTER HANDLER
CASORG  =       $EF41   ;CASSETTE HANDLER
MONORG  =       $F0E3   ;MONITOR/POWER UP MODULE
KBDORG  =       $F3E4   ;KEYBOARD/DISPLAY HANDLER
;
;
;
;
;       VECTOR TABLE
;
;       HANLDER ENTRY POINTS ARE CALLED OUT IS THE FOLLOWING VECTOR
;       TABLE. THESE ARE THE ADDRESSES MINUS ONE.
;
;       Example for Editor
;
;       E400    Open
;          2    Close
;          4    Get
;          8    Put
;          B    Status
;          A    Special
;          C    Jump to Power on initialization routine
;
;
;
EDITRV  =       $E400   ;EDITOR
SCRENV  =       $E410   ;TELEVISION SCREEN
KEYBDV  =       $F420   ;KEYBOARD
PRINTV  =       $E430   ;PRINTER
CASETV  =       $E440   ;CASSETTE
;
;       JUMP VECTOR TABLE
;
;THE FOLLOWING IS A TABLE OF JUMP INSTRUCTIONS
;TO VARIOUS ENTRY POINTS IN THE OPERATING SYSTEM
;
DISKIV  =       $E450   ;disk initialization
DSKINV  =       $E453   ;disk interface
CIOV    =       $E456   ;central input output routine

ICZERO  =       $0      ;proper values for X
ICONE   =       $10     ;when calling CIOV for each
ICTWO   =       $20     ;of the IO control Blocks
ICTHRE  =       $30
ICFOUR  =       $40
ICFIVE  =       $50
ICSIX   =       $60
ICSEVE  =       $70

SIOV    =       $E459   ;serial input output routine
SETVBV  =       $E45C   ;set system timers routine
; With respect to SETVBV. the call sequence is
; X = MSB of vector/timer
; Y = LSB of vector/timer
; A = # of vector to hack
SETMR1  =       1       ;Timer  1
SETMR2  =       2       ;       2
SETMR3  =       3       ;       3
SETMR4  =       4       ;       4
SETMR5  =       5       ;       5
SETIMM  =       6       ;Immediate VBLANK
SETDEF  =       7       ;Deffered VBLANK

SYSVBV  =       $E45F   ;SYSTEM VERTICAL BLANK CALCULATIONS
XITVBL  =       $E462   ;EXIT VERTICAL BLANK CALCULATIONS
SIOINV  =       $E465   ;SERIAL INPUT OUTPUT INITIALIZATION
SENDEV  =       $E468   ;SEND ENABLE ROUTINE
INTINV  =       $E46B   ;INTERRUPT HANDLER INITIALIZATION
CIOINV  =       $E46E   ;CENTRAL INPUT OUTPUT INITIALIZATION
BLKBDV  =       $E471   ;BLACKBOARD MODE
VARMSV  =       $E474   ;WARM START ENTRY POINT
COLDSV  =       $E477   ;COLD START ENTRY POINT
RBLOKV  =       $E47A   ;CASSETTE READ BLOCK ENTRY POINT VECTOR
CSOPIV  =       $E470   ;CASSETTE OPEN TOR INPUT VECTOR
;VCTABL =       $E480
;
;
;       OPERATING SYSTEM EQUATES
;
;       COMMAND CODES FOR IOCBS
OPEN    =       3       ;OPEN FOR INPUT/OUTPUT
GETREC  =       5       ;GET RECORD (TEXT)
GETCHR  =       7       ;GET CHARACTER(S)
PUTREC  =       9       ;PUT RECORD (TEXT)
PUTCHR  =       $B      ;PUT CHARACTER(S)
CLOSE   =       $C      ;CLOSE DEVICE
STATIS  =       $D      ;STATUS REQUEST
SPECIL  =       $E      ;BEGINNING OF SPECIAL ENTRY COMMANDS
;
;       SPECIAL ENTRY COMMANDS
DRAWLN  =       $11     ;DRAW LINE
FILLIN  =       $12     ;DRAW LINE WITH RIGHT FILL
RENAME  =       $20     ;RENAME DISK FILE
DELETE  =       $21     ;DELETE DISK FILE
FORMAT  =       $22     ;FORMAT
LOCKFL  =       $23     ;LOCK FILE TO READ ONLY
UNLOCK  =       $24     ;UNLOCK LOCKED FILE
POINT   =       $25     ;POINT SECTOR
NOTE    =       $26     ;NOTE SECTOR
IOCFRE  =       $FF     ;IOCB "FREE"
;
;       AUX1 EQUATES
;       () INDICATES WHICH DEVICES USE BIT
APPEND  =       $1      ;OPEN FOR WRITE APPEND (D). OR SCREEN READ (E)
DIRECT  =       $2      ;OPEN FOR DIRECTORY ACCESS (D)
OPNIN   =       $4      ;OPEN FOR INPUT (ALL DEVICES)
OPNOT   =       $8      ;GPEN FOR OUTPUT (ALL DEVICES)
OPNINO  =       OPNIN+OPNOT     ;OPEN FOR INPUT AND OUTPUT (ALL DEVICES)
MXDMOD  =       $10     ;OPEN FOR MIXED MODE (E,S)
INSCLR  =       $20     ;OPEN WITHOUT CLEARING SCREEN (E,S)
;
;       DEVICE NAMES
;
SCREDT  =       'E      ;SCREEN EDITOR (R/W)
KBD     =       'K      ;KEYBOARD (R ONLY)
DISPLY  =       'S      ;SCREEN DISPIAY (R/W)
PRINTR  =       'P      ;PRINTER (W ONLY)
CASSET  =       'C      ;CASSETTE
MODEM   =       'M      ;MODEM
DISK    =       'D      ;DISK
;
;
;
;
;       OPERATING SYSTEM STATUS CODES
;
SUCCES  =       $01     ;SUCCESSFUL OPERATION
;
BRKABT  =       $80     ;BREAK KEY ABORT
PRVOPN  =       $81     ;IOCB ALREADY OPEN
NONDEV  =       $82     ;NON-EXISTANT DEVICE
VRONLY  =       $83     ;IOCB OPENED FOR WRITE ONLY
NVALID  =       $84     ;INVALID COMMAND
NOIOPN  =       $85     ;DEVICE OR FILE NOT OPEN
BADIOC  =       $86     ;INVALID IOCB NUMBER
RDONLY  =       $87     ;IOCB OPENED FOR READ ONLY
EOFERR  =       $88     ;END OF FILE
TRNRCD  =       $89     ;TRUNCATED RECORD
TIMOUT  =       $8A     ;PERIPHERAL TIME OUT
DNACK   =       $8B     ;DEVICE DOES NOT ACKNOWLEDGE COMMAND
FRMERR  =       $8C     ;SERIAL BUS FRAMING ERROR
CRSROR  =       $8D     ;CURSOR OVERRANGE
OVRRUN  =       $8E     ;SERIAL BUS DATA OVERRUN
CHKERR  =       $8F     ;SERIAL BUS CHECKSUM ERROR
;
DERRER  =       $90     ;PERIPHERAL DEVICE ERROR (OPERATION NOT COMPLETED)
BADMOD  =       $91     ;BAD SCREEN MODE NUMBER
FNCNOT  =       $92     ;FUNCTION NOT IMPLEMENTED IN HANDLER
SCRMEM  =       $93     ;INSUFICIENT MEMORY FOR SCREEN MODE
;
;
;
;
;
;       PAGE ZERO RAM ASSIGNMENTS
;
LINZBS  =       $0000   ;LINBUG RAM (WILL BE REPLACED BY MONITOR RAM)
;
;       THESE LOCATIONS ARE NOT CLEARED
CASINI  =       $0002   ;CASSETTE INIT LOCATION
RAMLO   =       $0004   ;RAM POINTER FOR MEMORY TEST
TRAMSZ  =       $0006   ;TEMPORARY REGISTER FOR RAM SIZE
TSTDAT  =       $0007   ;RAM TEST DATA REGISTER
;
;       CLEARED ON COLD START ONLY


WARMST  =       $0008   ;WARM START FLAG
BOOTQ   =       $0009   ;SUCCESSFUL BOOT FLAG <WAS BOOT?>
DOSVEC  =       $000A   ;DISK SOFTWARE START FLAG
DOSINI  =       $000C   ;DISK SOFTWARE INIT ADDRESS
APPMHI  =       $000E   ;APPLICATIONS MEMORY HI LIMIT
;
;       CLEARED ON A COLD OR WARM START
INTZBS  =       $0010   ;INTERRUPT HANDLER
POKMSK  =       $0010   ;SYSTEM MASK FOR POKEY IRQ HANDLER
BRKKEY  =       $0011   ;BREAK KEY FLAG
RTCLOCK =       $0012   ;REAL TIME CLOCK (IN 16 MSEC UNITS)
;
BUFADR  =       $0015   ;INDIRECT BUFFER ADDRESS REGISTER
;
ICCOMT  =       $0017   ;COMMAND FOR VECTOR
;
DSKFMS  =       $0018   ;DISK FILE MANAGER POINTER
;
DSKUTL  =       $001A   ;DISK UTILITIES POINTER
;
PTIMOT  =       $001C   ;PRINTER TIME OUT REGISTER
PBPNT   =       $001D   ;PRINTER BUFFER POINTER
PBUFSZ  =       $001E   ;PRINT BUFFER SIZE
PTEMP   =       $001F   ;TEMPORARY REGISTER
;
ZIOCB   =       $0020   ;ZERO PAGE I/O CONIROL BLOCK
IOCBSZ  =       16      ;NUMBER OF BYTES PER IOCB
MAXIOC  =       8*IOCBSZ        ;LENGTH OF THE IOCB AREA
IOCBAS  =       $0020
ICHIDZ  =       $0020   ;HANDLER INDEX NUMBER (FF == IOCB FREE)
ICDNOZ  =       $0021   ;DEVICE NUMBER (DRIVE NUMBER)
ICCOMZ  =       $0022   ;COMMAND CODE
ICSTAZ  =       $0023   ;STATUS OF LAST IOCB ACTION
ICBALZ  =       $0024   ;BUFFER ADDRESS LOW BYTE
ICBAHZ  =       $0025   ;BUFFER ADDRESS HIGH BYTE
ICPTLZ  =       $0026   ;PUT BYTE ROUTINE ADDRESS - 1
ICPTHZ  =       $0027   ;
ICBLLZ  =       $0028   ;BUFFER LENGTH LOW BYTE
ICBLHZ  =       $0029
ICAX1Z  =       $002A   ;AUXILIARY INFORMATION FIRST BYTE
ICAX2Z  =       $002B
ICSPRZ  =       $002C   ;TWO SPARE BYTES (CIO LOCAL USE)
ICIDNO  =       ICSPRZ+2        ;IOCB NUMBER X 16
CIOCHR  =       ICSPRZ+3        ;CHARACTER BYTE FOR CURRENT OPERATION
;
STATUS  =       $0030   ;INTERNAL STATUS STORAGE
CHKSUM  =       $0031   ;CHECKSUM (SINGLE BYTE SUM WITH CARRY)
BUFRLO  =       $0032   ;POINTER TO DATA BUFFER (LO BYTE)
BUFRHI  =       $0033   ;POINTER TO DATA BUFFER (HI BYTE)
BFENLO  =       $0034   ;NEXT BYTE PAST END OF DATA BUFFER (LO BYTE)
BFENHI  =       $0035   ;NEXT BYTE PAST EHD OF DATA BUFFER (HI BYIE)
CRETRY  =       $0036   ;NUMBER OF COMMAND FRAME RETRIES
ORETRY  =       $0037   ;NUMBER OF DEVICE RETRIES
BUFRFL  =       $0038   ;DATA BUFFER FULL FLAG
RECVDN  =       $0039   ;RECIEVE DONE FLAG
XMTDON  =       $003A   ;TRANSMISSION DONE FLAG
CHKSNT  =       $003B   ;CHECKSUM SENT FLAG
NOCKSM  =       $003C   ;NO CHECKSUM FOLLOWS DATA FLAG
;
;
BPTR    =       $003D
FTYPE   =       $003E
FEOF    =       $003F
FREQ    =       $0040
SOUNDR  =       $0041   ;NOISY I/O FLAG (ZERO IS QUIET)
CRITIC  =       $0042   ;DEFINES CRITICAL SECTION (CRITICAL IF NON-ZERO)
;
FMSZPG  =       $0043   ;TOTAL OF 7 BYTES FOR DISK FILE MANAGER ZERO PAGE
;
;
CKEY    =       $004A   ;FLAG SET WHEN GAME START PRESSED
CASSBT  =       $0048   ;CASSETTE BOOT FLAG
DSTAT   =       $004C   ;DISPLAY STATUS
;
ATRACT  =       $004D   ;ATRACT FLAG
DRKMSK  =       $004E   ;DARK ATRACT FLAG
COLRSH  =       $004F   ;ATRACT COLOR SHIFTER (EOR'D WITH PLAYFIELD COLORS)
;
;LEDGE  =       2       ;LMARGN'S VALUE AT COLD START
;REDGE  =       39      ;
TMPCHR  =       $0050
HOLD1   =       $0051
LMARGN  =       $0052   ;LEFT MARGIN (SET TO ONE AT POWER ON)
RMARGN  =       $0053   ;RIGHT MARGIN (SET TO ONE AT POWER ON)
ROWCRS  =       $0054   ;CURSOR COUNTERS
COLCRS  =       $0055
DINDEX  =       $0057
SAVMSC  =       $0056
OLDROW  =       $005A
OLDCOL  =       $005B
OLDCHR  =       $005D   ;DATA UNDER CURSOR
OLDADR  =       $005E
NEWROW  =       $0060   ;POINT DRAW GOES TO
NEWCOL  =       $0061
LOGCOL  =       $0063   ;POINTS AT COLUMN IN LOGICAL LINE
AORESS  =       $0064
MLTTMP  =       $0066
SAVADR  =       $0068
RAMTOP  =       $006A   ;RAM SIZE DEFINED BY POWER ON LOGIC
BUFCNT  =       $006B   ;BUFFER COUNT
BUFSTR  =       $006C   ;EDITOR GETCH POINTER
BITMSK  =       $006E   ;BIT MASK
; LOTS OF RANDOM TEMPS
SWPFLG  =       $007B   ;NON-0 IF TXT AND REGULAR RAM IS SWAPPED
HOLDCH  =       $007C   ;CH IS MOVED HERE IF KGETCH BEfore CNTL & SHIFT PROC
;
;
;
;       80 - FF ARE FOR FP, USER, FMS AND DOS
;
;
;       PAGE 1 -- STACK
;
;
;       PAGE TWO RAM ASSIGNMENTS
;
INTABS  =       $0200   ;INTERRUPT RAM

VDBLST  =       $0200   ;DISPLAY LIST NMI VECTOR
VPRCED  =       $0202   ;PROCEED LINE IRQ VECTOR
VINTER  =       $0204   ;INTERRUPT LINE IRQ VECTOR
VBREAK  =       $0206   ;SOFTWARE BREAK (00) INSTRUCTION IRQ VECTOR
VKEYBD  =       $0208   ;POKEY KEYBOARD IRQ VECTOR
VSERIN  =       $020A   ;POKEY SERIAL INPUT READY IRQ
VSEROR  =       $020C   ;POKEY SERIAL OUTPUT READY IRQ
VSEROC  =       $020E   ;POKEY SERIAL OUTPUT COMPLETE IRQ
VTIMR1  =       $0210   ;POKEY TIMER 1 IRQ
VTIMR2  =       $0212   ;POKEY TIMER 2 IRQ
VTIMR4  =       $0214   ;POKEY TIMER 4 IRQ
VIMIRQ  =       $0216   ;IMMEDIATE IRQ VECTOR
CDTMV1  =       $0218   ;COUNT DOWN TIMER 1
CDTMV2  =       $021A   ;COUNT DOWN TIMER 2
CDTMV3  =       $021C   ;COUNT DOWN TIMER 3
CDTMV4  =       $021E   ;COUNT DOWN TIMER 4
CDTMV6  =       $0220   ;COUNT DOWN TIMER 5
VVBLKI  =       $0222   ;IMMEDIATE VERTICAL BLANK NMI VECTOR
VVBLKD  =       $0224   ;DEFERRED VERTICAL BLANK NMI VECTOR
CDTMA1  =       $0226   ;COUNT DOWN TIMER 1 JSR ADDRESS
CDTMA2  =       $0228   ;COUNT DOWN TIMER 2 JSR ADDRESS
CDTMF3  =       $022A   ;COUNT DOWN TIMER 3 FLAG
SRTIMR  =       $022B   ;SOFTWARE REPEAT TIMER
CDTMF4  =       $022C   ;COUNT DOWN TIMER 4 FLAG
CDTMF5  =       $022E   ;COUNT DOWN TIMER 5 FLAG
SDMCTL  =       $022F   ;SAVE DMACTL REGISTER
SDLSTL  =       $0230   ;SAVE DISPLAY LIST LOW BYTE
SDLSTH  =       $0231   ;SAVE DISPLAY LIST HIGH BYTE
SSKCTL  =       $0232   ;SKCTL REGISTER RAM
;
LPENH   =       $0234   ;LIGHT PEN HORIZONTAL VALUE
LPENV   =       $0235   ;LIGHT PEN VERTICAL VALUE

GPRIOR  =       $26F    ;Global priority call
;
;
;       POTENTIOMETERS
;
;
PADDL0  =       $0270
PADDL1  =       $0271
PADDL2  =       $0272
PADDL3  =       $0273
PADDL4  =       $0274
PADDL5  =       $0275
PADDL6  =       $0276
PADDL7  =       $0277
;
;
;       JOYSTICKS
;
;
STICK0  =       $0278
STICK1  =       $0279
STICK2  =       $027A
STICK3  =       $027B
;
;
;       PADDLE TRIGGER
;
;
PTRIG0  =       $027C
PTRIG1  =       $027D
PTR1G2  =       $027E
PTRIG3  =       $027F
PTRIG4  =       $0280
PTRIG5  =       $0281
PTRIG6  =       $0282
PTRIG7  =       $0283
;
;
;       JOYSTICK TRIGGER
;
;
STRIG0  =       $0284
STRIG1  =       $0285
STRIG2  =       $0286
STRIG3  =       $0287
;
;       Many random OS variables, the following were commented
;
TXTROW  =       $0290   ;Text rowcrs
TXTCOL  =       $0291   ;Text colcrs
TINDEX  =       $0293   ;text index
TXTMSC  =       $0294   ;fools convert into new msc
TXTOLD  =       $0296   ;oldrow and oldcol for text (etc.)
ESCFLG  =       $02A2   ;Escape flag
LOGMAP  =       $02B2   ;Logical line start bit map
INVFLAG =       $02B6   ;Inverse video flag (toggled by Atari key)
FILFLG  =       $02B7   ;Fill flag for draw
SCRFLG  =       $02B8   ;Set if scroll occures
SHFLOK  =       $02BE   ;Shift lock
BOTSCR  =       $02BF   ;Bottom of screen: 24 Norm. 4 Split.
;
;
;       COLORS
;
;
PCOLR0  =       $02C0   ;P0 COLOR
PCOLR1  =       $02C1   ;P1 COLOR
PCOLR2  =       $02C2   ;P2 COLOR
PCOLR3  =       $02C3   ;P3 COLOR
COLOR0  =       $02C4   ;COLOR 0
COLOR1  =       $02C5   ;COLOR 1
COLOR2  =       $02C6   ;COLOR 2
COLOR3  =       $02C7   ;COLOR 3
COLOR4  =       $02C8   ;COLOR 4
;
;
;       GLOBAL VARIABLES
;
;
RAMSIZ  =       $02E4   ;RAM SIZE (HI BYTE ONLY)
MEMIOP  =       $0215   ;TOP OF AVAILABLE USER MEMORY
MEMLO   =       $02E7   ;BOTTOM OF AVAILABLE USER MEMORY
DVSTAT  =       $02EA   ;STATUS BUFFER
;
CRSINH  =       $02F0   ;CURSOR INHIBIT (00 = CURSOR ON)
KEYDEL  =       $02F1   ;Key delay
CHACT   =       $02F3   ;CHACTL REGISTER RAM
CHBAS   =       $02F4   ;CHBAS REGISTER RAM
FILDAT  =       $02FD   ;RIGHT FILL DATA (DRAW)
ATACHR  =       $02FB   ;Atascii character
CM      =       $02FC   ;global variable for keyboard
DSPFLA  =       $02FE   ;DISPLAY FLAG: DISPLAYS CNTLS IF NON ZERO:
SSFLAG  =       $02FF   ;Start/stop flag for paging (CNTL 1). Cleared by Break

;
;       Page three RAM assignments
;
;       Device control blocks
;       (SIO)
DCB     =       $0300   ;Device control block
DDEVIC  =       $0300   ;Peripheral Unit 1 bus I.D. number
DUNIT   =       $0301   ;Unit number
DCOMND  =       $0302   ;Bus command
DSFATS  =       $0303   ;Command Type/status return
DBUFLO  =       $0304   ;Data buff- points low
DBUFHI  =       $0305
DTIMLO  =       $0306   ;Device time out in 1 second units
DBYTLO  =       $0308   ;Number of bytes to be transvered low byte
DBYTHI  =       $0309
DAUX1   =       $030A   ;Command Aux byte 1
DAUX2   =       $0308
;
IOCB    =       $0340
ICHID   =       $0340   ;Handler index number (FF = IOCB free)
ICDNO   =       $0341   ;Device number (drive number)
ICCOM   =       $0342   ;Command code
ICSTA   =       $0343   ;Status of last IOCB action
ICBAL   =       $0344   ;Buffer address low byte
ICBAH   =       $0345
ICPTL   =       $0346   ;Put byte routine address - 1
ICPTH   =       $0347
ICBLL   =       $0348   ;Buffer length low byte
ICBLH   =       $0349
ICAX1   =       $034A   ;Auxiliary information first byte
ICAX2   =       $034B
ICSPR   =       $034C   ;four spare bytes

;
PRNBUF  =       $0300   ;Printer buffer (40 bytes)
;       (21 spare bytes)
;
;       Page Four Ram Assignnents
CASBUF  =       $03FD   ;Cassette Buffer (131 bytes)
;
USAREA  =       $0480   ; (0480 thru 05FF for the user)
;                         (except for floating point...)
;
;       FLOATING POINT ROM ROUTINES
;
;
;       IF CARRY IS USED THEN CARRY CLEAR => NO ERROR. CARRY SET => ERROR
;
AFP     =       $D800   ;ASCII -> FLOATING POINT (FP)
;                       INBUFF * CIX -> FR0, CIX, CARRY
FASC    =       $D8E6   ;FP -> ASCII FR0 -> F0R,FD0-1, CARRY
IFP     =       $D9AA   ;INTEGER -> FP
;                       0-$FFFF (LSB, MSB) IN FR0,FR0+1->FR0
FPI     =       $D92D   ;FP -> INTEGER  FR0 -> FR0,FR0+1, CARRY
FSUB    =       $DA60   ;FR0 <- FR0 - FR1, CARRY
FADD    =       $DA66   ;FR0 <- FR0 + FR1  ,CARRY
FMUL    =       $DADB   ;FR0 <- FR0 * FR1  ,CARRY
FDIV    =       $DB28   ;FR0 <- FR0 / FR1  ,CARRY
FLD0R   =       $DD89   ;FLOATING LOAD REG0     FR0 <- (X,Y)
FLD0P   =       $DD8D   ;                       FR0 <- (FLPTR)
FLD1R   =       $DD9B   ;                       FR1 <- (X,Y)
FLD1P   =       $DD9C   ;                       FR1 <- (FLPTR)
FST0R   =       $DDA7   ;FLOATING STORE REG0  (X,Y) <- FR0
FST0P   =       $DDAB   ;                   (FLTPTR)<- FR0
FMOVE   =       $DDB6   ;FR1 <- FR0
PLYEVL  =       $DD40   ;FR0 <- P(Z) = SUM(I = N TO 0) (A(I) *Z**I) CARRY

;                       INPUT:  (X,Y) = A(N), A(N-I)...A(0) -> PLYARG
;                               ACC   = # OF COEFFICIENTS = DEGREE + 1
;                               FR0   = Z
EXP     =       $DDC0   ;FR0 <- E**FR0 = EXP10(FR0 * LOG10(E)) CARRY
EXP10   =       $DDCC   ;FR0 <- 10**FR0 CARRY
LOG     =       $DECD   ;FR0 <- LN(FR0) = LOG10(FR0) / LOG10(E) CARRY
LOG10   =       $DE01   ;FR0 <- LOG10(FR0) CARRY
;
;
;       THE FOLLOWING ARE IN THE BASIC CARTRIDGE:
;
;
SIN     =       $BD81   ;FR0 <- SIN(FR0) DEGFLG=0 => RADS, 6->DEG. CARRY

COS     =       $BD73   ;FR0 <- COS(FR0)        CARRY
ATAN    =       $BD43   ;FR0 <- ATN(FR0)        CARRY
SQR     =       $BEB1   ;FR0 <- SQUAREROOT(FR0) CARRY
;
;
;       FLOATING POINT ROUTINES ZERO PAGE (NEEDED ONLY IF F.P.
;               ROUTINES ARE CALLED)
FR0     =       $00D4   ;FP REG0
FR1     =       $00E0   ;FP REG1
CIX     =       $00F2   ;CURRENT INPUT INDEX
INBUFF  =       $00F3   ;POINTS TO USER'S LINE INPUT BUFFER
RADFLG  =       $00FB   ;0 = RADIANS, 6 = DEGREES
FLTPTR  =       $00FC   ;POINTS TO USERS FLOATING POINT NUMBER
;
;
;       FLOATING POINT ROUTINES' NON-ZP RAM
;
;       (057E to 06FF)
;
LBUFF   =       $0580   ;LINE BUFFER
PLYARG  =       LBUFF+$60       ;POLYNOMILA ARGUMENTS
;
;
;
;
;
;       COLLEEN MNEMONICS
;
;
;
POKEY   =       $D200       ;VBLANK ACTION:         DESCRIPTION:
POT0    =       POKEY+0     ;POT0-->PADDL0          0-227 IN RAM CELL
POT1    =       POKEY+1     ;POT1-->PADDL1          0-227 IN RAM CELL
POT2    =       POKEY+2     ;POT2-->PADDL2          0-227 IN RAM CELL
POT3    =       POKEY+3     ;POT3-->PADDL3          0-227 IN RAM CELL
POT4    =       POKEY+4     ;POT4-->PADDL4          0-227 IN RAM CELL
POTS    =       POKEY+5     ;POT5-->PADDL5          0-227 IN RAM CELL
POTC    =       POKEY+6     ;POT6-->PADDL8          0-227 IN RAM CELL
POT7    =       POKEY+7     ;POT7-->PADDL7          0-227 IN RAM CELL
ALLPOT  =       POKEY+8     ;???
KBCODE  =       POKEY+9
RANDOM  =       POKEY+10
POTGO   =       POKEY+11    ;Strobed
;               n/a
SERIN   =       POKEY+13
IRQST   =       POKEY+14
SKSTAT  =       POKEY+15
;
AUDF1   =       POKEY+0
AUDC1   =       POKEY+1
AUDF2   =       POKEY+2
AUDC2   =       POKEY+3
AUDF3   =       POKEY+4
AUDC3   =       POKEY+5
AUDF4   =       POKEY+6
AUDC4   =       POKEY+7
AUDCT   =       POKEY+8     ;NONE                   AUDCTL<--[SIO]
STIMER  =       POKEY+9
SKRES   =       POKEY+10    ;NONE                   SKRES<--[SIO]
;
POTGO   =       POKEY+11
SEROUT  =       POKEY+13    ;NONE                   SEROUT<--[SIO]
IRQEN   =       POKEY+14    ;POKMSK-->IRQEN (AFFECTED BY OPEN S: OR E:)
SKCTL   =       POKEY+16    ;SSKCTL-->SKCTL          SSKCTL<--[SIO]
;
CTIA    =       $D000
HPOSP0  =       CTIA+0
HPOSP1  =       CTIA+1
HPOSP2  =       CTIA+2
HPOSP3  =       CTIA+3
HPOSM0  =       CTIA+4
HPOSM1  =       CTIA+5
HPOSM2  =       CTIA+6
HPOSM3  =       CTIA+7
SIZEP0  =       CTIA+8
SIZEP1  =       CTIA+9
SIZEP2  =       CTIA+10
SIZCP3  =       CTIA+11
SIZEM   =       CTIA+12
GRAFP0  =       CTIA+13
GRAFP1  =       CTIA+14
GRAFP2  =       CTIA+15
GRAFP3  =       CTIA+16
GRAFM   =       CTIA+17
COLPM0  =       CTIA+18 ;PCOLR0-->COLPM0     WITH ATTRACT MODE
COLPM1  =       CTIA+19 ;ETC.N
COLPM2  =       CTIA+20
COLPM3  =       CTIA+21
COLPF0  =       CTIA+22
COLPF1  =       CTIA+23
COLPF2  =       CTIA+24
COLPF3  =       CTIA+25
COLBK   =       CTIA+26
PRIOR   =       CTIA+27
VDELAY  =       CTIA+28
GRACTL  =       CTIA+29
HITCLR  =       CTIA+30
CONSOL  =       CTIA+31 ;$08-->CONSOL        TURN OFF SPEAKER
;
M0PF    =       CTIA+0
M2PF    =       CTIA+2
M3PF    =       CTIA+3
P0PF    =       CTIA+4
P1PF    =       CTIA+5
P2PF    =       CTIA+6
P3PF    =       CTIA+7
M0PL    =       CTIA+8
M1PL    =       CTIA+9
M2PL    =       CTIA+10
M3PL    =       CTIA+11
P0PL    =       CTIA+12
P1PL    =       CTIA+13
P2PL    =       CTIA+14
P3PL    =       CTIA+15
TRIG0   =       CTIA+16         ;TRIG0-->STRIG1
TRIG1   =       CTIA+17         ;ETC.
TR1G2   =       CTIA+18
TRIG3   =       CTIA+19
PAL     =       CTIA+20
;
ANTIC   =       $D400
DMACTL  =       ANTIC+0         ;DMACTL<--SDMCTL  ON OPEN S: OR E:
CHARCTL =       ANTIC+1         ;CHACTL<--CHACT   ON OPEN S: OR E:
DLISTL  =       ANTIC+2         ;DIISTt<--SDLSTL  ON OPEN S: OR E:
DLISTH  =       ANTIC+3         ;OLISFH<--SDLSTH  ON OPEN S: OR E:
HSCROL  =       ANTIC+4
VSCROL  =       ANTIC+5
PMBASE  =       ANTIC+7
CHBASE  =       ANTIC+9         ;CMBASE<--CHBAS   ON OPEN S: OR E:
WSYNC   =       ANTIC+10
VCOUNT  =       ANTIC+11
PENH    =       ANTIC+12
PENV    =       ANTIC+13
NMIEN   =       ANTIC+14        ;NMIEN<--40       POWER ON AND [SETVBV]
NMIRES  =       ANTIC+15        ;STROBED
HMIST   =       ANTIC+15
;
;       Lots and lots of unofficial
;       Mnemonics for display list instructions.
;       as well as other bit patterns.
;
;       DL prefix implies display list
;       instruction, naturally
;
DLBL1   =       0       ; One blank line
DLBL2   =       $10     ; Two blank lines
DLBL3   =       $20     ; Three
DLBL4   =       $30     ; Four
DLBL5   =       $40     ; Five
DLBL6   =       $50     ; Six
DLBL7   =       $60     ; Seven
DLBL8   =       $70     ; Eight blank lines

DLINT   =       $80     ; Generate DisplayListInterrupt when this
                        ; instruction is interpreted.
DLJMP   =       $1      ; Tells Antic Chip to junp to contents of next two bytes
DLJVB   =       $41     ; Same as DLJMP but also halts ANTIC 'till next verticle blank
DLLDM   =       $40     ; Tells Antic chip to start retrieving data from memory referenced by the next t
DLVSCR  =       $20     ; (sort of) enables vertical scroll
DLHSCR  =       $10     ; enable horizontal scroll
;
;       Playfield Instructions
;
DLPF15  =       15      ; 320 dots  2 colors  1 scan line
DLPF14  =       14      ; 160       4         1
DLPF13  =       13      ; 160       4         2
DLPF12  =       12      ; 160       2         1
DLPF11  =       11      ; 160       2         2
DLPF10  =       10      ; 80        4         4
DLPF9   =       9       ; 80        2         4
DLPF8   =       8       ; 40        4         8

; Character PF types

DLPF7   =       7       ; 20 chars  5 colors  16 scan lines
DLPF6   =       6       ; 20        5         8
DLPF5   =       5       ; 40        5         16 (hairy 4 color characters)
DLPF4   =       4       ; 40        5         8
DLPF3   =       3       ; 40        2         10 (Text processing)
DLPF2   =       2       ; 40        2         8 (Normal text mode)

; PF1 & PF0 are special. . . .

;
;       Player & Missile Offsets
;       Denoted by PM prefix
;
PMLF    =       $24     ;left side of screen
PMRF    =       $DD     ;flight side of screen
PMDM    =       $180    ;Missile offset, for double line resolution
PMDP0   =       $200    ;Player 0
PMDP1   =       $280    ;Player 1
PMDP2   =       $300    ;Player 2
PMDP3   =       $380    ;Player 3
PMSM    =       2*PMDM  ;Missile offset for single line resolution
PMSP0   =       2*PMDP0 ;Player 0
PMSP1   =       2*PMDP1 ;       1
PMSP2   =       2*PMDP2 ;       2
PMSP3   =       2*PMDP3 ;       3

;
;       Colors. denoted by CL
;
CLGREY  =       0       ;grey
CLGOLD  =       $10     ;gold
CLORNG  =       $20     ;orange
CLRED   =       $30     ;red-orange
CLPINK  =       $40     ;pink
CLPURP  =       $50     ;purple
CLPURB  =       $60     ;purple blue
CLPBLU  =       $70     ;blue 1
CLBLUE  =       $80     ;blue 2
CLLBLU  =       $90     ;light blue
CLTURQ  =       $A0     ;turquoise
CLGBLU  =       $B0     ;green blue
CLGREN  =       $C0     ;green
CLYGRN  =       $D0     ;yellow green
CLOGRN  =       $E0     ;orange green
CLLTOR  =       $F0     ;light orange
;       Bit Masks for console switches
;
SWSTRT  =       $1      ;Start
SWSEL   =       $2      ;Select
SWOPT   =       $4      ;Option

;       Joystick bit masks

JYR     =       8       ;Right
JYL     =       4       ;Left
JYB     =       2       ;Back
JYF     =       1       ;Forward

PIA     =       $D300
PORTA   =       PIA+0   ;PORTA-->STICK0,1    X-Y CONTROLLERS
PORTB   =       PIA+1   ;PORTB-->STICK2,3
PACTL   =       PIA+2   ;NONE                PACTL<--3C [INIT]
PBCTL   =       PIA+3   ;NONE                PBCTL<--3C [INIT]
ASCZER  =       '0      ;Ascii zero
COLON   =       $3A     ;Ascii Colon
EOL     =       $9B     ;End of Record

; The Following are subroutines

PUTLIN  =       $F385   ;X -- Lo byte
                        ;Y -- Hi byte
                        ;of line

XVB     =       $E7D1   ;System VBLANK exit routine
;
;
;
;               End of Atari equates.
;
;       The rest of this is (C)1981 John H. Palevich
;
;
ORG     =       $1000           ;Must be at least 3K of memory
                                ;above this point. . . .
.=ORG
            ;Once in the actual game you can make
            ;identical copies of it by pressing OPTION
            ;and SELECT down simultaneously between
            ;plays.  The Atari will beep twice and you
            ;should press play & record and then RETURN
            ;to make a copy.  After one copy is made
            ;the game starts all over again.
PST=.
;
;       This is the Boot tape header table.
;
        .BYTE   0               ;Traditional
        .BYTE   PND-PST+127/128 ;# of 128 byte blocks in program
        .ADDR   PST             ;Start of place to load program
        .ADDR   PINIT           ;Place to jump after loading
                                ;program

; ENTRY POINT FOR MULTI-STAGE BOOT PROCESS.

        CLC
        RTS

; ENTRY POINT FOR FIRST TIME INITIALIZATION
PINIT:  LDA     #$3C
        STA     PACTL   ;turn off cassete motor

        LDA     #RESTRT&$FF     ;Shove the restrt vector into
        STA     DOSVEC          ;the DOS vector.
        LDA     #RESTRT^
        STA     DOSVEC+1
        RTS


;       WARMSTART ENTRY POINT
;
RESTRT: JMP     BEGIN

;
;
; .....................
; Look, up in the sky!  Its a helicopter, it's a plane. It's
; a saucer, no, it's Jack's wonderful 'SHOOT' game.
;

; Zero-Page-Variables
;(None of these variables Have to be on the zero page, but
;putting them here speeds up and shortens the code)
;
DLIC    =       $B0 ;Counter of display list interrupts
DSCOR   =       $B1 ;Delta score.
MX      =       $B2 ;Missile X coordinate
MDX     =       $B3 ;Missile X velocity
MY      =       $B4 ;Missile Y position (Zero means no missile
                    ;on the screen.)
DSEC    =       $B5 ;mod 15 counter for score to second conversion
JIFF    =       $B6 ;mod 60 counter for jiffy to second conversion
STOP    =       $B7 ;Non zero neans ignore player's button.  Used
                    ;to keep him from firing unless we want him to.
;
; Data Tables
;
; MDLIST -- My display list. Consists of the standard-24-blank-scan-lines.
; 8 scan lines of text (the score and copyright line)
; 11 sets of 16 scan lines with a display list interrupt
; occuring at the start of each pair
; and a final jump & wait for vertical blank instruction
;

MDLIST: .BYTE   DLBL8,DLBL8,DLBL8
        .BYTE   DLLDM+DLPF6     ;C
        .ADDR   SCORLN
        .BYTE   DLBL8+DLINT,DLBL8     ;1,2
        .BYTE   DLBL8+DLINT,DLBL8     ;3,4
        .BYTE   DLBL8+DLINT,DLBL8     ;5,6
        .BYTE   DLBL8+DLINT,DLBL8     ;7,8
        .BYTE   DLBL8+DLINT,DLBL8     ;9,10
        .BYTE   DLBL8+DLINT,DLBL8     ;11,12
        .BYTE   DLBL8+DLINT,DLBL8     ;13,14
        .BYTE   DLBL8+DLINT,DLBL8     ;15,16
        .BYTE   DLBL8+DLINT,DLBL8     ;17,18
        .BYTE   DLBL8+DLINT,DLBL8     ;19,20
        .BYTE   DLBL8+DLINT,DLBL8     ;21,22
        .BYTE   DLJVB
        .ADDR   MDLIST
;
; Message table
;

TMSG:   .ASCII  "(C)1981 J H PALEVICH" ;Horrible bugs will infest the code






                      ;of who-so-ever changes this copyright
                      ;message to something else!

;
; The next many tables are for the display list interrupt handler.
; They are all 11 bytes long, so that there is one byte in each
; table for each display list interrupt.  The First DLI uses the
; rirst byte in the table, and so forth, so in the TCOLB table,
; for instance, the top of the sky is black, then the first DLI
; makes it turn CLBLUE, the second CLLBLU. and so on.
;

;
; TCOLB - table of colors for backround
;  The sky starts out black and turns light blue, then
; the backround turns green for the 'ground' under the gun.
;
TCOLB:  .BYTE   CLBLUE,CLLBLU,CLBLUE+2
        .BYTE   CLLBLU+2,CLBLUE+4,CLLBLU+4
        .BYTE   CLBLUE+6,CLLBLU+6,CLBLUE+8
        .BYTE   CLLBLU+8,CLGREN+8
;
; TCOLP - COLOR PLAYER ZERO
; Player zero is the planes in the sky and the gun on the ground
;

TCOLP:  .BYTE   CLGREY+8,CLGOLD+8
        .BYTE   CLORNG+8,CLRED+8
        .BYTE   CLPINK+8,CLPURP+8
        .BYTE   CLPURB+8,CLPBLU+8
        .BYTE   CLBLUE,CLRED+8,CLRED+8
;
; TPX -- Players X position
;       The gun it always stuck at 124.
;       DPLANE takes care of the planes' x position.
;       DLIH sets the X position to zero to kill the
; plane and get it off the screen.
;

TPX:    .BYTE   0,1,2,3,4,5,6,7,8,124,124




;
; TDX -- Player's velocity.
;       The gun is always zero, so it will not drift off
; to either side.
;

TDX:    .BYTE   1,2,3,2,1,255,254,253


        .BYTE   254,0,0

;
; TVAL -- PLAYER'S POINT-VALUE
;
;       Set by DPLANE
;       Used by DLIH
;

TVAL:   .BYTE   1,2,3,4,5,6,7,8,9,10,11




;
; TWID -- width of the player
;
;       0 -- normal (two GR. 0 characters) wide
;       1 -- double (four Gr. 0 characters) wide
;       The gun is double width
;

TWID:   .BYTE   0,1,0,1,0,1,0,1,0,1,1



;
; That's the end of the tables used by the DLIH
; routine.
;

;
; JTAB -- missiles X velocity
;       Used to convert from the joystick direction to
; the speed end direction of the missile.  Used by VBLI.
;

JTAB:   .BYTE   0,1,255,0


;
; GUNTAB -- Picture of gun in all three
; directions.
;
;........
;......++
;.....++.
;....++..
;...+++..
;..++++..
;.++++++.
;++++++++
GUNTAB: .BYTE   0,3,6,$C,$1C,$3C,$7E,$FF


;........
;++......
;.++.....
;..++....
;..+++...
;..++++..
;.++++++.
;++++++++
        .BYTE   0,$C0,$60,$30,$38,$3C,$7E,$FF


;........
;...++...
;...++...
;...++...
;.. ++...
;..++++..
;.++++++.
;++++++++

        .BYTE   0,$18,$18,$18,$18,$3C,$7E,$FF



;  Pattern defn's.
;
;  Used by DPLANE to draw the planes.  Note that
; the top two lines must be blank or else all sorts
; of messy chopping effects will occur.
;

;
; Pattern Zero is a helicopter flying left.
;

;........
;........
;+++++...
;..+.....
;++++..+.
;+..++++.
;+..+....
;++++....
PTOL:   .BYTE   0,0,$F8,$20,$F2,$9E,$90,$F0


;........       helicopter flying right.
;........
;...+++++
;.....+..
;.+..++++
;.++++..+
;....+..+
;....++++


        .BYTE   0,0,$1F,4,$4F,$79,9,$F


;........       airplane flying left.
;........
;.......+
;....++.+
;..++++++
;.+++++++
;...++...
;........
        .BYTE   0,0,1,$0D,$3F,$7F,$18,0


;........       airplane flying right
;........
;+.......
;+.++....
;++++++..
;+++++++.
;...++...
;........

        .BYTE   0,0,$80,$B0,$FC,$FE,$18,0


;........       saucer flying left, right, hovering, etc.
;...++...
;..+..+..
;.++++++.
;+......+
;.++++++.
;........
;........
        .BYTE   0,$18,$24,$7E,$81,$7E,0,0


;
; TPLANE DX, VAL, WID, PAT table
;
;       TPLANE is a table used by DPLANE to
; create planes.  What DPLANE does Is pick a random number
; between zero and five and use that nunber to fill in the
; IDX, FVAL, TWID and player zero slots for that kind of plane.
;
;       There is no real reason to stop with only six
; kinds of planes. . . .
;
TPLANE: .BYTE   1,5,0,8     ;Helicopter, left

        .BYTE   $FF,5,0,0   ; "      " , right

        .BYTE   2,10,1,24   ;Airplane, left

        .BYTE   $FE,10,1,16 ; " " , right

        .BYTE   3,25,0,32   ;Saucer, left

        .BYTE   $FD,25,0,32 ;Saucer, right

; Player missile table equates
;
MPMBAS  =       ORG+$800    ;Player missile base --
                            ;Leave 2K for the main program

SCORLN  =       MPMBAS      ;Score line (uses 20 bytes)

GUNOFF  =       96          ;Gun offset -- Y position of top
                            ;of gun.

GUNPOS  =       MPMBAS+PMDP0+GUNOFF ;Memory location of
                                    ;top of gun in player0 memory.

SCORE   =       SCORLN      ;Address of Score (six digets)
HISCOR  =       SCORLN+7    ;Address of High score (six digets)
TIME    =       SCORLN+14   ;Address of Time remaining (six digets)

;
;
; This is the DLI handler --
;       it is called every time the Antic chip fetches a display
; list byte with the high bit set.  It saves the A and X registers.
; changes the sky & color & width & position of the next plane,
; and checks to see if the previous plane has been hit.  If so, it
; moves that plane off the screen and adds the point value of that
; plane to the DSCOR variable.  Then it restores X & A and returns.
;
;

DLIH:   PHA                 ;Save A
        TXA
        PHA                 ;Save X
        LDX     DLIC        ;Change the sky's color as fast as
        INX                 ;we can.
        LDA     TCOLB,X     ;but.
        STA     WSYNC       ;wait untill we can do it without
        STA     COLBK       ;the user noticing it.
        LDX     DLIC
        LDA     M0PL        ;Did missile 0 hit anything?
        AND     #1          ;like P0?
        BEQ     DLIH2       ;No.
        LDA     #0          ;Yes:
        STA     TPX,X       ;So zero x position.
        STA     TDX,X       ;and x velocity.
        LDA     TVAL,X      ;and add the value of
        CLC                 ;that player to DSCOR
        ADC     DSCOR
        STA     DSCOR
        STA     HITCLR      ;And clear the hit registers.

DLIH2:  INX                 ;In any event, update:
        STX     DLIC
        LDA     TPX,X       ;plane's X position.
        CLC
        ADC     TDX,X
        STA     TPX,X

        STA     HPOSP0
        LDA     TCOLP,X   ;plane's color
        STA     COLPM0
        LDA     TWID,X    ;plane's width
        STA     SIZEP0
        PLA               ;restore X
        TAX
        PLA               ;restore A
        RTI               ;and return.

;
; VBLH -- vertical blank interrupt
;       gets called 60 times a second when the TV gun has just
; retraced the screen and the Antic chip is starting to read the
; display list all over again.
;
;       It updates the player's score & time-left counter,
; updates the missile if it is in flight, fires it if it is not
; in flight and if the joystick's button is pressed, resets the
; counter that the display list interrupt handler uses to tell
; where it is, and kills the missile if it hit a plane or went
; off the top of the screen.
;

VBLH:   LDA     DSCOR     ;Check if there are any unscored
        BNE     VBL5      ;points left. Yes.
        LDA     #$80      ;No.
        STA     AUDC2     ;Turn off point sound
        JMP     VBL7

VBL5:   SEC               ;Subtract one from the unscored
        SBC     #1        ;points counter.
        STA     DSCOR

        LDA     #$8A      ;Turn on the point sound.
        STA     AUDC2

        LDX     #5        ;Add one to the SCORE counter.
VBL6:   LDA     SCORE,X   ;Which by an amazing coincidence
        CLC               ;is in a human readable forn.
        ADC     #1
        ORA     #$10      ;If it was a space make it a '1'.
        STA     SCORE,X
        CMP     #$1A      ;Greater than a '9'?
        BNE     VBLH5     ;No.
        LDA     #$10      ;Yes. Set to '0' ind add one to
        STA     SCORE,X   ;the next most significant diget.
        DEX
        JMP     VBL6
VBLH5:  LDA     STOP      ;No free time if
        BNE     VBL7      ;we're STOPed.

        LDX     DSEC      ;Has he scored 15 points in a row
        INX               ;yet?
        STX     DSEC
        CPX     #15
        BNE     VBL7      ;Nope.
        LDX     #0        ;Yes.  Reset this counter, then, and
        STX     DSEC

        LDX     #5        ;give this man a second of free time.
VBL8:   LDA     TIME,X    ;(this routine is just like the VBL6
        CLC               ;one, only it fiddles with numbers that
        ADC     #1        ;are a different color. . . .)
        ORA     #$90
        STA     TIME,X
        CMP     #$9A
        BCC     VBL7
        LDA     #$90
        STA     TIME,X
        DEX
        JMP     VBL8

VBL7:   LDX     JIFF      ;Move 60 jiffies (a jiffy is used
        INX               ;by Pet owners and other people
        STX     JIFF      ;to denote a 60th of a second) elapsed?
        CPX     #60
        BNE     VBL9      ;No!
        LDX     #0        ;Yes.  Reset jiffy counter
        STX     JIFF

        LDA     STOP      ;Has time stopped?
        BNE     VBL12     ;Yes.

        LDX     #5        ;No, so we shall take away a second from
VBL10:  LDA     TIME,X    ;the user's time (har har har)
        SEC               ;in just the same way as we added one.
        SBC     #1        ;except for a few changes.
        ORA     #$90
        STA     TIME,X

        CMP     #$9F      ;Like this check for borrow in place
        BNE     VBL9      ;of a check for carry.
        LDA     #$99
        STA     TIME,X
        DEX
        JMP     VBL10

VBL9:   LDA     #0        ;Has the user run out of time??
        LDX     #6        ;If so, OR-ing together all of his
VBL11:  ORA     TIME-1,X  ;time-left digets should give a zero
        DEX
        BNE     VBL11

        AND     #$F
        CMP     #0        ;Does It?
        BNE     VBL12     ;No
        LDA     #1        ;Yes.  Stop time!!!
        STA     STOP

VBL12:  LDA     #0        ;Store a zero into the ATRACT flag
        STA     ATRACT    ;to keep the Atari from futzing with
                          ;our screen colors. . . .  Of course
                          ;this means that the user might end
                          ;up with the game field permanently
                          ;embossed on his TV screen. . . .

        LDA     STICK0    ;Take STICK0
        LSR     A
        LSR     A         ;Divide it by 4
        TAX               ;Use that number to look up the
        LDA     JTAB,X    ;direction the missile should
        STA     MDX       ;travel in.
        DEX               ; Then subtract one from that
        TXA               ; (It better not be 0. . . .)
        ASL     A         ;And multiply by eight
        ASL     A         ;to get an index into the
        ASL     A         ;table of the gun pictures
        TAX
        LDY     #0
GUNDLP: LDA     GUNTAB,X  ;Copy the picture of the gun
        STA     GUNPOS,Y  ;into player zero.  Use two
        INY               ;bytes for each byte in the
        STA     GUNPOS,Y  ;piture table so the gun is
        INX               ;10 dots (32 scan lines) high.
        INY
        CPY     #16
        BNE     GUNDLP

        LDA     MX        ;Now update missile's X position.
        CLC
        ADC     MDX
        STA     MX
        STA     HPOSM0

        LDA     MY        ;Missile Y
        BEQ     VCONT     ;No missile
        TAX
        LDA     #0        ;Erase old missile
        STA     MPMBAS+PMDM,X

        DEX               ;Hit top of screen?
        BEQ     VMDIE     ;Yes.
                          ;No.
        LDA     DSCOR     ;Hit an airplane with the missile?
        BNE     VMHIT     ;No.
        STX     MY
        LDA     #$FF      ;Draw new missile

        STA     MPMBAS+PMDM,X

        STX     AUDF1     ;fweep sound effect
        JMP     VCONT

VMDIE:  STX     MY        ;Zero the missile's Y coordinate
        JMP     VCONT     ;to kill the missile.

VMHIT:  LDX     #0        ;Since we hit something we should
        STX     AUDF1     ;silence the sound register
        STX     MY        ;and zero the missile.

VCONT:  LDA     STOP      ;Stoped?
        BNE     VCONT2    ;Yes.


        LDA     STRIG0    ;Check if hunan wants to fire
        BNE     VCONT2    ;No.

        LDA     MY        ;Check if he CAN fire.
        BNE     VCONT2    ;Can't

        LDA     #GUNOFF+2 ;Set the Y coordinate to Just
        STA     MY        ;above the muzzle or the gun.
        LDA     MDX       ;To get the X coordinate.
        ASL     A         ;multiply MDX (the direction the
        ASL     A         ;gun is pointing) by 4
        CLC               ;and add to 132 (which is the
        ADC     #132      ;CENTER of the Gun)
        STA     MX


VCONT2: LDA     #$FF      ;Reset DLI counter
        STA     DLIC
        STA     HITCLR    ;Zero hits.
        JMP     SYSVBV    ;Jump to the OS's exit vblank routine.
;
; Main program starts here!!!
;


BEGIN:  LDA     #$A8        ;Missile sound is pure at volume 8
        STA     AUDC1
        LDA     #$80        ;Score sound is a silent fuzz.
        STA     AUDC2

        LDA     #0          ;missile frequency is ultrasonic
        STA     AUDF1

        LDA     #$30        ;score frequency is a high fuzz.
        STA     AUDF2
;
; Erase player missile memory space.
;
        LDX     #128
        LDA     #0
CLOOP:  STA     MPMBAS+PMDP0-1,X        ;We only use Player zero
        STA     MPMBAS+PMDM-1,X         ;and the missiles.
        DEX
        BNE     CLOOP

        LDA     #0          ;Move all the players and missiles
        LDX     #8          ;off the screen.
PLOOP:  STA     HPOSP0-1,X
        DEX
        BNE     PLOOP

        LDA     #$2E        ;Enable PM DMA and a normal playfield.
        STA     SDMCTL
        LDA     #MPMBAS^    ;Set up the pointer to the Player
        STA     PMBASE      ;missile defuns.
        LDA     #3          ;Tell the CTIA to expect PM DMA
        STA     GRACTL

        LDA     #$10        ;Enable fifth player so the
        ORA     GPRIOR      ;missiles will be COLOR3
        STA     GPRIOR
        STA     PRIOR

        LDA     #0          ;Zero the missile
        STA     MY

        LDA     #1          ;Stop the player from fireing.
        STA     STOP

        LDA     #$40        ;Disable DLI's
        STA     NMIEN
        LDA     #MDLIST^    ;Set up the vector to our
        STA     SDLSTH      ;display list.
        LDA     #MDLIST&$FF
        STA     SDLSTL
        LDA     #DLIH^      ;Setup the vector to our
        STA     VDBLST+1    ;DLI handler
        LDA     #DLIH&$FF
        STA     VDBLST
        LDX     #VBLH^      ;Load the address of our
        LDY     #VBLH&$FF   ;verticle blank interrupt
        LDA     #SETIMM     ;handler into X & Y and call
        JSR     SETVBV      ;SETVBV to set up the VBLI vector.

        LDA     #$C0        ;Enable DLI'S
        STA     NMIEN

        LDA     #CLGREN+6   ;Color 0 (score) is green
        STA     COLOR0

        LDA     #CLRED+6    ;Color 1 (high score) is red.
        STA     COLOR1

        LDA     #CLGOLD+8   ;Color 2 (time) is gold.
        STA     COLOR2

        LDA     #CLGREY+10  ;Color 3 (missiles) is white.
        STA     COLOR3

;
; Write out the copyright message.
;

        LDX     #20         ;For the twenty charaters in the message,
COPYR1: LDA     TMSG-1,X    ;load a character,
        JSR     ASTOIN      ;Call ASTOIN to get it to internal
        ORA     #$C0        ;form, change it to color 3, and
        STA     SCORLN-1,X  ;Store it on the play field.
        DEX
        BNE     COPYR1
        LDA     RTCLOC+1    ;get the real time (4 second ticks)
        CLC
        ADC     #3          ;8 to 12 seconds of glory

COPYW:  CMP     RTCLOC+1    ;Wait a while 'till user's read it.
        BNE     COPYW

;
; Erase & initialize score line
;

        LDX     #20         ;Fill score line with spaces.
        LDA     #0
ERASES: STA     SCORLN-1,X
        DEX
        BNE     ERASES

        LDA     #$10        ;Make score '     0'
        STA     SCORE+5


        LDA     #$50        ;Make high score '     0'
        STA     HISCOR+5

        LDA     #$90        ;Make time '     0'
        STA     TIME+5

REPEAT: LDA     #1          ;Stop the player (Just to make
        STA     STOP        ;sure!)
        LDA     #$08        ;Set up to read the consol
        STA     CONSOL      ;switches

WAIT:   LDA     CONSOL
        CMP     #SWSTRT     ;The other two switches -- Select
        BNE     WAIT1       ;and option, are not pressed down.

        JSR     MAKETP      ;If they are pressed down, make a
                            ;copy or this whole program
        JMP     BEGIN       ;And reset since the sound registers
                            ;will be messed up. . . .

WAIT1:  CMP     #6          ;Is the start switch pressed?
        BNE     WAIT        ;Nope. . . .

        LDA     #0          ;Yes. Start game (1)
        LDX     #6          ;Erase time and score but not
RESTR2: STA     TIME-1,X    ;high score.
        STA     SCORE-1,X
        DEX
        BNE     RESTR2

        LDA     #$91        ;Set the time left to '   120'
        STA     TIME+3
        LDA     #$92
        STA     TIME+4
        LDA     #$90
        STA     TIME+5

        LDA     #$10        ;Set the score to '     0'
        STA     SCORE+5

        LDA     #0          ;let the player shoot.
        STA     STOP
        STA     DSCOR       ;Clear out the vblank
        STA     JIFF        ;counters.
        STA     DSEC

;
;       Set up the PM graphics.
;

REDRAW: LDX     #$18        ;Start at lino 18,
        LDY     #0
CLOOP1: JSR     DPLANE      ;Draw 8 planes.
        INY
        CPY     #8
        BNE     CLOOP1


;
; Set up 30 second count down timer (used to time rounds)
;
        LDX     #7          ;30 secs = 1800 jiffies.
        LDY     #208
        LDA     #3          ;CDT # 3.
        STA     CDTMF3
        JSR     SETVBV

        LDA     #$C0        ;Re-enable DLI's
        STA     NMIEN

MAIN:   LDA     CDTMF3      ;Main loop -- if 30 seconds are
        BNE     MAIN2       ;up, draw another wave of planes.
        JMP     REDRAW
MAIN2:  LDY     #8          ;Check if all the planes have
        LDA     #0          ;been shot down (i.e. their
MAIN3:  ORA     TDX-1,Y     ;velocities are all zero)
        DEY
        BNE     MAIN3
        CMP     #0
        BNE     MAIN4
        LDA     #50         ;If so, player gets 60 points
        CLC
        ADC     DSCOR
        STA     DSCOR
        JMP     REDRAW          ;and a new round.

MAIN4:  LDA     STOP            ;Check if player is stopped.
        BEQ     MAIN            ;Nope.
                                ;Yes:
;
; Player died, so update high score
; and restart.
;

        LDA     RTCLOC+1        ;Wait 4 to 8 seconds
        CLC
        ADC     #2
HIW:    CMP     RTCLOC+1        ;for points to drain.
        BNE     HIW

        LDX     #0              ;Check his high score against
HICHK:  LDA     HISCOR,X        ;his current score.
        AND     #$1F            ;If his high score is anywhere
        CMP     SCORE,X         ;less than his current score
        BEQ     HICHK1          ;Equal
        BCS     NOHI            ;HI > score. Stop.
        JMP     NEWHI           ;HI < score.
HICHK1: INX                     ;NOTE: We check from left to right,
        CPX     #6              ;unlike the routines in VBIH.
        BNE     HICHK
NOHI:   JMP     REPEAT          ;So go and restart the game.

;
; Copy new high score
NEWHI:  LDX     #6              ;Copy all six digets of the
NEWHI1: LDA     SCORE-1,X       ;score into the high score,
        AND     #$1F            ;changing the color at the
        ORA     #$40            ;same time.
        STA     HISCOR-1,X
        DEX
        BNE     NEWHI1
        JMP     REPEAT          ;Then restart the game.

;
; DPLANE -- pick and draw a plane
;
XTEMP:  .BYTE   0               ;Temporary variables
YTEMP:  .BYTE   0               ;Used to save state of
TEMPA:  .BYTE   0               ;the processer.

DPLANE: STX     XTEMP           ;Save X
        STY     YTEMP           ;Save Y
DPLAN1: LDA     RANDOM          ;Get a random number
        AND     #7              ;reduce it to 0-7
        CMP     #6              ;Is it > 6 ?
        BCS     DPLAN1          ;Yes.  Pick another one.
        ASL     A               ;No.  Multiply by 4
        ASL     A
        TAX
        LDA     TPLANE,X        ;And use it to index into
        STA     TDX,Y           ;The tplane table for
        LDA     TPLANE+1,X      ;the velocity, the value.
        STA     TVAL,Y          ;the width, and the
        LDA     TPLANE+2,X      ;index into the plane
        STA     TWID,Y          ;picture table.
        LDA     #0
        STA     TPX,Y           ;Set the X position to 0.
        LDA     TPLANE+3,X      ;Get the index into the
        TAX                     ;picture table.
        LDY     XTEMP
        LDA     #8
        STA     TEMPA
DPLAN3: LDA     PTOL,X          ;Copy eight bytes from
        STA     MPMBAS+PMDP0,Y  ;the picture table to
        INX                     ;the player's defun space.
        INY
        DEC     TEMPA
        BNE     DPLAN3
        TYA                     ;Restore the processor
        TAX                     ;state, and return
        LDY     YTEMP           ;(X has had 0 added to it
        RTS                     ;so that the next plane
                                ;drawn will be one position
                                ;lower in the player's defun).
;
; Ascii character in A --> Screen internal character in A
; state saved and restored.
;
; (slightly modified from the internal
; Atari OS routine & uses ROM tables)

ASTEMP: .BYTE   0               ;Used to save the state of Y

ASTOIN: STY     ASTEMP          ;Save Y.
        TAY                     ;Copy A into Y
        TXA
        PHA                     ;Save X.
        TYA
        ROL     A               ;Get bits 6 & 5 or character
        ROL     A
        ROL     A
        ROL     A
        AND     #3
        TAX
        TYA
        AND     #$9F            ;Zero bits 6 & 5 of character
        ORA     $FEF6,X         ;and fill then with the bits
                                ;from the ROM table, giving
                                ;the internal (screen) code.

        TAY                     ;Restore X & Y registers.
        PLA
        TAX
        TYA
        LDY     ASTEMP
        RTS

;
;       Boot tape writer.  Writes out a Boot tape and returns.
;
MAKETP: LDX     #ICTWO          ;Choose IOCB two
        LDA     #CLOSE          ;Close it.
        STA     ICCOM,X
        JSR     CIOV
        LDA     #CAS^           ;Open the C: device.
        STA     ICBAH,X
        LDA     #CAS&$FF
        STA     ICBAL,X
        LDA     #OPEN
        STA     ICCOM,X
        LDA     #OPNOT          ;for output
        STA     ICAX1,X
        LDA     #$80            ;short IRQ
        STA     ICAX2,X
        JSR     CIOV
        LDA     #PST&$FF        ;Write out the program in
        STA     ICBAL,X         ;one fell swoop (using a
        LDA     #PST^           ;block putchar)
        STA     ICBAH,X
        LDA     #<PND-PST>&$FF
        STA     ICBLL,X
        LDA     #<PND-PST>^
        STA     ICBLH,X
        LDA     #PUTCHR
        STA     ICCOM,X
        JSR     CIOV
        LDA     #CLOSE          ;Close cassette buffer
        STA     ICCOM,X
        JSR     CIOV
        RTS
CAS:    .ASCII  "C:"            ;Name of cassette device.
        .BYTE   EOL

PND = .                         ;Used by MAKETP to figure
                                ;out what to save. Must
                                ;point to just after last
                                ;byte of program.
        .END
