######################################################################
        MIPS Assembly Program: Swap operation in an Array
######################################################################

Author: William Ng

######################################################################

Description:
------------


This MIPS assembly language program illustrates a swap operation on two 
elements in an array. The program allows you to see how the elements are 
swapped which provides a reusable swap function for future implementation in our
coursework.

######################################################################

Instructions:
-------------

1. Open the MIPS assembly code file (swap.asm) using a MIPS
   assembly language IDE or text editor.

2. Modify the array data or the indices of the elements to be swapped according
   to your requirements.

3. Assemble and run the program on MARS simulator.


######################################################################

Swap Operation:
---------------

	.data
array:  .word   1, 2, 3, 4, 5   # array
space:  .asciiz " "
newline: .asciiz "\n"
string:  .asciiz "array before swap: "
string2: .asciiz "array after swap: "

	.text
main:
    la      $s0, array           # Load address of the array
    li      $s1, 1               # Index of the first element to swap
    li      $s2, 3               # Index of the second element to swap
    li	    $s3, 4		 		# Index of the fourth element to swap
    li      $s4, 2				# Index of the second element to swap
    
    li	    $v0, 4
    la 	    $a0, string
    syscall
    
    # call the print subroutine
    jal	    print_array

    la      $s0, array
    
    li	    $v0, 4
    la 	    $a0, string2
    syscall
    
    # Call the swap subroutine
    jal     swap
    
    jal	    print_array
    
    la      $s0, array
    
    # Call the swap subroutine
    li	    $v0, 4
    la 	    $a0, string2
    syscall
    
    jal	    swap2
    
    # call the print subroutine
    jal	    print_array

    
    # Exit program
    li      $v0, 10              # System call code for program exit
    syscall

# Swap subroutine
swap:
    sll     $t1, $s1, 2          # Calculate the offset in bytes (4 bytes per word)
    add     $t1, $s0, $t1        # Calculate the address of the element at index $s1
    lw      $t0, 0($t1)          # Load the value of array[$s1]

    sll     $t2, $s2, 2          # Calculate the offset in bytes (4 bytes per word)
    add     $t2, $s0, $t2        # Calculate the address of the element at index $s2
    lw      $t3, 0($t2)          # Load the value of array[$s2]

    sw      $t3, 0($t1)          # Store the value of array[$s2] at array[$s1]
    sw      $t0, 0($t2)          # Store the value of array[$s1] at array[$s2]

    jr      $ra                 # Jump back to the calling routine

swap2:
    sll     $t1, $s3, 2          # Calculate the offset in bytes (4 bytes per word)
    add     $t1, $s0, $t1        # Calculate the address of the element at index $s1
    lw      $t0, 0($t1)          # Load the value of array[$s1]

    sll     $t2, $s4, 2          # Calculate the offset in bytes (4 bytes per word)
    add     $t2, $s0, $t2        # Calculate the address of the element at index $s2
    lw      $t3, 0($t2)          # Load the value of array[$s2]

    sw      $t3, 0($t1)          # Store the value of array[$s2] at array[$s1]
    sw      $t0, 0($t2)          # Store the value of array[$s1] at array[$s2]

    jr      $ra                 # Jump back to the calling routine

# Print array subroutine
print_array:
    li      $t0, 0               # Initialize loop counter

print_loop:
    beq     $t0, 5, end_print    # Exit loop when all elements are printed

    li      $v0, 1               # System call code for print_int
    lw      $a0, ($s0)           # Load the current element of the array
    syscall

    li      $v0, 4               # System call code for print_str
    la      $a0, space 	         # Load the address of the string
    syscall

    addi    $s0, $s0, 4          # Move to the next element in the array
    addi    $t0, $t0, 1          # Increment loop counter
    j       print_loop

end_print:
    li      $v0, 4               # System call code for print_str
    la      $a0, newline    # Load the address of the string
    syscall

    jr      $ra                # Jump back to the calling routine



