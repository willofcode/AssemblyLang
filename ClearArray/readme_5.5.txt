######################################################################
        MIPS Assembly Program: Clear Array Comparison
######################################################################

Author: William Ng

######################################################################

Description:
------------

This MIPS assembly language program compares two methods for clearing an
array: one using a pointer and another using an array. The program aims
to demonstrate the implementation of both approaches and compare their
time complexity.

######################################################################

Instructions:
-------------

1. Open the MIPS assembly code file (array_v_pointer.asm) using
   a MIPS assembly language IDE or text editor.

2. Modify the array size and data in the data section according to your
   requirements.

3. Assemble and run the program on MARS simulator.

######################################################################

Clear Array Function Comparison:
--------------------------------

### macro of functions ###
.macro clrarr1_macro(%array, %size) # %array will be head of array, 
	add	    $s1, $zero, %size		# size of array	
	add	    $t0, %array, $zero      	# address of array
loop1:
	sw	    $zero,($t0)		    	#  start at 0 index of the array
	add 	    $t0, $t0, 4		    	# adding 4 to the address, traversing through array
	add	    $s1, $s1, -1			# loop counter decrement
	bgtz        $s1, loop1	    		# continue loop until s1 = 0
.end_macro

.macro clrarr2_macro(%array, %size) # %array is pointer that points to head of array so register that has the address of the array
	move	    $t0, %array			# size of array	
	sll	    $t1, %size, 2
	add	    $t2, $t0, $t1
loop2: 
	sw	    $zero,0($t0)		# saving 0 at each index of the array
	addi        $t0, $t0, 4		   	# adding 4 to the address, traversing through array
	slt 	    $t1, $t0, $t2			# loop counter decrement
	bne	    $t1, $zero, loop2 		# continue loop until s1 = 0
.end_macro

.macro timer(%time)             # timer macro 
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
### macro of function (end) ### 