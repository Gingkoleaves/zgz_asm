DATA SEGMENT
	e dw 3
	theta dw 6820h
	d dw ?	;456b
	k dw ?	;2
	k1 dw 1
	l1 dw 0
	k2 dw 0
	l2 dw -1
	kk dw ?
	ll dw ?
DATA ENDS

_TEXT	SEGMENT 'CODE'
	ASSUME CS:_TEXT,DS:DATA
Start:	
	MOV	AX,DATA
	MOV	DS,AX



	push theta	
	push e	
	push	bp
	mov	bp,sp
	
	push ax
	push bx
	push dx

	mov ax,[bp+2]	;aa
	mov bx,[bp+4]	;bb
	;cx q,rr dx
	;k1,l1,k2,l2,kk,ll

again4:
	push ax

	mov dx,0
	idiv bx
	mov cx,ax

	pop ax

	cmp dx,0
	jz Next

	push ax
	push dx

	mov ax,k1
	mov kk,ax

	mov ax,k2
	imul cx
	sub kk,ax

	mov ax,l1
	mov ll,ax
	mov ax,l2
	imul cx
	sub ll,ax

	pop dx
	pop ax

	mov ax,bx

	push ax
	mov ax,k2
	mov k1,ax
	pop ax

	push ax
	mov ax,l2
	mov l1,ax
	pop ax

	mov bx,dx

	push ax
	mov ax,kk
	mov k2,ax
	pop ax

	push ax
	mov ax,ll
	mov l2,ax
	pop ax

	jmp again4

Next:
	cmp k2,0
	jge next1 
	push ax
	mov ax,[bp+4]
	add k2,ax
	pop ax
	push ax
	mov ax,[bp+2]
	add l2,ax
	pop ax

next1:
	push ax
	mov ax,k2
	mov d,ax
	pop ax

	push ax
	mov ax,l2
	mov k,ax
	pop ax




	pop dx
	pop bx
	pop ax
	mov sp,bp
	pop bp

	MOV	AX, 4C00h
	INT	21h

_TEXT	ENDS
	END Start





