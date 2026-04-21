# Cross Compiler GCC

- the compiler must know the correct target platform that the programmer is targeting 
- the default compiler targets the hosts system by default
- building a cross compiler or downloading an existing cross compiler solves this problem
- cross compiler is needed to support builds for different cpu architectures and operating systems

## For this project we are going to build our own GCC Cross Compiler
- os dev has guidelines for building your own cross compiler 
```bash
gcc --version
```
- to build a minimal cross compiler gcc and binutils are needed
```bash
ld --version
```
- for detailed guidelines refer: [OS DEV CROSS COMPILER GCC](https://wiki.osdev.org/GCC_Cross-Compiler#Preparation)


## Tools required for the build OS dev

replace dnf with **apt** for **debian/ ubuntu** and **pacman -S for arch**

1. GCC - core compiler
```bash
sudo dnf install gcc
```
2. G++ - required for new gcc versions
```bash
sudo dnf install g++
```
3. MAKE - automate the build system
```bash
sudo dnf install make
```
4. BISON - parser
```bash
sudo dnf install bison
```
5. FLEX - lexical analyzer generator
```bash
sudo dnf install flex
```
6. GMP (math library) - handles large arithmetic
```bash
sudo dnf install gmp-devel
```
7. MPFR(floating point math) - precise floating-point calculations
```bash
sudo dnf install mpfr-devel
```
8. MPC(complex math) - complex number arithmetic
```bash
sudo dnf install libmpc-devel
```
9. TEXINFO - generate GCC documentation
```bash
sudo dnf install texinfo
```
10. ISL (OPTIONAL) - advanced loop optimizations and code analysis
```bash
sudo dnf install isl-devel
```