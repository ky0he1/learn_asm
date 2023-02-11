; "hello, world"を標準出力

section .data
    ; "hello, world"を定義
    msg	db 'hello, world', 0x0A
    ; "hello, world"の文字数を定義
    msg_len equ $-msg

    ; write システムコールを定義
    sys_write equ 4
    ; write のファイルディスクリプタを定義(標準出力)
    stdout_code equ 1

    ; exit システムコールを定義
    sys_exit equ 1
    ; exit のリターンコードを定義(正常終了)
    return_code equ 0

section .text
global _start
_start:
    ; write システムコールの処理
    ; syscall番号の指定
    mov	eax, sys_write
    ; write の第1引数を定義
    mov ebx, stdout_code
    ; write の第2引数を定義
    mov ecx, msg
    ; write の第3引数を定義
    mov edx, msg_len
    ; write システムコールを実行
    int 0x80

    ; exit システムコールの処理
    ; syscall番号の指定
    mov eax, sys_exit
    ; exit の第1引数を定義
    mov ebx, return_code
    ; write システムコールを実行
    int 0x80
