# Assignment 2: Classify
I think the main focus this time is to write about the multiplier and dot.s.  
Therefore, the document will primarily explain the multiplier and dot.s,
while other explanations will be provided in the comments within the code.

# Multiplier
```riscv=
FUNCTION: Multilply 2 numbers   
Args:   
   a0 (int): multiplier   
   a1 (int): multiplicand   
Returns:   
  a0 (int):   answer   

multiply:
    li t2, 0                  # Initialize result
    beqz a0, end_multiply         # Exit if multiplicand (a1) is zero

multiply_loop:
    beqz a1, end_multiply         # Exit if multiplier (a1) is zero
    andi t3, a1, 1               # Check if lowest bit of multiplier is 1
    beqz t3, skip_addition       # If not, skip addition
    add t2, t2, a0                # Add multiplicand to result

skip_addition:
    slli a0, a0, 1                # Shift multiplicand left
    beqz a0, end_multiply         # Exit if multiplicand (a1) is zero
    srli a1, a1, 1                # Shift multiplier right
    j multiply_loop               # Repeat

end_multiply:
    mv a0, t2
    ret
```
