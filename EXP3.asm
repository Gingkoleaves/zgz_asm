DATA	SEGMENT
X	DW  	55, 112, 37, 82
Y	DW  	4 DUP (?)
DATA	ENDS
CODE	SEGMENT
	ASSUME	CS: CODE, DS: DATA
START:	MOV 	AX, DATA
	MOV	DS, AX
	MOV	DI, 2	;第二个元素在数组内的位移(思考一下：为什么位移是2，不是1或3)
	MOV	AX, X[DI]	;取出X数组第二个元素
	MOV	X[DI],0;把0写入X数组第二个元素
	MOV	Y[DI], AX	;送入Y数组第二个元素中
	MOV	AX, X[DI+4]	;取出X数组第四个元素
	MOV	X[DI+4],0;把0写入X数组第四个元素
	MOV	Y[DI+4], AX	;送入Y数组第四个元素中

	
	MOV	AX, 4C00H
	INT  	21H
CODE	ENDS
	END	 START