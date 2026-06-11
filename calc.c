#include "types.h"
#include "stat.h"
#include "user.h"

int calculate(char *str) {
    int result = 0;
    int num = 0;
    char op = '+';

    while (*str) {
        if (*str == ' ' || *str == '\t') {
            str++;
            continue;
        }

        // Parse numbers
        if (*str >= '0' && *str <= '9') {
            num = 0;
            while (*str >= '0' && *str <= '9') {
                num = num * 10 + (*str - '0');
                str++;
            }

            // Apply the previous operator
            if (op == '+') result += num;
            else if (op == '-') result -= num;
            else if (op == '*') result *= num;
            else if (op == '/') {
                if (num == 0) {
                    printf(2, "Error: Division by zero!\n");
                    return 0;
                }
                result /= num;
            }
            continue;
        }

        // Capture new operators
        if (*str == '+' || *str == '-' || *str == '*' || *str == '/') {
            op = *str;
            str++;
        } else {
            printf(2, "calc: Unknown symbol '%c'\n", *str);
            return 0;
        }
    }
    return result;
}

int main(int argc, char *argv[]) {
    if (argc < 2) {
        printf(2, "Usage: calc \"[expression]\" (e.g., calc \"10*5+2\"(There cant be any spaces!!!))\n");
        exit();
    }

    int res = calculate(argv[1]);
    printf(1, "= %d\n", res);
    exit();
}
