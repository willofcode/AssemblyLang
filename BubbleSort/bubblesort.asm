# William Ng
# the static array has 10 random integers

	.data
array:  .word	 5, 2, 8, 3, 1, 7, 10, 4, 6, 9   # Example array to be sorted
str1:   .asciiz  "array before sort: "
str2:   .asciiz  "array after sort: "
time: 	.asciiz  "time to sort: "  
space:  .asciiz  " "
newline: .asciiz "\n"

	.text
.macro	printArray(%address, %size)
	add	$t0, %address, $zero
	add	$t1, %size, $zero
printing:
	lw	$a0, ($t0)
	li	$v0, 1
	syscall
	la	$a0, space
	li	$v0, 4
	syscall
	add	$t0, $t0, 4
	add	$t1, $t1, -1
	bgtz	$t1, printing
	
.end_macro

.macro	new_line()
	li	$v0, 4
	la	$a0, newline
	syscall
.end_macro
	
.macro print(%int)
    addu     $s0, $zero, %int	# load address of temp register into saved register
    li       $v0, 1		# syscall for printing integer
    move     $a0, $s0		# print integer from the saved integer
    syscall
.end_macro 

main:
    li	    $v0, 4
    la 	    $a0, str1
    syscall
    
    li	$s1, 10
    la	$s0, array
    printArray($s0, $s1)
    new_line()
    
    li	    $v0, 4
    la 	    $a0, str2
    syscall
    
    la $a0, array    # Load the base address of the array into $a0
    li $a1, 10       # Load the size of the array into $a1
    jal sort         # Call the sorting functions

    # After sorting, print the sorted array
    
    li	$s1, 10
    la	$s0, array
    printArray($s0, $s1)
    new_line()
    
    # Exit the program
    
    li	$v0, 10
    syscall


# Sort function
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
