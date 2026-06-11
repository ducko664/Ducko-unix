#include "types.h"
#include "stat.h"
#include "user.h"

// Simple Linear Congruential Generator for random numbers
unsigned int random_target(unsigned int seed) {
    seed = (seed * 1103515245 + 12345) / 65536 % 32768;
    return (seed % 100) + 1; // Number between 1 and 100
}

int main(void) {
    // Use current system uptime ticks as the random seed
    unsigned int seed = uptime();
    int target = random_target(seed);

    char buf[16];
    int guess = 0;
    int attempts = 0;

    printf(1, "==== DUCKO.UNIX NUMBER GUESSING GAME ====\n");
    printf(1, "I'm thinking of a number between 1 and 100.\n");
    printf(1, "Can you guess it? It will be fun!!!\n\n");

    while(1) {
        printf(1, "Enter your guess: ");

        // Read input from user keyboard
        int n = read(0, buf, sizeof(buf) - 1);
        if (n <= 0) break;
        buf[n] = '\0';

        guess = atoi(buf);
        attempts++;

        if(guess < 1 || guess > 100) {
            printf(1, "Please guess a number BETWEEN 1 and 100!\n");
            continue;
        }

        if(guess == target) {
            printf(1, "\n BOOM! You got it! The number was %d.\n", target);
            printf(1, "It took you %d attempts.\n\n", attempts);
            break;
        } else if(guess < target) {
            printf(1, "Too LOW! Try again.\n");
        } else {
            printf(1, "Too HIGH! Try again.\n");
        }
    }

    exit();
}
