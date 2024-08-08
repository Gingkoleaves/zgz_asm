DATA	SEGMENT
	D1	DB 10,"Monday",13,10,'$'
	D2	DB 10,"Tuesday",13,10,'$'
	D3	DB 10,"Wednesday",13,10,'$'
	D4	DB 10,"Thursday",13,10,'$'
	D5	DB 10,"Friday",13,10,'$'
	D6	DB 10,"Saturday",13,10,'$'
	D7	DB 10,"Sunday",13,10,'$'
	E1	DB 10,"Error!",13,10,'$'
	CaseTab DW Case0,Case1,Case2,Case3,Case4,Case5,Case6,Case7,Default
DATA	ENDS

CODE	SEGMENT
	ASSUME	CS: CODE,DS:DATA
START:	
	MOV	AX,DATA
	MOV	DS,AX

Again:
	MOV	AH,01
	INT 21H

	CMP AL,'0'
	JL Default
	CMP AL,'7'
	JG Default
	SUB	AL,'0'

	ADD AL,AL
	AND AX,0FH
	MOV BP,AX

	JMP Word ptr CaseTab[BP]
Case0:	
	MOV	AX, 4C00H
	INT  	21H
Case1:  
	LEA DX,D1
	JMP EndSwitch
Case2:  
	LEA DX,D2
	JMP EndSwitch
Case3:  
	LEA DX,D3
	JMP EndSwitch
Case4:  
	LEA DX,D4
	JMP EndSwitch
Case5:  
	LEA DX,D5
	JMP EndSwitch
Case6:  
	LEA DX,D6
	JMP EndSwitch
Case7:  	
	LEA DX,D7
	JMP EndSwitch
Default:
	LEA DX,E1
	JMP EndSwitch
EndSwitch:
	MOV AH,09H
	INT 21H
	JMP Again


	MOV	AX, 4C00H
	INT  	21H
CODE	ENDS
	END	 START