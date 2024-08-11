DATA SEGMENT
A  	DW      1234H,1111h,5234h,4234h
N   	EQU     ($-A)/2
A1	DW	N DUP(0)
A2	DW	N DUP(0)
DATA ENDS

_TEXT	SEGMENT 'CODE'
	ASSUME CS:_TEXT,DS:DATA
Start:	
	MOV	AX,DATA
	MOV	DS,AX

	MOV	SI,OFFSET A
	mov		di,offset a1
	mov		bp,offset a2
	MOV	cx,0
	JMP	JUDGE

again:

	mov dx,word ptr [si]
	test word ptr [si],01h
	jz	evenl

	mov [di],dx	;奇数
	add di,2
	jmp	endl
evenl:
	mov ds:[bp],dx
	add bp,2

endl:
	inc	cx
	inc	si
	inc	si

JUDGE:
	CMP	CX,N
	JL		AGAIN

	mov		di,offset a1
	mov		bp,offset a2


again1:
	cmp word ptr [di],0
	jz	again2
	push word ptr [di]
	call display16
	add sp,2
	inc	di
	inc	di

	mov	ah,02
	mov dl,0ah
	int 21h

	jmp again1

again2:
	cmp word ptr [bp],0
	jz	endll
	push word ptr [bp]
	call display16
	add sp,2
	inc	bp
	inc	bp

	mov	ah,02
	mov dl,0ah
	int 21h

	jmp again2

endll:

	MOV	AX, 4C00h
	INT	21h
display16  proc
	push	bp
	mov	bp,sp

	mov	ax, [bp+4]
	mov	cx, 0
	mov	bx, 10

Rep1b:
	MOV	DX, 0
	DIV	BX
	PUSH	DX
	INC	CX
	OR	AX, AX
	JNZ Rep1b

Rep2b:
	POP	DX
	ADD	DL, 48
	MOV	AH, 2
	INT	21h
	LOOP Rep2b

	mov	sp, bp
	pop	bp
	ret
display16 endp
_TEXT	ENDS
	END Start





