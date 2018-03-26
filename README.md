# Pixel++

Pixel++ is a programming language for efficient manipulation of images coded in OCaml. This is a documentation intended for the compilation and execution instructions.

This is a class project for COMS W4115 Programming Languages and Translators, Spring 2018 at Columbia University.

## Group Members

- Jiayang Li	jl4305@columbia.edu
- Yilan He	yh2961@columbia.edu
- Bowen Mao	bm2734@columbia.edu
- Nana Pang	np2630@columbia.edu
- Yunxuan Sun	ys3065@columbia.edu

## Hello World

### Test programs

Our test programs are located under the `tests/` directory. For this deliverable, we write five test programs, whose filenames are in the format `test-helloworld-x.xpp`, to test various functionalities of the Pixel++ language.

`test-helloworld-0.xpp` prints a string `"Hello, Pixel++!"`. It mainly tests the built-in function `printline()`, which prints a string to the standard output. 

`test-helloworld-1.xpp` prints the first 10 Fibonacci numbers. It tests the built-in function `print()`, which prints an integer. Also it verifies that functions in Pixel++ could be recursive.

`test-helloworld-2.xpp` prints the factorial of 1, 2, 3, 4, 5.

`test-helloworld-3.xpp` implements the gcd (greatest common divisor) algorithm. It prints all integers from 1 to 20 that are not a multiple of 3. 

`test-helloworld-4.xpp` implements the bubble sort algorithm. It tests the declaration and initialization of a one-dimension array and array subscript operation. It should print 1, 4, 2, 8, 5, 7 in non-decreasing order.

### Makefile

Makefile is provided. By typing `make` in the terminal, the following commands will be executed automatically to produce the top-level executable:

	rm -f *.o
	ocamlbuild -use-ocamlfind -pkgs llvm,llvm.analysis -cflags -w,+a-4 \
		toplevel.native

If you wish to build it again, use `make clean` before `make` to clean intermediate and executable files, which is equivalent to the following commands:

	ocamlbuild -clean
	rm -rf toplevel scanner.ml parser.ml parser.mli
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

To test our five test programs, just run:
	
	./test-helloworld.sh

For all the five test programs, a message "Test passed." will be printed, which indicates that the files are successfully compiled and the results match our expectation. 
