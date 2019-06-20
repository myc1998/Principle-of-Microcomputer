 include io.inc
		.model small
		.stack
		.data
	intmsg3First byte 'TCPA Interrupt No.3 start !',13,10,0
	intmsg3Second byte 'TCPA Interrupt No.3 finish !',13,10,0
	intmsg10First byte 'TCPA Interrupt No.10 start !',13,10,0
	intmsg10Second byte 'TCPA Interrupt No.10 finish !',13,10,0
	counter byte 0
		
		.code
;���ȶ�0Bh�ж��������б���
start:
	mov ax,@data
      mov ds,ax
	mov ax,350Bh
	int 21h
	push es
	push bx
	
;�����µ�0Bh�ж���������
	cli          ;���ж�
	push ds
	mov ax,seg new0Bh
	mov ds,ax
	mov dx,offset new0Bh
	mov ax,250Bh
	int 21h
	pop ds
	
;��72h�ж��������б���
	mov ax,3572h
	int 21h
	push es
	push bx
;�����µ�72h�ж���������
	cli          ;���ж�
	push ds
	mov ax,seg new72h
	mov ds,ax
	mov dx,offset new72h
	mov ax,2572h
	int 21h
	pop ds
	
;����IRQ3�ж�
	in al,21h   ;����IMR
	push ax      ;����ԭIMR����
	and al,0f7h  ;����IRQ3���������ݲ��䣬����IRQ3Ϊ0
	out 21h,al	 ;������IMR����
;����IRQ10�ж�
	in al,0A1h   ;����IMR
	push ax      ;����ԭIMR����
	and al,0fbh  ;����IRQ10���������ݲ��䣬����IRQ10Ϊ0
	out 0A1h,al	 ;������IMR����

	mov counter,0
	sti			 ;���ж�
;����������жϷ���������ã���ʼ������������
	
start1:
	cmp counter,5
	jb start1
	;
	cli          ;���ж�
	pop ax		 ;�ָ�IMR
	out 21h,al
	pop dx		 ;�ָ�ԭ�ж���������
	pop ds
	mov ax,250Bh
	int 21h
	
	pop ax
      out 0A1h,al
      pop dx
      pop ds
      mov ax,2572h
      int 21h
	sti 	
	.exit 0
	
;new3���жϷ������
new0Bh proc
	   sti		 ;���ж�
	   push ax
	   push si
	   push ds
	   mov ax,@data    ;�ⲿ��������жϣ�DSҲ��ȷ�������Ա�������DS
	   mov ds,ax
	   inc counter	   ;�жϴ�����1
	   mov si,offset intmsg3First
	   call dpstri
;��ʱ
	   mov ah,86h
	   mov cx,0ffh
	   mov dx,8480h
	   int 15h
	   
;��ʾ�ж�3�ڶ����ַ���
	   mov si,offset intmsg3Second
	   call dpstri
	   mov al,20h      ;����EOI����
	   out 20h,al
	   pop ds
	   pop si
	   pop ax
	   iret				;�жϷ���
new0Bh endp
;new10���жϷ������
new72h proc
	   sti		 ;���ж�
	   push ax
	   push si
	   push ds
	   mov ax,@data    ;�ⲿ��������жϣ�DSҲ��ȷ�������Ա�������DS
	   mov ds,ax
	   inc counter	   ;�жϴ�����1;��ʾ�ж�10��һ���ַ���
	   mov si,offset intmsg10First
	   call dpstri
	   ;��ʱ
	   mov ah,86h
	   mov cx,0ffh
	   mov dx,8480h
	   int 15h
	   
	   ;��ʾ�ж�10�ڶ����ַ���
	   mov si,offset intmsg10Second
	   call dpstri
	   mov al,20h      ;����EOI����
	   out 0a0h,al	   ;д���ƬEOI����
	   out 20h,al	   ;д����ƬEOI����
	   pop ds
	   pop si
	   pop ax
	   iret				;�жϷ���
new72h endp

dpstri proc				;��ʾ�ַ����ӳ���
	   push ax			;��ڲ�����DS��SI=�ַ�����ַ
	   push bx
dsp1:  mov al,[si]
	   cmp al,0
	   jz dps2
	   mov bx,0
	   mov ah,0eh
	   int 10h
	   inc si
	   jmp dsp1
dps2:  pop bx
	   pop ax
	   ret
dpstri endp
	   
		.exit 0
		end start