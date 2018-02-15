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
  matrix c;
  matrix d;   
  matrix e;
  a = 1;
  b = 101;
  /*a = forLoopTest();*/
  temp();
  a;
  c = [[1,2,3];[4,5,6];[7,3,2]];
  d = [[12,23,19];[6,5,4];[2,3,7]];
  e = c * d;
}


