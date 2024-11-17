# Assignment 2: Classify
I think the main focus this time is to write about the multiplier and dot.s.  
Therefore, the document will primarily explain the multiplier and dot.s,
while other explanations will be provided in the comments within the code.

# Multiplier
First, check if the least significant bit of the multiplier is 1. If it is, add the multiplicand to the accumulated result; otherwise, skip the addition. Then, shift the multiplicand one bit to the left and simultaneously shift the multiplier one bit to the right. The multiplication operation ends when either the multiplier or the multiplicand becomes 0.    

```riscv=
# =======================================================
# FUNCTION: Multilply 2 numbers
#
# Args:
#   a0 (int): multiplicand
#   a1 (int): multiplier
#
# Returns:
#   a0 (int):   answer
# =======================================================
multiply:
    li t2, 0                     # Initialize result
    beqz a0, end_multiply        # Exit if multiplicand (a0) is zero

multiply_loop:
    beqz a1, end_multiply        # Exit if multiplier (a1) is zero
    andi t3, a1, 1               # Check if lowest bit of multiplier is 1
    beqz t3, skip_addition       # If not, skip addition
    add t2, t2, a0               # Add multiplicand to result

skip_addition:
    slli a0, a0, 1               # Shift multiplicand left
    beqz a0, end_multiply        # Exit if multiplicand (a0) is zero
    srli a1, a1, 1               # Shift multiplier right
    j multiply_loop              # Repeat

end_multiply:
    mv a0, t2
    ret
```

# dot.s

dot.s is used to perform the dot product of two matrices, which involves multiplying the values at corresponding indices in the arrays.

Initially, I calculated the indices using i * stride. Later, I realized that simply adding stride * sizeof(int) in each iteration of the loop works just as well. As a result, the performance improved significantly compared to before.
```riscv=
# =======================================================
# FUNCTION: Strided Dot Product Calculator
#
# Calculates sum(arr0[i * stride0] * arr1[i * stride1])
# where i ranges from 0 to (element_count - 1)
#
# Args:
#   a0 (int *): Pointer to first input array
#   a1 (int *): Pointer to second input array
#   a2 (int):   Number of elements to process
#   a3 (int):   Skip distance in first array
#   a4 (int):   Skip distance in second array
#
# Returns:
#   a0 (int):   Resulting dot product value
#
# Preconditions:
#   - Element count must be positive (>= 1)
#   - Both strides must be positive (>= 1)
#
# =======================================================
dot:
addi sp, sp, -12  # push stack space
    sw ra, 0(sp)
    sw s0, 4(sp)     # save a0
    sw s1, 8(sp)

    mv s0, a0
    mv s1, a1

    li t0, 0    # ans
    li t1, 0    # t1 = counter = i 
    slli a3, a3, 2 # stride0 * 4
    slli a4, a4, 2 # stride1 * 4

loop_start:
    beq t1, a2, loop_end # if counter >= Number of elements to process => dot end
    
    # TODO: Add your own implementation
    # address = a0 + stride0 * sizeof(int) * i
    lw a0, 0(s0)
    # address = a1 + stride1 * sizeof(int) * i
    lw a1, 0(s1)

    jal multiply

    # sum(arr0[i * stride0] * arr1[i * stride1])
    add t0, t0, a0
    addi t1, t1, 1

    add s0, s0, a3
    add s1, s1, a4

    j loop_start
    
loop_end:
    mv a0, t0

    lw ra, 0(sp)
    lw s0, 4(sp)     # save a0
    lw s1, 8(sp)
    addi sp, sp, 12  # push stack space
    jr ra
```
