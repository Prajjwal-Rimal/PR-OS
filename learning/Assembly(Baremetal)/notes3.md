## Bootloader second stage
- this is the feature rich stage after all the limitations
- steps to make the second stage:
    1. jump to the second stage
    2. enable a20 line
    3. set up interrupt descriptor table
    4. set up global descriptor table
    5. load the descriptor tables to the cpu
    6. switch to protected mode
    7. set up the kernel stack
    8. transfer control to the kernel via the long jump 


- thing to decide :
    * where are the bytes loaded ?
        + we cant load bytes where ever we want some memory is saved for other aspects some is already used like 0x7c00, at the same time we need enough memory to set up everything else, use the segment and offset

	* where the kernel is going to load
		+ it would be better to decide where to load the kernel before hand  as well 


---
https://thejat.in/learn/different-stages-of-bootloader

1. the second stage bootloader follows almost immediately after the first stage 
2. 0xA0000 – 0xFFFFF -> reserved (video/BIOS) is reserved for the bios


---

## SEGMENT OFFSET ADDRESSING

`Physical Address = (Segment × 16) + Offset	`

## Memory mounting for the second stage and the kernel stage
1. stage 1 is always loaded at `0x7c00`; has a  size of 512 bytes; `0x7C00+0x1FF= 0x7DFF`; the last 2 bytes are 0xaa55

2. the second stage can be immediately loaded after stage 1 buyt it is good to give a bit of buffer to it so it doesnt overlap with the stage 1 stack, we do not want it to be very far off but it shouldnt be so close to overwrite the stack of stage 1; recommended to leave few hundred bytes to load the kernel like load it at `0x8000`. `0x9000` is not remommended but can be done

3. `0x100000` is generally where the kernel is loaded at the 1 mb mark, real mode can only acess memory below the 1mb mark `ie till the time it can be registered as 20 bit address` after this it goes into 32 bit addressing



## Real Mode Memory Map (0x00000 – 0xFFFFF)

| Address Range      | Size       | Purpose / Reserved For                                   |
|-------------------|-----------|----------------------------------------------------------|
| 0x00000 – 0x003FF | 1 KB      | Interrupt Vector Table (IVT) – CPU interrupt handlers  |
| 0x00400 – 0x004FF | 256 B     | BIOS Data Area (BDA) – keyboard, COM ports, system info |
| 0x00500 – 0x7BFF | ~31 KB    | Conventional memory – free for programs, Stage 1 stack |
| 0x7C00 – 0x7DFF | 512 B      | Stage 1 Bootloader (loaded by BIOS), last 2 bytes 0xAA55 |
| 0x7E00 – 0x9FFF | ~144 KB   | Stage 2 Bootloader / temporary buffers                |
| 0xA000 – 0xBFFF | 128 KB    | Video RAM (VGA, text and graphics buffer)             |
| 0xC000 – 0xEFFF | 192 KB    | ROM extensions / memory-mapped hardware               |
| 0xF0000 – 0xFFFF | 64 KB     | System BIOS ROM – contains BIOS routines and bootstrap code |
| 0x100000+         | -         | Kernel / protected mode memory (requires A20 line)    |