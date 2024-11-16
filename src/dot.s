.globl dot

.text
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
# Error Handling:
#   - Exits with code 36 if element count < 1
#   - Exits with code 37 if any stride < 1
# =======================================================
dot:
    li t0, 1
    blt a2, t0, error_terminate  
    blt a3, t0, error_terminate   
    blt a4, t0, error_terminate  

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
    bge t1, a2, loop_end # if counter >= Number of elements to process => dot end
    
    # TODO: Add your own implementation
    # i * stride0
    mv a0, t1        # a0 = i
    mv a1, a3        # a1 = stride0
    jal ra, multiply # multiply a0, a1

    add a0, s0, a0
    lw t5, 0(a0)

    # i * stride1
    mv a0, t1        # a0 = i
    mv a1, a4        # a1 = stride0
    jal ra, multiply # multiply a0, a1       

    add a0, s1, a0
    lw t6, 0(a0)

    # arr0[i * stride0] * arr1[i * stride1]
    mv a0, t5
    mv a1, t6
    jal ra, multiply

    # sum(arr0[i * stride0] * arr1[i * stride1])
    add t0, t0, a0
    addi t1, t1, 1
    j loop_start
    
loop_end:
    mv a0, t0

    lw ra, 0(sp)
    lw s0, 4(sp)     # save a0
    lw s1, 8(sp)
    addi sp, sp, 12  # push stack space
    jr ra


error_terminate:
    blt a2, t0, set_error_36
    li a0, 37
    j exit

set_error_36:
    li a0, 36
    j exit

# =======================================================
# FUNCTION: Multilply 2 numbers
#
# Args:
#   a0 (int): multiplier
#   a1 (int): multiplicand
#
# Returns:
#   a0 (int):   answer
# =======================================================
multiply:
    li t2, 0                  # Initialize result

multiply_loop:
    beqz a0, end_multiply         # Exit if multiplier (t8) is zero
    andi t3, a0, 1               # Check if lowest bit of multiplier is 1
    beqz t3, skip_addition       # If not, skip addition
    add t2, t2, a1                # Add multiplicand to result

skip_addition:
    slli a1, a1, 1                # Shift multiplicand left
    srli a0, a0, 1                # Shift multiplier right
    j multiply_loop               # Repeat

end_multiply:
    mv a0, t2
    
    ret
