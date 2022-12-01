; "Hello, world"を標準出力

section .data
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
    push rbp
    mov rbp, rsp
    sub rsp, 0x16
    mov rax, 0x6F77206F6C6C6548     ; o w SP o l l e H (8bit)
    mov QWORD [rbp-0x12], rax
    mov DWORD [rbp-0x4], 0xA646C72  ; LF d l r (4bit)
    ; write システムコールの処理
    ; syscall番号の指定
    mov	rax, sys_write
    ; write の第1引数を定義
    mov rdi, stdout_code
    ; write の第2引数を定義
    lea rsi, [rbp-0x12]
    ; write の第3引数を定義
    mov rdx, 0x16
    ; write システムコールを実行
    syscall

    ; exit システムコールの処理
    ; syscall番号の指定
    mov rax, sys_exit
    ; exit の第1引数を定義
    mov rdi, return_code
    ; write システムコールを実行
    syscall
