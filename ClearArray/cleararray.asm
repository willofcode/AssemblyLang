# william Ng
# clear array 
	.data
array:      .word   0:29	# array 
size:       .word   30	# size of array
space:      .asciiz "    "
newline:    .asciiz " \n "
clr_array1:  .asciiz "printing and clear array1: "
clr_array2:  .asciiz "printing and clear array2: "

### macro of functions ###
.macro clrarr1_macro(%array, %size) # %array will be head of array, 
	add	    $s1, $zero, %size		# size of array	
	add	    $t0, %array, $zero      # address of array
loop1:
	sw	    $zero,($t0)		    	#  start at 0 index of the array
	add 	$t0, $t0, 4		    	# adding 4 to the address, traversing through array
	add	    $s1, $s1, -1			# loop counter decrement
	bgtz    $s1, loop1	    		# continue loop until s1 = 0
.end_macro

.macro clrarr2_macro(%array, %size) # %array is pointer that points to head of array so register that has the address of the array
	move	$t0, %array				# size of array	
	sll	    $t1, %size, 2
	add	    $t2, $t0, $t1
loop2: 
	sw	    $zero,0($t0)			# saving 0 at each index of the array
	addi    $t0, $t0, 4		   	 	# adding 4 to the address, traversing through array
	slt 	$t1, $t0, $t2			# loop counter decrement
	bne	    $t1, $zero, loop2 		# continue loop until s1 = 0
.end_macro


.macro all(%int, %size, %address)
	add	    $s7, $zero, %size   # saving size of array
	add	    $s1, %address, $zero
loop_all:
	sw	    %int, 0($s1)		# integer input to store at each index of array
	add	    $s1, $s1, 4		    # increment by 4 to get to next element of array	
	add	    $s7, $s7, -1		# loop counter decrement
	bgtz	$s7, loop_all		# continue loop until s7 = 0
.end_macro

.macro print(%address, %size)
    add	    $s2, %size, $zero
    add	    $s0, $zero, %address
printing:
    li      $v0, 1
    lw      $a0, 0($s0)
    syscall
    li      $a0, 32
    li      $v0, 11             # syscall number for printing character
    syscall
    add	    $s0, $s0, 4
    addi    $s2, $s2, -1
    bgtz    $s2, printing
.end_macro
### macro of function (end) ###

	.text
Main: 
	la	    $t5, array			# load address of array 
	la	    $t6, size		# load address of the size of array
	lw	    $t7, 0($t6)		# load size of array stored in the address 
	li	    $t8, 1			# set $t8 register equal to 1
	add	    $s7, $t7, 0		# loop counter
	add	    $s3, $t5, 0		# save address of original array
	
	all($t8, $t7, $t5)		# call macro to put 1 in every element in array	
	la	    $a0, clr_array1
	li	    $v0, 4
	syscall
	la	    $a0, newline
	li	    $v0, 4
	syscall

	print($t5,$t7)
	li	    $v0, 4
	la	    $a0, newline
	syscall

	jal	clear1			# jumping to function clear1

	print($t5, $t7)
	li	    $v0, 4
	la	    $a0, newline
	syscall

	la	    $a0, clr_array2
	li	    $v0, 4
	syscall

	all($t8, $t7, $t5)
	li	    $v0, 4
	la	    $a0, newline
	syscall

	print($t5, $t7)
	li	    $v0, 4
	la	    $a0, newline
	syscall
	
	jal 	clear2			# jumping to function clear2

	print($t5, $t7)
	li	    $v0, 10			# syscall to exit
	syscall				# EXIT!

clear1:
	clrarr1_macro $t5, $t7		# calling macro with inputs size of array and address of array
	sub	    $a0, $t9, $t6
	li	    $v0, 1
	syscall
	move	$zero, $t6
	move	$zero, $t9
	li	    $v0, 4
	la	    $a0, newline
	syscall
	jr	    $ra			# jump back to main

clear2:
	clrarr2_macro $t5, $t7		# calling macro with inputs size of array and address of array
	sub	    $a0, $t9, $t6
	li	    $v0, 1
	syscall
	move	$zero, $t6
	move	$zero, $t9
	li	    $v0, 4
	la	    $a0, newline
	syscall
	jr	    $ra			# jump back to main


