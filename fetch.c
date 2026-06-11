#include "types.h"
#include "stat.h"
#include "user.h"

int main(int argc, char *argv[]) {
    // Query the kernel for the live process count
    int active_procs = getproccount();

    printf(1, " _   _ _  _ _____  __      \n");
    printf(1, "| | | | \\| |_ _\\ \\/ /      \n");
    printf(1, "| |_| | .` || | >  <       \n");
    printf(1, " \\___/|_|\\_|___/_/\\_\\____  \n");
    printf(1, "|   \\| | | |/ __| |/ / _ \\\n");
    printf(1, "| |) | |_| | (__| ' < (_) |\n");
    printf(1, "|___/ \\___/ \\___|_|\\_\\___/ \n");
    printf(1, "--------------------------------------\n");
    printf(1, "Distro Version: 3.5\n");
    printf(1, "Kernel Version: 6\n");
    printf(1, "Live Procs:   %d active tasks\n", active_procs);
    printf(1, "--------------------------------------\n\n");

    exit();
}
