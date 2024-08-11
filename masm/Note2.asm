DATA	SEGMENT		PUBLIC
	s1 db "string4",13,10,'$'
        len1 db $-s1
        s2 db "string1",13,10,'$'
        len2 db $-s2
        Msg1 db "Match",13,10,'$'
        Msg2 db "NoMatch",13,10,'$'
DATA	ENDS


CODE	SEGMENT		PUBLIC
	ASSUME	CS: CODE,DS:DATA
START:	
	MOV	AX,DATA
	MOV	DS,AX

        MOV     AL,LEN2
        CMP     len1,AL
        JNZ     LNOM

        MOV     CL,len1
        AND     CX,0FH
        MOV     SI,OFFSET S1
        MOV     DI,OFFSET S2
AGAIN:  
        MOV     DL,[DI]
        CMP     [SI],DL
        JNZ     LNOM
        INC     SI
        INC     DI
        LOOP    AGAIN
        JMP     LMA
LMA:
        MOV     DX,OFFSET Msg1
        MOV     AH,09H
        INT     21H
        JMP     LEND

LNOM:
        MOV     DX,OFFSET Msg2
        MOV     AH,09H
        INT     21H
LEND:
	MOV	AX, 4C00H
	INT  	21H

CODE	ENDS
	END	 START



