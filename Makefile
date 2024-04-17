TARGET_DIR := ./target/riscv32em-unknown-none-elf/debug

.DEFAULT_GOAL: build
.PHONY: build
build:
	cargo build
	
.PHONY: objcopy
objcopy: build
	llvm-objcopy ${TARGET_DIR}/prototype_bare --strip-all -O binary ${TARGET_DIR}/prototype_bare.bin

.PHONY: objdump
objdump: build
	llvm-objdump -dw ${TARGET_DIR}/prototype_bare | less

.PHONY: debug
debug: objcopy
	${QEMU} ${QEMU_FLAG} -s -S	

.PHONY: gdb
gdb:
	${GDB} -x ./.gdbinit -q

.PHONY: check
check:
	cargo check

.PHONY: qemu
qemu: objcopy
	${QEMU} ${QEMU_FLAG}

.PHONY: clean
clean:
	@cargo clean
