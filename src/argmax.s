.globl argmax

.text
# =================================================================
# FUNCTION: Maximum Element First Index Finder
#
# Scans an integer array to find its maximum value and returns the
# position of its first occurrence. In cases where multiple elements
# share the maximum value, returns the smallest index.
#
# Arguments:
#   a0 (int *): Pointer to the first element of the array
#   a1 (int):  Number of elements in the array
#
# Returns:
#   a0 (int):  Position of the first maximum element (0-based index)
#
# Preconditions:
#   - Array must contain at least one element
#
# Error Cases:
#   - Terminates program with exit code 36 if array length < 1
# =================================================================
argmax:
    li t6, 1
    blt a1, t6, handle_error

    lw t0, 0(a0)    # t0 = array[index] 

    li t1, 0        
    li t2, 1        # t2 = index
loop_start:
    # TODO: Add your own implementation
    beq t2, a1, loop_end # if index == a1 -> end
    slli t3, t2, 2       # t3 = 4 * index
    add t4, t3, a0       # t4 = pointer + 4 * index
    lw t3, 0(t4)         # t3 = array[index]
    ble t3, t0, loop     # if array[index] =< t0 -> next_loop
    add t0, t3, x0       # t0 = t3
    add t1, t2, x0       # t1 = t2
    
loop:
    addi t2, t2, 1
    j loop_start 

loop_end:
    add a0, t1, x0
    ret

handle_error:
    li a0, 36
    j exit
