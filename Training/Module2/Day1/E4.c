#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>

uint32_t extract_field(uint32_t inst, int high, int low) {
    return (inst >> low) & ((1U << (high - low + 1)) - 1);
}

int main(int argc, char *argv[]) {
    if (argc != 2) return 1;
    uint32_t inst = strtoul(argv[1], NULL, 16);
    
    printf("opcode=0x%02X rd=x%u funct3=%u rs1=x%u rs2=x%u funct7=0x%02X\n",
           extract_field(inst, 6, 0),
           extract_field(inst, 11, 7),
           extract_field(inst, 14, 12),
           extract_field(inst, 19, 15),
           extract_field(inst, 24, 20),
           extract_field(inst, 31, 25));
           
    return 0;
}