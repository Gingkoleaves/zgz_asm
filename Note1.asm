
DATA	SEGMENT		PUBLIC
	M DW 10,73,-34,2,34,56,-876,3457,-43,-234,0,346,-342,-2345,5423,345,42,34,-4323,-45
	NPOS DB 0
	NNEG DB 0
DATA	ENDS


CODE	SEGMENT		PUBLIC
	ASSUME	CS: CODE,DS:DATA
START:	
	MOV	AX,DATA
	MOV	DS,AX

	MOV	SI,OFFSET M
	MOV AX,0
	MOV CX,20

AGAIN:
	CMP [SI],AX
	JG LPOS
	JL LNEG
	JMP LEND
LPOS:
	INC NPOS
	JMP LEND
LNEG:
	INC NNEG
	JMP LEND

LEND:
	INC SI
	INC SI
	loop AGAIN

	MOV BL,NPOS

        MOV     CH,2
        MOV     CL,4

ROTATE: ROR     BL,CL
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

	MOV DL,0AH
	MOV AH,02H
	INT 21H

	MOV BL,NNEG

        MOV     CH,2
        MOV     CL,4

ROTATE1: ROR     BL,CL
        MOV     AL,BL
        AND     AL,0FH
        ADD     AL,30H
        CMP     AL,3AH
        JL      PRINTIT1
        ADD     AL,7
PRINTIT1:MOV     DL,AL
        MOV     AH,2
        INT     21H
        DEC     CH
        JNZ     ROTATE1
        MOV     AH,2
        MOV     DL,48H
        INT     21H



ENDL:
	MOV	AX, 4C00H
	INT  	21H

CODE	ENDS
	END	 START



