# william Ng
# Stack operation using push and pop macro

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

pushloop:		
	push($t0)		# Push the current value onto the stack
        addi $t0, $t0, 1	# current value moves incremently
        addi $t1, $t1, -1	# Decrement for loop counter
        bnez $t1, pushloop	# return the push loop

# Pop values from the stack back into the array

    	la $t2, array      	# Load address of the array
    	li $t1, 10         	# Reset the loop counter
	
poploop:
        pop($t0)		# Store the popped value into the array
        sw $t0, 0($t2)    	# Store value in another memory address
        addi $t2, $t2, 4 	# Increment the array pointer
        addi $t1, $t1, -1 	# Decrement the loop counter
        bnez $t1, poploop 	# return the pop loop


    	li $v0, 10          	# exit program system call
    	syscall			# System call exexute for program exit
