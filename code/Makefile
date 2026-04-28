stage1:
	# to compile the first stage of the bootloader
	nasm -f bin Bootloader/src/boot.asm -o Bootloader/bin/boot.bin

stage2:
	# to compile the second stage of the bootloader
	nasm -f bin Bootloader/src/bootStageTwo.asm -o Bootloader/bin/bootStageTwo.bin
	
kernel: 
	# -f is for output format 
	nasm -f elf32 Kernel/src/kernel.asm -o Kernel/build/kernel_entry.o
	# combining the c source file without an OS, optimizations or a standard library using the cross compiler
	i686-elf-gcc -c Kernel/src/kernel.c -o Kernel/build/kernel.o -ffreestanding -O0 -nostdlib -fno-stack-protector
	# combining the kernel files using the linker script
	# specifying the input files, output file, attaching a linker file to the memory, and mentioning the output format 
	i686-elf-ld -o Kernel/bin/kernel.bin -T Bootloader/linker.ld Kernel/build/kernel_entry.o Kernel/build/kernel.o --oformat binary

truncate:
	# setting the file to the specific size
	# 1 sector
	truncate -s 512 Bootloader/bin/boot.bin
	# 8 sector
	truncate -s 4096 Bootloader/bin/bootStageTwo.bin

combine:
	# concatenating everything into a single file and making a image file
	cat Bootloader/bin/boot.bin Bootloader/bin/bootStageTwo.bin Kernel/bin/kernel.bin > os_image.bin

	# command to compile all
all: stage1 stage2 kernel truncate combine

run: combine
	# combine dependency and command to ru it in qemu in monitoring mode 
	qemu-system-i386 -hda os_image.bin -monitor stdio
