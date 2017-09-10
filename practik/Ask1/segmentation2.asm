;nasm
;model small
;.data
message db 'Hello world! $'
;.stack 256h
;.code
;main proc

	;mov ax, @data
	mov ds, ax
	mov ah, 9
	mov dx, message
	int 21h
	mov ax, 4c00h
	int 21h

;main endp
;end main