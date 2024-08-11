DATA	SEGMENT			; 定义数据段
Msg	DB	'Hello, World!', 13,10,'$'
DATA	ENDS			; 数据段定义结束
CODE	SEGMENT			; 定义代码段
	ASSUME CS: CODE, DS:DATA
Start:	MOV	AX, DATA	; 取数据内存区段地址
	MOV	DS, AX		; 设置数据段寄存器
	MOV	DX, Offset Msg
	MOV	AH, 9
	INT	21h	; dos 9号功能,显示DS:DX指向的字符串
	MOV	AX, 4C00h
	INT	21h		; 运行结束,返回DOS
CODE	ENDS			; 代码段定义结束
	END	Start		; 源程序到此为止
