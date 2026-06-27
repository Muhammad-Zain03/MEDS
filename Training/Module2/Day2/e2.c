#include <stdio.h>
#include <stdint.h>

void write_reg(uint32_t *regs, uint8_t rd, uint32_t value) {
    if (rd != 0) { 
        regs[rd] = value;
    }
}

uint32_t read_reg(const uint32_t *regs, uint8_t rs) {
    return regs[rs];
}

int main() {
    uint32_t regs[32] = {0};
    
    write_reg(regs, 0, 0xDEADBEEF);
    write_reg(regs, 5, 0xCAFEBABE); 

    printf("x0: 0x%08X\n", read_reg(regs, 0));
    printf("x5: 0x%08X\n", read_reg(regs, 5));
    
    return 0;
}