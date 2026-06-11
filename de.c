#include "types.h"
#include "stat.h"
#include "user.h"
#include "fcntl.h"

#define BUFFER_SIZE 2048

int main(int argc, char *argv[]) {
    int fd;
    char buf[BUFFER_SIZE];
    int n, total = 0;

    if(argc < 2){
        printf(1, "Usage: de <filename>\n");
        exit();
    }

    // Open file for writing
    fd = open(argv[1], O_WRONLY | O_CREATE);
    if(fd < 0){
        printf(1, "de: cannot open/create %s\n", argv[1]);
        exit();
    }

    printf(1, "--- Ducko.Unix Editor: %s ---\n", argv[1]);
    printf(1, "Type your text. To SAVE and EXIT, press Ctrl+D on a new line.\n");
    printf(1, "--------------------------------------------------------\n");

    // Read from the keyboard console (file descriptor 0) line-by-line
    while((n = read(0, buf + total, BUFFER_SIZE - total - 1)) > 0){
        total += n;
        if(total >= BUFFER_SIZE - 1) {
            printf(1, "\n[Warning: Buffer full! Saving automatically]\n");
            break;
        }
    }

    // Write the buffer contents to the file descriptor
    if(write(fd, buf, total) != total){
        printf(1, "de: write error occurred!\n");
    } else {
        printf(1, "\n[File '%s' successfully saved! (%d bytes)]\n", argv[1], total);
    }

    close(fd);
    exit();
}
