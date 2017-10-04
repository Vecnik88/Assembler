[org 0x7c00]
message:
	times 49 db 0

mov edi, message
mov eax, 0x80000002
cpuid
mov [edi], eax
add edi, 4
call print
call print_nl
mov [edi], eax
add edi, 4
call print
call print_nl
mov [edi], ebx
add edi, 4
call print
call print_nl
mov eax, 0x80000003
cpuid
mov [edi], eax
add edi, 4
call print
call print_nl
mov [edi], ebx
add edi, 4
call print
call print_nl
mov [edi], edx
add edi, 4
call print
call print_nl
mov [edi], eax
add edi, 4
call print
call print_nl
mov [edi], ebx
add edi, 4
call print
call print_nl
mov [edi], ecx
add edi, 4
call print
call print_nl
mov [edi], edx

jmp $

print:
	pusha

start:
	mov al, [edi]
	cmp al, 0
	je done

	mov ah, 0x0e
	int 0x10

	add edi, 1
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