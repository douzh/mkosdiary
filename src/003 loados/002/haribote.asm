; ���󣺹����ֺ���ʧ����ʾģʽ���óɹ�
; haribote-os
; TAB=4

		ORG		0xc200			

		MOV		AL,0x13			; VGA�Կ���320x200x8λģʽ
		MOV		AH,0x00
		INT		0x10
fin:
		HLT
		JMP		fin
