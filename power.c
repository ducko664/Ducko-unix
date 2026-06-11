#include "types.h"
#include "stat.h"
#include "user.h"

int main(int argc, char *argv[]) {
    if (argc < 2) {
        printf(2, "Usage: power [reboot|shutdown]\n");
        exit();
    }

    if (strcmp(argv[1], "reboot") == 0) {
        printf(1, "Restarting DUCKO.UNIX... See ya later!\n");
        sleep(110);

        // Pass '1' to tell the kernel to reset the CPU
        reboot(1); 
    } 
    else if (strcmp(argv[1], "shutdown") == 0) {
        printf(1, "Shutting down DUCKO.UNIX cleanly. Goodbye!\n");
        sleep(110);

        // Pass '2' to tell the kernel to drop motherboard power
        reboot(2); 
    } 
    else {
        printf(2, "Unknown power option. Use 'reboot' or 'shutdown'.\n");
    }

    exit();
}
