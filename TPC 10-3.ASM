	include io.inc
	.model small
	.stack
	.data
intoff word ?
intseg word ?
adtemp byte 0
	.code
start:
	mov ax,@data
	mov ds,ax
	
	mov ax,350bh;��ȡϵͳ��ԭ0BH�ж���������
	int 21h
	mov intoff,bx;����ƫ�Ƶ�ַ
	mov intseg,es;����λ���ַ
	
	push ds
	mov dx,offset new0bh ;
	mov ax,seg new0bh
	mov ds,ax
	mov ax,250bh;���ñ������80H�ж���������
	int 21h
	pop ds
	
	in al,21h;��IMR
	and al,0f7h;����IRQ3
	out 21h,al;������IMR����

again:
	mov al,00h;AL=00���ٴε��øù��ܻ�ȡ��չASCII�ַ�����
	mov dx,298h
	out dx,al
		
	mov al,adtemp
	call dispuib
	call dispcrlf

	mov dl,0ffh;���ܣ�ֱ�ӿ���̨I/O�� DL=FF ����
	mov ah,06h;ֱ�ӿ���̨I/O,�������룬AL=�����ַ�������AL=0
	int 21h
	jz again
	.exit 0

new0bh proc  ;�ж�
	sti
	  
	push ax
	push dx
	push ds

	mov ax,@data
	mov ds,ax
	mov dx,298h
	in al,dx;��ȡA/Dת�����������
	mov adtemp,al;���뻺����
	call delay
	mov al,20h;����EIO����
	out 20h,al
	pop ds;�ָ��Ĵ���
	pop dx
	pop ax
	iret;�жϷ���
new0bh endp

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