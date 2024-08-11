PUBLIC Disp
CODE	SEGMENT         PUBLIC
	ASSUME	CS: CODE

Disp PROC       NEAR
        MOV     CH,4
        MOV     CL,12

ROTATE: ROR     BX,CL
        MOV     AL,BL
        AND     AL,0FH
        ADD     AL,30H
        CMP     AL,3AH
        JL      PRINTIT
        ADD     AL,7
PRINTIT:MOV     DL,AL
        MOV     AH,2
        INT     21H
        DEC     CH
        JNZ     ROTATE
        MOV     AH,2
        MOV     DL,48H
        INT     21H

        RET
Disp ENDP

CODE	ENDS
	END	