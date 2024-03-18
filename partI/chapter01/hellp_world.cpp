#include <stdio.h>

extern "C"{
  void asmFunc(void);
};

int main(void){
  printf("%s","Calling asmFunc:\n");
  asmFunc();
  printf("%s","\nReturning from asmFunc:\n");
}
