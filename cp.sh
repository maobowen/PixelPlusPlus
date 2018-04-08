#!/bin/bash

./toplevel.native test2.xpp > test2.ll
./toplevel.native -c2 builtin.xpp > builtin.ll
llc test2.ll > test2.s
llc builtin.ll > builtin.s
gcc -c load.c
cc -o test2.exe test2.s builtin.s load.o -lm
