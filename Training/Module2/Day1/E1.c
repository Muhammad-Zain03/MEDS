#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>

int main(int argc, char *argv[]) {
    if (argc != 2) return 1;
    
    uint32_t val = strtoul(argv[1], NULL, 16);

    printf("Hex: 0x%08X\n", val);
    printf("Unsigned: %u\n", val);
    printf("Signed: %d\n", (int32_t)val);
    
    printf("Binary: ");
    for (int i = 31; i >= 0; i--) {
        printf("%d", (val >> i) & 1);
    }
    printf("\n");
    
    return 0;
}