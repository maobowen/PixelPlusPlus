---
title: Pixel++
layout: default
---
Pixel++ is a programming language for efficient manipulation of images coded in OCaml.

# 1 Introduction

## 1.1 Overview

In this document, we propose Pixel++, a domain-specific language designed for efficient manipulation on images, which contains features that allow users to edit image with convenience and conciseness. Pixel++ provides a foundation for image processing through the development of powerful yet simple primitive data types, operators, built-in functions and standard library. We will demonstrate the usability of Pixel++ by explaining the essential components in a programming language such as architectural design, reference manual, language testing, etc.

## 1.2 Aims and Motivations

Since posting photos on social media has become an important part of people’s lives in the 21<sup>st</sup> century, it would bring a huge impact to the society if one can create a tool to help people easily edit photos and apply effects on them to reach goals such as expressing feelings or conveying messages. While Photoshop and some other cutting-edge software do a pretty good job at image editing, most of them still requires a large amount of manual labor. There exists few programming languages or software that enable automatic image manipulation. Therefore, we designed the Pixel++ programming language, which enables users to modify an image by changing its RGB pixel values.

## 1.3 Context

Our programming language represents an image as an integer array and stores the pixel values in that array. We allow user to add effects on images by self-defined filters or Pixel++’s pre-defined filters, and we provide filter operators for users to apply convolution matrices on images. In order to process images presented in arrays, we also provide operators such as component-wise multiplication operator, transpose operator, subscript operator, etc. Additionally, there are built-in functions for users to load images, initialize blank images, set  height and width of a filter, etc. and a standard library for users to crop, rotate, flip, collage and apply sci-fi effect to images. These features give users the flexibility to transform their images by simply operating on the arrays. 

The syntax of Pixel++ is similar to the syntax of C, excluding some  irrelevant details such as inheritance, template, etc. Since Pixel++ includes the array data type and other relative operators, it does not only implement image processing but also grants users the ability to manipulate images on a pixel scale and the freedom to define their own filters based on individual preference.

Combining these features could considerably simplify real-life tasks such as adjusting brightness and contrast of images, editing the sizes, flipping and concatenating images, adding interesting effects on images, and so on.

# 2 Language Tutorial

## 2.1 Environment Setup

### 2.1.1 Ubuntu

Our compiler is developed and has been tested on

- Ubuntu 14.04 with [OCaml 4.02](https://launchpad.net/~avsm/+archive/ubuntu/ocaml42+opam12) and [LLVM 6.0](http://apt.llvm.org/);
- Ubuntu 17.10 with [OCaml 4.04](https://packages.ubuntu.com/artful/ocaml) and LLVM 6.0.

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

```bash
source ~/.bashrc
```

### 2.1.2 macOS

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

## 2.2 Building Pixel++ Compiler

After you setup your environment correctly, the first thing you should do is to build our Pixel++ compiler. We provide a Makefile to make this process convenient for you. To build the compiler, just use the following command:

```bash
make
```

## 2.3 Compiling and Running Your Pixel++ Program

First things first: pick up your favorite text editor, and write a Pixel++ program! You can just copy and paste the sample program in Section [2.4](#24-a-sample-program), name it as `myprogram.xpp`, and put it under the root directory of the compiler. Don't forget to include your favorite images (only PNG format is supported). If you use the sample program, just name an image as `image.png`.

Now let's compile our program step by step.

First, compile the Pixel++ program and produce an LLVM IR `myprogram.ll`:

```bash
./toplevel.native myprogram.xpp > myprogram.ll
```

Next, Invokes the LLVM compiler to produce an assembly file `myprogram.s`:

```bash
llc myprogram.ll > myprogram.s
```

If you would like to use any functions in the standard library to process images (for example, the sample program in Section [2.4](#24-a-sample-program) uses a sci-fi effect filter in the stardary library), compile the file `stdlib.xpp`:

```bash
make -C stdlib/
./stdlib/toplevel.native -c2 ./stdlib/stdlib.xpp > stdlib.llllc stdlib.ll > stdlib.s
gcc -std=c99 -Wall -c load.c
```

Now produce an executable `myprogram.exe` for the Pixel++ program if you do not use functions in the standard library:

```bash
gcc -Wall myprogram.s -o myprogram.exe
```

If you use any functions in the standard library, link all the assembly files and object files and produce the executable:

```
gcc -Wall myprogram.s stdlib.s load.o -lm -o myprogram.exe
```

> You might need to add the `-no-pie` flag to GCC if you experience any relocation errors when linking on Ubuntu 18.04.

Finally, run your executable and see the result:

```bash
./myprogram.exe
```

If you follow our sample program, you can find a file named `image2.png` generated under the root directory. Check it out and see what has happened!

You can also clean intermediate files and executables before building the top-level executables using:

```
make clean
make -C stdlib/ clean
```

## 2.4 A Sample Program

Since Pixel++ is designed for image processing, let’s look at a beginner program on how to manipulate images in Pixel++.

```cpp
func int main() {
    arr img1 = load("./image.png");
    scifi_filter(img1);
    save(img1, "./image2.png");
    close(img1, 0);
    return 0;
}
```

- Line 1: Every Pixel++ program must have a main function. It’s the entry point of a Pixel++ program. 
- Line 2: `load()` function loads the picture file `image.png` from the disk into a variable `img1`. Every image in Pixel++ is of type `arr`, which stands for array. `load()` is a built-in function provided by Pixel++. `save()` and `close()` are also built-in functions. To see a full list of built-in functions, please refer to Section [3.8.3](#383-built-in-function). 
- Line 3: `scifi_filter()` applies the sci-fi effect filter to the loaded image. `scifi_filter()` is a function in the Pixel++ standard library. Other standard library functions include `crop()`, `collage()`, `flip()`, etc. To see a full list of functions in the standard library, please refer to Section [3.9](#39-standard-library).
- Line 4: The built-in `save()` function saves the changes you made on the image to the disk. 
- Line 5: Don’t forget to close the image file when you are done manipulating the image using the built-in `close()` function.

# 3 Language Manual

## 3.1 Organization

Section [3.2](#32-notations) describes notations used to present code samples and proses.

Section [3.3](#33-lexical-conventions) describes Pixel++'s lexical conventions, such as the language's identifiers, keywords and data types.

Section [3.4](#34-literials) describes literals in the language.

Section [3.5](#35-declarations) describes how to declare variables and functions in the language.

Section [3.6](#36-expressions) describes expressions in Pixel++.

Section [3.7](#37-statements) describes statements in Pixel++, which include the if statement, the for-loop statement, the while-loop statement and the return statement.

Section [3.8](#38-function) describes functions in the language, including function syntax and structure.

Section [3.9](#39-standard-library) describes the standard libraries of Pixel++.

Section [3.10](#310-program) describes the rules and units of a Pixel++ program, such as the scope rule and the program units.

Section [3.11](#311-supplementary-notes-on-image-operations) contains some important notes on image operations.

Section [3.12](#312-code-listings) lists some sample programs that demonstrate the features of Pixel++.

## 3.2 Notations

In this document, codes are `highlighted`. For example:

> The following code declares a 1-dimension array of 32-bit signed integers and assigns values to it:
>
>     arr a;
>     a = [1, 2, 3];

## 3.3 Lexical Conventions

### 3.3.1 Whitespace

Since Pixel++ is a free-format language, styling with whitespace characters, including spaces, tabs, and line breaks, does not matter. All the whitespace characters will be ignored during scanning.

However, we encourage users to use four spaces, two spaces or one tab for indention.

### 3.3.2 Identifiers

A valid identifier is a literal that

- differs from any keywords defined in Section [3.3.3](#333-reserved-words), and
- starts with a letter of either uppercase or lowercase (i.e. 'A'-'Z', 'a'-'z'), and
- follows any combination of numbers, uppercase or lowercase letters, and underscore (i.e. '0'-'9', 'A'-'Z', 'a'-'z', '\_').

Identifiers are generally used to declare variables (including image filters) or functions. Since Pixel++ is a case-sensitive language, uppercase letters and lowercase letters will be treated differently.

### 3.3.3 Reserved Words

Keywords are reserved by the language so that they cannot be used for other purposes (e.g. the name of an identifier). These words include:

- Primitive data types (see Section [3.3.4](#334-data-types)): `arr`, `bool`, `float`, `int`, `kernel`, `string`, `void`;
- Boolean values: `true`, `false`;
- Control flow (See Section [3.3.6](#336-control-flow)): `else`, `for`, `if`, `return`, `while`;
- Function declaration (See Section [3.5.2](#352-function-declaration)): `func`.

Some words are reserved by the language as built-in functions. Users are welcome to call these functions, but they are not expected to use these words to name other functions. These words include:

- Built-in functions (See Section [3.8.3](#383-built-in-function)): `close`, ``float_of`, height`, `imgcpy`, `init`, `int_of`, `length`, `load`, `print`, `printf`, `printline`, `save`, `set`, `width`.

Some words are reserved in the standard library `stdlib.xpp`. Users are welcome to call these functions or filters, but they should not use these words for other purposes provided that the standard library will be linked during compilation. These words include:

- Standard library functions (See Section [3.9](#39-standard-library)): `collage`, `crop`, `flip`, `rotate`, `scifi_filter`.

Some other words are reserved by the language or the standard library `stdlib.xpp`. They are “helper functions” for developers, and thus users are neither expected to call these functions nor to use these words to name other functions. These words include:

- Built-in functions: `f_len`, `get_filter`;
- Standard library functions: `apply_conv_filter`, `apply_conv_filters`, `exp`, `exp2`, `mtimes`, `transpose`.

### 3.3.4 Data Types

There are seven primitive data types in the language specification of Pixel++.

- `void`: `void` is only used as the return type of functions which have no return values. Variables **cannot** be declared as `void` type.
- `int`: A 32-bit signed integer ranging from -2<sup>31</sup> to 2<sup>31</sup>-1.
- `float`: A 32-bit signed floating point number.
- `bool`: A boolean value, either `true` or `false`.
- `string`: A sequence of characters. A `string` is **immutable**.
- `arr`: A container storing a sequence of `int` (32-bit signed integer) values. An `arr` is of **fixed length** but **mutable**.
- `kernel`: A container storing a sequence of image filters. For more details, please see Section [3.6.2](#362-image-filter-expression).

### 3.3.5 Operators

Operator | Description
--- | ---
`*`, `/` `+`, `-` | *Arithmetic operators. (Binary)*<br>Arithmetic addition, subtraction, multiplication and division for scalars.
`^` | *Arithmetic operator. (Binary)*<br>Exponentiation for scalars.
`:*` | *Matrix&#42; arithmetic operator. (Binary)*<br>Component-wise multiplication for matrices. The two matrices need to have the same shape.
`**` | *Matrix&#42; arithmetic operator. (Unary)*<br>Transpose operation of a matrix.
`==`, `!=`, `>`, `<`, `>=`, `<=` | *Relational operators. (Binary)*<br>Relational operators which return boolean values.
`not`, `and`, `or` | *Logical operators. (Unary / binary)*<br>Short-circuit Logical operators which evaluate boolean expressions.
`->` | *Stacking operator. (Binary)*<br>Stacking filters.
`@` | *Filtering operator. (Binary)*<br>Apply a stack of filters to an image.
`=` | *Assignment operator. (Binary)*<br>Assign a value or an object to a variable.
`[]` | *Subscript operator. (Binary)*<br>Subscript operator, which takes the index and returns the element of that index inside a collection.
`()` | *Parentheses.*<br>Parentheses are mandatory in condition clauses or boolean expressions. Parentheses also serve as the function call operator.
`||` | *Filter parentheses.*<br>Parentheses are mandatory to group the filters.

*&#42; Please refer to Section [3.6.1](#361-mathematical-expression) for more information about matrices.*

Below is the operator precedence (from high to low):

1. `()`, `[]`, `||`
2. `**`, `:*`, `^` (left associative)
3. `*`, `/`, `+`, `-` (left associative)
4. `==`, `!=`, `>`, `<`, `>=`, `<=` (left associative)
5. `not`, `and`, `or` (left associative)
6. `->` (left associative)
7. `@` (non-associative)
8. `=` (right associative)

### 3.3.6 Control Flow

If there is only one line of statement in the block, the block `{}` can be omitted. Any dangling `else` in this case will be associated to the nearest `if`. However, we strongly recommend users to use blocks to avoid ambiguity.

Type | Explanation| Example
--- | ---
if | The basic control flow statement. Codes inside the `if` block will execute only if the condition is evaluated to `true`. | `if (condition) { }`
if-else | Provide an `else` path when the condition is evaluated to `false`. | `if (condition) { } else { }`
if-else if | Can evaluate another condition other than the first one. | `if (condition1) { } else { if (condition2) { } }`
for-loop | Started by an initialization, execute and update over every iteration when the condition is evaluated as `true`. | `for (initial; condition; update) { }`
while-loop | Execute over every iteration when the condition is evaluated as `true`. | `while (condition) { }`

### 3.3.7 Comment Style

`/* ... */` is used for multi-line comments. All content wrapped between `/*` and `*/` will be ignored.

### 3.3.8 Separator

Semicolon `;` is used as statement separator.

## 3.4 Literals

### 3.4.1 Integer Literals

A sequence of digits formed by 0-9. Integer literals are associated with the `int` data type. Examples: `1`, `2`, `3`.

### 3.4.2 Float Literals

A sequence of digits starts by 0-9, followed by a floating point '`.`' and another sequence of digits of 0-9. Float literals are associated with the `float` data type. Examples: `1.0`, `2.0`, `3.0`.

### 3.4.3 Boolean Literals

`true` and `false`.

### 3.4.4 String Literals

A sequence of characters enclosed by double quotation marks `""`. String literals are associated with `string` data type. Examples: `"Pixel++"`, `"Programming Languages and Translators"`.

### 3.4.5 Array Literals

A sequence of list of zero or more literals of the `int` type, each of which represents an array element, enclosed by squared brackets `[]`. Array literals are associated with the `arr` data type. An array literal is always 1-dimensional. Example: `[1, 2, 3]`, `[4, 5, 6]`.

## 3.5 Declarations

### 3.5.1 Variable Declaration

Type declaration is required when declaring a variable. For example, to declare an integer variable `a`, a valid declaration will be:

```cpp
int a;
```

Alternatively, Pixel++ offers the freedom to combine the declaration and initialization. For instance, the following statements are also correct:

```cpp
int a = 0;
float b = 0.0;
bool c = true;
arr d = [1, 2, 3];
```

### 3.5.2 Function Declaration

Function declaration should have the following structure:

```cpp
func return_type function_name(type1 argument1, type2 argument2, ...)
{
    statement1;
    ...
}
```

For example:

```cpp
func int add(int a, int b)
{
    return a + b;
}
```

In the above example, `func` is a reserved keyword of Pixel++ indicating the beginning of a function declaration. `int` followed right after `func` is the return type of the function. `add` is the name of the function, which can be defined by the users. Inside the parentheses is a list of argument variables (with type) passed to the function. For each argument variable `a` and `b`, it is required to specify their return types. The main body of the function is wrapped by the `{}` block, which is mandatory.

## 3.6 Expressions

### 3.6.1 Mathematical Expression

A mathematical expression contains operators, identifiers, and literals. An example to add an integer variable `a` and a scalar `2` would be (assuming `a` and `b` have already been declared and `a` has been initialized):

```cpp
b = a + 2
```

Additionally, Pixel++ offers two matrix operators: component-wise multiplication and transpose. Pixel++ **does not** have a native matrix type. Here, a matrix means **a 1-dimensional array with height and width**, which looks like a 2-dimensional array. For more information, please refer to Section [3.8.3](#383-built-in-function) and [3.11.1](#3111-images-and-filters). Some examples of valid matrix expressions would be:

```cpp
m = [1, 2, 3, 4, 5, 6, 7, 8, 9];
set(m, 3, 3);

m2 = **m      /* Transpose */
m3 = m :* m2  /* Component-wise multiplication */
```

### 3.6.2 Image Filter Expression

An image filter expression contains operators `@` and `->`. `@` means operating on an image and `->` means stacking filters. For example, if we have two filters `blur` and `smooth`, `blur->smooth` means first applying the blurring filter and then the smoothing filter (since in this example `smooth` is physically closer to the `image` operand). Valid filtering expressions can be:

```cpp
func void applyFilter()
{
    arr image = load("~/image/image.png");
    arr blur = [1, 4, 7, 4, 1, 4, 16, 26, 16, 4, 7, 26, 41, 26, 7, 4, 16, 26, 16, 4, 1, 4, 7, 4, 1];
    arr smooth = [1, 1, 1, 1, 1, 1, 4, 4, 4, 1, 1, 4, 12, 4, 1, 1, 4, 4, 4, 1, 1, 1, 1, 1, 1];
    set(blur, 5, 5);
    set(smooth, 5, 5);
    kernel k = |blur->smooth| /* Stack filters to a kernel */
    k@image;                  /* Apply a kernel to an image */
    save(image, "~/image/image2.png");
}
```

## 3.7 Statements

All expressions plus semi-colon are statements. In addition, there are control flow statements and `return` statements.

### 3.7.1 If Statement

An `if` statement contains conditionals with `bool` data type.

A valid `if` statement can be:

```cpp
if (a > b)
{
    a = a - b;
} 
else
{
    b = b - a;
}
```

### 3.7.2 While Statement

A `while` statement contains conditionals with `bool` data type.

A valid `while` statement can be:

```cpp
func int gcd(int a, int b)
{
    while (a != b)
    {
        if (a > b)
        {
            a = a - b;
        }
        else
        {
            b = b - a;
        }
    }
    return a;
}
```

### 3.7.3 For Statement

A `for` statement contains pre-statements (initialization), conditionals and post-statements (update).

A valid `for` statement can be:

```cpp
func int forLoopTest()
{
    int b = 10;
    int accu = 0;
    int i;
    for (i = 0; i < b; i = i + 1)
    {
        accu = accu + i;
    }
    return accu;
}
```

### 3.7.4 Return Statement

A `return` statement returns the result of a function with the same type of the return type defined in the function declaration. It is optional. For more detail, please refer to Section [3.8.1](#381-function-definition).

A valid `return` statement can be:

```cpp
func int main()
{
    int result = gcd(5050,100);
    return result;
}
```

## 3.8 Function

### 3.8.1 Function Definition

A function is a piece of code that can be invoked repeatedly in the program. In Pixel++, a function definition is composed of two parts: function signature and function body. A function signature must contain a `func` keyword, return type, function name and a formal argument list.

```cpp
func return_type function_name ( formal_list ) 
{
    function_body
}
```

`func` is a reserved keyword for function definition which cannot be ignored.

`return_type` can be any primitive type defined in Pixel++, including `arr` and `kernel`. It must be explicitly specified even when no return value is expected, in which case `void` is used.

`function_name` should be a valid identifier in Pixel++. It cannot be any reserved words. For more information, please refer to Section [3.3.3](#333-reserved-words).

`formal_list` is a list of zero or more formals, separated by commas. A formal is a pair of argument type and its name. An argument type can be any primitive data type and an argument name should be a valid identifier:

```cpp
formal_list: (type arg (, type arg)*)?
```

A function body is a list of zero or more statements, including expressions, statement blocks, control-flow statements, return statements, local variable declarations and assignments. A return statement is optional, but if one exists, the value of it must match `return_type` specified in the function signature. Pixel++ does not require declaration of local variables before any other statements. Users can declare local variables anywhere in the function body, as long as the declarations comes before using them. Pixel++ also supports local variable declaration and assignment (initialization) in one statement:

```cpp
type variable_name = expression;
```

Pixel++ does not support nested function definition. Functions can only be defined globally, which means that a function can not be defined within the body of another function.

### 3.8.2 Function Call

Function call in Pixel++ is in the following form:

```cpp
function_name( argument_list )
```

`function_name` should be a valid identifier. `argument_list` is a list of zero or more arguments, separated by commas. An argument must be a valid expression in Pixel++:

```cpp
argument_list: (expr (, expr)*)?
```

To correctly invoke a function, the function name, the number and types of arguments must match a defined function signature exactly. Pixel++ does not support automatic type conversion in function calls, so passing a `float` value to a function demanding `int` argument will issue a compiler error.

A function call is itself an expression, so it can be used in the program wherever an expression can be used.

Pixel++ does not support first-class function, so a function can not be passed as an argument in a function call.

### 3.8.3 Built-in Function

The built-in functions listed below are defined in the language and are available to the users.

1.  `print(int value)`
    - **Description**: Print an integer value.
    - **Prototype**: `func void print(int value);`
    - **Parameters**:
        - `int value`: An integer value.
    - **Return**: An image array.
    - **Example**: `int i = 1; print(i);`

2.  `printf(float value)`
    - **Description**: Print a floating point value.
    - **Prototype**: `func void printf(float value);`
    - **Parameters**:
        - `float value`: A floating point integer.
    - **Return**: Nothing.
    - **Example**: `float i = 1.0; printf(i);`

3.  `printline(string str)`
    - **Description**: Print a string.
    - **Prototype**: `func void printline(string str);`
    - **Parameters**:
        - `string str`: A string.
    - **Return**: Nothing.
    - **Example**: `string str = Hello world!; printline(str);`

4.  `load(string filepath)`
    - **Description**: Load an image from a file.
    - **Prototype**: `func arr load(string filepath);`
    - **Parameters**:
        - `string filepath`: The location of the file to store the image, which can be either an absolute or a relative path.
    - **Return**: An image array.
    - **Example**: `arr image = load(image.png);`

5.  `init(int length, int height, int width)`
    - **Description**: Create a blank image.
    - **Prototype**: `func arr init(int length, int height, int width);`
    - **Parameters**:
        - `int height`: The height (in pixel) of the image.
        - `int width`: The width (in pixel) of the image.
        - `int length`: The length of the image array. The value of this parameter **must be** `height` &times; `width` &times; 3.
    - **Return**: An image array.
    - **Example**: `arr image = init(768 * 1024 * 3, 768, 1024);`

6.  `imgcpy(arr dst, arr src)`
    - **Description**: Copy an image.
    - **Prototype**: `func void imgcpy(arr dst, arr src);`
    - **Parameters**:
        - `arr dst`: The target image.
        - `arr src`: The source image.
    - **Return**: Nothing.
    - **Example**: `imgcpy(image1, image2);`

7.  `save(arr image, string filepath)`
    - **Description**: Save an image to a file.
    - **Prototype**: `func void save(arr image, string filepath);`
    - **Parameters**:
        - `arr image`: The image.
        - `string filepath`: The location of the file to store the image, which can be either an absolute or a relative path.
    - **Return**: Nothing.
    - **Example**: `save(image, image.png);`

8.  `close(arr image, int method)`
    - **Description**: Deallocate the space of an array.
    - **Prototype**: `func void close(arr a, int method);`
    - **Parameters**:
        - `arr image`: The image.
        - `int method`: An integer. If an image is loaded by the `load` function, it should be released from the memory by assigning `method = 0`. If an image is created by the `init` function, or the content of a loaded image will be replaced later, it should be released from the memory by assigning `method = 1`.
    - **Return**: Nothing.
    - **Example**: `close(image, 0);`

9.  `height(arr image)`
    - **Description**: Get the height of an image.
    - **Prototype**: `func int height(arr image);`
    - **Parameters**:
        - `arr image`: The image.
    - **Return**: The height (in pixel) of an image.
    - **Example**: `int h = height(image);`

10. `width(arr image)`
    - **Description**: Get the width of an image.
    - **Prototype**: `func int width(arr image);`
    - **Parameters**:
        - `arr image`: The image.
    - **Return**: The width (in pixel) of an image.
    - **Example**: `int w = width(image);`

11. `length(arr image)`
    - **Description**: Get the length of an image array.
    - **Prototype**: `func int length(arr image);`
    - **Parameters**:
        - `arr image`: The image.
    - **Return**: The length of an image array. This value **must be** `height(image)` &times; `width(image)` &times; 3.
    - **Example**: `int l = length(image);`

12. `set(arr filter, int height, int width)`
    - **Description**: Set the height and the width of a filter.
    - **Prototype**: `func void set(arr filter, int height, int width);`
    - **Parameters**:
        - `arr filter`: The filter.
        - `int height`: The height of the filter.
        - `int width`: The width of the filter.
    - **Return**: Nothing.
    - **Example**: `set(blur, 5, 5);`

## 3.9 Standard Library

There are some standard library functions to perform easy manipulation on images. They are in the standard library `stdlib.xpp`. To use them, users need link `stdlib.xpp` during compilation.

### 3.9.1 Image Operations

1.  `collage(arr image1, arr image2)`\
    - **Description**: Produce a vertical collage of two images. The images should have the same width.
    - **Prototype**: `func arr collage(arr image1, arr image2);`
    - **Parameters**:
        - `arr image1`: The first image (on the top).
        - `arr image1`: The second image (on the bottom).
    - **Return**: An image array containing the images after concatenation.
    - **Example**: `arr image3 = collage(image1, image2);`

2.  `crop(arr image, int x, int y, int height, int width)`
    - **Description**: Crop an image based on the coordinate of the top-left corner point, height and width.
    - **Prototype**: `func arr crop(arr img, int x, int y, int height, int width);`
    - **Parameters**:
        - `arr image`: The input image.
        - `int x`: The x-coordinate (vertical) of the top-left corner point (in pixel).
        - `int y`: The y-coordinate (horizontal) of the top-left corner point (in pixel).
        - `int height`: The new value of height (in pixel).
        - `int width`: The new value of width (in pixel).
    - **Return**: The cropped image.
    - **Example**: `arr image2 = crop(image1, 0, 350, 540, 300);`

3.  `flip(arr image, string direction)`
    - **Description**: Flip the image horizontally.
    - **Prototype**: `func arr flip(arr image);`
    - **Parameters**:
        - `arr image`: The input image.
    - **Return**: The flipped image.
    - **Example**: `arr image2 = flip(image1);`

4.  `rotate(arr image, int angle)`
    - **Description**: Rotate the image by either 90&deg; counterclockwise, 90&deg; clockwise or 180&deg;.
    - **Prototype**: `func void rotate(arr image, int angle);`
    - **Parameters**:
        - `arr image`: The input image.
        - `int angle`: `-90` for rotating 90&deg; counterclockwise, `90` for rotating rotating 90&deg; clockwise, or `180` for rotating 180&deg;.
    - **Return**: Nothing.
    - **Example**: `rotate(image, 90)`;

5.  `scifi_filter(arr image)`
    - **Description**: Apply a sci-fi effect to the image.
    - **Prototype**: `func void scifi_filter(arr image);`
    - **Parameters**:
        - `arr image`: The input image.
    - **Return**: Nothing.
    - **Example**: `scifi_filter(image);`

## 3.10 Program

### 3.10.1 Scope Rules

In Pixel++, global variables are the variables declared at the main body of the program, which can be accessed anywhere in the rest of the files. If a variable is declared within a function, its scope is limited within the function block. Variables declared in if-else or while blocks will also have the scopes limited within the corresponding blocks.

### 3.10.2 Program Flow

There is an entry point of the program, which is the `main()` function. If the program lacks this function, it will raise an exception.

The whole program consists of a mixture of declarations, statements, and functions.

## 3.11 Supplementary Notes on Image Operations

### 3.11.1 Images and Filters

If an image is loaded by the `load` built-in function, for example, `arr image = load(image.png);`, users **do not need** to set the height and the width, since it is read from an external file.

If an image is created by the `init` built-in function, for example, `arr image = init(768 * 1024 * 3, 768, 1024);`, users **do not need** to set the height and the width, since they have been recorded by the arguments.

If a filter is created by the Pixel++ statement `arr filter = [1, 3, 1, 1, 3, 1, 1, 3, 1];` and its shape is 3 &times; 3, the compiler only knows that its length is 9. It does not know the height or the width. Therefore, users **need** to use the built-in function `set(filter, 3, 3);` to set the height and the width manually.

### 3.11.2 Pixels

The array storing the pixels of an image is thus in row-major order. Therefore, the pixel on row `x` and column `y` is on the position `(x, y)`. To get the RGB color values of the pixel on position `(x, y)`:

```cpp
int w = width(img);
int red   = img[(x * w + y) * 3];      /* Red value on (x, y) */
int green = img[(x * w + y) * 3 + 1];  /* Green value on (x, y) */
int blue  = img[(x * w + y) * 3 + 2];  /* Blue value on (x, y) */
```

## 3.12 Code Listings

We will demonstrate three programs which illustrate the key features of Pixel++. For more sample programs, please refer to the test suites for [Deliverable #4 Hello World](https://github.com/maobowen/PixelPlusPlus/tree/master/helloworld_tests), [Deliverable #5 Extended Testsuite](https://github.com/maobowen/PixelPlusPlus/tree/master/extended_tests) and [Demo](https://github.com/maobowen/PixelPlusPlus/tree/master/demo).

### 3.12.1 Greatest common divisor (GCD)

The following codes demonstrate how to calculate the greatest common divisor by using our language.

```cpp
func int gcd(int a, int b)
{
    while (a != b) {
        if (a > b) {
            a = a - b;
        }
        else { 
            b = b - a;
        }
    }
    return a;
}
```

### 3.12.2 Image Filters

The following codes demonstrate how to apply a filter on an image object with our special filtering operator `->` and `@`.

```cpp
func int main() {
    arr image = load("~/Documents/image1.png");
    /* Define a filter for blurring */
    arr blur = [1, 4, 7, 4, 1, 4, 16, 26, 16, 4, 7, 26, 41, 26, 7, 4, 16, 26, 16, 4, 1, 4, 7, 4, 1];
    set(blur, 5, 5);
        
    kernel k = |blur->blur|; /* Concatenate filters to a kernel */
    k@img;                   /* Apply the kernel to the image */
    save(image1, "~/Documents/image1_blurred.png");
    close(image, 0);
    return 0;
}
```

### 3.12.3 Image Operations

The following code snippet demonstrates our featured image operating functions “collage”, “crop” and “flip”.

```cpp
func void main()
{
    arr image1 = load("~/Documents/image1.png");
    arr image2 = load("~/Documents/image2.png");  /* Suppose image2 has the same width as image1 */
    arr image3 = collage(image1, image2);         /* Concatenate two images vertically */
    arr image4 = flip(image3);                    /* Concatenate the images horizontally */
    arr image5 = crop(image4, 0, 350, 540, 300);  /* Crop the images */
    save(image5, "~/Documents/image_transformed.png");
}
```

# 4 Project Plan

## 4.1 Process Overview

We started the proposal discussion from the first week and held regular meetings every one or two weeks. Due to a common interest, we decided to design an image processing language. We met before each deliverable submissions to make sure that our work had met the requirements. During the meetings with Nimo Ni, our TA, we also received much advice on our project progress. Therefore, even though we did not have much experience on computer vision or related fields before, the whole process went smoothly.

As for the specification process, we started by defining our expected functionalities. Aiming at the image domain, we expected our language to be able to apply some transformations to image files. After we agreed on the proposal, we then defined our language rules and started coding up the scanner and parser. Though, we added several new rules by ourselves, such as the filter rules based on our discussions. As we went through each stage, we were getting closer to our original expectation. Certainly, modification of our original plan was necessary. Once we found some issues that would require us to make a big change, we would hold a meeting to discuss it together.

During the development, we divided work among us in each meeting. We set up a Github repository to cooperate: <https://github.com/maobowen/PixelPlusPlus>. It had been difficult for us to divide the work at the beginning since we were not familiar with OCaml and MicroC at all. During that period, we met and went through the codes of MicroC together to understand the process before we could figure out how we should start the work. We met with our TA and took meeting minutes for our later reference. The situation got better as we were more familiar with the compiling process and the whole structure. Therefore, in the following stages, each of us was mainly responsible for one component, and we worked on the same branch before merging to our master branch.

## 4.2 Programming Style Guide

### 4.2.1 General Rules

-   Indentation should be consistent across each file and files of the same extension and type;
-   The naming of the test cases should be consistent and distinguishable;
-   All the codes should be well commented;
-   Variable identifiers and function names should start with lowercase letters;
-   Naming should follows the camelCase rule or the snake_case rule.

### 4.2.2 OCaml

-   All the OCaml files have an indentation of 2 spaces;
-   Pattern matching starts at the same column.

### 4.2.3 C and C++

-   All the C and C++ files have an indentation of 4 spaces.

### 4.2.4 Pixel++

-   All the Pixel++ files have the extension of `.xpp`.
-   All the Pixel++ files have an indentation of 4 spaces;
-   Global variables are always declared at the top;
-   Curly braces start from a new line.

## 4.3 Project Timeline

Date | Description
--- | ---
Jan 26 | First team meeting; brainstormed ideas; decided on writing image processing language Pixel++; discussed division of labor for project proposal.
Feb 2 | Fine-tuned project proposal together and submitted.
Feb 7 | Meeting with TA; confirmed idea and fixed some language specification according to TA’s advice.
Feb 9 | Team meeting studying OCaml and MicroC; set up Github repository for collaboration; discussed language syntax for writing up scanner and parser.
Feb 21 | Finished the scanner and parser deliverable.
Feb 26 | Integrated and finished the language reference manual.
Mar 1 | Fixed some specification based on TA’s advice.
Mar 16 | Working on the semantic checker, linking C++ library and codegen part.
Mar 26 | Finished arithmetic operations and simple filter application.
Apr 11 | Confirmed standard library functions and implementations.
Apr 18 | Finished all the standard library functions with extended testsuite.

## 4.4 Roles and Responsibilities

Name | Role | Description
--- | --- | ---
Jiayang Li | Language Guru | Technical lead responsible for `codegen.ml`, C library linking, and standard library building, also engaged in other components and documentations.
Nana Pang | System Architect | Responsible for the architecture and semantic checker implementation, engaged in standard library functions writing and documentation.
Yilan He | Manager | Responsible for the semantic checker implementation, engaged in standard library functions writing and documentation, organized meetings.
Bowen Mao | Tester | Responsible for the testing, engaged in standard library functions writing, responsible for writing C++ verification program and integrating documentation.
Yunxuan Sun | Tester | Responsible for the testing, engaged in standard library functions writing and documentation.

## 4.5 Software Development Environment

### Environment

At the early stage, our development environment varies among each individual, which includes macOS 10.13, Ubuntu 16.04 and Ubuntu 17.10. To make sure everyone had the same working environment, we later set up a shared virtual machine with Ubuntu 14.04 hosted on Google Compute Engine. In this virtual machine, we used OCaml 4.02 and LLVM 6.0. We have tested our compiler on other environments as well. For more information, please refer to Section [2.1](#21-environment-setup).

### Tool

We used text editor includes Sublime Text and Vim for the development. For version control, we set up Github repository to cooperate. Google drive is also set up for recording our questions and meeting minutes.

### Language

**OCaml**: OCaml is the major language for writing Pixel++. All the components except for the standard library functions are written in OCaml.

**C**: C libraries (including the Single-file header-file libraries for reading and writing images) are linked during the implementation of image processing. Some functions such as `print()` are also implemented by them.

**C++**: We wrote C++ programs to verify the correctness of the standard library functions which involve image generations.

In addition, we wrote Bash scripts to batch test our test cases.

# 5 Architectural Design

# 6 Test Plan
