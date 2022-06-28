*-----------------------------------------------------------
* Title      :
* Written by :
* Date       :
* Description:
*-----------------------------------------------------------
        ORG    0
        DC.L    $00FFFFF0
        DC.L    $00000500   * RESET EHR address


        ORG    $07C
        DC.L    $2000       * Level-7 ISR/EHR address



* Reset EHR 

        ORG     $500
        MOVEA.L #$E00000,A3
        MOVE.L  #0,D1
        LEA     seven_seg_codes,A2

        move    #13,D0  D0 = task number 13.
        lea     start_text,A1 A1 = address of string to display.
        trap    #15     Activate input/output task.
        move    #$2000,SR

        BRA     START



* Level-7 ISR/EHR     
        ORG $2000
LEVEL_7_INTERRUPT:    
        move    #13,D0  D0 = task number 13.
        lea     text1,A1 A1 = address of string to display.
        trap    #15     Activate input/output task.
        move    #3,D0  D0 = task number 3.
        trap    #15     Activate input/output task.
        bsr     delay
        move    #13,D0  D0 = task number 14.
        lea     text2,A1 A1 = address of string to display.
        trap    #15     Activate input/output task.
        bsr     delay
        MOVE.B  $E00012,$E00010   Read the switches and display them on the LEDs
        MOVE.B  (A2,D1),(A3)        Display the seven segment code on a seven sigment display digit.
        ADDA.L  #2,A3
        BSR     delay
        ADD.L    #1,D1
        RTE
        
    

delay:  MOVE.L  #1000000,D5
LOOP2:  SUB.L   #1,D5
        BNE     LOOP2
        RTS

start_text:  dc.b  'Welcome from hardware reset ....',CR,LF,BEL,0   Null terminated string.
text1:   dc.b    FF,'Welcome from interrupt level-7 ....',CR,LF,0   Null terminated string.
text2:   dc.b    CR,LF,'another welcome from interrupt level-7...',CR,LF,0   Null terminated string.
seven_seg_codes:    DC.B  %0111111,%0000110,%1011011,%11001111,%1100110,%1101101,%1111101,%0000111,%1111111,%1101111 


    ORG     $1000    
START:                  ; first instruction the simulator will try to execute

* Put program code here

        MOVE.L  #0,D6
LOOP:   ADD.L   #1,D6
        bsr     delay
        bra     LOOP
    
    

    SIMHALT             ; halt simulator

* Put variables and constants here

BEL EQU  $07   Bell
BS  EQU  $08   Backspace
HT  EQU  $09   Tab (horizontal 5 characters)
LF  EQU  $0A   Line Feed
VT  EQU  $0B   Vertical tab (4 lines)
FF  EQU  $0C   Form Feed (Always end printing with a Form Feed.)
CR  EQU  $0D   Carriage Return 


    END    START        ; last line of source






*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
