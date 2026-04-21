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



## Steps
1. install the above tools
2. install the gcc and binutils source code from [binutils](https://ftp.gnu.org/gnu/binutils/) and [GCC](https://ftp.lip6.fr/pub/gcc/releases/)
3. commands
```bash
# defining the path and the target

#defining the path where everything will be installed
export PREFIX="$HOME/opt/cross"

# the target architecture i686 is for 32 bit mode and the file output -elf is for flat binary output file
export TARGET=i686-elf

# adding the compiler to the path
export PATH="$PREFIX/bin:$PATH"

# make sure that the folder names are the below mentioned
# src is the source folder where the extracted source code is saved
cd $HOME/src

# compiling binutils replace x.y.z with the downloaded version
mkdir build-binutils
cd build-binutils
../binutils-x.y.z/configure --target=$TARGET --prefix="$PREFIX" --with-sysroot --disable-nls --disable-werror
make
make install

cd $HOME/src

# compiling gcc replace x.y.z with the downloaded version
mkdir build-gcc
cd build-gcc
../gcc-x.y.z/configure --target=$TARGET --prefix="$PREFIX" --disable-nls --enable-languages=c,c++ --without-headers --disable-hosted-libstdcxx
make all-gcc
make all-target-libgcc
make all-target-libstdc++-v3
make install-gcc
make install-target-libgcc
make install-target-libstdc++-v3

## to verify the cross compiler build
$HOME/opt/cross/bin/i686-elf-gcc --version
```