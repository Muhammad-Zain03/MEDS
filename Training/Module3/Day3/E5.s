# Day 3, Exercise 5

.data
my_var: .word 42

.text
.globl main
main:
    nop                 # 1. No Operation
    #instruction Executed: addi x0, x0, 0
    
    li t0, 5            # 2. Load Immediate (Small number)
    #instruction Executed: addi t0, x0, 5
    
    li t1, 0x12345678   # 3. Load Immediate (Large number)
    #instruction Executed: lui t1, 0x12345
    #                      addi t1, t1, 0x678
    
    la t2, my_var       # 4. Load Address
    #instruction Executed: auipc t2, ...
    #                      addi t2, t2, ...
    
    mv t3, t0           # 5. Move Register
    #instruction Executed: addi t3, t0, 0
    
    not t4, t0          # 6. Bitwise NOT
    #instruction Executed: xori t4, t0, -1
    
    neg t5, t0          # 7. Negate (Two's complement)
    #instruction Executed: sub t5, x0, t0
    
    beqz t0, skip       # 8. Branch if Equal to Zero
    #instruction Executed: beq t0, x0, skip
    
    j skip              # 9. Unconditional Jump
    #instruction Executed: jal x0, ski
    
skip:
    ret                 # 10. Return
    #instruction Executed: jalr x0, x1, 0
