; ループのテスト
; "Hello, world"を10回標準出力する

section .data
    ; "Hello, world"の定義
    msg db "Hello, world!", 10
    msg_len equ $-msg

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

    ; ループ
    .loop:
        ; "Hello, world"出力
        call .print_hello
        ; カウンタをインクリメント
        inc rcx

        ; limit(10)より小さい場合.loopへジャンプ
        cmp rcx, limit
        jb .loop

    ; 終了
    call .exit


; "Hello, world"出力
.print_hello:
    mov rax, sys_write
    mov rdi, stdout_code
    mov rsi, msg
    mov rdx, msg_len
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
