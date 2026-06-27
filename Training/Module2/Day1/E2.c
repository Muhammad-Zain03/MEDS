#include <stdio.h>
#include <stdint.h>

uint32_t extract_field(uint32_t instruction, int high, int low) {
    return (instruction >> low) & ((1U << (high - low + 1)) - 1);
}

int main() {
    uint32_t inst = 0x00A28233;
    printf("Opcode: 0x%02X\n", extract_field(inst, 6, 0)); // Prints 0x33
    return 0;
}