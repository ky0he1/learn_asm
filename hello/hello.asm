; "hello, world"を標準出力

section .data
	msg	db 'hello, world', 0x0A
	msg_len equ $-msg
	sys_write equ 1
	sys_exit equ 60

section .text
	global _start
_start:
	mov	rax, sys_write
	mov rdi, 1
	mov rsi, msg
	mov rdx, msg_len
	syscall
	mov rax, sys_exit
	mov rdi, 0
	syscall
