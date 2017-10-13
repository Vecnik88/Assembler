[bits 16]
text:
global start

start:
	mov ax, 0
	mov ax, ds
	mov ax, ss

	mov sp, 0x7c00
	add sp, 0x0400

	mov ax, 0xb800
	mov es, ax
	mov si, data
	mov di, 0
	mov cx, size
	call memcpy

loop:
	jmp loop

memcpy:
	test cx, cx
	jz out
again:
	mov ah, [si]
	mov di, ah
	inc si
	inc di
	dec cx
	jnz again
out:
	ret

data:
	db 'Hello', '0'