# Registers

| Register | Purpose / Notes |
|----------|-----------------|
| AX       | Accumulator — general purpose (AL = low byte, AH = high byte) |
| BX       | Base register — general purpose (sometimes used for memory offset) |
| CX       | Count register — often used in loops |
| DX       | Data register — often used for I/O or high/low parts of 16-bit values |
| SI       | Source index — used for string/memory operations |
| DI       | Destination index — used for string/memory operations |
| SP       | Stack pointer — points to the current top of the stack |
| BP       | Base pointer — often used with stack frames |
| CS       | Code segment — holds segment of currently executing code |
| DS       | Data segment — points to data |
| SS       | Stack segment — points to stack |
| ES       | Extra segment — optional extra data segment |

---

# Instructions

| Instruction | Example               | Purpose                                |
|-------------|-----------------------|----------------------------------------|
| mov         | mov ax, 0x1234         | Move a value into a register           |
| add         | add ax, 5             | Add a value to a register              |
| sub         | sub ax, 1             | Subtract a value                       |
| xor         | xor ax, ax            | Clear a register to zero (faster than mov) |
| cmp         | cmp ax, 0             | Compare values for jumps               |
| jmp         | jmp label             | Unconditional jump                     |
| je / jne    | je equal              | Conditional jumps based on cmp        |
| inc / dec   | inc ax / dec ax       | Increment or decrement register       |