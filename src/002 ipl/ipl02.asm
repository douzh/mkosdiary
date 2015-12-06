;
;���ܣ��������̵ĵ�һ������,���Դ�5��
;���룺nasm.exe
; hello-os
; TAB=4

		ORG		0x7c00			; ָ�������װ�ص�ַ

; ���µļ������ڱ�׼��FAT12��ʽ������

		JMP		entry
		DB		0x90
		DB		"HELLOIPL"		; �����������ƿ�����������ַ���(8�ֽ�)
		DW		512				; ÿ������(sector)�Ĵ�С(����Ϊ512�ֽ�)
		DB		1				; ��(cluster)�Ĵ�С(����Ϊ1������)
		DW		1				; FAT����ʼλ��(һ��ӵ�һ��������ʼ)
		DB		2				; FAT�ĸ���(����Ϊ2)
		DW		224				; ��Ŀ¼�Ĵ�С(һ�����224��)
		DW		2880			; �ô��̵Ĵ�С(������2880����)
		DB		0xf0			; Ӳ�̵�����(������oxf0)
		DW		9				; FAT�ĳ���(������9����)
		DW		18				; 1���ŵ�(track)�м�������(������18)
		DW		2				; ��ͷ��(������2)
		DD		0				; ��ʹ�÷�����������0
		DD		2880			; ��дһ�δ��̴�С
		DB		0,0,0x29		; ���岻�����̶�
		DD		0xffffffff		; (������)�������
		DB		"HELLO-OS   "	; ���̵�����(11�ֽ�)
		DB		"FAT12   "		; ���̸�ʽ����(8�ֽ�)
		RESB	18				; �ȿճ�18�ֽ�

; �������

entry:
		MOV		AX,0			; ���W�X�^������
		MOV		SS,AX
		MOV		SP,0x7c00
		MOV		DS,AX

;��ȡ�������� 

		MOV		AX,0x0820
		MOV		ES,AX
		MOV		CH,0			; ����0
		MOV		DH,0			; ��ͷ0
		MOV		CL,2			; ����2

		MOV		SI,0			;��¼ʧ�ܴ����ļĴ��� 
retry:
		MOV		AH,0x02			; AH=0x02 : ����
		MOV		AL,1			; 1������
		MOV		BX,0
		MOV		DL,0x00			; A������
		INT		0x13			; ���ô���BIOS
		JNC		fin				; û����ת��fin
		ADD		SI,1			; SI��1
		CMP		SI,5			; SI��5��
		JAE		error			; SI >= 5 ��ת��error
		MOV		AH,0x00
		MOV		DL,0x00			; A������
		INT		0x13			; ����������
		JMP		retry

; 

fin:
		HLT						; ��CPUֹͣ���ȴ�ָ��
		JMP		fin				; ����ѭ��

error:
		MOV		SI,msg
putloop:
		MOV		AL,[SI]
		ADD		SI,1			; ��SI��1
		CMP		AL,0
		JE		fin
		MOV		AH,0x0e			; ��ʾһ������
		MOV		BX,15			; ָ���ַ���ɫ
		INT		0x10			; �����Կ�BIOS
		JMP		putloop
msg:
		DB		0x0a, 0x0a		; ����2��
		DB		"load error"
		DB		0x0a			; ����
		DB		0

		RESB	0x7dfe-($-$$)		; ��д0x00ֱ��0x001fe

		DB		0x55, 0xaa