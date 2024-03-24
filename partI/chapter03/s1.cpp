#include <stdio.h>
#include <stdlib.h>
#include <string.h>

extern "C" {
void asmMain(void);   // main assembly function
char *getTitle(void); // external assembly function

int readLine(char *dest, int maxLen); // C++ function that assembly can call
};
int readLine(char *dest, int maxLen) {
  char *result = fgets(dest, maxLen, stdin);
  if (result != NULL) {
    int len = strlen(result);
    if (len > 0) {
      dest[len - 1] = 0;
    }
    return len;
  }
  return -1; // there was an error
}
int main(void) {
  try {
    char *title = getTitle();
    printf("Calling %s:\n", title);
    asmMain();
    printf("%s terminated\n", title);
  } catch (...) {
    printf("Exception occurred during program execution\n"
           "Abnormal program termination.\n");
  }
}
