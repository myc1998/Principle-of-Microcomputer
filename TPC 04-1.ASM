 include io.inc
	.model small
	.stack
	.data
msg	byte 'TPCA InternetNo.3!',0dh,0ah,0
counter byte 0
	.code
start:
	mov ax,@data
	mov ds,ax
	
	mov ax,350bh  ;��ȡԭ�ж�������
	int 21h
	push es	;����ԭ�ж���������
	push bx
	cli		;���ж�
	push ds
	mov ax,seg new0bh
	mov ds,ax
	mov dx,offset new0bh
	mov ax, 250bh
	int 21h       ;�������ж�
	pop ds
	in al,21h    ;����imr
	push ax		;����ԭIMR����
	and al,0f7h	;����irq3����������
	out 21h,al			;�����µ�imr����
	mov counter,0		;�����жϳ�ʼ����
	sti         ;���ж�

start1:
	cmp counter,5
	jb start1
      .exit 0 
	
	cli
	pop   ax   ;�ָ�imr
	out 21h,al
	pop dx
	pop ds
	mov ax,250bh
	int 21h
	sti
;�жϷ������
new0bh  proc
	sti
	push ax	;�����Ĵ���
	push si
	push ds
	mov ax,@data	;�ⲿ��������жϣ�dsҲ��ȷ�������Ա�������ds
	mov ds,ax
	inc counter
	mov si,offset msg
	call   dpstri
	mov al,20h		
	out 20h,al			;��ͨ�жϽ���EOI��ʽ
	pop ds
	pop si
	pop ax
	iret			;�жϷ���
new0bh endp 

dpstri proc			;��ʾ�ַ����ӳ���
	 push ax
	 push bx
dps1:					;�ַ���ʾ����
	 mov al,[si]
	 cmp al,0
	 jz dps2
	 mov bx,0
	 mov ah,0eh
	 int 10h
	 inc si
	 jmp dps1
dps2:					;�ָ��Ĵ���
	 pop bx
	 pop ax
	 ret
dpstri endp


	end start







