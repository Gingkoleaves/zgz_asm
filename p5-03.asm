EXTRN  Disp:Near

MYDATA	SEGMENT 
DATA	DW	1234H, 5678H, 9D4CH, 0D7H, 0, -1, 7D2AH, 8A0EH, 10F5H, 645DH,8000H,8322H
N	EQU ($-DATA)/2
MYDATA	ENDS

CODE	SEGMENT PUBLIC
	ASSUME	CS: CODE,DS:MYDATA
START:	

MAIN	PROC	FAR             ;视为main子程序

        PUSH    DS         
        MOV     AX,0
        PUSH    AX
        
	MOV	AX,MYDATA
	MOV	DS,AX

        MOV     CX,N
        MOV     BX,OFFSET DATA
        MOV     AX,32766
	MOV		DX,0001H
AGAIN:  
	TEST	[BX],DX		;test even
	JNZ		NEXT		;not even
        CMP     AX,[BX]
        JLE     NEXT
        MOV     AX,[BX]
NEXT:	INC     BX
	INC	BX	;要加2
   	LOOP    AGAIN

        MOV     BX,AX

	CALL Disp


	;MOV	AX, 4C00H
	;INT  	21H

        
        RETF
MAIN	ENDP



CODE	ENDS
	END	 START