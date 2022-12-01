#!/bin/bash

if [ $# -ne 1 ] || [ ${1##*.} != "asm" ]; then
  echo "拡張子が\".asm\"のファイルを指定してください。"
  echo "ファイル名: $1"
  exit 1
fi

# ファイル名取得
filename=$(basename $1 .asm)

# 出力ディレクトリ作成
mkdir -p out

# オブジェクトコード生成
nasm -g -f elf64 -o ./out/$filename.o $1

# 実行ファイル生成
ld -g -o ./out/$filename ./out/$filename.o

# 実行ファイル実行
./out/$filename
