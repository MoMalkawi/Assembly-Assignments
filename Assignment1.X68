*-----------------------------------------------------------
* Title      : Micro Assignment 1
* Written by : Mohammad Malkawi (****)
* Date       : 30/04/2021
* Description: Searches and Capitalizes first character of a keyword
*-----------------------------------------------------------
    ORG    $1000
START:                  ; first instruction of program

* Put program code here

    LEA     text,       a0             ;Assign a0 to the base address of 'text'
    LEA     keyword,    a1             ;Assign a1 to the base address of 'keyword'

outerLoop:                             ;Label for the outer Loop
    MOVEA.L     a0,         a4         ;Move a copy of the current text base address to a4
    CMP.B       #0,         (a0)+      ;Compare a0 with 0 (a0 != NULL), then post-increment
    BEQ         EXIT                   ;If a0 == NULL, Branch to EXIT (Simhalt...)
   
    MOVEA.L     a4,         a2         ;Create a copy of a4 (previous a0) (text) and post-increment
    MOVEA.L     a1,         a3         ;Create a copy of a1 (keyword) and post-increment
innerLoop:                             ;Label for the inner Loop
    CMPM.B      (a2)+,      (a3)+      ;Compare Memory and Increment a2 and a3 (text and keyword)
    BNE         outerLoop              ;if currentText != currentKeyword, branch to outerLoop
    
    CMP.B       #0,         (a3)       ;Compare 0 with incremented a3 to see if it's NULL
    BNE         innerLoop              ;If incremented a3 != 0, continue with innerLoop
    
    SUB.B       #$20,       (a4)       ;If the incremented a3 == 0, then Subtract 20 Hexa from a4 value (p -> P)
    ;MOVE.B      (a4),        d0       ;Move a4 value to d0 (used for testing purposes) uncomment to see changed value
    BRA         outerLoop              ;Exit innerLoop and continue with outerLoop 

EXIT:
    SIMHALT             ; halt simulator

* Put variables and constants here

text        DC.B    'This is a text phrase containing petra, petra is in Jordan',0 ;Define text constant (Byte indexed)
keyword     DC.B    'petra',0                                                      ;Define keyword constant (Byte ..)

    END    START        ; last line of source
    
    
