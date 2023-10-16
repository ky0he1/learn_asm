; sys_open, sys_write, sys_close のテスト
section .data
    filename db 'output.txt', 0
    hello db 'Hello, world!'
    hello_len equ $-hello

section .text
    global _start

_start:
    ; ファイルをオープンする
    mov rax, 2 ; sys_open のシステムコール番号
    mov rdi, filename ; ファイル名のアドレス
    mov rsi, 1 | 64 | 512 ; O_WRONLY | O_CREATE | O_TRUNC フラグ
    mov rdx, 420 ; 0o644 ファイルのアクセスモード
    syscall
    mov r10, rax ; ファイルディスクリプタを保存

    ; ファイルに書き込む
    mov rax, 1 ; sys_write のシステムコール番号
    mov rdi, r10 ; ファイルディスクリプタ
    mov rsi, hello ; 書き込むデータのアドレス
    mov rdx, hello_len ; データのサイズ
    syscall

    ; ファイルを閉じる
    mov rax, 3 ; sys_close のシステムコール番号
    mov rdi, r10 ; ファイルディスクリプタ
    syscall

    ; プログラムを終了する
    mov rax, 60 ; sys_exit のシステムコール番号
    xor rdi, rdi ; 終了コード 0
    syscall
