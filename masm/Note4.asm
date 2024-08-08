_TEXT	SEGMENT 'CODE'
	ASSUME CS:_TEXT
	.386
Start:	MOV	ECX, 1000	;交替输出0和1,
			;500个周期须循环1000次
	IN	AL, 61h		;直接读入PB口数据
	AND	AL, 0FEh	;PB0清0
Loc1:	
	XOR	AL, 10b		;PB1变反
	OUT	61h, AL		;直接向PB口输出数据
	PUSH	ECX
	MOV	ECX, 2000h	;延时的循环次数
Delay:	
	LOOP	Delay		;通过循环产生延时
	POP	ECX
	LOOP	Loc1
	MOV	AX, 4C00h
	INT	21h
_TEXT	ENDS
	END Start
