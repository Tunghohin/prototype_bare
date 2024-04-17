.section entry, "ax"
.globl _start
.type _start, @function

_start:
  jal _fsbl
  mv s0, zero
  la sp, _stack_pointer
  tail rust_main

// First stage boot loader
_fsbl:

  la a0, _slssbl
  la a1, _sssbl
  la a2, _essbl

0:
  lw a3, 0(a0)
  sw a3, 0(a1)
  addi a0, a0, 4
  addi a1, a1, 4
  bne a1,a2, 0b


  tail _ssbl
  ret

.section ssbl, "ax"
.globl _ssbl
.type _ssbl, @function

// Second stage boot loader
_ssbl:
  la a0, _sltext
  la a1, _stext
  la a2, _erodata
9:
  beq a1, a2, 99f
  lw a3, 0(a0)
  sw a3, 0(a1)
  addi a0, a0, 4
  addi a1, a1, 4
  j 9b

99:

  la a0, _sldata
  la a1, _sdata
  la a2, _edata
0:
  beq a1, a2, 1f
  lw a3, 0(a0)
  sw a3, 0(a1)
  addi a0, a0, 4
  addi a1, a1, 4
  j 0b
1:
  la a0, _sbss
  la a1, _ebss
2:
  beq a0, a1, 3f
  sw x0, 0(a0)
  addi a0, a0, 4
  j 2b
3:
  ret
