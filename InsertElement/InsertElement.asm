# william Ng
# Insert element[integer] into the array
	.data
array:  .word 0 : 10
size: 	.word 10
head: 	.asciiz " Please input the integer you would like to input: "
head2: 	.asciiz " please select the index in the array : "
head3:  .asciiz " the new array after insertion : "
space:  .asciiz " "
newline: .asciiz "\n"

    	.text
# insert a word after element A[j], taking user input
	la 	$s0, array 	# load address of array 
	la 	$s5, size 	# load address of size variable
	lw 	$s5, 0($s5) 	# load array size
	li 	$s2, 1 		# first value of array = 1
	sw 	$s2, 0($s0) 	# storing the first value of the array
	addi	$s0, $s0, 4 	# increment address to array number size
	addi 	$s1, $s5, -1 	# Counter for loop, will execute (size-1) times

loop1: 
	addi 	$s2, $s2, 1 	# adding one to previous value of array to be the next value i
	sw 	$s2, 0($s0) 	# storing the value of the array
	addi 	$s0, $s0, 4 	# increment address to array number size
	addi 	$s1, $s1, -1 	# decrement loop counter
	bgtz   	$s1, loop1 	# repeat while not finished
	
	li 	$s1, 10 	# reset loop counter
	add 	$t0, $s0, 200 	# setting memory word address of new array to end of original array + 40 bits
	la 	$s0, array 	# load address of array 
	add 	$t1, $t0, $zero # beginning address of temporary array
	
insert:
   	la $a0, head        # load address of head to print
	li $v0, 4           # system call to print string
    	syscall             # print string

    	li $v0, 5           # system call to take integer input
    	syscall             # integer input stored in $v0
    	move $s6, $v0       # move the input value 

    	la $a0, head2       # load address of head2 to print
    	li $v0, 4           # system call for print string
    	syscall

    	li $v0, 5           # system call for integer input
    	Syscall
    	move $s7, $v0       # move the input value into s7

    	lw $t2, 0($t1)      # load value in the address written in t1 into t2
    	add $t3, $t3, 11    # length of new array increased by +1
    	sub $s3, $s7, 1     # subtract the index -1 and store in $s3
    	sub $s1, $5, $s7    # Loop counter to start at the index we want to replace = length of array + 1 - index of array store

    	la $s0, array       # load address of array
    	mul $s2, $s3, 4     # address of where we want to start changing in the array
    	add $s0, $s0, $s2   # save the address to s0

loop2:
    	lw $s4, 0($s0)      # load value in the address of s0 into s4
    	sw $s6, 0($s0)      # save value of s6 into s0
    	add $s6, $s4, $zero # change s6 to s4 the original value of element
    	addi $s0, $s0, 4    # increment address to now-known array number storage
    	addi $s1, $s1, -1   # decrement loop counter
    	bgtz $s1, loop2     # repeat until program finish

print: 
    	la $a0, head3       # load address of print head string
    	li $v0, 4           # specify print string directive
    	syscall

    	add $t3, $zero, 10  # loop counter for printing
    	la $s0, array

out:
    	lw $a0, 0($s0)      # load the integer to be printed
    	li $v0, 1           # specify print integer service
    	syscall

    	la $a0, space       # load the address to add space in $a0
    	li $v0, 4           # specify print string 
    	syscall

    	addi $s0, $s0, 4    # increment address of spacing
    	addi $t3, $t3, -1   # decrement loop counter
    	bgtz $t3, out      # repeat loop until function completes

exit:
	li 	$v0, 10
	syscall

