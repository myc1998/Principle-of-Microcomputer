	include io.inc
	.model small
	.stack
	.data
	.code
start:
	mov ax,@data
	mov ds,ax
	mov dx,28bh
	mov al,10001000b;��ʽ0 C�˿�����
	
start1:
	mov al,00h;AL=00���ٴε��øù��ܻ�ȡ��չASCII�ַ�����
	mov dx,298h
	out dx,al

	mov dx,28ah;ѭ����ѯ�Ƿ�ת������
start2:	
	in al,dx;����״̬��Ϣ
	test al,80h
	jz start2;û�н�����������ѯ

	mov dx,298h
	in al,dx
	call dispuib
	call dispcrlf
	call delay

	mov dl,0ffh;���ܣ��������빦�ܵ��ã� DL=FF ��Ӧ���빦��
	mov ah,06h;ֱ�ӿ���̨I/O,�������룬AL���������ַ���ASCII�ַ�������AL=0
	int 21h
	jz start1
	.exit 0

;��ʱ�ӳ���	
delay proc 
	push bx
	push cx
	mov bx,100
delay1: xor cx,cx
delay2:
	loop delay2
	dec bx
	jnz delay1
	pop cx
	pop bx
	ret
delay endp


end start	  