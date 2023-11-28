#include <stdio.h>

char* READ(char* arg) {
  return arg;
}

char* EVAL(char* arg) {
  return arg;
}

char* PRINT(char* arg) {
  printf("%s", arg);
  return arg;
}

void rep(char* input) {
  PRINT(EVAL(READ(input)));
}

int main(int argc, char* argv[]) {
  char input[500];

  printf("user> ");
  while (fgets(input, 500, stdin) != NULL) {
    rep(input);
    printf("user> ");
  }

  return 0;
}
