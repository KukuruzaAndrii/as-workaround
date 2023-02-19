DIR = 5-print-args
FILE = print-args
SRC = $(DIR)/$(FILE)

all: run

run: $(SRC)
	./$(SRC) $(A)

$(SRC): $(SRC:=.asm)
	nasm -g -f elf64 -l $(SRC:=.lst) $<
	ld -o $(SRC) $(SRC:=.o)

debug: $(SRC)
	gdb \
	-ex "set debuginfod enabled off" \
	-ex "set disassembly-flavor intel" \
	-ex "b _start" \
	-ex "run" \
	-ex "layout regs" \
	--args ./$(SRC) $(A)


clean:
	rm $(SRC:=.lst)
	rm $(SRC:=.o)
	rm $(SRC)
