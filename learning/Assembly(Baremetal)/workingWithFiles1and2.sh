#!/bin/bash

rm workingWithFiles.bin workingWithFilesTwo.bin workingwithfiles.img

echo "compiling the first bootfile"
nasm -f bin workingWithFiles.asm -o workingWithFiles.bin


echo "compiling the second bootfile"
nasm -f bin workingWithFilesTwo.asm -o workingWithFilesTwo.bin


echo "concatenating the files"
cat workingWithFiles.bin workingWithFilesTwo.bin > workingwithfiles.img


echo "starting qemu"
qemu-system-x86_64 -fda workingwithfiles.img