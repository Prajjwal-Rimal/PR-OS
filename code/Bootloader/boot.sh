#!/bin/bash

rm boot.bin bootStageTwo.bin boot.img

echo "compiling the first bootfile"
nasm -f bin boot.asm -o boot.bin


echo "compiling the second bootfile"
nasm -f bin bootStageTwo.asm -o bootStageTwo.bin


echo "concatenating the files"
cat boot.bin bootStageTwo.bin > boot.img


echo "starting qemu"
qemu-system-x86_64 -fda boot.img