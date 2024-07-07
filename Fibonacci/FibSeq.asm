################################# CSc 343 LAB #3 part 1 ######################################
	.data
    student_name:.asciiz "CSc343000:\nStudent name: William Ng"
    student_id: .asciiz "Student ID: 23445871"
    prompt:     .asciiz "The Fibonacci Number F("
    closing:    .asciiz ") is "
    newline:    .asciiz "\n"
	.text
	.globl main 
############################# Macros ###################################################
    .macro print_space
        li $v0, 4             # Load system call code for print string
        la $a0, newline       # Load address of the newline string
        syscall               # system call
    .end_macro

    .macro Print(%x,%y)		# macro definition for printing Fibonacci
        li $v0, 4              # Print message
        la $a0, prompt
        syscall			# system call
        li $v0, 1              # Print integer
        move $a0, %x         # Move value to $a0
        syscall			# system call
        li $v0, 4              # Print separator
        la $a0, closing
        syscall			# system call
        move $a0, %y          # Move value to $a0
        li $v0, 1              # Print integer
        syscall			# system call
        li $v0, 4              # Print newline
        la $a0, newline
        syscall			# system call 
    .end_macro
########################### Register Usage #########################################    
   	# $t0: index i
    	# $t1: F(i-2)
    	# $t2: F(i-1)
    	# $t3: F(i)
    	# $t4: Threshold limit (10)
######################################################################################
    main:
        # Print Student name and ID
        li $v0, 4              # Load system call code for print string
        la $a0, student_name   # Load address of the student name string
        syscall                # Make system call
        print_space		# Print newline       
        li $v0, 4              # Load system call code for print string
        la $a0, student_id     # Load address of the student ID string
        syscall                # Make system call
        print_space		# Print newline

        # Calculate and print Fibonacci numbers F(1) to F(10)
        li $t0, 0               # $t0 holds the index i for F(i)
        li $t1, 1             	# $t1 holds F(i-2)
        li $t2, 1              # $t2 holds F(i-1)
        li $t4, 10             # $t4 is the limit (10)
	
	# Prints the first two numbers of fibonacci sequence
	Print($t1,$t1)		# Print the Ith Fibonacci sequence ~ fibonacci(0) & etc., and the equivalent value to the Ith fibonacci
	addiu $t2, $t2,1 	# increment the next index
	Print($t2,$t1)		# Print the Ith Fibonacci sequence ~ fibonacci(0) & etc., and the equivalent value to the Ith fibonacci
	li $t2, 1		# re initialize the integer to avoid error output
	addiu $t0, $t1, 1	# increments
	
################################ Fibonacci Sequence Generator #############################
    fib_loop:
        beq $t0, $t4, end_loop  # Increment index, when index equals limit ends the loop at threshold
        addu $t3, $t1, $t2     # F(i) = F(i-2) + F(i-1)
        addiu $t0, $t0, 1      # Increment index
        addu $t1, $t2, $zero      # Update F(i-2)
        addu $t2, $t3, $zero      # Update F(i-1)
        # Print the Fibonacci number
	jal Print		# Print the Ith Fibonacci sequence ~ fibonacci(0) & etc., and the equivalent value to the Ith fibonacci›
        jal fib_loop            # Repeat loop     
        
############################### Print Function #############################################        
    Print:  			# Function definition for printing fibonacci
        li $v0, 4              # Print message
        la $a0, prompt		
        syscall			# system call
        li $v0, 1              # Print integer
        move $a0, $t0         # Move value X to $a0
        syscall			# system call
        li $v0, 4              # Print separator
        la $a0, closing		
        syscall			# system call
        move $a0, $t3         # Move value Y to $a0
        li $v0, 1              # Print integer
        syscall			# system call
	print_space		# Print newline 
        jr $ra
        
############################## Exit Syscall ###############################################        
    end_loop:
        li $v0, 10             # Exit program
        syscall

