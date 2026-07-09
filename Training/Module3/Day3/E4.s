# Day 3, Exercise 4

.data
array: .word 10,20,30,40,50

.text
.globl main

main:
    la s0, array        # pointer to array
    li s1, 5            # array size = 5
    li s2, 40           # Target value to search

    li t0, 0            # low = 0
    addi t1, s1, -1     # high = size - 1 
    li t2, -1           # index = -1
    
loop:
    bgt t0, t1, done
    
    # Calculating mid point
    sub t3, t1, t0      # mid = high - low
    srli t3, t3, 1      # mid = (high - low) / 2
    add t3, t0, t3      # mid = low + (high - low) / 2

    # array[mid]
    slli t4, t3, 2      # t4 = mid * 4
    add t4, s0, t4      # t4 = base address + offset
    lw t5, 0(t4)        # t5 = array[mid]
    
    # Compare array[mid] with target
    beq t5, s2, found   # If array[mid] == target, found
    blt t5, s2, right   # If array[mid] < target, search right half
    
    # Left Half
    addi t1, t3, -1     # high = mid - 1
    j loop

right:
    addi t0, t3, 1      # low = mid + 1
    j loop

found:
    mv t2, t3           # t2 = index found
    
done: 
    # Print
    li a0, 1
    mv a1, t2
    ecall
    
    # Exit
    li a0, 10
    ecall
