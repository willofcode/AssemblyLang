######################################################################
                  MIPS Assembly Program: Print and Reverse Array
######################################################################

Author: William Ng

######################################################################

Description:
------------

This MIPS assembly language program demonstrates how to print the elements
of an array and then reverse the order of the elements in the same array.

The program setup the array to be stored in the data section of the program,
and it provides a simple loop for printing the elements and another loop
for reversing the array in the text section

Additional note:
---------------

program executes over text segment for function calls
data segment get updated on the Built-in MIPS IDE debugger
memory allocation are manipulation through registers

######################################################################

Instructions:
-------------

1. Open the MIPS assembly code file [reversearray.asm] using
   a MIPS assembly language IDE.

2. Modify the array of 10 integers in the data section if needed.

3. Assemble and run the program using MARS simulator.

######################################################################

Implementation layout:
----------------------

    .data
array:  .word 0 : 10
size: 	.word 10
head: 	.asciiz " array[10] is listed: "
head2: 	.asciiz " array[10] in reversed: "
space:  .asciiz " "
newline: .asciiz "\n"

	.text 

# insert values into array and save into word memory address

loop1: 

# this loop copies array from memory to a different memory address

print1:
	la 	$a0, head 	# load address of the print heading string
	li 	$v0, 4 		# specify Print String service
	syscall 		# print the heading string

loop2: 

# this loop stores in reverse order in a different memory address
	
# print reverse array
	add $t0, $t7, $zero # load address of the reverse array 
	li 	$t1, 10 	# loop counter for printing

print2: 
	la 	$a0, newline 	# printing new line for neat and clean view for users
	li 	$v0, 4	 	# specify Print String service
	syscall 		# print the heading string
	la 	$a0, head2 	# load address of the print heading string
	li 	$v0, 4 		# specify Print String service
	syscall 		# print the heading string

loop3: 

# this loop write array in reverse order in the same memory location of the original array

exit:
	li 	$v0, 10
	syscall
