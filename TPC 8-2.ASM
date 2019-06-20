include io.inc
	.model small
	.stack
	.data
leddt byte 3,4,5,6
;ledtb byte 0c0h,0f9h,0a4h,0b0h,99h,92h,82h,0f8h,80h,90h,88h,83h,0c1h,86h,8eh
ledtb byte 3fh,06h,05bh,04fh,66h,6dh,7dh,07h,7fh,6fh
	.code
start:
	  mov ax,@data
        mov ds,ax 
again:  
	  mov dx,28bh
        mov al,80h
        out dx,al
        mov si,offset leddt
        call displed
        jmp again
        .exit 0

displed proc
	push ax
	push bx
	push dx
	xor bx,bx
	mov ah,01h;ָ������ߵ������
led1: mov bl,[si];ȡ��Ҫ��ʾ������
	inc si	;
	mov al,ledtb[bx];�õ���ʾ���룺AL->LEDTB[BX]
	mov dx,288h;segportΪ�ο��ƶ˿�
	out dx,al;�ͳ�����
	mov al,ah;ȡ��λ��ʾ����
	mov dx,289h;λ���ƶ˿�
	out dx,al;�ͳ�λ��
	call delay;ʵ���������ʱ��ʾ
      rol ah,1
	cmp ah,10h;�Ƿ�ָ�����ұ������
	jnz led1;û�У���ʾ��һ������
	pop dx
	pop bx
	pop ax
	ret
displed endp
;��ʱ�ӳ���
timer	=5
delay	proc
	push bx
	push cx
	mov bx,timer
delay1:
	xor cx,cx
delay2:
	loop delay2
	dec bx
	jnz delay1
	pop cx
	pop bx
	ret
delay endp
	
	end start
 