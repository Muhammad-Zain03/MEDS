#include <stdio.h>
#include <stdint.h>

void memory_dump(const uint8_t *mem, size_t size) {
    for (size_t i = 0; i < size; i += 8) {
        printf("0x%04zX: ", i);
        
        for (size_t j = 0; j < 8; j++) {
            if (i + j < size) printf("%02X ", mem[i + j]);
            else printf("   ");
        }
        
        printf(" |");
        
        for (size_t j = 0; j < 8; j++) {
            if (i + j < size) {
                unsigned char c = mem[i + j];
                printf("%c", (c >= 32 && c <= 126) ? c : '.');
            }
        }
        printf("|\n");
    }
}

int main() {
    uint8_t test_mem[] = {0xDE, 0xAD, 0xBE, 0xEF, 0x48, 0x69, 0x21, 0x00, 0xFF};
    memory_dump(test_mem, sizeof(test_mem));
    return 0;
}