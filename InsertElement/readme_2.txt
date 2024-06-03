######################################################################
                  MIPS Assembly Program:  Insert Element into Array
######################################################################

Author: William Ng

######################################################################

Description:
------------

This MIPS assembly language program demonstrates how to insert an integer
into an array at a specified position [index]. The program sets the array to be
stored in the data section of the program, and it provides a simple
algorithm to insert an element at the desired index. 

Additional note:
---------------

the insertion occurs on the array
Index must be addressed between the range of 1 to 10
element insertion must be an integer.

######################################################################

Instructions:
-------------

1. Open the MIPS assembly code file [insertElement.asm] using
   a MIPS assembly language IDE.

2. Assemble and run the program using MARS simulator.

3. Modify integers and index in the user defined interface when prompted.

######################################################################

Implementation layout:
----------------------

    .data
array:  .word 0 : 10
size: 	.word 10
head: 	.asciiz " Please input the integer you would like to input: "
head2: 	.asciiz " please select the index in the array : "
head3:  .asciiz " the new array after insertion : "
space:  .asciiz " "
newline: .asciiz "\n"

    	.text
# load address of array with 10 integer
	la  	$s0, array 	# load address of array 
	la 	    $s5, size 	# load address of size variable
	lw 	    $s5, 0($s5) 	# load array size
	li 	    $s2, 1 		# first value of array = 1
	sw 	    $s2, 0($s0) 	# storing the first value of the array
	addi	$s0, $s0, 4 	# increment address to now-known array number storage
	addi 	$s1, $s5, -1 	# Counter for loop, will execute (size-1) times

loop1: 

# array of 10 integer will be stored in a memory location

# insert an integer after element A[j], taking user input	
insert:
   	    la $a0, head        # load address of head to print
	    li $v0, 4           # system call to print string
    	syscall             # print string

# input the [integer] on the first prompt from head string by entering userdefined directive call $v0, 5

    	la $a0, head2       # load address of head2 to print
    	li $v0, 4           # system call for print string
    	syscall

# input the index [integer] on the second prompt from head2 string by entering userdefined directive call $v0, 5

    	lw $t2, 0($t1)      # load value in the address written in t1 into t2
    	add $t3, $t3, 12    # length of new array increased by +1
    	sub $s3, $s7, 1     # subtract the index -1 and store in $s3
    	sub $s1, $5, $s7    # Loop counter to start at the index we want to replace = length of array + 1 - index of array store

# load the address of index on the array to be manipulated

loop2:

# element on the index are updated 

print: 
    	la $a0, head3       # load address of print head string
    	li $v0, 4           # specify print string directive
    	syscall

    	add $t3, $zero, 10  # loop counter for printing
    	la $s0, array

# loop counter can manipulate how insertion will occur 

out:

# output and prints new array after insertion

exit:
	li 	$v0, 10
	syscall

