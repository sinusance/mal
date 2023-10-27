#include <stdio.h>

void READ(char* arg) {
  return arg;
}

void EVAL(char* arg) {
  return arg;
}

void PRINT(char* arg) {
  return arg;
}

void rep(char* input) {
  return PRINT(EVAL(READ(input)));
}

main(char* argv[], int argc) {
  char input[500];

  printf("user> ");
  while (fgets(input, 500, STDIN) != EOF) {
    rep(input);
  }

  return 0;
}
