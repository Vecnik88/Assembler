[bits 16]

[org 0x7c0]
jmp main

%include "stdio.s"
%include "gdt.s"

LoadingMsg db "Preparing to load operating system...", 0x0D, 0x0A, 0x00

main:
	;-------------------------------;
	; Устанавливаем сегменты и стек ;
	;-------------------------------;

	cli				; запрещаем прерывания
	xor ax, ax		; зануляем
	mov ds, ax
	mov es, ax
	mov ax, 0x9000
	mov ss, ax		; стек начниается на 0х9000:0xffff
	mov sp, 0xffff	; разрешаем прерывания
	sti

	;-----------------------------;
	; Печатаем сообщение загрузки ;
	;-----------------------------;

	mov si, LoadingMsg
	call Puts16

	;---------------;
	; Загружаем GDT ;
	;---------------;

	call LoadGDT

	;----------------------------;
	; Переходим в Protected Mode ;
	;----------------------------;

	cli
	mov eax, cr0
	or eax, 1		; устанавливаем бит 0 в cr0 для перехода в pmode
	mov cr0, eax

	jmp 0x08:Stage3	; таким устанавливаем значение в регистре cs

	;---------------------;
	; ##### STAGE 3 ##### ;
	;---------------------;

[bits 32]
Stage3:
	mov ax, 0x10
	mov ds, ax
	mov ss, ax
	mov es, ax
	mov esp, 0x9000

	;-------------------------;
	; Останавливаем процессор ;
	;-------------------------;

STOP:
	cli
	hlt

times 510-($-$$) db 0
dw 0x55aa