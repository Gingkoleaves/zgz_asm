DATA SEGMENT
	Ctt	db	'Inf'
	Count	EQU	$-Ctt
	EnCtt	db Count*2 dup(0)
	UnEnctt	db Count*2 dup(0)
	n	dw 696dh
	theta	dw 6820h
	d	dw 0456bh
	k	dw 2	
	e 	dw 3
	E1	DB "Error!",13,10,'$'	
DATA ENDS

_TEXT	SEGMENT 'CODE'
	ASSUME CS:_TEXT,DS:DATA
Start:	
	MOV	AX,DATA
	MOV	DS,AX

	mov si,offset Ctt
	mov di,offset EnCtt
	mov bp,0
	jmp judge2

Encode:
	mov ax,0
	mov al,[si]
	push	ax		;读一个字节

	push	e
	push 	di
	call FastP
	add sp,6
	
	inc bp
	inc si
	inc di
	inc di

judge2:
	cmp bp,Count
	jl Encode



	mov si,offset Enctt
	mov di,offset UnEnctt
	mov bp,0
	jmp judge4

Encrypt:
	mov 	ax,[si]
	push	ax		;读一个字节

	push	d
	push 	di
	call FastP
	add sp,6
	
	inc bp
	inc si
	inc si
	inc di
	inc di

judge4:
	cmp bp,Count
	jl Encrypt

	mov cx,Count
	mov si,offset UnEnctt
printl:
	mov dl,[si]
	mov ah,02h

	int 21h
	add si,2

	loop printl


	MOV	AX, 4C00h
	INT	21h

FastP	proc	;取x，取m，取d（地址），计算x的m次方模n，结果放入d
	
	push	bp
	mov	bp,sp
		
	push ax
	push bx
	push cx
	push dx
	mov cx,15	;i

	MOV	di,offset [bp+4]	;[di]=r
	mov word ptr [di],1
	mov ax,offset [bp+6]	;m
	mov bx,offset [bp+8]	;x
	

	;开始循环
judge3:
	cmp cx,0
	jl endl4

	push ax
	push dx
	push cx

	mov ax,[di]
	mul ax
	mov cx,n
	div cx
	mov [di],dx

	pop cx
	pop dx
	pop ax

	shl ax,1
	jnc endl5

	push ax
	push dx
	push cx

	mov ax,[di]
	mul bx
	mov cx,n
	div cx
	mov [di],dx

	pop cx
	pop dx
	pop ax

endl5:
	dec cx
	jmp judge3
endl4:


	pop dx
	pop cx
	pop bx
	pop ax

	mov sp,bp
	pop		bp
ret
FastP	ENDP

_TEXT	ENDS
	END Start





