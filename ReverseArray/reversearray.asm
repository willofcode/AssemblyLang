# william Ng
# print and reverse array and store in original array

.data
array:  .word 0 : 10
size: 	.word 10
head: 	.asciiz " array[10] is listed: "
head2: 	.asciiz " array[10] in reversed: "
space:  .asciiz " "
newline: .asciiz "\n"

.text 
	la 	$s0, array 	# load address of array 
	la 	$s5, size 	# load address of size variable
	lw 	$s5, 0($s5) 	# load array size
	li 	$s2, 1 		# first value of array = 1
	sw 	$s2, 0($s0) 	# storing the first value of the array
	addi	$s0, $s0, 4 	# increment address to array number size
	addi 	$s1, $s5, -1 	# Counter for loop, will execute (size-1) times

# loop to insert values into array and save into word memory address

loop1: 
	addi 	$s2, $s2, 1 	# adding one to previous value of array to be the next value i
	sw 	$s2, 0($s0) 	# storing the value of the array
	addi 	$s0, $s0, 4 	# increment address to array number size
	addi 	$s1, $s1, -1 	# decrement loop counter
	bgtz   	$s1, loop1 	# repeat while not finished

# loop to read array from memory & storing in a different memory address

	li 	$s1, 10 	# reset loop counter
	add 	$t0, $s0, 200 	# setting memory word address of new array to end of original array + 40 bits
	la 	$s0, array 	# load address of array 
	add 	$t7, $t0, $zero # beginning address of temporary array

print1:
	la 	$a0, head 	# load address of the print heading string
	li 	$v0, 4 		# specify Print String service
	syscall 		# print the heading string

# storing in reverse order in a different memory address
out1: 
	lw 	$a0, 0($s0) 	# load the integer to be printed
	li 	$v0, 1 		# specify Print Integer service
	syscall 		# print number
	la 	$a0, space 	# load address of spacer for syscall
	li 	$v0, 4 		# specify Print String service
	syscall 		# print the spacer string

	addi 	$s0, $s0, 4 	# increment address of data to be printed
	addi 	$s1, $s1, -1 	# decrement loop counter
	bgtz  	$s1, out1 	# repeat while not finished

	addi 	$s0, $s0, -4 	# decrement address of data so that it's the address of the last value of array
	li 	$t1, 10 	# loop counter for reverse array

loop2: 
	lw 	$t2, 0($s0) 	# set value of last element to the first element of reverse array
	sw 	$t2, 0($t0) 	# storing the value of reverse array
	addi 	$t0, $t0, 4 	# increment address to now-known reverse array number storage
	addi 	$s0, $s0, -4 	# decrement address to now-known array number storage
	addi 	$t1, $t1, -1 	# decrement loop counter
	bgtz 	$t1, loop2 	# repeat while not Finished

# print reverse array
	add 	$t0, $t7, $zero # load address of the reverse array 
	li 	$t1, 10 	# loop counter for printing

print2: 
	la 	$a0, newline 	# printing new line for neat and clean view for users
	li 	$v0, 4	 	# specify Print String service
	syscall 		# print the heading string
	la 	$a0, head2 	# load address of the print heading string
	li 	$v0, 4 		# specify Print String service
	syscall 		# print the heading string

out2: 
	lw 	$a0, 0($t0) 	#Load the integer Io be printed
	li 	$v0, 1 		# specify Print Integer service
	syscall 		# print number

	la 	$a0, space 	# load address of spacer for syscall
	li 	$v0, 4 		# specify Print String service
	syscall 		# print the spacer string

	addi 	$t0, $t0, 4 	# increment address of data to be printed
	addi 	$t1, $t1, -1 	# decrement loop counter
	bgtz  	$t1, out2 	# repeat while not finished

# loop to write array in reverse order in the same memory location of the original array

	add 	$t0, $t7, $zero # load address of the reverse array 
	li 	$t1, 10 	# loop counter for transfering the reverse array into original array
	la 	$s0, array 	# load address of array 

loop3: 
	lw 	$s1, 0($t0) 	# set value of last element to the first element of reverse array
	sw 	$s1, 0($s0) 	# storing the value of reverse array
	addi 	$t0, $t0,4 	# increment address to now-known reverse array number storage
	addi 	$s0, $s0, 4 	# increment address to now-known array number storage
	beqz 	$t1, loop3 	# repeat until loop finished

exit:
	li 	$v0, 10
	syscall
