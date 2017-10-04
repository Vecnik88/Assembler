[org 0x7c00]
mov edi, message
mov eax, 0x80000002
cpuid
mov [edi], eax
add edi, 4
mov [edi], eax
add edi, 4
mov [edi], ebx
add edi, 4
mov eax, 0x80000003
cpuid
mov [edi], eax
add edi, 4
mov [edi], ebx
add edi, 4
mov [edi], edx
add edi, 4
mov [edi], eax
add edi, 4
mov [edi], ebx
add edi, 4
mov [edi], ecx
add edi, 4
mov [edi], edx

message:
	db 00000000000000000000000000000000

print:
	pusha

start:
	mov al, [bx]
	cmp al, 0
	je done

	mov ah, 0x0e
	int 0x10

	add bx, 1
	jmp start

done:
	popa
	ret

print_nl:
	pusha

	mov ah, 0x0e
	mov al, 0x0a
	int 0x10
	mov al, 0x0d
	int 0x10

	popa
	ret

times 510-($-$$) db 0
dw 0xaa55