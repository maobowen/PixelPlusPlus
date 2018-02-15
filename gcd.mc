int i;
int j;
int newvar;
int superpower;

void temp() {
  /*int a;
  int b;*/
  a = 123;
  b = 321;
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
  a = 1;
  b = 101;
  temp();
  a;
  arr1 = [1,2,3];
  arr2 = [4,5,6];
  arr3 = [arr1, arr2];
  arr4 = [arr2, arr1];
  arr3 * [[3,4,5],[0,1,-1]];
}


