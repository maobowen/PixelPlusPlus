# Pixel++

Pixel++ is a programming language for efficient manipulation of images coded in OCaml. This is a documentation intended for the compilation and execution instructions.

This is a class project for COMS W4115 Programming Languages and Translators, Spring 2018 at Columbia University.

## Group Members

- Jiayang Li	jl4305@columbia.edu
- Yilan He	yh2961@columbia.edu
- Bowen Mao	bm2734@columbia.edu
- Nana Pang	np2630@columbia.edu
- Yunxuan Sun	ys3065@columbia.edu

## Configuration

### Environment

Our compiler is tested on Ubuntu 17.10 with OCaml 4.04 and LLVM 6.0. To set up the environment, please run the following commands:

	

```bash
#!/bin/bash 

# Add LLVM repositories
LLVM_VERSION=6.0
OCAML_LLVM_VERSION=6.0.0
wget -qO - https://apt.llvm.org/llvm-snapshot.gpg.key | sudo apt-key add -
echo "deb http://apt.llvm.org/artful/ llvm-toolchain-`lsb_release --codename | cut -f2`-${LLVM_VERSION} main" | sudo tee /etc/apt/sources.list.d/llvm-${LLVM_VERSION}.list
echo "deb-src http://apt.llvm.org/artful/ llvm-toolchain-`lsb_release --codename | cut -f2`-${LLVM_VERSION} main" | sudo tee -a /etc/apt/sources.list.d/llvm-${LLVM_VERSION}.list
sudo apt update

# Install OCaml and LLVM
sudo apt install ocaml opam m4 clang-${LLVM_VERSION} llvm-${LLVM_VERSION} llvm-${LLVM_VERSION}-runtime cmake pkg-config
opam init

# Install OCaml LLVM library
opam install llvm.${OCAML_LLVM_VERSION}
tee -a ~/.bashrc << EOF
export PATH="/usr/lib/llvm-${LLVM_VERSION}/bin:\$PATH"
eval \`opam config env\`
EOF
source ~/.bashrc
```

### Makefile

Makefile is provided. By typing `make` in the terminal, the following commands will be executed automatically to produce the top-level executable:

	rm -f *.o
	ocamlbuild -use-ocamlfind -pkgs llvm,llvm.analysis -cflags -w,+a-4 toplevel.native

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

## Hello World

### Test Suites

Our test suites are located under the `tests/` directory. For this deliverable, we write five test cases, whose filenames are in the format `test-helloworld-x.xpp`, to test various functionalities of the Pixel++ language.

- `test-helloworld-0.xpp` prints a string `Hello, Pixel++!`. It mainly tests the built-in function `printline()`, which prints a string to the standard output. 
- `test-helloworld-1.xpp` prints the first 10 Fibonacci numbers. It tests the built-in function `print()`, which prints an integer. Also it verifies that functions in Pixel++ could be recursive.
- `test-helloworld-2.xpp` prints the factorial of 1, 2, 3, 4, 5.
- `test-helloworld-3.xpp` implements the greatest common divisor algorithm. It prints all integers from 1 to 20 that are not a multiple of 3. 
- `test-helloworld-4.xpp` implements the selection sort algorithm. It tests the declaration and initialization of a one-dimension array and array subscript operation. It should print 1, 4, 2, 8, 5, 7 in non-decreasing order.

### Test Script

To test our test suites, just run:
	
	./test-helloworld.sh

For all the five test programs, a message "Test passed." will be printed, which indicates that the files are successfully compiled and the results match our expectation. 

## Scanner and Parser

### Test Script

We have also provided our own test cases. There are 10 test cases, 5 of which will compile and execute successfully and the others will not compile.

To test our test script, just run:
	
	./testall.sh

For positive test cases, a message "positive test succeeded" will be printed, which indicates that the files are successfully compiled and the results match our expectation. For negative test cases, a message "negative test succeeded" will be displayed to indicate that the files are failed to compile and the error matches our expectation.

-----

So far, we have implemented all the syntax we have defined except:

1. Array subscript
2. Built-in functions

We will add those in the future implementation.

