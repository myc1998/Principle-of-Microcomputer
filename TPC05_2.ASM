  ;֧���ӳ����ļ򻯶�Դ�����ʽ
    include io.inc
	.model small	; �������Ĵ洢ģʽ
	.stack	; �����ջ�Σ�Ĭ����1KB�ռ䣩
	.data	;���ݶ�

	.code	;�����
start:	
	mov ax,@data
	mov ds,ax
	
	mov al,00110110B
	mov dx,283h
	out dx,al	
	mov ax,1000
	mov dx,280h
	out dx,al
	mov al,ah
	out dx,al

	mov al,01110110B
	mov dx,283h
	out dx,al
	mov ax,1000
	mov dx,281h
	out dx,al
	mov al,ah
	out dx,al

	.exit 0

	end start