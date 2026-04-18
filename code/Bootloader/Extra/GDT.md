# GDT
- cpu access memory as segment and offset
    * real: physical = segment * 16 + offset
        + in real mode the max memory that can be accessed is 1mb
        + but registers in that mode are only 16 bit
        + hence it is stored as segment and offset 
    * protected: physical = base (from GDT) + offset
        +  it is possible to access 4gb of memory as the registers are 32 bit
        + in protected mode the segment defines the gdt entry and offset is the address to the base

---

- table of segment descriptors
- defines rules for how cpu is allowed to access the memory when a segment register is used

## example of gdt
lets say we define the gdt as 

1. `Index 0 → null`
2. `Index 1 → code`
3. `Index 2 → data`

then in the kernel we do 

`mov ax, 0x10` and `mov ds, ax`

the cpu sees this and divides `0x10` by 8 (gdt entries are always 8 bytes by default) : 10/8 = 2
and this is interpreted as use gdt section 2 for the data segment 


## Make of each entry
each entry is of 8 bytes (64 bits) split into various fields:

|64 bit| low 32 bits | high 32 bits|
|--|--|--|
| 1 gdt entry | base + limits|base + flag + limit|

- limit low (16 bits) 
- base low  (16 bits) 
- base mid  (8 bits)  
- access    (8 bits)  
- flags+limit high (8 bits)
- base high (8 bits)


1. the **base** is made of **32 bits** and tells where the segment starts in the memory, in flat memory model it is generally placed at 0 `physical address = offset only`
2. **limit** is of **20 bits** and this tells the no of maximum offset allowed in a segment
3. **Granularity** is basically the **scaling for the limit** if it is 0 then the cpu enforces the limit as bytes, but if it is 1 it is then interpreted as 4 kb blocks/page

## minimum things to define in a gdt
1. null -> mandatory , this is a fail safe for the segment value if anytime the segment 0x00 is called the cpu will crash without this 
2. code -> this is to define the executable memory, any instruction if the code segment is not present ans is not readable or writable will not work
3. data -> this is for variable and other storage functionalities, this should only be writable as if an attacker writes the code in this area and can execute it the whole system is compromised

## access bytes
- layout: P DPL S E DC RW A

1. p = present, defines if the segment is present in the memory and if the system can use it or not 0 means cant use 1 means can use
2. dpl = define privilege level, who can use this segment 0 is for kernel and 3 is for user space
3. s = descriptor type, to separate system memory from normal memory 1 is code data memory and 0 is system memory
4. e = executable, if the segment can execute code or not
5. dc = direction/Conforming, this behaves differently based on if the segment is a code or a data
    1. in data it defines the growth of the stack if it is 0 stack grows normally if it is 1 stack grows downwards
        1. this is more about introducing limit
        2. 0 mean stack can go to the very end of the memory and
        3. 1 means the stack will have a base limit that when touched the os will crash
    2. in code it is the confirming bit says what type of privilege is needed to execute it so 1 would be anything could execute the code, and 0 would be strict privilege is required
6. rw = read write, for **_code segment_** 0 is execute only 1 is executable+ readable, for **_data segment_** its 0 is read only and 1 read write
7. a = access, this is set by the cpu when the segment is used basically to show ok we are using this segment

## Flag
- G D L AVL
- g = granularity, what kind of scaling is the cpu gonna use should it be bytes or kilobytes
- d = default operand size 1 is for 32 bit and 0 is for 16 bit, basically if this a 16 bit or 32 bit environment
- l = long mode for 64 bit versions, is this a 64 bit environment
- avl = free bits, this is just telling the system the memory is free for os use just use it

## why flags and high limit are merged 
by design the manufactures have designed it to be that way most generally as both are 4 bits field so as to not waste space
