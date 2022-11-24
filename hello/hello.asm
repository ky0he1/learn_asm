; "hello, world"を標準出力

section .data
	; "hello, world"を定義
	msg	db 'hello, world', 0x0A
	; "hello, world"の文字数を定義
	msg_len equ $-msg

	; write システムコールを定義
	sys_write equ 1
	; write のファイルディスクリプタを定義(標準出力)
	stdout_code equ 1

	; exit システムコールを定義
	sys_exit equ 60
	; exit のリターンコードを定義(正常終了)
	return_code equ 0

section .text
	global _start
_start:
	mov	rax, sys_write
	mov rdi, stdout_code
	mov rsi, msg
	mov rdx, msg_len
	syscall
	mov rax, sys_exit
	mov rdi, return_code
	syscall
