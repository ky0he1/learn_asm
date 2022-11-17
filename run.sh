#!/bin/bash

if [ $# -ne 1 ] || [ ${1##*.} != "asm" ]; then
  echo "拡張子が\".asm\"のファイルを指定してください。"
  echo "ファイル名: $1"
  exit 1
fi

filename=$(basename $1 .asm)

# オブジェクトコード生成
nasm -f elf64 $1

# リンクし実行ファイル生成
ld -s -o $filename $filename.o

# 実行ファイル実行
./$filename
