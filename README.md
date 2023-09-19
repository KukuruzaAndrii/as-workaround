This repo shows progress in learn [Intel x86 assembly](https://en.wikipedia.org/wiki/X86_assembly_language).
Source code example  compileble with [nasm](https://github.com/netwide-assembler/nasm).
Install dependensies for Ubuntu with install-deps.sh.
Looks in Makefile for build resipes.
Example compile `expl1.asm`:
```sh
nasm -f elf64 expl1.asm
ld -o expl1 expl1.o
```

