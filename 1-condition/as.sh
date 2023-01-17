rm a.out
rm cond.o
nasm -felf64 cond.asm
ld cond.o
./a.out
