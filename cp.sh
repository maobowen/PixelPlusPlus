#!/bin/bash

./toplevel.native test2.xpp > test2.ll
./builtin/toplevel.native -c2 ./builtin/builtin.xpp > builtin.ll
llc-6.0 test2.ll > test2.s
llc-6.0 builtin.ll > builtin.s
gcc -std=c99 -c load.c
cc -o test2.exe test2.s builtin.s load.o -lm
