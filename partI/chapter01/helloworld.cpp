#include <stdio.h>

extern "C"{
  void asmFunc(void);
}

int main(void){
  printf("%s","Calling asmFunc:\n");
  asmFunc();
  printf("%s","Returning from asmFunc:\n");
}
