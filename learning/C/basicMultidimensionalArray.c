// we can have multi dimensional array in c 
// type name [size 1] [size 2]
/*
char vowels[1][5] = {
    {'a', 'e', 'i', 'o', 'u'}
};

1 is the row 5 is the column



char vowels[][5] = {
    {'A', 'E', 'I', 'O', 'U'},
    {'a', 'e', 'i', 'o', 'u'}
};


elements acessed by specifying the row index then the coluumn index
*/

	#include <stdio.h>

	int main() {
		/* TODO: declare the 2D array grades here */
        int grades[2][5];
		float average;
		int i;
		int j;

		grades[0][0] = 80;
		grades[0][1] = 70;
		grades[0][2] = 65;
		grades[0][3] = 89;
		grades[0][4] = 90;

		grades[1][0] = 85;
		grades[1][1] = 80;
		grades[1][2] = 80;
		grades[1][3] = 82;
		grades[1][4] = 87;

		/* TODO: complete the for loop with appropriate terminating conditions */
		for (i = 0; i < 2 ; i++) {
			average = 0;
			for (j = 0; j < 5 ; j++) {
				average += grades[i][j];
			}

			/* TODO: compute the average marks for subject i */
            average= average/5;
			printf("The average marks obtained in subject %d is: %.2f\n", i, average);
		}

		return 0;
	}