#include <stdio.h>

void guessNumber(int guess) {
    if (guess < 555){
        printf ("Your guess is too low.\n");
    } else if (guess > 555){
        printf ("Your guess is too high.\n");
    } else if(guess == 555){
        printf ("Correct. You guessed it!\n");
    } else{
        printf("please guess a number\n");
    }
}

int main() {
    guessNumber(500);
    guessNumber(600);
    guessNumber(555);
}