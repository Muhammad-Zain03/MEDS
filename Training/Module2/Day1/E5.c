#include <stdio.h>
#include <stdint.h>

int32_t sign_extend(uint32_t val, int bit_width) {
    uint32_t sign_bit = 1U << (bit_width - 1);
    return (int32_t)((val ^ sign_bit) - sign_bit);
}

int main() {
    printf("Extended: %d\n", sign_extend(0xFFF, 12)); // Correctly prints -1
    return 0;
}