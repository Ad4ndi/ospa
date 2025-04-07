# OSPA -> One-Stack Programming Architecture
OSPA is a minimal computing machine architecture that currently contains only 8 instructions. Emulation is implemented in OCaml.

## Launch

  ```bash
  git clone https://github.com/Ad4ndi/ospa
  cd ospa
  ocaml ospa.ml
  ```

## Guide

OSPA has only 1 register - accumulator. Data is written to the stack instead of memory addresses from the accumulator, and vice versa.
Instructions have only 1 argument, which is why they can be written in a string. If desired, you can write instead of text instructions like `hlt` - their HEX addresses.

- 0x00 -> hlt    : Halt
- 0x01 -> out    : Print ACC value
- 0x02 -> asc    : Print ACC value as ASCII
- 0x03 -> inp    : Register value entry
- 0x04 -> ld     : Load stack top to ACC
- 0x05 -> st     : Save ACC at stack top
- 0x06 -> inc    : Increment ACC
- 0x07 -> dec    : Decrement ACC
- 0x08 -> res    : Reset ACC
