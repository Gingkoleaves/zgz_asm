.386
EXTRN	  _Sub1: NEAR
PUBLIC	  _StringInASM, _Sub2
_DATA	SEGMENT 'DATA' PUBLIC USE32
_StringInASM	DB	'ASM ( USE32 ) MODULE', 0
_DATA	ENDS
_TEXT	SEGMENT 'CODE' PUBLIC USE32
	ASSUME CS: _TEXT, DS:_DATA
_Sub2	PROC	NEAR
	PUSH	EBP
	MOV	EBP, ESP
	PUSH	DWord Ptr [EBP+12]	;this is y
	PUSH	DWord Ptr [EBP+8]	;this is x
	CALL	_Sub1
	ADD	ESP, 8
	SUB	EAX, [EBP+8]
	SUB	EAX, [EBP+12]
	POP	EBP
	RET
_Sub2	ENDP
_TEXT	ENDS
	END
