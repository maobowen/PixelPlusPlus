# Pixel++

Pixel++ is a programming language for efficient manipulation of images coded in OCaml. This is a documentation intended for the compilation and execution instructions.

This is a class project for COMS W4115 Programming Languages and Translators, Spring 2018 at Columbia University.

## Group Members

- Jiayang Li ([@jiayangli2](https://github.com/jiayangli2)) jl4305@columbia.edu
- Yilan He ([@elenahoho](https://github.com/elenahoho)) yh2961@columbia.edu
- Bowen Mao ([@maobowen](https://github.com/maobowen)) bm2734@columbia.edu
- Nana Pang ([@nanahpang](https://github.com/nanahpang)) np2630@columbia.edu
- Yunxuan Sun ([@yunxuansun](https://github.com/yunxuansun)) ys3065@columbia.edu

## Configuration

### Environment

#### Ubuntu

Our compiler is developed and has been tested on

- Ubuntu 16.04 with [OCaml 4.02](https://packages.ubuntu.com/xenial/ocaml) and [LLVM 6.0](http://apt.llvm.org/);
- Ubuntu 17.10 with [OCaml 4.04](https://packages.ubuntu.com/artful/ocaml) and LLVM 6.0;
- Ubuntu 18.04 with [OCaml 4.05](https://packages.ubuntu.com/bionic/ocaml) and [LLVM 6.0](https://packages.ubuntu.com/bionic/llvm).

To set up the environment, please run the following commands:

```bash
#!/bin/bash 

LLVM_VERSION=6.0
OCAML_LLVM_VERSION=6.0.0
UBUNTU_CODENAME=`lsb_release --codename | cut -f2`
UBUNTU_VERSION=`lsb_release -r | awk '{ print $2 }' | sed 's/[.]//'`
if [ ${UBUNTU_VERSION} -lt 1804 ]; then
    # Add LLVM repositories for Ubuntu version 17.10 and lower
    wget -qO - https://apt.llvm.org/llvm-snapshot.gpg.key | sudo apt-key add -
    echo "deb http://apt.llvm.org/${UBUNTU_CODENAME}/ llvm-toolchain-${UBUNTU_CODENAME}-${LLVM_VERSION} main" | sudo tee /etc/apt/sources.list.d/llvm-${LLVM_VERSION}.list
    echo "deb-src http://apt.llvm.org/${UBUNTU_CODENAME}/ llvm-toolchain-${UBUNTU_CODENAME}-${LLVM_VERSION} main" | sudo tee -a /etc/apt/sources.list.d/llvm-${LLVM_VERSION}.list
fi
sudo apt update

# Install OCaml and LLVM
sudo apt install ocaml opam m4 clang-${LLVM_VERSION} llvm-${LLVM_VERSION} llvm-${LLVM_VERSION}-runtime cmake pkg-config build-essential
opam init

# Install OCaml LLVM library
opam install llvm.${OCAML_LLVM_VERSION}
tee -a ~/.bashrc << EOF
export PATH="/usr/lib/llvm-${LLVM_VERSION}/bin:\$PATH"
eval \`opam config env\`
EOF
```

You may also run the following command to take changes into effect:

	source ~/.bashrc

#### macOS

Our compiler has been tested on

- macOS 10.13 with [OCaml 4.06](http://formulae.brew.sh/formula/ocaml) and [LLVM 6.0](http://formulae.brew.sh/formula/llvm@6).

To set up the environment, please run the following commands (with [Homebrew](https://brew.sh/) installed):

```bash
brew update
brew install ocaml opam llvm
echo 'export PATH="/usr/local/opt/llvm/bin:$PATH"' >> ~/.bash_profile
opam init
eval `opam config env`
opam install llvm.6.0.0
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

You can compile and execute an Pixel++ program (supposing the name of the program is `myprogram.xpp`) by following the steps below:

1. Produce the top-level executable `toplevel.native`:

		make clean
		make

2. Compile the Pixel++ program and produce an LLVM IR `myprogram.ll`:
	
		./toplevel.native myprogram.xpp > myprogram.ll

3. Invokes the LLVM compiler to produce an assembly file `myprogram.s`:
	
		llc myprogram.ll > myprogram.s

4. If you would like to use any functions in the standard library to process images, compile the file `stdlib.xpp`:
	
		make -C stdlib/ clean
		make -C stdlib/
		./stdlib/toplevel.native -c2 ./stdlib/stdlib.xpp > stdlib.ll
		llc stdlib.ll > stdlib.s
		gcc -std=c99 -Wall -c load.c

5. Produce an executable `myprogram.exe` for the Pixel++ program if you do not use functions in the standard library:
	
		gcc myprogram.s -o myprogram.exe

	If you use any functions in the standard library, link all the assembly files and object files and produce the executable:

		gcc myprogram.s stdlib.s load.o -lm -o myprogram.exe

6. Run your executable:
	
		./myprogram.exe

You can also clean intermediate files and executables before building the top-level executables using:

	make clean

#### Options of the Top-level Executable

- `./toplevel.native -a myprogram.xpp`: Print the abstract syntax tree (AST);
- `./toplevel.native -s myprogram.xpp`: Print the semantically-checked abstract syntax tree (SAST);
- `./toplevel.native -l myprogram.xpp`: Print the LLVM IR;
- `./toplevel.native -c myprogram.xpp` (or `./toplevel.native myprogram.xpp`): Check and print the LLVM IR;
- `./stdlib/toplevel.native -c2 ./stdlib/stdlib.xpp`: Check and print the LLVM IR for the standard library (a piece of Pixel++ code without a main function).

## Deliverable #2: Scanner and Parser

### Test Script

Our test suites are located under the `syntax_tests/` directory. For this deliverable, there are 10 test cases, 5 of which will compile and execute successfully and the others will not compile.

To test our test script, just run:
	
	make clean && make
	./test-syntax.sh

For positive test cases, a message "positive test succeeded" will be printed, which indicates that the files are successfully compiled and the results match our expectation. For negative test cases, a message "negative test succeeded" will be displayed to indicate that the files are failed to compile and the error matches our expectation.

## Deliverable #4: Hello World

### Test Suites

Our test suites are located under the `helloworld_tests/` directory. For this deliverable, we write five test cases, whose filenames are in the format `test-helloworld-x.xpp`, to test various functionalities of the Pixel++ language.

- `test-helloworld-0.xpp` prints a string `Hello, Pixel++!`. It mainly tests the built-in function `printline()`, which prints a string to the standard output. 
- `test-helloworld-1.xpp` prints the first 10 Fibonacci numbers. It tests the built-in function `print()`, which prints an integer. Also it verifies that functions in Pixel++ could be recursive.
- `test-helloworld-2.xpp` prints the factorial of 1, 2, 3, 4, 5.
- `test-helloworld-3.xpp` implements the greatest common divisor algorithm. It prints all integers from 1 to 20 that are not a multiple of 3. 
- `test-helloworld-4.xpp` implements the selection sort algorithm. It tests the declaration and initialization of a one-dimension array and array subscript operation. It should print 1, 4, 2, 8, 5, 7 in non-decreasing order.

### Test Script

To test our test suites, just run:
	
	make clean && make
	./test-helloworld.sh

For all the five test programs, a message "Test passed." will be printed, which indicates that the files are successfully compiled and the results match our expectation. 

## Deliverable #5: Extended Testsuite

### Test Suites

Our test suites are located under the `extended-tests/` directory. For this deliverable, we have 7 positive test cases, whose filenames are in the format `extended-pos-x.xpp`, to test various functionalities of the Pixel++ language. We also have 3 negative test cases, whose filenames are in the format `extended-neg-x.xpp`, which will fail to compile due to semantic errors.

- `extended-pos-0.xpp` implements the vertical collage function in the standard library. It takes an image of the same width and combines them vertically. 
- `extended-pos-1.xpp` implements the image cropping function in the standard library. It lets the users specifiy an area by the starting point, height and width, and produces a cropped one.
- `extended-pos-2.xpp` implements the image flipping function in the standard library. It takes an image and produces a horizontally flipped one.
- `extended-pos-3.xpp` demonstrates a self-defined Gaussian blur filter, which takes an image and applies blurring operation on it. 
- `extended-pos-4.xpp` implements the rotation function in the standard library. It takes an image and rotates it by 180 degrees.
- `extended-pos-5.xpp` demonstrates a Sci-Fi effect filter defined in the standard library, which takes an image and adds Sci-Fi effect on it. 
- `extended-pos-6.xpp` implements a reverse sorting algorithm with input `9 1 2 8 3` and output `9 8 3 2 1`.
- `extended-neg-0.xpp` tests undeclared variable and produces an error: Fatal error: exception Failure("undeclared identifier d").
- `extended-neg-1.xpp` tests unmatched type in assignment and produces an error: Fatal error: exception Failure("illegal assignment int = string").   
- `extended-neg-2.xpp` tests unmatched type in binary operation and produces an error: Fatal error: exception Failure("illegal binary operator int + string in a + b").  

### Test Script

To test our test suites, just run:

	make clean && make
	make -C stdlib/ clean && make -C stdlib/
	./test-extended.sh

For all the 7 positive test cases, a message "Positive test passed." will be printed, which indicates that the programs are successfully compiled and the output results match our expectation.

> For the first 6 positive test cases, the images generated are available under the `extended-tests/` directory.
>
> For each of these test cases, an equivalent C++ program `extended-pos-x.cpp` is provided for validation. A test case passes if the hash value of the image generated by the Pixel++ program matches the hash value of the image generated by its equivalent C++ program.

For all the 3 negative test cases, a message "Negative test passed." will be printed, which indicates that the programs fail to compile and the errors match our expectations.
