#include "types.h"
#include "stat.h"
#include "user.h"
#include "fcntl.h"

enum token_type {
    TOKEN_EOF = 0,
    TOKEN_INT,
    TOKEN_NAME,
    TOKEN_NUM,
    TOKEN_STRING,
    TOKEN_LBRACE,
    TOKEN_RBRACE,
    TOKEN_LPAREN,
    TOKEN_RPAREN,
    TOKEN_SEMICOLON,
    TOKEN_COMMA
};

char buffer[2048];
char *src_ptr;
enum token_type current_token;
char token_string[128];
int token_value;
int out_fd;

// Tiny array to buffer da compiled x86 machine instructions
uchar code_buf[512];
int code_idx = 0;

// Helper to emit raw bytes into our program memory buffer
void emit(uchar b) {
    code_buf[code_idx++] = b;
}

// Helper to emit a 4-byte little-endian integer (x86 architecture)
void emit_int(uint i) {
    code_buf[code_idx++] = i & 0xFF;
    code_buf[code_idx++] = (i >> 8) & 0xFF;
    code_buf[code_idx++] = (i >> 16) & 0xFF;
    code_buf[code_idx++] = (i >> 24) & 0xFF;
}

void next_token() {
    while (*src_ptr == ' ' || *src_ptr == '\t' || *src_ptr == '\n' || *src_ptr == '\r') {
        src_ptr++;
    }
    if (*src_ptr == '\0') { current_token = TOKEN_EOF; return; }
    if (*src_ptr == '{')  { current_token = TOKEN_LBRACE; src_ptr++; return; }
    if (*src_ptr == '}')  { current_token = TOKEN_RBRACE; src_ptr++; return; }
    if (*src_ptr == '(')  { current_token = TOKEN_LPAREN; src_ptr++; return; }
    if (*src_ptr == ')')  { current_token = TOKEN_RPAREN; src_ptr++; return; }
    if (*src_ptr == ';')  { current_token = TOKEN_SEMICOLON; src_ptr++; return; }
    if (*src_ptr == ',')  { current_token = TOKEN_COMMA; src_ptr++; return; }

    if (*src_ptr == '"') {
        src_ptr++;
        int i = 0;
        while (*src_ptr != '"' && *src_ptr != '\0') {
            if (*src_ptr == '\\' && *(src_ptr + 1) == 'n') {
                token_string[i++] = '\n';
                src_ptr += 2;
            } else {
                token_string[i++] = *src_ptr++;
            }
        }
        if (*src_ptr == '"') src_ptr++;
        token_string[i] = '\0';
        current_token = TOKEN_STRING;
        return;
    }

    if ((*src_ptr >= 'a' && *src_ptr <= 'z') || (*src_ptr >= 'A' && *src_ptr <= 'Z')) {
        int i = 0;
        while ((*src_ptr >= 'a' && *src_ptr <= 'z') || (*src_ptr >= 'A' && *src_ptr <= 'Z') || (*src_ptr >= '0' && *src_ptr <= '9')) {
            token_string[i++] = *src_ptr++;
        }
        token_string[i] = '\0';
        if (strcmp(token_string, "int") == 0) current_token = TOKEN_INT;
        else current_token = TOKEN_NAME;
        return;
    }

    if (*src_ptr >= '0' && *src_ptr <= '9') {
        token_value = 0;
        while (*src_ptr >= '0' && *src_ptr <= '9') {
            token_value = token_value * 10 + (*src_ptr - '0');
            src_ptr++;
        }
        current_token = TOKEN_NUM;
        return;
    }
    printf(2, "dcc: Lexer error\n");
    exit();
}

void match(enum token_type expected) {
    if (current_token == expected) next_token();
    else { printf(2, "dcc: Syntax Error\n"); exit(); }
}

void compile_statement() {
    if (current_token == TOKEN_NAME) {
        char name[64];
        strcpy(name, token_string);
        next_token();
        match(TOKEN_LPAREN);
        
        if (strcmp(name, "reboot") == 0) {
            int arg = token_value;
            next_token();
            
            // 1. Machine Code: pushl $arg Opcode: 0x6A for 8-bit immediate value
            emit(0x6A); 
            emit(arg);
            
            // 2. Machine Code: movl $23, %eax (Opcode: 0xB8)
            emit(0xB8);
            emit_int(23); // SYS_reboot ID
            
            // 3. Machine Code: int $64 (Opcode: 0xCD 0x40)
            emit(0xCD);
            emit(0x40);
        }
        else if (strcmp(name, "exit") == 0) {
            // Machine Code: movl $2, %eax (SYS_exit) followed by int $64
            emit(0xB8);
            emit_int(2);
            emit(0xCD);
            emit(0x40);
        }
        
        match(TOKEN_RPAREN);
        match(TOKEN_SEMICOLON);
    }
}

// Generates a proper, lightweight ELF binary header structure
void write_elf_header(int fd, int code_size) {
    // Complete 32-bit ELF Header (52 bytes) + 1 Program Header (32 bytes) = 84 bytes total
    uchar elfhdr[84] = {
        // --- ELF HEADER ---
        0x7F, 'E', 'L', 'F',                // very magic Number
        1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, // 32-bit, Little Endian
        2, 0,                               // Type: Executable
        3, 0,                               // Machine: Intel x86
        1, 0, 0, 0,                         // Version
        0x54, 0x00, 0x00, 0x00,             // Entry point: 0x54 (Right after the 84-byte headers)
        52, 0, 0, 0,                        // Program header table offset: 52 (Right after ELF header)
        0, 0, 0, 0,                         // Section header table offset (none)
        0, 0, 0, 0,                         // Flags
        52, 0,                              // Size of ELF header (52)
        32, 0,                              // Size of program header entry (32)
        1, 0,                               // Number of program header entries (1)
        0, 0, 0, 0, 0, 0,                   // Padding

        // --- PROGRAM HEADER (Tells the Kernel's Page Table to map this file) ---
        1, 0, 0, 0,                         // p_type: PT_LOAD (1 = Loadable segment)
        0, 0, 0, 0,                         // p_offset: Start of the file (0)
        0, 0, 0, 0,                         // p_vaddr: Virtual address to load into (0x0)
        0, 0, 0, 0,                         // p_paddr: Physical address (0x0)
        84, 0, 0, 0,                        // p_filesz: File size of segment (Headers + code size)
        84, 0, 0, 0,                        // p_memsz: Memory size of segment 
        7, 0, 0, 0,                         // p_flags: RWE (7 = Read + Write + Execute permissions)
        0, 0, 0, 0                          // p_align: Alignment (none)
    };

    // Dynamically patch the file size and memory size in the program header 
    // so the kernel maps the exact number of bytes your code generates
    uint total_size = 84 + code_size;
    elfhdr[68] = total_size & 0xFF;        // Update p_filesz
    elfhdr[69] = (total_size >> 8) & 0xFF;
    elfhdr[72] = total_size & 0xFF;        // Update p_memsz
    elfhdr[73] = (total_size >> 8) & 0xFF;

    write(fd, elfhdr, 84);
}

int main(int argc, char *argv[]) {
    if (argc < 3) {
        printf(2, "Usage: dcc [input.c] [output_executable]\n");
        exit();
    }

    int in_fd = open(argv[1], O_RDONLY);
    if (in_fd < 0) { printf(2, "dcc: Cannot open input file\n"); exit(); }
    int n = read(in_fd, buffer, sizeof(buffer) - 1);
    buffer[n] = '\0';
    close(in_fd);

    src_ptr = buffer;
    next_token();

    match(TOKEN_INT);
    if (strcmp(token_string, "main") != 0) { printf(2, "dcc: Main missing\n"); exit(); }
    next_token();
    match(TOKEN_LPAREN);
    match(TOKEN_RPAREN);
    match(TOKEN_LBRACE);

    // Compile variables and loop instructions down into raw bytes
    while (current_token != TOKEN_RBRACE && current_token != TOKEN_EOF) {
        compile_statement();
    }
    match(TOKEN_RBRACE);

    // Append an exit() system call byte block to the end automatically 
    // so compiled apps don't crash when they finish running
    emit(0xB8); emit_int(2); // movl $2, %eax
    emit(0xCD); emit(0x40); // int $64

    // Open and write out the completely standalone binary executable file
    out_fd = open(argv[2], O_CREATE | O_WRONLY);
    if (out_fd < 0) { printf(2, "dcc: Cannot create executable\n"); exit(); }

    write_elf_header(out_fd, code_idx);
    write(out_fd, code_buf, code_idx);
    close(out_fd);

    printf(1, "SUCCESS! '%s' compiled directly into executable binary '%s'\n", argv[1], argv[2]);
    exit();
}
// this code was very confusing, only god and i understand it ugh
