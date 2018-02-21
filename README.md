# Pixel++

Pixel++ is a programming language for efficient manipulation of images coded in OCaml. This is a document intended for the compilation and execution instructions.

## Makefile

Makefile is provided. By typing "make" in the terminal, the following commands will be executed automatically to produce the top level executable:

	rm -f *.o
	ocamlbuild top.native

If you wish to build it again, use "make clean" before "make" to clean intermediate and executable files, which is equivalent to the following commands:

	ocamlbuild -clean
	rm -rf top scanner.ml parser.ml parser.mli
	rm -rf *.cmx *.cmi *.cmo *.cmx *.o *.s *.ll *.out *.exe

## Compilation & Execution

You can compile and execute the codes using our provided Makefile. Detailed procedure is listed as below:

1. Produce the top level executable with the following command:

		make

2. Run the program with the following command:
	
		./top.native

3. Type in any valid statements, expressions, or functions you want to run with the program, each line separated with ";", for example:

		int a;
		int foo() {
			int b;
			b = a;
			return b;
		}

4. Press CTRL+D as an indicationo of EOF. You will get the output immediately.

You casn also clean intermediate and executable files before building again using the following command:

	make clean

## Test Script

Alternatively, we have provided our own testcases. There are 10 testcases, 5 will compile and execute successfully and the others will not.

To test on our test script instead of your own input, follow the following procedure:

1. Produce the top level executable with the following command:
   
		make 

2. Run bash test script with the following command:
	
		./testall.sh

For successful test cases, a message of "test succeeded" will be printed. Otherwise, "test failed" will be displayed.
