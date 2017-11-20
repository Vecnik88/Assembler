%ifndef __GDT_INC
%define __GDT_INC

[bits 16]

LoadGDT:			; загружаем таблицу GDT в GDTR
	cli
	pusha
	lgdt [toc]		; загружаем таблицу GDT
	sti
	popa
	ret

	;-------------;
	; Таблица GDT ;
	;-------------;

gdt_data:
	dd 0x0			; нулевой дескриптор, всегда 1
	dd 0x0

; gdt_code:			; дескрпитор кода(ядра)
	dw 0xffff		; предел сегмента(можно увеличить за счет флагов granularity в pmode)
	dw 0x0			; базовый адрес нижние 16 бит
	db 0x0			; базовый адрес средние 8 бит
	db 10011010b	; флаги доступа
	db 11001111b	; флаги granularity
	db 0x0			; базовый адрес врехние 8 бит

; gdt_data:			; дескриптор данный(ядра)
	dw 0xffff		; предел сегмента(можно увеличить за счет флагов granularity в pmode)
	dw 0x0
	db 0x0
	db 10010010b
	db 11001111b
	db 0

; Это минимально необходимая таблица GDT
; Дальше должны идти дескрипторы кода и данных пространства пользователя и тд

end_fo_gdt:
toc:
	dw end_fo_gdt - gdt_data - 1
	dd gdt_data
%endif ; __GDT_INC