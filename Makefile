DIR = 3-sum-args
FILE = sum
SRC = $(DIR)/$(FILE)

all: run

run: $(SRC)
	./$(SRC) $(A)

$(SRC): $(SRC:=.asm)
	nasm -g -f elf64 -l $(SRC:=.lst) $<
	ld -o $(SRC) $(SRC:=.o)

debug: $(SRC)
	gdb \
	-ex "b _start" \
	-ex "set debuginfod enabled off" \
	-ex "set disassembly-flavor intel" \
	--args ./$(SRC) $(A)


clean:
	rm $(SRC:=.lst)
	rm $(SRC:=.o)
	rm $(SRC)
