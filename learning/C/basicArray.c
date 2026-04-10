// index starts from 0
// only one type of variable
// implemented as an sequence in the computers memory


#include <stdio.h>

int main() {
  /* TODO: define the grades variable here */
  // array definition
  int grades[3];
  int average;

  grades[0] = 80;
  /* TODO: define the missing grade
     so that the average will sum to 85. */

  grades[1] =85;
  grades[2] = 90;

  average = (grades[0] + grades[1] + grades[2]) / 3;
  printf("The average of the 3 grades is: %d", average);

  return 0;
}