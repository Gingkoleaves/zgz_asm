DATA	SEGMENT		PUBLIC
        MAXLEN DB 80
        ACTLEN DB ?
        S1 DB 80 DUP(?)
        ANS DB 80 DUP(?)
DATA	ENDS


CODE	SEGMENT		PUBLIC
	ASSUME	CS: CODE,DS:DATA
START:	
	MOV	AX,DATA
	MOV	DS,AX

        MOV     DX,OFFSET MAXLEN
        MOV     AH,0AH
        INT 21H

        MOV     CL,ACTLEN
        CMP     CL,4            ;不为4位则退出
        JNZ     ENDL


        AND     CH,00
        MOV     SI,OFFSET S1
        MOV     DI,OFFSET ANS


 AGAIN:
        MOV     DX,0    ;DL用来输出
        MOV     BP,0    ;BL用来记录四位二进制
        CMP     BYTE PTR [SI],'0'
        JB      ENDL
        CMP     BYTE PTR [SI],'9'
        JA      JUDLE

        MOV     DH,[SI]         ;是数
        SUB     DH,'0'        
        
        PUSH CX
        MOV     CL,4
        SHL     DX,CL
        POP     CX
OUTPL:
        MOV     DL,0
        ROL     DX,1
        ADD     DL,'0'
        MOV     DS:[BP][DI],DL

        INC BP
        CMP BP,4
        JB OUTPL

        JMP     NEXT

JUDLE:   
        MOV     BP,0    ;BP用来记录四位二进制
        CMP     BYTE PTR [SI],'A'        
        JB      ENDL
        CMP     BYTE PTR [SI],'Z'
        JA      ENDL

        MOV     DH,[SI]                ;是大写字母
        SUB     DH,'A'
        ADD     DH,0AH

        PUSH CX
        MOV     CL,4
        SHL     DX,CL
        POP     CX
OUTPL1:
        MOV     DL,0
        ROL     DX,1
        ADD     DL,'0'
        MOV     DS:[BP][DI],DL

        INC BP
        CMP BP,4
        JB OUTPL1


        JMP     NEXT


NEXT:
        ADD     SI,1
        ADD     DI,4
        LOOP AGAIN
        
        MOV     AH,02
        MOV     DL,0AH
        INT 21H



        MOV     BYTE PTR [DI],'$'
        MOV     AH,09H
        MOV     DX,OFFSET ANS
        INT 21H


ENDL:
	MOV	AX, 4C00H
	INT  	21H

CODE	ENDS
	END	 START



