; 现象：光标出现后消失，显示模式设置成功
; haribote-os
; TAB=4

		ORG		0xc200			

		MOV		AL,0x13			; VGA显卡，320x200x8位模式
		MOV		AH,0x00
		INT		0x10
fin:
		HLT
		JMP		fin
