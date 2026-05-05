stage1:
	# to compile the first stage of the bootloader
	nasm -f bin Bootloader/src/boot.asm -o Bootloader/bin/boot.bin

stage2:
	# to compile the second stage of the bootloader
	nasm -f bin Bootloader/src/bootStageTwo.asm -o Bootloader/bin/bootStageTwo.bin

rust_userspace:
	# Added unstable-options and json-target-spec to allow the .json file
	cd Userspace/rust_userspace && cargo +nightly build --release \
		-Z unstable-options \
		-Z json-target-spec \
		--target i686-unknown-none.json \
		-Z build-std=core,compiler_builtins

kernel: rust_userspace
	# 1. Compile assembly
	nasm -f elf32 Kernel/src/kernel.asm -o Kernel/build/kernel_entry.o
	nasm -f elf32 Kernel/src/gdtflush.asm -o Kernel/build/gdt_flush.o
	nasm -f elf32 Kernel/src/idtflush.asm -o Kernel/build/idt_flush.o
	nasm -f elf32 Kernel/src/userspace.asm -o Kernel/build/userspace.o
    
	# 2. Compile C logic
	i686-elf-gcc -c Kernel/src/kernel.c -o Kernel/build/kernel.o -ffreestanding -O0 -nostdlib -fno-stack-protector -fno-builtin -I Kernel/src/
	i686-elf-gcc -c Kernel/src/gdt.c -o Kernel/build/gdt.o -ffreestanding -O0 -nostdlib -fno-stack-protector -fno-builtin -I Kernel/src/
	i686-elf-gcc -c Kernel/src/idt.c -o Kernel/build/idt.o -ffreestanding -O0 -nostdlib -fno-stack-protector -fno-builtin -I Kernel/src/
	i686-elf-gcc -c Kernel/src/vga.c -o Kernel/build/vga.o -ffreestanding -O0 -nostdlib -fno-stack-protector -fno-builtin -I Kernel/src/
	i686-elf-gcc -c Kernel/src/driver.c -o Kernel/build/driver.o -ffreestanding -O0 -nostdlib -fno-stack-protector -fno-builtin -I Kernel/src/

	# 3. Link everything
	i686-elf-ld -o Kernel/bin/kernel.bin -T Bootloader/linker.ld \
		Kernel/build/kernel_entry.o \
		Kernel/build/kernel.o \
		Kernel/build/gdt.o \
		Kernel/build/gdt_flush.o \
		Kernel/build/idt.o \
		Kernel/build/idt_flush.o \
		Kernel/build/vga.o \
		Kernel/build/driver.o \
		Kernel/build/userspace.o \
		Userspace/rust_userspace/target/i686-unknown-none/release/librust_userspace.a \
		--oformat binary
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

run: all
	# combine dependency and command to run it in qemu
	# 4GB memory provided as requested
	qemu-system-i386 -m 4096 -drive format=raw,file=os_image.bin -monitor stdio