######################################################################
        MIPS Assembly Program: Clearing an Array Using Pointers
######################################################################

Author: William Ng

######################################################################

Description:
------------

This MIPS assembly language program showcases two methods for clearing an array:
1. Using two functions to iterate through the array and set each element to zero.
2. Directly using the array itself to set each element to zero.

The program provides examples of both methods, allowing you to observe
how function calls on both text segment and data segment are updated. 

######################################################################

Instructions:
-------------

1. Open the MIPS assembly code file (cleararray.asm) using a MIPS
   assembly language IDE or text editor.

2. Modify the array data or the size of the array according to your requirements.

3. Assemble and run the program using a MIPS assembler and simulator.


######################################################################

Array Clearing Methods:
-----------------------
## macro of functions from textbook ###
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

