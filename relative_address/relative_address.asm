; 相対アドレスのテスト
; 数字を"1"から"10"表示する

section .data
    ; "0"から"9"の定義
    numbers db "0123456789"

    ; 改行の定義
    new_line db 0xA

    ; write システムコールの定義
    sys_write equ 1
    stdout_code equ 1

    ; exit システムコールの定義
    sys_exit equ 60
    return_code equ 0

    ; ループ回数の定義
    limit equ 10

section .text
global main
main:
    ; カウンタの初期化
    xor rcx, rcx

    ; ループ実行
    call .loop

    ; 終了
    call .exit

; ループ
.loop:
    ; 数字を出力
    call .print_number
    ; 改行を出力
    call .print_newline
    ; カウンタをインクリメント
    inc rcx
    ; limit(10)より小さい場合.loopへジャンプ
    cmp rcx, limit
    jb .loop
    ret

; 数字を出力
.print_number:
    mov rax, sys_write
    mov rdi, stdout_code
    mov rsi, numbers
    add rsi, rcx
    mov rdx, 1
    ; syscallはripをrcxに退避するため
    ; syscall実行前にrcxを退避
    push rcx
    syscall
    pop rcx
    ret

; 改行を出力
.print_newline:
    mov rax, sys_write
    mov rdi, stdout_code
    mov rsi, new_line
    mov rdx, 1
    ; syscallはripをrcxに退避するため
    ; syscall実行前にrcxを退避
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