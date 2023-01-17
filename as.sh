rm a.out
rm hello.o
nasm -felf64 hello.asm
ld hello.o
./a.out
