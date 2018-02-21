# Pixel++

Pixel++ is a programming language for efficient manipulation of images coded in OCaml. This is a documentation intended for the compilation and execution instructions.

This is a class project for COMS W4115 Programming Languages and Translators, Spring 2018 at Columbia University.

## Group Members

- Jiayang Li	jl4305@columbia.edu
- Yilan He	yh2961@columbia.edu
- Bowen Mao	bm2734@columbia.edu
- Nana Pang	np2630@columbia.edu
- Yunxuan Sun	ys3065@columbia.edu

## Scanner and Parser

### Makefile

Makefile is provided. By typing `make` in the terminal, the following commands will be executed automatically to produce the top-level executable:

	rm -f *.o
	ocamlbuild top.native

If you wish to build it again, use `make clean` before `make` to clean intermediate and executable files, which is equivalent to the following commands:

	ocamlbuild -clean
	rm -rf top scanner.ml parser.ml parser.mli
	rm -rf *.cmx *.cmi *.cmo *.cmx *.o *.s *.ll *.out *.exe

### Compilation and Execution

You can compile and execute the codes using our Makefile. Detailed procedure is listed as below:

1. Produce the top level executable with the following command:

		make

2. Run the program with the following command:
	
		./toplevel.native <file.xpp>

The function takes one argument, which is a `.xpp` file that contains some Pixel++ codes.

3. You will get the output immediately.

You can also clean intermediate and executable files before building again using the following command:

	make clean

### Test Script

We have also provided our own test cases. There are 10 test cases, 5 of which will compile and execute successfully and the others will not compile.

To test our test script, just run:
	
	./testall.sh

A message, "test succeeded", will be printed if the test files are successfully compiled and executed. Otherwise, "test failed" will be displayed.
