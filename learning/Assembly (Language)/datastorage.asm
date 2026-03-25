section .data
	num DD 5; NAME SIZE AND THE VALUE VALUE IS IN THE STACK

section .txt
global _start
_start:

	mov eax,1
	mov ebx,[num]
	int 0x80

