ENTRY(_start)

MEMORY {
  SRAM  (rwx) : ORIGIN = 0x0f000000, LENGTH = 8K
  /* MROM  (rx) : ORIGIN = 0x20000000, LENGTH = 4K */
  FLASH (rx) : ORIGIN = 0x30000000, LENGTH = 256M
  PSRAM (rwx) : ORIGIN = 0x80000000, LENGTH = 4M
}

SECTIONS {
  _sltext = LOADADDR(.text);

  .text.entry : {
    *(entry)
  } > FLASH

  _slssbl = LOADADDR(.ssbl);
  .ssbl : {
    _sssbl = .;
    KEEP(*(ssbl))
    . = ALIGN(4);
    _essbl = .;
  } > SRAM AT> FLASH

  .text : {
    _stext = .;
    /* *(entry) */
    *(.text*)
    etext = .;
    _etext = .;
  } > PSRAM AT> FLASH

  .rodata : ALIGN(4) {
    *(.rodata*)
    *(.srodata*)
    . = ALIGN(4);
    _erodata = .;
  } > PSRAM AT> FLASH

  _sldata = LOADADDR(.data);

  .data : ALIGN(4) {
    _sdata = .;
    *(.data*)
    *(.data)
    *(.sdata*)
    . = ALIGN(4);
    _edata = .;
    _data = .;
  } > PSRAM AT> FLASH

  .bss : ALIGN(4){
    _sbss = .;
    _bss_start = .;
    *(.bss*)
    *(.sbss*)
    *(.scommon)
    . = ALIGN(4);
    _ebss = .;
  } > PSRAM /* Since bss don't actually exisit in image file. AT> MROM is not necessary here */

  .stack : ALIGN(4) {
    /* _stack_top = .; */
    _stack_top = ORIGIN(SRAM);
    . = _stack_top + LENGTH(SRAM) - 4;
    _stack_pointer = .;
    end = .;
    _end = .;
  } > SRAM

  .heap : ALIGN(4) {
    _heap_start = .;
    _heap_end = ORIGIN(PSRAM) + LENGTH(PSRAM) - 1;
    ASSERT((_heap_end > _heap_start), "Heap too small!");
    ASSERT((_heap_end) - (_heap_start) >= 0x200, "Heap too small");
  } > PSRAM

  /DISCARD/ : {
    *(.debug*)
    *(.comment)
    *(.riscv.attributes)
    *(.note.GNU*)
  }
}
