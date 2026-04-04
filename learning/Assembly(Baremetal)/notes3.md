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