######################################################################
        MIPS Assembly Program: Bubble Sort Algorithm
######################################################################

Author: William Ng

######################################################################

Description:
------------

his MIPS assembly language program demonstrates the implementation of
the Bubble Sort algorithm to sort an array in ascending order. Bubble Sort
is a simple sorting algorithm that repeatedly steps through the list,
compares adjacent elements, and swaps them if they are in the wrong order.
The pass through the list is repeated until the list is sorted.

######################################################################

Instructions:
-------------

1. Open the MIPS assembly code file (bubblesort.asm) using
   a MIPS assembly language IDE or text editor.

2. Modify the array size and data in the data section according to your
   requirements.

3. Assemble and run the program on MARS simulator.

######################################################################

Bubble Sort Function:
---------------------

sort:
    addi $sp, $sp, -20   # Make room on the stack for 5 registers
    sw $ra, 16($sp)      # Save $ra on the stack
    sw $s3, 12($sp)      # Save $s3 on the stack
    sw $s2, 8($sp)       # Save $s2 on the stack
    sw $s1, 4($sp)       # Save $s1 on the stack
    sw $s0, 0($sp)       # Save $s0 on the stack
    move $s2, $a0        # Copy parameter $a0 into $s2 (save $a0)
    move $s3, $a1        # Copy parameter $a1 into $s3 (save $a1)
    move $s0, $zero      # i = 0

for1tst:
    slt $t0, $s0, $s3    # $t0=1 if $s0 < $s3 (i < n)
    beq $t0, $zero, exit1 # Exit loop if $s0 >= $s3 (i >= n)
    addi $s1, $s0, -1    # j = i - 1

for2tst:
    slti $t0, $s1, 0     # $t0=1 if $s1 < 0 (j < 0)
    bne $t0, $zero, exit2 # Exit inner loop if $s1 < 0 (j < 0)
    sll $t1, $s1, 2      # $t1 = j * 4
    add $t2, $s2, $t1    # $t2 = v + (j * 4)
    lw $t3, 0($t2)       # $t3 = v[j]
    lw $t4, 4($t2)       # $t4 = v[j + 1]
    slt $t0, $t4, $t3    # $t0=1 if $t4 < $t3
    beq $t0, $zero, exit2 # Exit inner loop if $t4 >= $t3
    move $s5, $s2        # 1st parameter of swap is v (old $a0)
    move $s6, $s1        # 2nd parameter of swap is j
    jal swap             # Call the swap function

    addi $s1, $s1, -1    # j -= 1
    j for2tst            # Jump to test of inner loop

exit2:
    addi $s0, $s0, 1     # i += 1
    j for1tst            # Jump to test of outer loop

exit1:
    lw $s0, 0($sp)       # Restore $s0 from the stack
    lw $s1, 4($sp)       # Restore $s1 from the stack
    lw $s2, 8($sp)       # Restore $s2 from the stack
    lw $s3, 12($sp)      # Restore $s3 from the stack
    lw $ra, 16($sp)      # Restore $ra from the stack
    addi $sp, $sp, 20    # Restore stack pointer
    jr $ra               # Return to calling routine

# Swap function
swap:
    sll $t1, $s6, 2      # $t1 = k * 4
    add $t1, $s5, $t1    # $t1 = v + (k * 4)
    lw $t0, 0($t1)       # $t0 = v[k]
    lw $t2, 4($t1)       # $t2 = v[k + 1]
    sw $t2, 0($t1)       # v[k] = $t2
    sw $t0, 4($t1)       # v[k + 1] = $t0
    jr $ra               # Return to calling routine