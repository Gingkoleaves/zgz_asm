EXTRN  Disp:Near

MYDATA	SEGMENT 
DATA	DW	1234H, 8000H,8322H
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
		MAX1 DW -32768

        MOV     CX,N
        MOV     BX,OFFSET DATA
        MOV     AX,32766
	MOV		DX,0001H
AGAIN:  
	TEST	[BX],DX		;test even
	JNZ		NEXT		;not even
        CMP     AX,[BX]
        JLE     MAXP
        MOV     AX,[BX]
MAXP:	
	PUSH	AX
	MOV		AX,CS:MAX1
	CMP		AX,[BX]
	JGE     NEXT1
	MOV		AX,[BX]
	MOV		CS:MAX1,AX
	
NEXT1:
	POP	AX
NEXT:
	INC     BX
	INC		BX	;要加2
   	LOOP    AGAIN



    MOV     BX,AX

	CALL Disp

	MOV		DL,0AH
	MOV		AH,02H
	INT 21H

	MOV	BX,CS:MAX1

	CALL Disp

	;MOV	AX, 4C00H
	;INT  	21H
        
    RETF
MAIN	ENDP



CODE	ENDS
	END	 START