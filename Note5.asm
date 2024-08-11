DATA	SEGMENT
X	DW 0
DATA	ENDS

_TEXT	SEGMENT 'CODE'
	ASSUME CS:_TEXT,DS:DATA
Start:	
	MOV	AX,DATA
	MOV	DS,AX

	MOV	SI,OFFSET X
	MOV 	word ptr [SI],0

	push	bp
	mov	bp,sp
	push	cx
	PUSH	BX
	PUSH	DX
	mov cx,0
	mov BX,0
	MOV AX,0
	MOV DX,0

again:
	mov ah,01h
	int 21H
	cmp al,0ah	;输入与回车符比较
	jz endL
	cmp al,13	;输入与回车符比较
	jz endL

	mov ah,0			;数字从大到小存入栈
	sub ax,'0'
	push ax
	inc DX
	jmp again

endL:
	mov bx,10
	mov cx,dx
endl3:
	POP AX
	push dx
	sub dx,cx		;dx存有几个数字
	jmp judge

timesl:
	dec dx
	push dx
	mul	bx
	pop dx
judge:	
	cmp dx,0
	jnz timesl
	
	add x,ax

	pop dx
	dec	cx
	CMP	CX,0
	Jg	ENDL3

	pop	DX
	POP BX
	POP CX
	MOV SP,BP
	POP BP	


	MOV	AX, 4C00h
	INT	21h
_TEXT	ENDS
	END Start





