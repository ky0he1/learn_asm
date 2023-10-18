; コマンドライン引数を表示するテスト

section .text
global _start
_start:
    ; int argc
    mov rdi, [rsp]
    ; char* argv[1] = [rsp+0x8]
    ; char* argv[2]
    mov rsi, [rsp+0x10]

    ; argc = 1 の場合 exit
    cmp rdi, 1
    jz .exit

    ; カウント初期化
    xor rcx, rcx
    call .strlen

    ; コマンドライン引数表示
    call .print

; 終了
.exit:
    mov rax, 60
    mov rdi, 0
    syscall


; 文字数カウント
.strlen:
.loop:
    ; 1文字取得
    mov al, BYTE [rsi+rcx]
    ; 0 かどうか
    cmp al, 0
    ; 0 (文字列の末尾) の場合 break
    jz .break
    ; インクリメント
    add rcx, 1
    ; ループ
    jmp .loop
.break:
    ret


; コマンドライン引数表示
.print:
    ; write の指定
    mov	rax, 1
    ; 第1引数を定義
    mov rdi, 1
    ; 第2引数を定義
    mov rsi, rsi
    ; 第3引数を定義
    mov rdx, rcx
    ; システムコールを実行
    syscall
    ret
