# Assignment 2: Classify
I think the main focus this time is to write about the multiplier and dot.s.  
Therefore, the document will primarily explain the multiplier and dot.s,
while other explanations will be provided in the comments within the code.

# Multiplier
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
First, check if the least significant bit of the multiplier is 1. If it is, add the multiplicand to the accumulated result; otherwise, skip the addition. Then, shift the multiplicand one bit to the left and simultaneously shift the multiplier one bit to the right. The multiplication operation ends when either the multiplier or the multiplicand becomes 0.
