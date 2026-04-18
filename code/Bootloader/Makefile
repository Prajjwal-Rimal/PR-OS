stage1:
	# typing make all will compile the asm file to the binary file
	# this will produce a binary of the boot asm in the binary folder 
	nasm -f bin ./src/boot.asm -o ./bin/boot.bin

stage2:
	nasm -f bin ./src/bootStageTwo.asm -o ./bin/bootStageTwo.bin

combine:
	cat ./bin/boot.bin ./bin/bootStageTwo.bin > ./img/boot.img

cleanBin:
	# clean will remove the existing binary file
	rm -f ./bin/*.bin

cleanImg:
	rm -f ./img/*.img

# writing all in seperate line would act like commands for the terminal
# defining them in a single line creates dependencies 
# this basically says to build this stage1 stage2 and combine all should be built
all: stage1 stage2 combine

run: combine
	qemu-system-x86_64 -fda ./img/boot.img