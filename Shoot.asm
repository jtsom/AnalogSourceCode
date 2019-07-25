1                           ;-*-MIDAS-*-
2                                   .ENABLE LC
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

     E000               CHRORG  =       $E000   ;CHARACTER SET
     E400               VECTBL  =       $E400   ;VECTOR TABLE
     E4B0               VCTABL  =       $E480   ;RAM VECTOR INITIAL VALUE TABLE
     E4A8               CIOORG  =       $E4A6   ;CENTRAL I/O HANDLER
     E0D5               INTORG  =       $EC05   ;INTERRUPT HANDLER
     E344               SIOORG  =       $E344   ;SERIAL I/O HANDLER
     E0EA               DSKORG  =       $E0FA   ;DISK HANDLER
     EE76               PRNORG  =       $EE7B   ;PRINTER HANDLER
     EF41               CASORG  =       $EF41   ;CASSETTE HANDLER
     F0E3               MONORG  =       $F0E3   ;MONITOR/POWER UP MODULE
     F3E4               KBDORG  =       $F3E4   ;KEYBOARD/DISPLAY HANDLER
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
     E400               EDITRV  =       $E400   ;EDITOR
     E410               SCRENV  =       $E410   ;TELEVISION SCREEN
     E420               KEYBDV  =       $F420   ;KEYBOARD
     E430               PRINTV  =       $E430   ;PRINTER
     E440               CASETV  =       $E440   ;CASSETTE
                        ;
                        ;       JUMP VECTOR TABLE
                        ;
                        ;THE FOLLOWING IS A TABLE OF JUMP INSTRUCTIONS
                        ;TO VARIOUS ENTRY POINTS IN THE OPERATING SYSTEM
                        ;
     E450               DISKIV  =       $E450   ;disk initialization
     E453               DSKINV  =       $E453   ;disk interface
     E456               CIOV    =       $E456   ;central input output routine

     0000               ICZERO  =       $0      ;proper values for X
     0010               ICONE   =       $10     ;when calling CIOV for each
     0020               ICTWO   =       $20     ;of the IO control Blocks
     0030               ICTHRE  =       $30
     0040               ICFOUR  =       $40
     0060               ICFIVE  =       $50
     0060               ICSIX   =       $60
     0073               ICSEVE  =       $70

     E459               SIOV    =       $E459   ;serial input output routine
     E46C               SETVBV  =       $E45C   ;set system timers routine
                        ; With respect to SETVBV. the call sequence is
                        ; X = MSB of vector/timer
                        ; Y = LSB of vector/timer
                        ; A = # of vector to hack
     0001               SETMR1  =       1       ;Timer  1
     0002               SETMR2  =       2       ;       2
     0003               SETMR3  =       3       ;       3
     0004               SETMR4  =       4       ;       4
     0005               SETMR5  =       5       ;       5
     0006               SETIMM  =       6       ;Immediate VBLANK
     0007               SETDEF  =       7       ;Deffered VBLANK

     E45F               SYSVBV  =       $E45F   ;SYSTEM VERTICAL BLANK CALCULATIONS
     F462               XITVBL  =       $E462   ;EXIT VERTICAL BLANK CALCULATIONS
     E465               SIOINV  =       $E465   ;SERIAL INPUT OUTPUT INITIALIZATION
     E468               SENDEV  =       $E468   ;SEND ENABLE ROUTINE
     E46B               INTINV  =       $E46B   ;INTERRUPT HANDLER INITIALIZATION
     E46E               CIOINV  =       $E46E   ;CENTRAL INPUT OUTPUT INITIALIZATION
     E471               BLKBDV  =       $E471   ;BLACKBOARD MODE
     E474               VARMSV  =       $E474   ;WARM START ENTRY POINT
     E477               COLDSV  =       $E477   ;COLD START ENTRY POINT
     E47A               RBLOKV  =       $E47A   ;CASSETTE READ BLOCK ENTRY POINT VECTOR
     E47D               CSOPIV  =       $E470   ;CASSETTE OPEN TOR INPUT VECTOR
                        ;VCTABL =       $E480
                        ;
                        ;
                        ;       OPERATING SYSTEM EQUATES
                        ;
                        ;       COMMAND CODES FOR IOCBS
     0003               OPEN    =       3       ;OPEN FOR INPUT/OUTPUT
     0005               GETREC  =       5       ;GET RECORD (TEXT)
     0007               GETCHR  =       7       ;GET CHARACTER(S)
     0009               PUTREC  =       9       ;PUT RECORD (TEXT)
     000B               PUTCHR  =       $B      ;PUT CHARACTER(S)
     000C               CLOSE   =       $C      ;CLOSE DEVICE
     000D               STATIS  =       $D      ;STATUS REQUEST
     000E               SPECIL  =       $E      ;BEGINNING OF SPECIAL ENTRY COMMANDS
                        ;
                        ;       SPECIAL ENTRY COMMANDS
     0011               DRAWLN  =       $11     ;DRAW LINE
     0012               FILLIN  =       $12     ;DRAW LINE WITH RIGHT FILL
     0020               RENAME  =       $20     ;RENAME DISK FILE
     0021               DELETE  =       $21     ;DELETE DISK FILE
     0022               FORMAT  =       $22     ;FORMAT
     0023               LOCKFL  =       $23     ;LOCK FILE TO READ ONLY
     0024               UNLOCK  =       $24     ;UNLOCK LOCKED FILE
     0025               POINT   =       $25     ;POINT SECTOR
     0026               NOTE    =       $26     ;NOTE SECTOR
     00FF               IOCFRE  =       $FF     ;IOCB "FREE"
                        ;
                        ;       AUX1 EQUATES
                        ;       () INDICATES WHICH DEVICES USE BIT
     0001               APPEND  =       $1      ;OPEN FOR WRITE APPEND (D). OR SCREEN READ (E)
     0002               DIRECT  =       $2      ;OPEN FOR DIRECTORY ACCESS (D)
     0004               OPNIN   =       $4      ;OPEN FOR INPUT (ALL DEVICES)
     0008               OPNOT   =       $8      ;GPEN FOR OUTPUT (ALL DEVICES)
     000C               OPNINO  =       OPNIN+OPNOT     ;OPEN FOR INPUT AND OUTPUT (ALL DEVICES)
     0010               MXDMOD  =       $10     ;OPEN FOR MIXED MODE (E,S)
     0020               INSCLR  =       $20     ;OPEN WITHOUT CLEARING SCREEN (E,S)
                        ;
                        ;       DEVICE NAMES
                        ;
     0045               SCREDT  =       'E      ;SCREEN EDITOR (R/W)
     004B               KBD     =       'K      ;KEYBOARD (R ONLY)
     0053               DISPLY  =       'S      ;SCREEN DISPIAY (R/W)
     0050               PRINTR  =       'P      ;PRINTER (W ONLY)
     0043               CASSET  =       'C      ;CASSETTE
     004D               MODEM   =       'M      ;MODEM
     0044               DISK    =       'D      ;DISK
                        ;
                        ;
                        ;
                        ;
                        ;       OPERATING SYSTEM STATUS CODES
                        ;
     0001               SUCCES  =       $01     ;SUCCESSFUL OPERATION
                        ;
     0080               BRKABT  =       $80     ;BREAK KEY ABORT
     0081               PRVOPN  =       $81     ;IOCB ALREADY OPEN
     0082               NONDEV  =       $82     ;NON-EXISTANT DEVICE
     0083               VRONLY  =       $83     ;IOCB OPENED FOR WRITE ONLY
     0084               NVALID  =       $84     ;INVALID COMMAND
     0085               NOIOPN  =       $85     ;DEVICE OR FILE NOT OPEN
     0086               BADIOC  =       $86     ;INVALID IOCB NUMBER
     0087               RDONLY  =       $87     ;IOCB OPENED FOR READ ONLY
     0088               EOFERR  =       $88     ;END OF FILE
     0089               TRNRCD  =       $89     ;TRUNCATED RECORD
     008A               TIMOUT  =       $8A     ;PERIPHERAL TIME OUT
     008B               DNACK   =       $8B     ;DEVICE DOES NOT ACKNOWLEDGE COMMAND
     008C               FRMERR  =       $8C     ;SERIAL BUS FRAMING ERROR
     008D               CRSROR  =       $8D     ;CURSOR OVERRANGE
     008E               OVRRUN  =       $8E     ;SERIAL BUS DATA OVERRUN
     008F               CHKERR  =       $8F     ;SERIAL BUS CHECKSUM ERROR
                        ;
     0090               DERRER  =       $90     ;PERIPHERAL DEVICE ERROR (OPERATION NOT COMPLETED)
     0091               BADMOD  =       $91     ;BAD SCREEN MODE NUMBER
     0092               FNCNOT  =       $92     ;FUNCTION NOT IMPLEMENTED IN HANDLER
     0093               SCRMEM  =       $93     ;INSUFICIENT MEMORY FOR SCREEN MODE
                        ;
                        ;
                        ;
                        ;
                        ;
                        ;       PAGE ZERO RAM ASSIGNMENTS
                        ;
     0000               LINZBS  =       $0000   ;LINBUG RAM (WILL BE REPLACED BY MONITOR RAM)
                        ;
                        ;       THESE LOCATIONS ARE NOT CLEARED
     0002               CASINI  =       $0002   ;CASSETTE INIT LOCATION
     0004               RAMLO   =       $0004   ;RAM POINTER FOR MEMORY TEST
     0006               TRAMSZ  =       $0006   ;TEMPORARY REGISTER FOR RAM SIZE
     0007               TSTDAT  =       $0007   ;RAM TEST DATA REGISTER
                        ;
                        ;       CLEARED ON COLD START ONLY


     0008               WARMST  =       $0008   ;WARM START FLAG
     0009               BOOTQ   =       $0009   ;SUCCESSFUL BOOT FLAG <WAS BOOT?>
     000A               DOSVEC  =       $000A   ;DISK SOFTWARE START FLAG
     000C               DOSINI  =       $000C   ;DISK SOFTWARE INIT ADDRESS
     000E               APPMHI  =       $000E   ;APPLICATIONS MEMORY HI LIMIT
                        ;
                        ;       CLEARED ON A COLD OR WARM START
     0010               INTZBS  =       $0010   ;INTERRUPT HANDLER
     0010               POKMSK  =       $0010   ;SYSTEM MASK FOR POKEY IRQ HANDLER
     0011               BRKKEY  =       $0011   ;BREAK KEY FLAG
     0012               RTCLOCK =       $0012   ;REAL TIME CLOCK (IN 16 MSEC UNITS)
                        ;
     0015               BUFADR  =       $0015   ;INDIRECT BUFFER ADDRESS REGISTER
                        ;
     0017               ICCOMT  =       $0017   ;COMMAND FOR VECTOR
                        ;
     0018               DSKFMS  =       $0018   ;DISK FILE MANAGER POINTER
                        ;
     001A               DSKUTL  =       $001A   ;DISK UTILITIES POINTER
                        ;
     001C               PTIMOT  =       $001C   ;PRINTER TIME OUT REGISTER
     0010               PBPNT   =       $001D   ;PRINTER BUFFER POINTER
     001E               PBUFSZ  =       $001E   ;PRINT BUFFER SIZE
     001F               PTEMP   =       $001F   ;TEMPORARY REGISTER
                        ;
     0020               ZIOCB   =       $0020   ;ZERO PAGE I/O CONIROL BLOCK
     0010               IOCBSZ  =       16      ;NUMBER OF BYTES PER IOCB
     0080               MAXIOC  =       8*IOCBSZ        ;LENGTH OF THE IOCB AREA
     0020               IOCBAS  =       $0020
     0020               ICHIDZ  =       $0020   ;HANDLER INDEX NUMBER (FF == IOCB FREE)
     0021               ICDNOZ  =       $0021   ;DEVICE NUMBER (DRIVE NUMBER)
     0022               ICCOMZ  =       $0022   ;COMMAND CODE
     0023               ICSTAZ  =       $0023   ;STATUS OF LAST IOCB ACTION
     0024               ICBALZ  =       $0024   ;BUFFER ADDRESS LOW BYTE
     0025               ICBAHZ  =       $0025   ;BUFFER ADDRESS HIGH BYTE
     0026               ICPTLZ  =       $0026   ;PUT BYTE ROUTINE ADDRESS - 1
     0027               ICPTHZ  =       $0027   ;
     0028               ICBLLZ  =       $0028   ;BUFFER LENGTH LOW BYTE
     0029               ICBLHZ  =       $0029
     002A               ICAX1Z  =       $002A   ;AUXILIARY INFORMATION FIRST BYTE
     002B               ICAX2Z  =       $002B
     002C               ICSPRZ  =       $002C   ;TWO SPARE BYTES (CIO LOCAL USE)
     002E               ICIDNO  =       ICSPRZ+2        ;IOCB NUMBER X 16
     002F               CIOCHR  =       ICSPRZ+3        ;CHARACTER BYTE FOR CURRENT OPERATION
                        ;
     0030               STATUS  =       $0030   ;INTERNAL STATUS STORAGE
     0031               CHKSUM  =       $0031   ;CHECKSUM (SINGLE BYTE SUM WITH CARRY)
     0032               BUFRLO  =       $0032   ;POINTER TO DATA BUFFER (LO BYTE)
     0033               BUFRHI  =       $0033   ;POINTER TO DATA BUFFER (HI BYTE)
     0034               BFENLO  =       $0034   ;NEXT BYTE PAST END OF DATA BUFFER (LO BYTE)
     0035               BFENHI  =       $0035   ;NEXT BYTE PAST EHD OF DATA BUFFER (HI BYIE)
     0036               CRETRY  =       $0036   ;NUMBER OF COMMAND FRAME RETRIES
     0037               ORETRY  =       $0037   ;NUMBER OF DEVICE RETRIES
     0038               BUFRFL  =       $0038   ;DATA BUFFER FULL FLAG
     0039               RECVDN  =       $0039   ;RECIEVE DONE FLAG
     003A               XMTDON  =       $003A   ;TRANSMISSION DONE FLAG
     003B               CHKSNT  =       $003B   ;CHECKSUM SENT FLAG
     003C               NOCKSM  =       $003C   ;NO CHECKSUM FOLLOWS DATA FLAG
                        ;
                        ;
     003D               BPTR    =       $003D
     003E               FTYPE   =       $003E
     003F               FEOF    =       $003F
     0040               FREQ    =       $0040
     0041               SOUNDR  =       $0041   ;NOISY I/O FLAG (ZERO IS QUIET)
     0042               CRITIC  =       $0042   ;DEFINES CRITICAL SECTION (CRITICAL IF NON-ZERO)
                        ;
     0043               FMSZPG  =       $0043   ;TOTAL OF 7 BYTES FOR DISK FILE MANAGER ZERO PAGE
                        ;
                        ;
     004A               CKEY    =       $004A   ;FLAG SET WHEN GAME START PRESSED
     004B               CASSBT  =       $0048   ;CASSETTE BOOT FLAG
     004C               DSTAT   =       $004C   ;DISPLAY STATUS
                        ;
     004D               ATRACT  =       $004D   ;ATRACT FLAG
     004E               DRKMSK  =       $004E   ;DARK ATRACT FLAG
     004F               COLRSH  =       $004F   ;ATRACT COLOR SHIFTER (EOR'D WITH PLAYFIELD COLORS)
                        ;
                        ;LEDGE  =       2       ;LMARGN'S VALUE AT COLD START
                        ;REDGE  =       39      ;
     0050               TMPCHR  =       $0050
     0051               HOLD1   =       $0051
     0052               LMARGN  =       $0052   ;LEFT MARGIN (SET TO ONE AT POWER ON)
     0053               RMARGN  =       $0053   ;RIGHT MARGIN (SET TO ONE AT POWER ON)
     0054               ROWCRS  =       $0054   ;CURSOR COUNTERS
     0055               COLCRS  =       $0055
     0057               DINDEX  =       $0057
     0058               SAVMSC  =       $0056
     005A               OLDROW  =       $005A
     005B               OLDCOL  =       $005B
     005D               OLDCHR  =       $005D   ;DATA UNDER CURSOR
     005E               OLDADR  =       $005E
     0060               NEWROW  =       $0060   ;POINT DRAW GOES TO
     0061               NEWCOL  =       $0061
     0063               LOGCOL  =       $0063   ;POINTS AT COLUMN IN LOGICAL LINE
     0004               AORESS  =       $0064
     0066               MLTTMP  =       $0066
     0068               SAVADR  =       $0068
     006A               RAMTOP  =       $006A   ;RAM SIZE DEFINED BY POWER ON LOGIC
     006B               BUFCNT  =       $006B   ;BUFFER COUNT
     006C               BUFSTR  =       $006C   ;EDITOR GETCH POINTER
     006E               BITMSK  =       $006E   ;BIT MASK
                        ; LOTS OF RANDOM TEMPS
     007B               SWPFLG  =       $007B   ;NON-0 IF TXT AND REGULAR RAM IS SWAPPED
     007C               HOLDCH  =       $007C   ;CH IS MOVED HERE IF KGETCH BEfore CNTL & SHIFT PROC
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
     0200               INTABS  =       $0200   ;INTERRUPT RAM

     0200               VDBLST  =       $0200   ;DISPLAY LIST NMI VECTOR
     0202               VPRCED  =       $0202   ;PROCEED LINE IRQ VECTOR
     0204               VINTER  =       $0204   ;INTERRUPT LINE IRQ VECTOR
     0206               VBREAK  =       $0206   ;SOFTWARE BREAK (00) INSTRUCTION IRQ VECTOR
     0208               VKEYBD  =       $0208   ;POKEY KEYBOARD IRQ VECTOR
     020A               VSERIN  =       $020A   ;POKEY SERIAL INPUT READY IRQ
     020C               VSEROR  =       $020C   ;POKEY SERIAL OUTPUT READY IRQ
     020E               VSEROC  =       $020E   ;POKEY SERIAL OUTPUT COMPLETE IRQ
     0210               VTIMR1  =       $0210   ;POKEY TIMER 1 IRQ
     0212               VTIMR2  =       $0212   ;POKEY TIMER 2 IRQ
     0214               VTIMR4  =       $0214   ;POKEY TIMER 4 IRQ
     0216               VIMIRQ  =       $0216   ;IMMEDIATE IRQ VECTOR
     0218               CDTMV1  =       $0218   ;COUNT DOWN TIMER 1
     021A               CDTMV2  =       $021A   ;COUNT DOWN TIMER 2
     021C               CDTMV3  =       $021C   ;COUNT DOWN TIMER 3
     021E               CDTMV4  =       $021E   ;COUNT DOWN TIMER 4
     0220               CDTMV6  =       $0220   ;COUNT DOWN TIMER 5
     0222               VVBLKI  =       $0222   ;IMMEDIATE VERTICAL BLANK NMI VECTOR
     0224               VVBLKD  =       $0224   ;DEFERRED VERTICAL BLANK NMI VECTOR
     0226               CDTMA1  =       $0226   ;COUNT DOWN TIMER 1 JSR ADDRESS
     0228               CDTMA2  =       $0228   ;COUNT DOWN TIMER 2 JSR ADDRESS
     022A               CDTMF3  =       $022A   ;COUNT DOWN TIMER 3 FLAG
     022B               SRTIMR  =       $022B   ;SOFTWARE REPEAT TIMER
     022C               CDTMF4  =       $022C   ;COUNT DOWN TIMER 4 FLAG
     022E               CDTMF5  =       $022E   ;COUNT DOWN TIMER 5 FLAG
     022F               SDMCTL  =       $022F   ;SAVE DMACTL REGISTER
     0230               SDLSTL  =       $0230   ;SAVE DISPLAY LIST LOW BYTE
     0231               SDLSTH  =       $0231   ;SAVE DISPLAY LIST HIGH BYTE
     0232               SSKCTL  =       $0232   ;SKCTL REGISTER RAM
                        ;
     0234               LPENH   =       $0234   ;LIGHT PEN HORIZONTAL VALUE
     0235               LPENV   =       $0235   ;LIGHT PEN VERTICAL VALUE

     026F               GPRIOR  =       $26F    ;Global priority call
                        ;
                        ;
                        ;       POTENTIOMETERS
                        ;
                        ;
     0270               PADDL0  =       $0270
     0271               PADDL1  =       $0271
     0272               PADDL2  =       $0272
     0273               PADDL3  =       $0273
     0274               PADDL4  =       $0274
     0275               PADDL5  =       $0275
     0276               PADDL6  =       $0276
     0277               PADDL7  =       $0277
                        ;
                        ;
                        ;       JOYSTICKS
                        ;
                        ;
     0278               STICK0  =       $0278
     0279               STICK1  =       $0279
     027A               STICK2  =       $027A
     027B               STICK3  =       $027B
                        ;
                        ;
                        ;       PADDLE TRIGGER
                        ;
                        ;
     027C               PTRIG0  =       $027C
     027D               PTRIG1  =       $027D
     027E               PTR1G2  =       $027E
     027F               PTRIG3  =       $027F
     0280               PTRIG4  =       $0280
     0281               PTRIG5  =       $0281
     0282               PTRIG6  =       $0282
     0283               PTRIG7  =       $0283
                        ;
                        ;
                        ;       JOYSTICK TRIGGER
                        ;
                        ;
     0284               STRIG0  =       $0284
     0285               STRIG1  =       $0285
     0286               STRIG2  =       $0286
     0287               STRIG3  =       $0287
                        ;
                        ;       Many random OS variables, the following were commented
                        ;
     0290               TXTROW  =       $0290   ;Text rowcrs
     0291               TXTCOL  =       $0291   ;Text colcrs
     0293               TINDEX  =       $0293   ;text index
     0294               TXTMSC  =       $0294   ;fools convert into new msc
     0296               TXTOLD  =       $0296   ;oldrow and oldcol for text (etc.)
     02A2               ESCFLG  =       $02A2   ;Escape flag
     02B2               LOGMAP  =       $02B2   ;Logical line start bit map
     02B6               INVFLAG =       $02B6   ;Inverse video flag (toggled by Atari key)
     02B7               FILFLG  =       $02B7   ;Fill flag for draw
     02B6               SCRFLG  =       $02B8   ;Set if scroll occures
     02BE               SHFLOK  =       $02BE   ;Shift lock
     02BF               BOTSCR  =       $02BF   ;Bottom of screen: 24 Norm. 4 Split.
                        ;
                        ;
                        ;       COLORS
                        ;
                        ;
     02C0               PCOLR0  =       $02C0   ;P0 COLOR
     02C1               PCOLR1  =       $02C1   ;P1 COLOR
     02C2               PCOLR2  =       $02C2   ;P2 COLOR
     02C3               PCOLR3  =       $02C3   ;P3 COLOR
     02C4               COLOR0  =       $02C4   ;COLOR 0
     02C5               COLOR1  =       $02C5   ;COLOR 1
     02C6               COLOR2  =       $02C6   ;COLOR 2
     02C7               COLOR3  =       $02C7   ;COLOR 3
     02C6               COLOR4  =       $02C8   ;COLOR 4
                        ;
                        ;
                        ;       GLOBAL VARIABLES
                        ;
                        ;
     02E4               RAMSIZ  =       $02E4   ;RAM SIZE (HI BYTE ONLY)
     02E5               MEMIOP  =       $0215   ;TOP OF AVAILABLE USER MEMORY
     02E7               MEMLO   =       $02E7   ;BOTTOM OF AVAILABLE USER MEMORY
     02EA               DVSTAT  =       $02EA   ;STATUS BUFFER
                        ;
     02F0               CRSINH  =       $02F0   ;CURSOR INHIBIT (00 = CURSOR ON)
     02F1               KEYDEL  =       $02F1   ;Key delay
     02F3               CHACT   =       $02F3   ;CHACTL REGISTER RAM
     02F4               CHBAS   =       $02F4   ;CHBAS REGISTER RAM
     02FD               FILDAT  =       $02FD   ;RIGHT FILL DATA (DRAW)
     02FB               ATACHR  =       $02FB   ;Atascii character
     02FC               CM      =       $02FC   ;global variable for keyboard
     02FE               DSPFLA  =       $02FE   ;DISPLAY FLAG: DISPLAYS CNTLS IF NON ZERO:
     02FF               SSFLAG  =       $02FF   ;Start/stop flag for paging (CNTL 1). Cleared by Break

                        ;
                        ;       Page three RAM assignments
                        ;
                        ;       Device control blocks
                        ;       (SIO)
     0300               DCB     =       $0300   ;Device control block
     0300               DDEVIC  =       $0300   ;Peripheral Unit 1 bus I.D. number
     0301               DUNIT   =       $0301   ;Unit number
     0302               DCOMND  =       $0302   ;Bus command
     0303               DSFATS  =       $0303   ;Command Type/status return
     0304               DBUFLO  =       $0304   ;Data buff- points low
     0305               DBUFHI  =       $0305
     0306               DTIMLO  =       $0306   ;Device time out in 1 second units
     0308               DBYTLO  =       $0308   ;Number of bytes to be transvered low byte
     0309               DBYTHI  =       $0309
     030A               DAUX1   =       $030A   ;Command Aux byte 1
     0308               DAUX2   =       $0308
                        ;
     0340               IOCB    =       $0340
     0340               ICHID   =       $0340   ;Handler index number (FF = IOCB free)
     0341               ICDNO   =       $0341   ;Device number (drive number)
     0342               ICCOM   =       $0342   ;Command code
     0343               ICSTA   =       $0343   ;Status of last IOCB action
     0344               ICBAL   =       $0344   ;Buffer address low byte
     0345               ICBAH   =       $0345
     0346               ICPTL   =       $0346   ;Put byte routine address - 1
     0347               ICPTH   =       $0347
     0348               ICBLL   =       $0348   ;Buffer length low byte
     0349               ICBLH   =       $0349
     034A               ICAX1   =       $034A   ;Auxiliary information first byte
     0348               ICAX2   =       $034B
     034C               ICSPR   =       $034C   ;four spare bytes

                        ;
     03C0               PRNBUF  =       $0300   ;Printer buffer (40 bytes)
                        ;       (21 spare bytes)
                        ;
                        ;       Page Four Ram Assignnents
     03FD               CASBUF  =       $03FD   ;Cassette Buffer (131 bytes)
                        ;
     0480               USAREA  =       $0480   ; (0480 thru 05FF for the user)
                        ;                         (except for floating point...)
                        ;
                        ;       FLOATING POINT ROM ROUTINES
                        ;
                        ;
                        ;       IF CARRY IS USED THEN CARRY CLEAR => NO ERROR. CARRY SET => ERROR
                        ;
     D800               AFP     =       $D800   ;ASCII -> FLOATING POINT (FP)
                        ;                       INBUFF * CIX -> FR0, CIX, CARRY
     D8E6               FASC    =       $D8E6   ;FP -> ASCII FR0 -> F0R,FD0-1, CARRY
     D9AA               IFP     =       $D9AA   ;INTEGER -> FP
                        ;                       0-$FFFF (LSB, MSB) IN FR0,FR0+1->FR0
     D92D               FPI     =       $D92D   ;FP -> INTEGER  FR0 -> FR0,FR0+1, CARRY
     DA60               FSUB    =       $DA60   ;FR0 <- FR0 - FR1, CARRY
     DA66               FADD    =       $DA66   ;FR0 <- FR0 + FR1  ,CARRY
     DADB               FMUL    =       $DADB   ;FR0 <- FR0 * FR1  ,CARRY
     DB28               FDIV    =       $DB28   ;FR0 <- FR0 / FR1  ,CARRY
     DD89               FLD0R   =       $DD89   ;FLOATING LOAD REG0     FR0 <- (X,Y)
     DD80               FLD0P   =       $DD8D   ;                       FR0 <- (FLPTR)
     DD98               FLD1R   =       $DD9B   ;                       FR1 <- (X,Y)
     DD9C               FLD1P   =       $DD9C   ;                       FR1 <- (FLPTR)
     DDA7               FST0R   =       $DDA7   ;FLOATING STORE REG0  (X,Y) <- FR0
     DDAB               FST0P   =       $DDAB   ;                   (FLTPTR)<- FR0
     DDB6               FMOVE   =       $DDB6   ;FR1 <- FR0
     DD40               PLYEVL  =       $DD40   ;FR0 <- P(Z) = SUM(I = N TO 0) (A(I) *Z**I) CARRY

                        ;                       INPUT:  (X,Y) = A(N), A(N-I)...A(0) -> PLYARG
                        ;                               ACC   = # OF COEFFICIENTS = DEGREE + 1
                        ;                               FR0   = Z
     DDC0               EXP     =       $DDC0   ;FR0 <- E**FR0 = EXP10(FR0 * LOG10(E)) CARRY
     DDCC               EXP10   =       $DDCC   ;FR0 <- 10**FR0 CARRY
     DECD               LOG     =       $DECD   ;FR0 <- LN(FR0) = LOG10(FR0) / LOG10(E) CARRY
     DE01               LOG10   =       $DE01   ;FR0 <- LOG10(FR0) CARRY
                        ;
                        ;
                        ;       THE FOLLOWING ARE IN THE BASIC CARTRIDGE:
                        ;
                        ;
     BD81               SIN     =       $BD81   ;FR0 <- SIN(FR0) DEGFLG=0 => RADS, 6->DEG. CARRY

     BD73               COS     =       $BD73   ;FR0 <- COS(FR0)        CARRY
     BD43               ATAN    =       $BD43   ;FR0 <- ATN(FR0)        CARRY
     BEB1               SQR     =       $BEB1   ;FR0 <- SQUAREROOT(FR0) CARRY
                        ;
                        ;
                        ;       FLOATING POINT ROUTINES ZERO PAGE (NEEDED ONLY IF F.P.
                        ;               ROUTINES ARE CALLED)
     00D4               FR0     =       $00D4   ;FP REG0
     00E0               FR1     =       $00E0   ;FP REG1
     00F2               CIX     =       $00F2   ;CURRENT INPUT INDEX
     00F3               INBUFF  =       $00F3   ;POINTS TO USER'S LINE INPUT BUFFER
     00FB               RADFLG  =       $00FB   ;0 = RADIANS, 6 = DEGREES
     00FC               FLTPTR  =       $00FC   ;POINTS TO USERS FLOATING POINT NUMBER
                        ;
                        ;
                        ;       FLOATING POINT ROUTINES' NON-ZP RAM
                        ;
                        ;       (057E to 06FF)
                        ;
     0580               LBUFF   =       $0580   ;LINE BUFFER
     05E0               PLYARG  =       LBUFF+$60       ;POLYNOMILA ARGUMENTS
                        ;
                        ;
                        ;
                        ;
                        ;
                        ;       COLLEEN MNEMONICS
                        ;
                        ;
                        ;
     D200               POKEY   =       $D200       ;VBLANK ACTION:         DESCRIPTION:
     D200               POT0    =       POKEY+0     ;POT0-->PADDL0          0-227 IN RAM CELL
     D201               POT1    =       POKEY+1     ;POT1-->PADDL1          0-227 IN RAM CELL
     D202               POT2    =       POKEY+2     ;POT2-->PADDL2          0-227 IN RAM CELL
     D203               POT3    =       POKEY+3     ;POT3-->PADDL3          0-227 IN RAM CELL
     D204               POT4    =       POKEY+4     ;POT4-->PADDL4          0-227 IN RAM CELL
     D205               POTS    =       POKEY+5     ;POT5-->PADDL5          0-227 IN RAM CELL
     D206               POTC    =       POKEY+6     ;POT6-->PADDL8          0-227 IN RAM CELL
     D207               POT7    =       POKEY+7     ;POT7-->PADDL7          0-227 IN RAM CELL
     D208               ALLPOT  =       POKEY+8     ;???
     D209               KBCODE  =       POKEY+9
     D20A               RANDOM  =       POKEY+10
     D20B               POTGO   =       POKEY+11    ;Strobed
                        ;               n/a
     D20D               SERIN   =       POKEY+13
     D20E               IRQST   =       POKEY+14
     D20F               SKSTAT  =       POKEY+15
                        ;
     D200               AUDF1   =       POKEY+0
     D201               AUDC1   =       POKEY+1
     D202               AUDF2   =       POKEY+2
     D203               AUDC2   =       POKEY+3
     D204               AUDF3   =       POKEY+4
     D205               AUDC3   =       POKEY+5
     D206               AUDF4   =       POKEY+6
     D207               AUDC4   =       POKEY+7
     D208               AUDCT   =       POKEY+8     ;NONE                   AUDCTL<--[SIO]
     D209               STIMER  =       POKEY+9
     D20A               SKRES   =       POKEY+10    ;NONE                   SKRES<--[SIO]
                        ;
     D20B               POTGO   =       POKEY+11
     D20D               SEROUT  =       POKEY+13    ;NONE                   SEROUT<--[SIO]
     D20E               IRQEN   =       POKEY+14    ;POKMSK-->IRQEN (AFFECTED BY OPEN S: OR E:)
     D20F               SKCTL   =       POKEY+16    ;SSKCTL-->SKCTL          SSKCTL<--[SIO]
                        ;
     D000               CTIA    =       $D000
     D000               HPOSP0  =       CTIA+0
     D001               HPOSP1  =       CTIA+1
     D002               HPOSP2  =       CTIA+2
     D003               HPOSP3  =       CTIA+3
     D004               HPOSM0  =       CTIA+4
     D005               HPOSM1  =       CTIA+5
     D006               HPOSM2  =       CTIA+6
     D007               HPOSM3  =       CTIA+7
     D008               SIZEP0  =       CTIA+8
     D009               SIZEP1  =       CTIA+9
     D00A               SIZEP2  =       CTIA+10
     D00B               SIZCP3  =       CTIA+11
     D00C               SIZEM   =       CTIA+12
     D00D               GRAFP0  =       CTIA+13
     D00E               GRAFP1  =       CTIA+14
     D00F               GRAFP2  =       CTIA+15
     D010               GRAFP3  =       CTIA+16
     D011               GRAFM   =       CTIA+17
     D012               COLPM0  =       CTIA+18 ;PCOLR0-->COLPM0     WITH ATTRACT MODE
     D013               COLPM1  =       CTIA+19 ;ETC.N
     D014               COLPM2  =       CTIA+20
     D015               COLPM3  =       CTIA+21
     D016               COLPF0  =       CTIA+22
     D017               COLPF1  =       CTIA+23
     D018               COLPF2  =       CTIA+24
     D019               COLPF3  =       CTIA+25
     D01A               COLBK   =       CTIA+26
     D01B               PRIOR   =       CTIA+27
     D01C               VDELAY  =       CTIA+28
     D01D               GRACTL  =       CTIA+29
     D01E               HITCLR  =       CTIA+30
     D01F               CONSOL  =       CTIA+31 ;$08-->CONSOL        TURN OFF SPEAKER
                        ;
     D000               M0PF    =       CTIA+0
     D002               M2PF    =       CTIA+2
     D003               M3PF    =       CTIA+3
     D004               P0PF    =       CTIA+4
     D005               P1PF    =       CTIA+5
     D006               P2PF    =       CTIA+6
     D007               P3PF    =       CTIA+7
     D008               M0PL    =       CTIA+8
     D009               M1PL    =       CTIA+9
     D00A               M2PL    =       CTIA+10
     D00B               M3PL    =       CTIA+11
     D00C               P0PL    =       CTIA+12
     D00D               P1PL    =       CTIA+13
     D00E               P2PL    =       CTIA+14
     D00F               P3PL    =       CTIA+15
     D010               TRIG0   =       CTIA+16         ;TRIG0-->STRIG1
     D011               TRIG1   =       CTIA+17         ;ETC.
     D012               TR1G2   =       CTIA+18
     D013               TRIG3   =       CTIA+19
     D014               PAL     =       CTIA+20
                        ;
     D400               ANTIC   =       $D400
     D400               DMACTL  =       ANTIC+0         ;DMACTL<--SDMCTL  ON OPEN S: OR E:
     D401               CHARCTL =       ANTIC+1         ;CHACTL<--CHACT   ON OPEN S: OR E:
     D402               DLISTL  =       ANTIC+2         ;DIISTt<--SDLSTL  ON OPEN S: OR E:
     D403               DLISTH  =       ANTIC+3         ;OLISFH<--SDLSTH  ON OPEN S: OR E:
     D404               HSCROL  =       ANTIC+4
     D405               VSCROL  =       ANTIC+5
     D407               PMBASE  =       ANTIC+7
     D409               CHBASE  =       ANTIC+9         ;CMBASE<--CHBAS   ON OPEN S: OR E:
     D40A               WSYNC   =       ANTIC+10
     D408               VCOUNT  =       ANTIC+11
     D40C               PENH    =       ANTIC+12
     D40D               PENV    =       ANTIC+13
     D40E               NMIEN   =       ANTIC+14        ;NMIEN<--40       POWER ON AND [SETVBV]
     D40F               NMIRES  =       ANTIC+15        ;STROBED
     D40F               HMIST   =       ANTIC+15
                        ;
                        ;       Lots and lots of unofficial
                        ;       Mnemonics for display list instructions.
                        ;       as well as other bit patterns.
                        ;
                        ;       DL prefix implies display list
                        ;       instruction, naturally
                        ;
     0000               DLBL1   =       0       ; One blank line
     0010               DLBL2   =       $10     ; Two blank lines
     0020               DLBL3   =       $20     ; Three
     0030               DLBL4   =       $30     ; Four
     0040               DLBL5   =       $40     ; Five
     0050               DLBL6   =       $50     ; Six
     0060               DLBL7   =       $60     ; Seven
     0070               DLBL8   =       $70     ; Eight blank lines

     0080               DLINT   =       $80     ; Generate DisplayListInterrupt when this
                                                ; instruction is interpreted.
     0001               DLJMP   =       $1      ; Tells Antic Chip to junp to contents of next two bytes
     0041               DLJVB   =       $41     ; Same as DLJMP but also halts ANTIC 'till next verticle blank
     0040               DLLDM   =       $40     ; Tells Antic chip to start retrieving data from memory referenced by the next t
     0020               DLVSCR  =       $20     ; (sort of) enables vertical scroll
     0010               DLHSCR  =       $10     ; enable horizontal scroll
                        ;
                        ;       Playfield Instructions
                        ;
     000F               DLPF15  =       15      ; 320 dots  2 colors  1 scan line
     000E               DLPF14  =       14      ; 160       4         1
     000D               DLPF13  =       13      ; 160       4         2
     000C               DLPF12  =       12      ; 160       2         1
     000B               DLPF11  =       11      ; 160       2         2
     000A               DLPF10  =       10      ; 80        4         4
     0009               DLPF9   =       9       ; 80        2         4
     0008               DLPF8   =       8       ; 40        4         8

                        ; Character PF types

     0007               DLPF7   =       7       ; 20 chars  5 colors  16 scan lines
     0006               DLPF6   =       6       ; 20        5         8
     0005               DLPF5   =       5       ; 40        5         16 (hairy 4 color characters)
     0004               DLPF4   =       4       ; 40        5         8
     0003               DLPF3   =       3       ; 40        2         10 (Text processing)
     0002               DLPF2   =       2       ; 40        2         8 (Normal text mode)

                        ; PF1 & PF0 are special. . . .

                        ;
                        ;       Player & Missile Offsets
                        ;       Denoted by PM prefix
                        ;
     0024               PMLF    =       $24     ;left side of screen
     00DD               PMRF    =       $DD     ;flight side of screen
     0180               PMDM    =       $180    ;Missile offset, for double line resolution
     0200               PMDP0   =       $200    ;Player 0
     0280               PMDP1   =       $280    ;Player 1
     0300               PMDP2   =       $300    ;Player 2
     0380               PMDP3   =       $380    ;Player 3
     0300               PMSM    =       2*PMDM  ;Missile offset for single line resolution
     0400               PMSP0   =       2*PMDP0 ;Player 0
     0500               PMSP1   =       2*PMDP1 ;       1
     0600               PMSP2   =       2*PMDP2 ;       2
     0700               PMSP3   =       2*PMDP3 ;       3

                        ;
                        ;       Colors. denoted by CL
                        ;
     0000               CLGREY  =       0       ;grey
     0010               CLGOLD  =       $10     ;gold
     0020               CLORNG  =       $20     ;orange
     0030               CLRED   =       $30     ;red-orange
     0040               CLPINK  =       $40     ;pink
     0050               CLPURP  =       $50     ;purple
     0060               CLPURB  =       $60     ;purple blue
     0070               CLPBLU  =       $70     ;blue 1
     0080               CLBLUE  =       $80     ;blue 2
     0090               CLLBLU  =       $90     ;light blue
     00A0               CLTURQ  =       $A0     ;turquoise
     00B0               CLGBLU  =       $B0     ;green blue
     00C0               CLGREN  =       $C0     ;green
     0000               CLYGRN  =       $D0     ;yellow green
     00E0               CLOGRN  =       $E0     ;orange green
     00F0               CLLTOR  =       $F0     ;light orange
                        ;       Bit Masks for console switches
                        ;
     0001               SWSTRT  =       $1      ;Start
     0002               SWSEL   =       $2      ;Select
     0004               SWOPT   =       $4      ;Option

                        ;       Joystick bit masks

     0008               JYR     =       8       ;Right
     0004               JYL     =       4       ;Left
     0002               JYB     =       2       ;Back
     0001               JYF     =       1       ;Forward

     D300               PIA     =       $D300
     D300               PORTA   =       PIA+0   ;PORTA-->STICK0,1    X-Y CONTROLLERS
     D301               PORTB   =       PIA+1   ;PORTB-->STICK2,3
     D302               PACTL   =       PIA+2   ;NONE                PACTL<--3C [INIT]
     D303               PBCTL   =       PIA+3   ;NONE                PBCTL<--3C [INIT]
     0030               ASCZER  =       '0      ;Ascii zero
     003A               COLON   =       $3A     ;Ascii Colon
     009B               EOL     =       $9B     ;End of Record

                        ; The Following are subroutines

     F385               PUTLIN  =       $F385   ;X -- Lo byte
                                                ;Y -- Hi byte
                                                ;of line

     E7D1               XVB     =       $E7D1   ;System VBLANK exit routine
                        ;
                        ;
                        ;
                        ;               End of Atari equates.
                        ;
                        ;       The rest of this is (C)1981 John H. Palevich
                        ;
                        ;
     1000               ORG     =       $1000           ;Must be at least 3K of memory
                                                        ;above this point. . . .
     1000               .=ORG
                                    ;Once in the actual game you can make
                                    ;identical copies of it by pressing OPTION
                                    ;and SELECT down simultaneously between
                                    ;plays.  The Atari will beep twice and you
                                    ;should press play & record and then RETURN
                                    ;to make a copy.  After one copy is made
                                    ;the game starts all over again.
     1000               PST=.
                        ;
                        ;       This is the Boot tape header table.
                        ;
1000   00                       .BYTE   0               ;Traditional
1001   09                       .BYTE   PND-PST+127/128 ;# of 128 byte blocks in program
1002   00   10                  .ADDR   PST             ;Start of place to load program
1004   08   10                  .ADDR   PINIT           ;Place to jump after loading
                                                        ;program

                        ; ENTRY POINT FOR MULTI-STAGE BOOT PROCESS.

1006   18                       CLC
1007   60                       RTS

                        ; ENTRY POINT FOR FIRST TIME INITIALIZATION
1008   A9   3C          PINIT:  LDA     #$3C
100A   8D   02   D3             STA     PACTL   ;turn off cassete motor

100D   A9   16                  LDA     #RESTRT&$FF     ;Shove the restrt vector into
100F   85   0A                  STA     DOSVEC          ;the DOS vector.
1011   A9   10                  LDA     #RESTRT^
1013   85   0B                  STA     DOSVEC+1
1015   60                       RTS


                        ;       WARMSTART ENTRY POINT
                        ;
1016   4C   4E   12     RESTRT: JMP     BEGIN

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
     00B0               DLIC    =       $B0 ;Counter of display list interrupts
     00B1               DSCOR   =       $B1 ;Delta score.
     00B2               MX      =       $B2 ;Missile X coordinate
     00B3               MDX     =       $B3 ;Missile X velocity
     00B4               MY      =       $B4 ;Missile Y position (Zero means no missile
                                            ;on the screen.)
     00B5               DSEC    =       $B5 ;mod 15 counter for score to second conversion
     00B6               JIFF    =       $B6 ;mod 60 counter for jiffy to second conversion
     00B7               STOP    =       $B7 ;Non zero neans ignore player's button.  Used
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

1019   70   70   70     MDLIST: .BYTE   DLBL8,DLBL8,DLBL8
101C   46                       .BYTE   DLLDM+DLPF6     ;C
101D   00   18                  .ADDR   SCORLN
101F   F0   70                  .BYTE   DLBL8+DLINT,DLBL8     ;1,2
1021   F0   70                  .BYTE   DLBL8+DLINT,DLBL8     ;3,4
1023   F0   70                  .BYTE   DLBL8+DLINT,DLBL8     ;5,6
1025   F0   70                  .BYTE   DLBL8+DLINT,DLBL8     ;7,8
1027   F0   70                  .BYTE   DLBL8+DLINT,DLBL8     ;9,10
1029   F0   70                  .BYTE   DLBL8+DLINT,DLBL8     ;11,12
102B   F0   70                  .BYTE   DLBL8+DLINT,DLBL8     ;13,14
102D   F0   70                  .BYTE   DLBL8+DLINT,DLBL8     ;15,16
102F   F0   70                  .BYTE   DLBL8+DLINT,DLBL8     ;17,18
1031   F0   70                  .BYTE   DLBL8+DLINT,DLBL8     ;19,20
1033   F0   70                  .BYTE   DLBL8+DLINT,DLBL8     ;21,22
1035   41                       .BYTE   DLJVB
1036   19   10                  .ADDR   MDLIST
                        ;
                        ; Message table
                        ;

1038   28   43   29     TMSG:   .ASCII  "(C)1981 J H PALEVICH" ;Horrible bugs will infest the code
103B   31   39   38
103E   31   20   4A
1041   20   48   20
1044   50   41   4C
1047   45   56   49
104A   43   48
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
104C   80   90   82     TCOLB:  .BYTE   CLBLUE,CLLBLU,CLBLUE+2
104F   92   84   94             .BYTE   CLLBLU+2,CLBLUE+4,CLLBLU+4
1052   86   96   88             .BYTE   CLBLUE+6,CLLBLU+6,CLBLUE+8
1055   98   C8                  .BYTE   CLLBLU+8,CLGREN+8
                        ;
                        ; TCOLP - COLOR PLAYER ZERO
                        ; Player zero is the planes in the sky and the gun on the ground
                        ;

1057   08   18          TCOLP:  .BYTE   CLGREY+8,CLGOLD+8
1059   28   38                  .BYTE   CLORNG+8,CLRED+8
105B   48   58                  .BYTE   CLPINK+8,CLPURP+8
105D   68   78                  .BYTE   CLPURB+8,CLPBLU+8
105F   80   38   38             .BYTE   CLBLUE,CLRED+8,CLRED+8
                        ;
                        ; TPX -- Players X position
                        ;       The gun it always stuck at 124.
                        ;       DPLANE takes care of the planes' x position.
                        ;       DLIH sets the X position to zero to kill the
                        ; plane and get it off the screen.
                        ;

1062   00   01   02     TPX:    .BYTE   0,1,2,3,4,5,6,7,8,124,124
1065   03   04   05
1068   06   07   08
106B   7C   7C

                        ;
                        ; TDX -- Player's velocity.
                        ;       The gun is always zero, so it will not drift off
                        ; to either side.
                        ;

106D   01   02   03     TDX:    .BYTE   1,2,3,2,1,255,254,253
1070   02   01   FF
1073   FE   FD
1075   FE   00   00             .BYTE   254,0,0

                        ;
                        ; TVAL -- PLAYER'S POINT-VALUE
                        ;
                        ;       Set by DPLANE
                        ;       Used by DLIH
                        ;

1078   01   02   03     TVAL:   .BYTE   1,2,3,4,5,6,7,8,9,10,11
107B   04   05   06
107E   07   08   09
1081   0A   0B

                        ;
                        ; TWID -- width of the player
                        ;
                        ;       0 -- normal (two GR. 0 characters) wide
                        ;       1 -- double (four Gr. 0 characters) wide
                        ;       The gun is double width
                        ;

1083   00   01   00     TWID:   .BYTE   0,1,0,1,0,1,0,1,0,1,1
1086   01   00   01
1089   00   01   00
108C   01   01
                        ;
                        ; That's the end of the tables used by the DLIH
                        ; routine.
                        ;

                        ;
                        ; JTAB -- missiles X velocity
                        ;       Used to convert from the joystick direction to
                        ; the speed end direction of the missile.  Used by VBLI.
                        ;

108E   00   01   FF     JTAB:   .BYTE   0,1,255,0
1091   00

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
1092   00   03   06     GUNTAB: .BYTE   0,3,6,$C,$1C,$3C,$7E,$FF
1095   0C   1C   3C
1098   7E   FF
                        ;........
                        ;++......
                        ;.++.....
                        ;..++....
                        ;..+++...
                        ;..++++..
                        ;.++++++.
                        ;++++++++
109A   00   C0   60             .BYTE   0,$C0,$60,$30,$38,$3C,$7E,$FF
109D   30   38   3C
10A0   7E   FF
                        ;........
                        ;...++...
                        ;...++...
                        ;...++...
                        ;.. ++...
                        ;..++++..
                        ;.++++++.
                        ;++++++++

10A2   00   18   18             .BYTE   0,$18,$18,$18,$18,$3C,$7E,$FF
10A5   18   18   3C
10A8   7E   FF

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
10AA   00   00   F8     PTOL:   .BYTE   0,0,$F8,$20,$F2,$9E,$90,$F0
10AD   20   F2   9E
10B0   90   F0
                        ;........       helicopter flying right.
                        ;........
                        ;...+++++
                        ;.....+..
                        ;.+..++++
                        ;.++++..+
                        ;....+..+
                        ;....++++


10B2   00   00   1F             .BYTE   0,0,$1F,4,$4F,$79,9,$F
10B5   04   4F   79
10B8   09   0F
                        ;........       airplane flying left.
                        ;........
                        ;.......+
                        ;....++.+
                        ;..++++++
                        ;.+++++++
                        ;...++...
                        ;........
10BA   00   00   01             .BYTE   0,0,1,$0D,$3F,$7F,$18,0
10BD   0D   3F   7F
10C0   18   00
                        ;........       airplane flying right
                        ;........
                        ;+.......
                        ;+.++....
                        ;++++++..
                        ;+++++++.
                        ;...++...
                        ;........

10C2   00   00   80             .BYTE   0,0,$80,$B0,$FC,$FE,$18,0
10C5   B0   FC   FE
10C8   18   00
                        ;........       saucer flying left, right, hovering, etc.
                        ;...++...
                        ;..+..+..
                        ;.++++++.
                        ;+......+
                        ;.++++++.
                        ;........
                        ;........
10CA   00   18   24             .BYTE   0,$18,$24,$7E,$81,$7E,0,0
10CD   7E   81   7E
10D0   00   00
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
10D2   01   05   00     TPLANE: .BYTE   1,5,0,8     ;Helicopter, left
10D5   08
10D6   FF   05   00             .BYTE   $FF,5,0,0   ; "      " , right
10D9   00
10DA   02   0A   01             .BYTE   2,10,1,24   ;Airplane, left
10DD   18
10DE   FE   0A   01             .BYTE   $FE,10,1,16 ; " " , right
10E1   10
10E2   03   19   00             .BYTE   3,25,0,32   ;Saucer, left
10E5   20
10E6   FD   19   00             .BYTE   $FD,25,0,32 ;Saucer, right
10E9   20
                        ; Player missile table equates
                        ;
     1800               MPMBAS  =       ORG+$800    ;Player missile base --
                                                    ;Leave 2K for the main program

     1800               SCORLN  =       MPMBAS      ;Score line (uses 20 bytes)

     0080               GUNOFF  =       96          ;Gun offset -- Y position of top
                                                    ;of gun.

     1A80               GUNPOS  =       MPMBAS+PMDP0+GUNOFF ;Memory location of
                                                            ;top of gun in player0 memory.

     1800               SCORE   =       SCORLN      ;Address of Score (six digets)
     1807               HISCOR  =       SCORLN+7    ;Address of High score (six digets)
     180E               TIME    =       SCORLN+14   ;Address of Time remaining (six digets)

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

10EA   48               DLIH:   PHA                 ;Save A
10EB   8A                       TXA
10EC   48                       PHA                 ;Save X
10ED   A6   B0                  LDX     DLIC        ;Change the sky's color as fast as
10EF   E8                       INX                 ;we can.
10F0   BD   4C   10             LDA     TCOLB,X     ;but.
10F3   8D   0A   D4             STA     WSYNC       ;wait untill we can do it without
10F6   8D   1A   D0             STA     COLBK       ;the user noticing it.
10F9   A6   B0                  LDX     DLIC
10FB   AD   08   D0             LDA     M0PL        ;Did missile 0 hit anything?
10FE   29   01                  AND     #1          ;like P0?
1100   F0   13                  BEQ     DLIH2       ;No.
1102   A9   00                  LDA     #0          ;Yes:
1104   9D   62   10             STA     TPX,X       ;So zero x position.
1107   9D   6D   10             STA     TDX,X       ;and x velocity.
110A   BD   78   10             LDA     TVAL,X      ;and add the value of
110D   18                       CLC                 ;that player to DSCOR
110E   65   B1                  ADC     DSCOR
1110   85   B1                  STA     DSCOR
1112   8D   1E   D0             STA     HITCLR      ;And clear the hit registers.

1115   E8               DLIH2:  INX                 ;In any event, update:
1116   86   B0                  STX     DLIC
1118   BD   62   10             LDA     TPX,X       ;plane's X position.
111B   18                       CLC
111C   7D   6D   10             ADC     TDX,X
111F   9D   62   10             STA     TPX,X

1122   8D   00   D0             STA     HPOSP0
1125   BD   57   10             LDA     TCOLP,X   ;plane's color
1128   8D   12   D0             STA     COLPM0
112B   BD   83   10             LDA     TWID,X    ;plane's width
112E   8D   08   D0             STA     SIZEP0
1131   68                       PLA               ;restore X
1132   AA                       TAX
1133   68                       PLA               ;restore A
1134   40                       RTI               ;and return.

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

1135   A5   B1          VBLH:   LDA     DSCOR     ;Check if there are any unscored
1137   D0   08                  BNE     VBL5      ;points left. Yes.
1139   A9   80                  LDA     #$80      ;No.
113B   8D   03   D2             STA     AUDC2     ;Turn off point sound
113E   4C   90   11             JMP     VBL7

1141   38               VBL5:   SEC               ;Subtract one from the unscored
1142   E9   01                  SBC     #1        ;points counter.
1144   85   B1                  STA     DSCOR

1146   A9   8A                  LDA     #$8A      ;Turn on the point sound.
1148   8D   03   D2             STA     AUDC2

114B   A2   05                  LDX     #5        ;Add one to the SCORE counter.
114D   BD   00   18     VBL6:   LDA     SCORE,X   ;Which by an amazing coincidence
1150   18                       CLC               ;is in a human readable forn.
1151   69   01                  ADC     #1
1153   09   10                  ORA     #$10      ;If it was a space make it a '1'.
1155   9D   00   18             STA     SCORE,X
1158   C9   1A                  CMP     #$1A      ;Greater than a '9'?
115A   D0   09                  BNE     VBLH5     ;No.
115C   A9   10                  LDA     #$10      ;Yes. Set to '0' ind add one to
115E   9D   00   18             STA     SCORE,X   ;the next most significant diget.
1161   CA                       DEX
1162   4C   4D   11             JMP     VBL6
1165   A5   B7          VBLH5:  LDA     STOP      ;No free time if
1167   D0   27                  BNE     VBL7      ;we're STOPed.

1169   A6   B5                  LDX     DSEC      ;Has he scored 15 points in a row
116B   E8                       INX               ;yet?
116C   86   B5                  STX     DSEC
116E   E0   0F                  CPX     #15
1170   D0   1E                  BNE     VBL7      ;Nope.
1172   A2   00                  LDX     #0        ;Yes.  Reset this counter, then, and
1174   86   B5                  STX     DSEC

1176   A2   05                  LDX     #5        ;give this man a second of free time.
1178   BD   0E   18     VBL8:   LDA     TIME,X    ;(this routine is just like the VBL6
117B   18                       CLC               ;one, only it fiddles with numbers that
117C   69   01                  ADC     #1        ;are a different color. . . .)
117E   09   90                  ORA     #$90
1180   9D   0E   18             STA     TIME,X
1183   C9   9A                  CMP     #$9A
1185   90   09                  BCC     VBL7
1187   A9   90                  LDA     #$90
1189   9D   0E   18             STA     TIME,X
118C   CA                       DEX
118D   4C   78   11             JMP     VBL8

1190   A6   B6          VBL7:   LDX     JIFF      ;Move 60 jiffies (a jiffy is used
1192   E8                       INX               ;by Pet owners and other people
1193   86   B6                  STX     JIFF      ;to denote a 60th of a second) elapsed?
1195   E0   3C                  CPX     #60
1197   D0   22                  BNE     VBL9      ;No!
1199   A2   00                  LDX     #0        ;Yes.  Reset jiffy counter
119B   86   B6                  STX     JIFF

119D   A5   B7                  LDA     STOP      ;Has time stopped?
119F   D0   2E                  BNE     VBL12     ;Yes.

11A1   A2   05                  LDX     #5        ;No, so we shall take away a second from
11A3   BD   0E   18     VBL10:  LDA     TIME,X    ;the user's time (har har har)
11A6   38                       SEC               ;in just the same way as we added one.
11A7   E9   01                  SBC     #1        ;except for a few changes.
11A9   09   90                  ORA     #$90
11AB   9D   0E   18             STA     TIME,X

11AE   C9   9F                  CMP     #$9F      ;Like this check for borrow in place
11B0   D0   09                  BNE     VBL9      ;of a check for carry.
11B2   A9   99                  LDA     #$99
11B4   9D   0E   18             STA     TIME,X
11B7   CA                       DEX
11B8   4C   A3   11             JMP     VBL10

11BB   A9   00          VBL9:   LDA     #0        ;Has the user run out of time??
11BD   A2   06                  LDX     #6        ;If so, OR-ing together all of his
11BF   1D   0D   18     VBL11:  ORA     TIME-1,X  ;time-left digets should give a zero
11C2   CA                       DEX
11C3   D0   FA                  BNE     VBL11

11C5   29   0F                  AND     #$F
11C7   C9   00                  CMP     #0        ;Does It?
11C9   D0   04                  BNE     VBL12     ;No
11CB   A9   01                  LDA     #1        ;Yes.  Stop time!!!
11CD   85   B7                  STA     STOP

11CF   A9   00          VBL12:  LDA     #0        ;Store a zero into the ATRACT flag
11D1   85   4D                  STA     ATRACT    ;to keep the Atari from futzing with
                                                  ;our screen colors. . . .  Of course
                                                  ;this means that the user might end
                                                  ;up with the game field permanently
                                                  ;embossed on his TV screen. . . .

11D3   AD   78   02             LDA     STICK0    ;Take STICK0
11D6   4A                       LSR     A
11D7   4A                       LSR     A         ;Divide it by 4
11D8   AA                       TAX               ;Use that number to look up the
11D9   BD   8E   10             LDA     JTAB,X    ;direction the missile should
11DC   85   B3                  STA     MDX       ;travel in.
11DE   CA                       DEX               ; Then subtract one from that
11DF   8A                       TXA               ; (It better not be 0. . . .)
11E0   0A                       ASL     A         ;And multiply by eight
11E1   0A                       ASL     A         ;to get an index into the
11E2   0A                       ASL     A         ;table of the gun pictures
11E3   AA                       TAX
11E4   A0   00                  LDY     #0
11E6   BD   92   10     GUNDLP: LDA     GUNTAB,X  ;Copy the picture of the gun
11E9   99   60   1A             STA     GUNPOS,Y  ;into player zero.  Use two
11EC   C8                       INY               ;bytes for each byte in the
11ED   99   60   1A             STA     GUNPOS,Y  ;piture table so the gun is
11F0   E8                       INX               ;10 dots (32 scan lines) high.
11F1   C8                       INY
11F2   C0   10                  CPY     #16
11F4   D0   F0                  BNE     GUNDLP

11F6   A5   B2                  LDA     MX        ;Now update missile's X position.
11F8   18                       CLC
11F9   65   B3                  ADC     MDX
11FB   85   B2                  STA     MX
11FD   8D   04   D0             STA     HPOSM0

1200   A5   B4                  LDA     MY        ;Missile Y
1202   F0   26                  BEQ     VCONT     ;No missile
1204   AA                       TAX
1205   A9   00                  LDA     #0        ;Erase old missile
1207   9D   80   19             STA     MPMBAS+PMDM,X

120A   CA                       DEX               ;Hit top of screen?
120B   F0   11                  BEQ     VMDIE     ;Yes.
                                                  ;No.
120D   A5   B1                  LDA     DSCOR     ;Hit an airplane with the missile?
120F   D0   12                  BNE     VMHIT     ;No.
1211   86   B4                  STX     MY
1213   A9   FF                  LDA     #$FF      ;Draw new missile

1215   9D   80   19             STA     MPMBAS+PMDM,X

1218   8E   00   D2             STX     AUDF1     ;fweep sound effect
121B   4C   2A   12             JMP     VCONT

121E   86   B4          VMDIE:  STX     MY        ;Zero the missile's Y coordinate
1220   4C   2A   12             JMP     VCONT     ;to kill the missile.

1223   A2   00          VMHIT:  LDX     #0        ;Since we hit something we should
1225   8E   00   D2             STX     AUDF1     ;silence the sound register
1228   86   B4                  STX     MY        ;and zero the missile.

122A   A5   B7          VCONT:  LDA     STOP      ;Stoped?
122C   D0   16                  BNE     VCONT2    ;Yes.


122E   AD   84   02             LDA     STRIG0    ;Check if hunan wants to fire
1231   D0   11                  BNE     VCONT2    ;No.

1233   A5   B4                  LDA     MY        ;Check if he CAN fire.
1235   D0   0D                  BNE     VCONT2    ;Can't

1237   A9   62                  LDA     #GUNOFF+2 ;Set the Y coordinate to Just
1239   85   B4                  STA     MY        ;above the muzzle or the gun.
123B   A5   B3                  LDA     MDX       ;To get the X coordinate.
123D   0A                       ASL     A         ;multiply MDX (the direction the
123E   0A                       ASL     A         ;gun is pointing) by 4
123F   18                       CLC               ;and add to 132 (which is the
1240   69   84                  ADC     #132      ;CENTER of the Gun)
1242   85   B2                  STA     MX


1244   A9   FF          VCONT2: LDA     #$FF      ;Reset DLI counter
1246   85   B0                  STA     DLIC
1248   8D   1E   D0             STA     HITCLR    ;Zero hits.
124B   4C   5F   E4             JMP     SYSVBV    ;Jump to the OS's exit vblank routine.
                        ;
                        ; Main program starts here!!!
                        ;


124E   A9   A8          BEGIN:  LDA     #$A8        ;Missile sound is pure at volume 8
1250   8D   01   D2             STA     AUDC1
1253   A9   80                  LDA     #$80        ;Score sound is a silent fuzz.
1255   8D   03   D2             STA     AUDC2

1258   A9   00                  LDA     #0          ;missile frequency is ultrasonic
125A   8D   00   D2             STA     AUDF1

125D   A9   30                  LDA     #$30        ;score frequency is a high fuzz.
125F   8D   02   D2             STA     AUDF2
                        ;
                        ; Erase player missile memory space.
                        ;
1262   A2   80                  LDX     #128
1264   A9   00                  LDA     #0
1266   9D   FF   19     CLOOP:  STA     MPMBAS+PMDP0-1,X        ;We only use Player zero
1269   9D   7F   19             STA     MPMBAS+PMDM-1,X         ;and the missiles.
126C   CA                       DEX
126D   D0   F7                  BNE     CLOOP

126F   A9   00                  LDA     #0          ;Move all the players and missiles
1271   A2   08                  LDX     #8          ;off the screen.
1273   9D   FF   CF     PLOOP:  STA     HPOSP0-1,X
1276   CA                       DEX
1277   D0   FA                  BNE     PLOOP

1279   A9   2E                  LDA     #$2E        ;Enable PM DMA and a normal playfield.
127B   8D   2F   02             STA     SDMCTL
127E   A9   18                  LDA     #MPMBAS^    ;Set up the pointer to the Player
1280   8D   07   D4             STA     PMBASE      ;missile defuns.
1283   A9   03                  LDA     #3          ;Tell the CTIA to expect PM DMA
1285   8D   1D   D0             STA     GRACTL

1288   A9   10                  LDA     #$10        ;Enable fifth player so the
128A   0D   6F   02             ORA     GPRIOR      ;missiles will be COLOR3
128D   8D   6F   02             STA     GPRIOR
1290   8D   1B   D0             STA     PRIOR

1293   A9   00                  LDA     #0          ;Zero the missile
1295   85   B4                  STA     MY

1297   A9   01                  LDA     #1          ;Stop the player from fireing.
1299   85   B7                  STA     STOP

129B   A9   40                  LDA     #$40        ;Disable DLI's
129D   8D   0E   D4             STA     NMIEN
12A0   A9   10                  LDA     #MDLIST^    ;Set up the vector to our
12A2   8D   31   02             STA     SDLSTH      ;display list.
12A5   A9   19                  LDA     #MDLIST&$FF
12A7   8D   30   02             STA     SDLSTL
12AA   A9   10                  LDA     #DLIH^      ;Setup the vector to our
12AC   8D   01   02             STA     VDBLST+1    ;DLI handler
12AF   A9   EA                  LDA     #DLIH&$FF
12B1   8D   00   02             STA     VDBLST
12B4   A2   11                  LDX     #VBLH^      ;Load the address of our
12B6   A0   35                  LDY     #VBLH&$FF   ;verticle blank interrupt
12B8   A9   06                  LDA     #SETIMM     ;handler into X & Y and call
12BA   20   5C   E4             JSR     SETVBV      ;SETVBV to set up the VBLI vector.

12BD   A9   C0                  LDA     #$C0        ;Enable DLI'S
12BF   8D   0E   D4             STA     NMIEN

12C2   A9   C6                  LDA     #CLGREN+6   ;Color 0 (score) is green
12C4   8D   C4   02             STA     COLOR0

12C7   A9   36                  LDA     #CLRED+6    ;Color 1 (high score) is red.
12C9   8D   C5   02             STA     COLOR1

12CC   A9   18                  LDA     #CLGOLD+8   ;Color 2 (time) is gold.
12CE   8D   C6   02             STA     COLOR2

12D1   A9   0A                  LDA     #CLGREY+10  ;Color 3 (missiles) is white.
12D3   8D   C7   02             STA     COLOR3

                        ;
                        ; Write out the copyright message.
                        ;

12D6   A2   14                  LDX     #20         ;For the twenty charaters in the message,
12D8   BD   37   10     COPYR1: LDA     TMSG-1,X    ;load a character,
12DB   20   0E   14             JSR     ASTOIN      ;Call ASTOIN to get it to internal
12DE   09   C0                  ORA     #$C0        ;form, change it to color 3, and
12E0   9D   FF   17             STA     SCORLN-1,X  ;Store it on the play field.
12E3   CA                       DEX
12E4   D0   F2                  BNE     COPYR1
12E6   A5   13                  LDA     RTCLOC+1    ;get the real time (4 second ticks)
12E8   18                       CLC
12E9   69   03                  ADC     #3          ;8 to 12 seconds of glory

12EB   C5   13          COPYW:  CMP     RTCLOC+1    ;Wait a while 'till user's read it.
12ED   D0   FC                  BNE     COPYW

                        ;
                        ; Erase & initialize score line
                        ;

12EF   A2   14                  LDX     #20         ;Fill score line with spaces.
12F1   A9   00                  LDA     #0
12F3   9D   FF   17     ERASES: STA     SCORLN-1,X
12F6   CA                       DEX
12F7   D0   FA                  BNE     ERASES

12F9   A9   10                  LDA     #$10        ;Make score '     0'
12FB   8D   05   18             STA     SCORE+5


12FE   A9   50                  LDA     #$50        ;Make high score '     0'
1300   8D   0C   18             STA     HISCOR+5

1303   A9   90                  LDA     #$90        ;Make time '     0'
1305   8D   13   18             STA     TIME+5

1308   A9   01          REPEAT: LDA     #1          ;Stop the player (Just to make
130A   85   B7                  STA     STOP        ;sure!)
130C   A9   08                  LDA     #$08        ;Set up to read the consol
130E   8D   1F   D0             STA     CONSOL      ;switches

1311   AD   1F   D0     WAIT:   LDA     CONSOL
1314   C9   01                  CMP     #SWSTRT     ;The other two switches -- Select
1316   D0   06                  BNE     WAIT1       ;and option, are not pressed down.

1318   20   2A   14             JSR     MAKETP      ;If they are pressed down, make a
                                                    ;copy or this whole program
131B   4C   4E   12             JMP     BEGIN       ;And reset since the sound registers
                                                    ;will be messed up. . . .

131E   C9   06          WAIT1:  CMP     #6          ;Is the start switch pressed?
1320   D0   EF                  BNE     WAIT        ;Nope. . . .

1322   A9   00                  LDA     #0          ;Yes. Start game (1)
1324   A2   06                  LDX     #6          ;Erase time and score but not
1326   9D   0D   18     RESTR2: STA     TIME-1,X    ;high score.
1329   9D   FF   17             STA     SCORE-1,X
132C   CA                       DEX
132D   D0   F7                  BNE     RESTR2

132F   A9   91                  LDA     #$91        ;Set the time left to '   120'
1331   8D   11   18             STA     TIME+3
1334   A9   92                  LDA     #$92
1336   8D   12   18             STA     TIME+4
1339   A9   90                  LDA     #$90
133B   8D   13   18             STA     TIME+5

133E   A9   10                  LDA     #$10        ;Set the score to '     0'
1340   8D   05   18             STA     SCORE+5

1343   A9   00                  LDA     #0          ;let the player shoot.
1345   85   B7                  STA     STOP
1347   85   B1                  STA     DSCOR       ;Clear out the vblank
1349   85   B6                  STA     JIFF        ;counters.
134B   85   B5                  STA     DSEC

                        ;
                        ;       Set up the PM graphics.
                        ;

134D   A2   18          REDRAW: LDX     #$18        ;Start at lino 18,
134F   A0   00                  LDY     #0
1351   20   C5   13     CLOOP1: JSR     DPLANE      ;Draw 8 planes.
1354   C8                       INY
1355   C0   08                  CPY     #8
1357   D0   F8                  BNE     CLOOP1


                        ;
                        ; Set up 30 second count down timer (used to time rounds)
                        ;
1359   A2   07                  LDX     #7          ;30 secs = 1800 jiffies.
135B   A0   D0                  LDY     #208
135D   A9   03                  LDA     #3          ;CDT # 3.
135F   8D   2A   02             STA     CDTMF3
1362   20   5C   E4             JSR     SETVBV

1365   A9   C0                  LDA     #$C0        ;Re-enable DLI's
1367   8D   0E   D4             STA     NMIEN

136A   AD   2A   02     MAIN:   LDA     CDTMF3      ;Main loop -- if 30 seconds are
136D   D0   03                  BNE     MAIN2       ;up, draw another wave of planes.
136F   4C   4D   13             JMP     REDRAW
1372   A0   08          MAIN2:  LDY     #8          ;Check if all the planes have
1374   A9   00                  LDA     #0          ;been shot down (i.e. their
1376   19   6C   10     MAIN3:  ORA     TDX-1,Y     ;velocities are all zero)
1379   88                       DEY
137A   D0   FA                  BNE     MAIN3
137C   C9   00                  CMP     #0
137E   D0   0A                  BNE     MAIN4
1380   A9   32                  LDA     #50         ;If so, player gets 60 points
1382   18                       CLC
1383   65   B1                  ADC     DSCOR
1385   85   B1                  STA     DSCOR
1387   4C   4D   13             JMP     REDRAW          ;and a new round.

138A   A5   B7          MAIN4:  LDA     STOP            ;Check if player is stopped.
138C   F0   DC                  BEQ     MAIN            ;Nope.
                                                        ;Yes:
                        ;
                        ; Player died, so update high score
                        ; and restart.
                        ;

138E   A5   13                  LDA     RTCLOC+1        ;Wait 4 to 8 seconds
1390   18                       CLC
1391   69   02                  ADC     #2
1393   C5   13          HIW:    CMP     RTCLOC+1        ;for points to drain.
1395   D0   FC                  BNE     HIW

1397   A2   00                  LDX     #0              ;Check his high score against
1399   BD   07   18     HICHK:  LDA     HISCOR,X        ;his current score.
139C   29   1F                  AND     #$1F            ;If his high score is anywhere
139E   DD   00   18             CMP     SCORE,X         ;less than his current score
13A1   F0   05                  BEQ     HICHK1          ;Equal
13A3   B0   08                  BCS     NOHI            ;HI > score. Stop.
13A5   4C   B0   13             JMP     NEWHI           ;HI < score.
13A8   E8               HICHK1: INX                     ;NOTE: We check from left to right,
13A9   E0   06                  CPX     #6              ;unlike the routines in VBIH.
13AB   D0   EC                  BNE     HICHK
13AD   4C   08   13     NOHI:   JMP     REPEAT          ;So go and restart the game.

                        ;
                        ; Copy new high score
13B0   A2   06          NEWHI:  LDX     #6              ;Copy all six digets of the
13B2   BD   FF   17     NEWHI1: LDA     SCORE-1,X       ;score into the high score,
13B5   29   1F                  AND     #$1F            ;changing the color at the
13B7   09   40                  ORA     #$40            ;same time.
13B9   9D   06   18             STA     HISCOR-1,X
13BC   CA                       DEX
13BD   D0   F3                  BNE     NEWHI1
13BF   4C   08   13             JMP     REPEAT          ;Then restart the game.

                        ;
                        ; DPLANE -- pick and draw a plane
                        ;
13C2   00               XTEMP:  .BYTE   0               ;Temporary variables
13C3   00               YTEMP:  .BYTE   0               ;Used to save state of
13C4   00               TEMPA:  .BYTE   0               ;the processer.

13C5   8E   C2   13     DPLANE: STX     XTEMP           ;Save X
13C8   8C   C3   13             STY     YTEMP           ;Save Y
13CB   AD   0A   D2     DPLAN1: LDA     RANDOM          ;Get a random number
13CE   29   07                  AND     #7              ;reduce it to 0-7
13D0   C9   06                  CMP     #6              ;Is it > 6 ?
13D2   B0   F7                  BCS     DPLAN1          ;Yes.  Pick another one.
13D4   0A                       ASL     A               ;No.  Multiply by 4
13D5   0A                       ASL     A
13D6   AA                       TAX
13D7   BD   D2   10             LDA     TPLANE,X        ;And use it to index into
13DA   99   6D   10             STA     TDX,Y           ;The tplane table for
13DD   BD   D3   10             LDA     TPLANE+1,X      ;the velocity, the value.
13E0   99   78   10             STA     TVAL,Y          ;the width, and the
13E3   BD   D4   10             LDA     TPLANE+2,X      ;index into the plane
13E6   99   83   10             STA     TWID,Y          ;picture table.
13E9   A9   00                  LDA     #0
13EB   99   62   10             STA     TPX,Y           ;Set the X position to 0.
13EE   BD   D5   10             LDA     TPLANE+3,X      ;Get the index into the
13F1   AA                       TAX                     ;picture table.
13F2   AC   C2   13             LDY     XTEMP
13F5   A9   08                  LDA     #8
13F7   8D   C4   13             STA     TEMPA
13FA   BD   AA   10     DPLAN3: LDA     PTOL,X          ;Copy eight bytes from
13FD   99   00   1A             STA     MPMBAS+PMDP0,Y  ;the picture table to
1400   E8                       INX                     ;the player's defun space.
1401   C8                       INY
1402   CE   C4   13             DEC     TEMPA
1405   D0   F3                  BNE     DPLAN3
1407   98                       TYA                     ;Restore the processor
1408   AA                       TAX                     ;state, and return
1409   AC   C3   13             LDY     YTEMP           ;(X has had 0 added to it
140C   60                       RTS                     ;so that the next plane
                                                        ;drawn will be one position
                                                        ;lower in the player's defun).
                        ;
                        ; Ascii character in A --> Screen internal character in A
                        ; state saved and restored.
                        ;
                        ; (slightly modified from the internal
                        ; Atari OS routine & uses ROM tables)

140D   00               ASTEMP: .BYTE   0               ;Used to save the state of Y

140E   8C   0D   14     ASTOIN: STY     ASTEMP          ;Save Y.
1411   A8                       TAY                     ;Copy A into Y
1412   8A                       TXA
1413   48                       PHA                     ;Save X.
1414   98                       TYA
1415   2A                       ROL     A               ;Get bits 6 & 5 or character
1416   2A                       ROL     A
1417   2A                       ROL     A
1418   2A                       ROL     A
1419   29   03                  AND     #3
141B   AA                       TAX
141C   98                       TYA
141D   29   9F                  AND     #$9F            ;Zero bits 6 & 5 of character
141F   1D   F6   FE             ORA     $FEF6,X         ;and fill then with the bits
                                                        ;from the ROM table, giving
                                                        ;the internal (screen) code.

1422   A8                       TAY                     ;Restore X & Y registers.
1423   68                       PLA
1424   AA                       TAX
1425   98                       TYA
1426   AC   0D   14             LDY     ASTEMP
1429   60                       RTS

                        ;
                        ;       Boot tape writer.  Writes out a Boot tape and returns.
                        ;
142A   A2   20          MAKETP: LDX     #ICTWO          ;Choose IOCB two
142C   A9   0C                  LDA     #CLOSE          ;Close it.
142E   9D   42   03             STA     ICCOM,X
1431   20   56   E4             JSR     CIOV
1434   A9   14                  LDA     #CAS^           ;Open the C: device.
1436   9D   45   03             STA     ICBAH,X
1439   A9   75                  LDA     #CAS&$FF
143B   9D   44   03             STA     ICBAL,X
143E   A9   03                  LDA     #OPEN
1440   9D   42   03             STA     ICCOM,X
1443   A9   08                  LDA     #OPNOT          ;for output
1445   9D   4A   03             STA     ICAX1,X
1448   A9   80                  LDA     #$80            ;short IRQ
144A   9D   4B   03             STA     ICAX2,X
144D   20   56   E4             JSR     CIOV
1450   A9   00                  LDA     #PST&$FF        ;Write out the program in
1452   9D   44   03             STA     ICBAL,X         ;one fell swoop (using a
1455   A9   10                  LDA     #PST^           ;block putchar)
1457   9D   45   03             STA     ICBAH,X
145A   A9   78                  LDA     #<PND-PST>&$FF
145C   9D   48   03             STA     ICBLL,X
145F   A9   04                  LDA     #<PND-PST>^
1461   9D   49   03             STA     ICBLH,X
1464   A9   0B                  LDA     #PUTCHR
1466   9D   42   03             STA     ICCOM,X
1469   20   56   E4             JSR     CIOV
146C   A9   0C                  LDA     #CLOSE          ;Close cassette buffer
146E   9D   42   03             STA     ICCOM,X
1471   20   56   E4             JSR     CIOV
1474   60                       RTS
1475   43   3A          CAS:    .ASCII  "C:"            ;Name of cassette device.
1477   9B                       .BYTE   EOL

     1478               PND = .                         ;Used by MAKETP to figure
                                                        ;out what to save. Must
                                                        ;point to just after last
                                                        ;byte of program.
     0000                       .END
