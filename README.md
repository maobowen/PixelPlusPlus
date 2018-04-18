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

#### Ubuntu

Our compiler is tested on Ubuntu 17.10 with OCaml 4.04 and LLVM 6.0. To set up the environment, please run the following commands:

```bash
#!/bin/bash 

# Add LLVM repositories
LLVM_VERSION=6.0
OCAML_LLVM_VERSION=6.0.0
UBUNTU_CODENAME=`lsb_release --codename | cut -f2`
wget -qO - https://apt.llvm.org/llvm-snapshot.gpg.key | sudo apt-key add -
echo "deb http://apt.llvm.org/${UBUNTU_CODENAME}/ llvm-toolchain-${UBUNTU_CODENAME}-${LLVM_VERSION} main" | sudo tee /etc/apt/sources.list.d/llvm-${LLVM_VERSION}.list
echo "deb-src http://apt.llvm.org/${UBUNTU_CODENAME}/ llvm-toolchain-${UBUNTU_CODENAME}-${LLVM_VERSION} main" | sudo tee -a /etc/apt/sources.list.d/llvm-${LLVM_VERSION}.list
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
```

You may also run the following command to take changes into effect:

	source ~/.bashrc

#### macOS

To set up the environment on macOS 10.13 with OCaml 4.06 and LLVM 6.0, please run the following commands (with [Homebrew](https://brew.sh/) installed):

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

You can compile and execute the codes using our Makefile. Detailed procedure is listed as below:

1. Produce the top level executable with the following command:

		make

2. Run the program with the following command:
	
		./toplevel.native <file.xpp>

	The function takes one argument, which is a `.xpp` file that contains some Pixel++ codes.

3. You will get the output immediately.

You can also clean intermediate and executable files before building again using the following command:

	make clean

## Deliverable #2: Scanner and Parser

### Test Script

Our test suites are located under the `syntax_tests/` directory. For this deliverable, there are 10 test cases, 5 of which will compile and execute successfully and the others will not compile.

To test our test script, just run:
	
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
	
	./test-helloworld.sh

For all the five test programs, a message "Test passed." will be printed, which indicates that the files are successfully compiled and the results match our expectation. 

## Deliverable #5: Extended Testsuite

### Test Suites

Our test suites are located under the `extended-tests/` directory. For this deliverable, we have 7 positive test cases, whose filenames are in the format `extended-pos-x.xpp`, to test various functionalities of the Pixel++ language. We also have 3 negative test cases, whose filenames are in the format `extended-neg-x.xpp`, which will fail to compile due to semantic errors.

- `extended-pos-0.xpp` implements the built-in vertical collage function. It takes an image of the same width and combine them vertically. 
- `extended-pos-1.xpp` implements the built-in image cropping function. It lets the users specifiy an area by the starting point, width, and height and produces a cropped image.
- `extended-pos-2.xpp` implements the built-in image flipping function. It takes an image and produces a horizontally flipped one.
- `extended-pos-3.xpp` demonstrates an Gaussian blur filter, which takes an image and adds blur operation on that image. 
- `extended-pos-4.xpp` implements the built-in rotate function. It takes an image and rotate the image with 180 degrees.
- `extended-pos-5.xpp` demonstrates an sci fi effect filter, which takes an image and adds sci fi effect on that image. 
- `extended-pos-6.xpp` implements the reverse sorting algorithm with input: 9 1 2 8 3 and output: 9 8 3 2 1.
- `extended-neg-0.xpp` Test undeclared variable and produce an error: Fatal error: exception Failure("undeclared identifier d").
- `extended-neg-1.xpp` Test unmatched type in assignment and produce an error: Fatal error: exception Failure("illegal assignment int = string").   
- `extended-neg-2.xpp` Test unmatched type in binary operation and produce an error: Fatal error: exception Failure("illegal binary operator int + string in a + b").  

### Test Script

To test our test suites, just run:

```
make clean && make -C builtin clean && make -C builtin
./test-extended.sh
```

For all the 7 positive test cases, a message "Positive test passed." will be printed, which indicates that the files are successfully compiled and the results match our expectation. 

For all the 3 negative test cases, a message "Negative test passed." will be printed, which indicates that the files fail to compile and the errors match our expectation.
