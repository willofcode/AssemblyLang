# William Ng
# array vs Pointer time measurement

.data
array:      .word 	0:99	# array 
size:       .word 	100	# size of array
space:      .asciiz " "
newline:    .asciiz " \n "
clr_array1:  .asciiz "printing and clear array1: "
clr_array2:  .asciiz "printing and clear array2: "
clear_timer:.asciiz "the time complexity is:"

### macro of functions from textbook ###
.macro clrarr1_macro(%array, %size) # %array will be head of array,		
	move	$t0, $zero             # i = 0
loop1:  sll	$t1, $t0, 2     	# $t1 = i * 4
        add     $t2, %array, $t1   	# $t2 = &array[i]
        sw	$zero, 0($t2)   	# array[i] = 0		
        addi    $t0, $t0, 1     	# i = i + 1
        slt	$t1, $t0, %size  	# $t3 = (i <size)
        bne	$t1, $zero,loop1	# if () go to loop1
.end_macro

.macro clrarr2_macro(%array, %size) # %array is pointer that points to head of array so register that has the address of the array
	move 	$t0, %array       	# p = & array[0]
        sll	$t1, %size, 2     	# $t1 = size * 4
        add    	$t2, $t0, $t1   	# Memory[p] = 0
loop2:  sw	$zero, 0($t0)   	#array[i] = 0		
        addi    $t0, $t0, 4     	# p = p + 4
        slt	$t1, $t0, $t2   	# $t1 = (p < &array[size])
        bne	$t1, $zero,loop2	# if () go to loop2
.end_macro

.macro timer(%time)             	# timer macro 
	li	    $v0, 30             # system time call
	syscall
	add	    %time, $zero, $a0   #
.end_macro

.macro all(%int, %size, %address)
	add	    $s7, $zero, %size   # saving size of array
	add	    $s1, %address, $zero
loop_all:
	sw	    %int, 0($s1)		# integer input to store at each index of array
	add	    $s1, $s1, 4		    # increment by 4 to get to next element of array	
	add	    $s7, $s7, -1		# loop counter decrement
	bgtz	    $s7, loop_all		# continue loop until s7 = 0
.end_macro

.macro print(%address, %size)
    	addu	    $s2, %size, $zero
  	addu	    $s0, $zero, %address
printing:
    	li     	    $v0, 1
    	lw          $a0, 0($s0)
   	syscall
    	la          $a0, space
    	li          $v0, 4             # syscall number for printing character
    	syscall
    	add	    $s0, $s0, 4
    	addi        $s2, $s2, -1
    	bgtz        $s2, printing
.end_macro
### macro of function from textbook (end) ###

.text
Main: 
	la	    $t5, array			# load address of array A
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
	la	    $a0, clear_timer
	li	    $v0, 4
	syscall
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
	la	    $a0, clear_timer
	li	    $v0, 4
	syscall
	li	    $v0, 4
	la	    $a0, newline
	syscall
	jal 	clear2			# jumping to function clear2

	print($t5, $t7)
	li	    $v0, 10			# syscall to exit
	syscall				# EXIT!

clear1:
	timer($t6)
	clrarr1_macro $t5, $t7		# calling macro with inputs size of array and address of array
	timer($t9)
	sub	    $a0, $t9, $t6
	li	    $v0, 1
	syscall
	move	    $zero, $t6
	move	    $zero, $t9
	li	    $v0, 4
	la	    $a0, newline
	syscall
	jr	    $ra			# jump back to main

clear2:
	timer($t6)
	clrarr2_macro $t5, $t7		# calling macro with inputs size of array and address of array
	timer($t9)
	sub	    $a0, $t9, $t6
	li	    $v0, 1
	syscall
	move	$zero, $t6
	move	$zero, $t9
	li	    $v0, 4
	la	    $a0, newline
	syscall
	jr	    $ra			# jump back to main


