data	segment
a	dw	3,4,5,6,7,8
b	dw	4,5,6,7,8,9
c	dw	6 dup(?)
N	dw	6
data	ends

code	segment
	assume cs:code,ds:data
main:
	mov	ax, data
	mov	ds,ax

	push	N
	lea	ax, c
	push	ax
	lea	ax, b
	push	ax
	lea	ax, a
	push	ax
	call	f
	add	sp, 8

	mov	ax,4c00h
	int	21h

f	proc
	push	bp
	mov	bp,sp

	mov	cx, [bp+10]	;N
	mov	si, 0
	jmp rrr
bbb:	
	mov	di, si
	add	di,di	;i*2
	mov	bx, [bp+4]	;x
	mov	ax, [bx+di]	;x[i]

	mov	bx, [bp+6]	;y
	add	ax, [bx+di]	;y[i]

	mov	bx, [bp+8]	;z
	mov	[bx+di], ax

	inc	si

rrr:	cmp	si,cx
	jl	bbb

	pop	bp
	ret
f	endp

code	ends
	end main