; ASCII文字のテスト
; 0x4d2 を 1234 へ変換し表示する

section .data
    ; 改行の定義
    new_line db 0xA
    ; write システムコールの定義
    sys_write equ 1
    stdout_code equ 1
    ; exit システムコールの定義
    sys_exit equ 60
    return_code equ 0

section .text
global _start
_start:
    ; 変換テスト:1234
    mov rcx, 0x4d2
    ; 数字に変換し、ascii文字を出力
    call .print_ascii_number
    ; 改行を出力
    call .print_newline
    ; 終了
    call .exit

; 数字に変換
; 1234 / 10 = 123 ... 4
; 123 / 10 = 12 ... 3
; 12 / 10 = 1 ... 2
; 1 / 10 = 0 ... 1
.print_ascii_number:
    push rbp
    mov rbp, rsp
    sub rsp, 0x16
    ; 終端文字をスタック
    push 0x00
    ; 変換するカウントを割られる数に代入
    mov rax, rcx
    ; 変換のループ
    .convert_loop:
        xor rdx, rdx
        ; 割る数を代入
        mov rbx, 10
        ; 割り算(カウント:rax / 10:rbx = 答え:rax, 余り:rdx)
        div rbx
        ; 余りの数値(rdx)をascii文字の数字に変換
        add rdx, 0x30
        ; ascii文字をスタックに退避
        push rdx
        ; 答えが0になるまでループ
        cmp rax, 0
        jnz .convert_loop
    ; ascii文字を一文字ずつ出力
    .ascii_pop_loop:
        ; スタックのascii文字を取得
        pop r15
        ; ascii文字を標準出力
        mov rax, sys_write
        mov rdi, stdout_code
        mov [rbp], r15
        lea rsi, [rbp]
        mov rdx, 1
        push rcx
        syscall
        pop rcx
        ; 終端文字までループ
        cmp r15, 0x00
        jnz .ascii_pop_loop
    leave
    ret

; 改行を出力
.print_newline:
    mov rax, sys_write
    mov rdi, stdout_code
    mov rsi, new_line
    mov rdx, 1
    push rcx
    syscall
    pop rcx
    ret

; 終了
.exit:
    mov rax, sys_exit
    mov rdi, return_code
    syscall
    ret
