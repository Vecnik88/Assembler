ORG 100h

stack_base_address equ 200000h
user_pm_code_base_address equ 400000h
user_pm_code_size equ user_pm_code_end - user_pm_code_base_address

code_selector equ 8h
data_selector equ 10h
video_selector 18h

start:
	mov ax, 3
	int 10h

	in al, 92h
	or al, 2
	out 92h, al

	xor eax, eax
	mov ax, cs
	shl eax, 4
	add eax, protected_mode_entry_point
	mov [entry_off], eax

	xor eax, eax
	mov ax, cs
	shl eax, 4
	add ax, GDT

	mov dword [GDTR+2], eax
	lgdt fword [GDTR]

	cli
	in al, 70h
	or al, 80h
	out 70h, al

	mov eax, cr0
	or al, 1
	mov cr0, eax

	db 66h
	db 0EAh
	entry_off dd protected_mode_entry_point
	dw code_selector
	align 8
	GDT:
	null_descr db 8 dup(0)
	code_descr db 0FFh, 0FFh, 00h, 00h, 10011010b, 11001111b, 00h
	data_descr db 0FFh, 0FFh, 00h, 00h, 10011010b, 11001111b, 00h
	video_descr db 0FFh, 0FFh, 00h, 80h, 0Bh, 10010010b, 01000000b, 00h
	GDT_size equ $-GDT

	label GDTR fword
		dw GDT_size-1
		dd ?

		use32

	protected_mode_entry_point:
		mov ax, data_selector
		mov ds, ax
		mov es, ax
		mov ss, ax
		mov esp, stack_base_address

		call delta
			delta:

			pop ebx
			add ebx, user_pm_code_start-delta

			mov esi, ebx
			mov edi, user_pm_code_base_address
			mov ecx, user_pm_code_size
			rep movsb

			mov eax, user_pm_code_base_address
			jmp eax

	user_pm_code_start:
		ORG user_pm_code_base_address

		include 'pm_code.asm'

	user_pm_code_end: