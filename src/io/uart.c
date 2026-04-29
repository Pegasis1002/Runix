 #include "uart.h"

 void print_char(char c) {
     UART = c;
}

void print_str(const char* str){
    for (int i = 0; str[i] != '\0'; i++) {
        UART = str[i];
    }
}
