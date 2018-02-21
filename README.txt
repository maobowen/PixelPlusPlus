# Pixel++

Pixel++ is an object-oriented programming language for efficient manipulation of images.

This is a class project for COMS W4115 Programming Languages and Translators, Spring 2018 at Columbia University.

Makefile is provided. Use "make clean" to clean intermediate and executable files. Use "make" to produce the top level executable and run it with the following command:

./top.native test_file.xpp

You can test the current 4 files with 

Input:

	int i;
	int j;
	int newvar;
	int superpower;
	float f;
	String s;
	void temp() {
	  /*int a;
	  int b;*/
	  a = 123;
	  b = 321;
	  f = 1.21;
	  s = "anc";
	}

	int gcd(int a, int b) {
	  while (a!=b) {
	    if (a > b)
	      a = a - b;
	    else
	      b = b - a;
	  }
	  return a;
	}

	int forLoopTest() {
	  int accu;
	  int i;
	  i = 0;
	  accu = 0;
	  for (i = a; i < b; i = i + 1) {
	    accu = accu + i;
	  }
	  a=gcd(5050,100);
	  return a;
	}


	int main() {
	  int a;
	  int b;
	  arr arr1;
	  arr arr2;
	  arr arr3;
	  arr arr4; 
	  matrix m1;
	  matrix m2;
	  matrix m3;
	  a = 1;
	  b = 101;
	  temp();
	  a;
	  arr1 = [1,2,3];
	  arr2 = [4,5,6];
	  arr3 = [arr1, arr2];
	  arr4 = [arr2, arr1];
	  arr3 * [[3,4,5],[0,1,-1]];
	  m1 = [[1],[2],[3]];

	}




EOF
Output:
11

