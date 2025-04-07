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
