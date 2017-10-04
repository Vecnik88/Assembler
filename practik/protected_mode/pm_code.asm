mov esi, message
mov edi, 0B8000h
mov ecx, 18

rep movsb
jmp $

message: db "152535455565758595"