data segment para publoc 'data'
message db 'Hello World! No war and bomb! Let us live friendly and learn assembler language. $'
data ends
stk segment stack
	db 256 dup('?')							;	сегмент стека
stk ends
code segment para public 'code'				;	начало сегмента кода
main proc									;	начало процедуры main

	assume cs:code, ds:data, ss:stk
	mov ax, data							;	адрес сегмента данных в регистр ах
	mov ds, ax								;	ax в ds
	mov ah, 9
	mov dx, offset message
	int 21h									;	вывод сообщения на экран
	mov ax, 4c00h
	int 21h

main endp									;	конец процедуры main
code ends									;	конец сегмента кода
end main									;	конец программы с точкой входа main