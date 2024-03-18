#include <iostream>

extern "C" {
  void asmFunc(void);
}

int main(void){
  std::cout << "Calling asmMain:\n";
  asmFunc();
  std::cout << "Returned from asmMain\n";
}
