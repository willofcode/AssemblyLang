######################################################################
            MIPS Assembly Program: Stack Push and Pop Operations
######################################################################

Author: William Ng

######################################################################

Description:
------------

This MIPS assembly language program illustrates the implementation of
stack push and pop operations. The program includes macros for pushing
and popping elements onto and from the stack, providing a simple way
to manage a stack in MIPS assembly.

Additional note:
---------------

Stack data structure features the function allows push and pop 
operation. Pushing onto stack will add data to top of the call stack,
Pop will release the data that was on top of stack.

######################################################################

Instructions:
-------------

1. Open the MIPS assembly code file (e.g., `stack_operations.asm`) using
   a MIPS assembly language IDE or text editor.

2. Modify the stack-related data or the elements to be pushed onto the
   stack according to your requirements.

3. Assemble and run the program using a MIPS assembler and simulator

######################################################################

Implementation layout:
----------------------

    .data
array: 	.word 40     # Allocate space for an array of 10 integers (4 bytes each)

# push macro 
	.macro push(%x)
	addi 	$sp, $sp, -4
	sw 	%x, 0($sp)
	.end_macro

# pop macro 
	.macro pop(%x)
	lw	%x, 0($sp)
	addi 	$sp, $sp, 4
	.end_macro

	.text
# Initialize 10 integers in the array using stack operations

main:	la $t0, 0		# load the first value
    	li $t1, 10		# load the loop counter 
