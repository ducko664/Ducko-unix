#include "types.h"
#include "stat.h"
#include "user.h"

int main(void) {
    // ANSI escape codes clear screen, reset cursor position
    printf(1, "\x1b[2J\x1b[H");
    exit();
}
