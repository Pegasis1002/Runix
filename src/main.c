typedef unsigned int uint32_t;
#define VRAM ((volatile uint32_t*) 0x11000000)
#define UART (*(volatile uint32_t*) 0x10000000)

void print_char(char c);
void print_str(const char* str);

// Entry point
void kmain(void){
    for (int i = 0; i < 341; i++) {
        VRAM[i] = 0xFFFF0000;
    }

    print_char('X');
    print_char('\n');

    print_str("Hello, World!\n");

    while(1) {}
}

 void print_char(char c) {
     UART = c;
}

void print_str(const char* str){
    for (int i = 0; str[i] != '\0'; i++) {
        UART = str[i];
    }
}
