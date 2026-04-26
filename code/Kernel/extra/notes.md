# Kernel
- kernel starts running and never stops
- controls the cpu, memory, and hardware access
- kernel has full control
- start → take control → never give it back

## key components of a kernel:
1. memory management
2. idt
3. scheduling
4. device drivers
5. system calls


## basic kerenl

```c
void kernel_main(void) {

    // 1. Initialize hardware
    init_memory();
    init_interrupts();
    init_devices();

    // 2. Enter control loop
    while (1) {
        // handle system activity
    }
}
```

- the void in the kernel says that it takes no arguements
- while (1){}: makes the kernel run forever 