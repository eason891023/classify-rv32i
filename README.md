# Assignment 2: Classify
my origin multiplier
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
    li t0, 0                  # Initialize result
    
multiply_loop:
    beqz a0, end_multiply         # Exit if multiplier (t8) is zero
    andi t1, a0, 1               # Check if lowest bit of multiplier is 1
    beqz t1, skip_addition       # If not, skip addition
    add t0, t0, a1                # Add multiplicand to result

skip_addition:
    slli a1, a1, 1                # Shift multiplicand left
    srli a0, a0, 1                # Shift multiplier right
    j multiply_loop               # Repeat

end_multiply:
    mv a0, t0

    ret
