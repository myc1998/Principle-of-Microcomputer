 ;֧���ӳ����ļ򻯶�Դ�����ʽ
    include io.inc
	.model small	; �������Ĵ洢ģʽ
	.stack	; �����ջ�Σ�Ĭ����1KB�ռ䣩
	.data	;���ݶ�

	.code	;�����
start:	
	mov ax,@data
	mov ds,ax
	
	mov al,10h	;00 11 000 1
	mov dx,283h
	out dx,al
	mov ax,3
	mov dx,280h
	out dx,al	
       mov ah,al
       out dx,al
call delay
	mov al,00h
	mov dx,283h
	out dx,al
	mov dx,280h
	in al,dx
	call dispuib
again:
	call delay
	mov al,00h
	mov dx,283h
	out dx,al
	mov dx,280h
	in al,dx
	call dispuib
	cmp al,0
   	jnz again
			
	.exit 0
delay proc
push cx
push dx
mov ah,86h
	mov cx,0ffh
	   mov dx,8480h
	   int 15h
pop cx
pop dx 
delay endp
end start