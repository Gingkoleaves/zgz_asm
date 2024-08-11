DATA	SEGMENT		PUBLIC
	Ctt	db	'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'
	Count	EQU	$-Ctt
	EnCtt	db Count*2 dup(0)
	UnEnctt	db Count*2 dup(0)
	n	dw ?
	theta	dw ?
	d	dw ?
	k	dw ?	
	e 	dw 1
	E1	DB "Error!",13,10,'$'	
	x 	dw 0
	k1 dw 1
	l1 dw 0
	k2 dw 0
	l2 dw -1
	kk dw ?
	ll dw ?
DATA	ENDS


CODE	SEGMENT		PUBLIC
	ASSUME	CS: CODE,DS:DATA
START:	
	MOV	AX,DATA
	MOV	DS,AX
	jmp bgl


again1:

	mov dx,offset E1
	mov ah,09
	int 21H
bgl:
	MOV	cx,0
	;输入两个8-bits数，判断是否为素数
	call inp_decimal
	mov bx,ax
	call inp_decimal

	push ax
	call Prime_test
	add sp,2
	push bx
	call Prime_test
	add sp,2
	cmp cx,1
	jz again1


	;计算n和θ
	push ax
	mul bx
	mov n,ax
	pop ax
	dec ax
	dec bx
	mul bx
	mov theta,ax
	
	;遍历奇数，找e使gcd(e,θ)=1，之后求出d、k，使得d*e-k*θ=1
	mov si,offset e

again3:				;用cx传gcd
	add word ptr [si],2
	push [si]		
	push theta
	call Euild
	add sp,4
	cmp cx,1
	jnz again3
	
	;记录e，n，d,si存e
	push theta
	push e
	call ExEuild
	add sp,4

	;加密、解密：根据参数
	;入栈e\d，输入文段地址、输出文段地址入栈
	
	mov si,offset Ctt
	mov di,offset EnCtt
	mov bp,0
	jmp judge7

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

judge7:
	cmp bp,Count
	jl Encode



	mov si,offset Enctt
	mov di,offset UnEnctt
	mov bp,0
	jmp judge8

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

judge8:
	cmp bp,Count
	jl Encrypt

	mov bp,Count
	add bp,bp
	mov si,offset Enctt
	mov ax,'$'
	mov [si][bp],ax
	
	mov dx,si
	mov ah,09h
	int 21h

	call newline

	mov bp,Count
	add bp,bp
	mov si,offset UnEnctt
	mov ax,'$'
	mov [si][bp],ax
	
	mov dx,si
	mov ah,09h
	int 21h



call newline





	mov cx,Count
	mov si,offset UnEnctt

printl:
	mov dl,[si]
	mov ah,02h

	int 21h
	add si,2

	loop printl



	MOV	AX, 4C00H
	INT  	21H

Prime_test      PROC	;入栈待测数,素数则cx OR 0，不素 OR 1
	push	bp
	mov	bp,sp
	push	ax
	PUSH	BX
	push	dx

	mov ax,[bp+4]	;取到入栈的待检测数
	and	ax,00ffh	;8位输入
	mov bx,2
again2:
	push ax
	div bl
	cmp ah,0

	jz errorl
	inc BL
	pop ax
	cmp bx,ax
	jl again2
	
	or cx,0		;是素数置0，不是素数置1
	jmp endl2
errorl:

	or cx,01
endl2:
	pop dx
	pop bx
	pop ax
	mov sp,bp
	pop bp
	ret
Prime_test      ENDP

inp_decimal		PROC

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

	mov ax,x
	pop	DX
	POP BX
	POP CX
	MOV SP,BP
	POP BP	
	ret
inp_decimal		endp

newline	PROC
	push ax
	push dx

	mov ah,02h
	mov dl,0ah
	int 21H

	pop dx
	pop ax

	ret
newline endp

Euild	PROC		;传入两个参数
	push	bp
	mov	bp,sp

	push ax
	push bx
	push dx
	mov cx,0

	mov ax,[bp+4]
	mov bx,[bp+6]


	jmp judge1
again4:
	mov ax,bx
	mov bx,cx
judge1:
	div bx

	push cx
	mov cx,0
	cmp dx,cx
	pop cx
	mov cx,dx
	mov dx,0
	jnz again4
	
	mov cx,bx

	pop dx
	pop bx
	pop ax
	mov sp,bp
	pop bp

	ret
Euild	endp

ExEuild PROC
	push	bp
	mov	bp,sp
	
	push ax
	push bx
	push dx

	mov ax,[bp+4]	;aa
	mov bx,[bp+6]	;bb
	;cx q,rr dx
	;k1,l1,k2,l2,kk,ll

again5:
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

	jmp again5

Next:
	cmp k2,0
	jge next1 
	push ax
	mov ax,[bp+6]
	add k2,ax
	pop ax
	push ax
	mov ax,[bp+4]
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
	ret
ExEuild ENDP

FastP	proc	;取x（地址），取m，取d（地址），计算x的m次方模n，结果放入d
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





CODE	ENDS
	END	 START



