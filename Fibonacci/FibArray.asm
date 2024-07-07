#######################################################################    
    		 .data
    student_name:.asciiz "\nStudent name: William Ng"
    student_id: .asciiz "Student ID:"
    prompt:     .asciiz "The Fibonacci Number F("
    closing:    .asciiz ") is "
    newline:    .asciiz "\n"
        	.align 2
    FBN: 	.space 400      # Array to store Fibonacci numbers (100 integers)
        	.align 2
    NUM_FBN: 	.space 4        # Variable to store the index of the largest Fibonacci number

    		.text
    		.globl main
############################# Macro ###################################################
    .macro print_space
        li $v0, 4             # Load system call code for print string
        la $a0, newline       # Load address of the newline string
        syscall               # system call
    .end_macro

########################### Register Usage ############################################  
#$t0: Base address of the FBN array, and iteration through the array.
#$t1: Temporary register for storing Fibonacci values.
#$t2: Counter for the current index N of the Fibonacci sequence.
#$t3: Temporary register for storing FBN[N-1].
#$t4: Temporary register for storing FBN[N].
#$t5: Temporary register for calculating the next Fibonacci number.
######################################################################################
main:
    # Print student name and ID
    li $v0, 4                 # Print string syscall
    la $a0, student_name      # Load address of student_name string
    syscall
    print_space
    la $a0, student_id        # Load address of student_id string
    syscall
    print_space

    # Step 1: Calculate Fibonacci numbers until overflow
    la $t0, FBN               # Load base address of FBN array 100 integers
    li $t1, 0                 # FBN[0] = 0
    sw $t1, 0($t0)            # Store 0 at FBN[0]
    li $t1, 1                 # FBN[1] = 1
    sw $t1, 4($t0)            # Store 1 at FBN[1]
    li $t2, 1                 # N = 1 (last computed Fibonacci index)
    addiu $t0, $t0, 4         # Update address to FBN[1]

store_loop: 
    lw $t3, -4($t0)           # Load FBN[N-1]
    lw $t4, 0($t0)            # Load FBN[N]
    addu $t5, $t3, $t4        # Calculate F(N+1) = F(N) + F(N-1)
    # bltu $t5, $t3, overflow
    sltu $s0, $t5, $t4	      # (if result < previous number)
    bne $s0, $zero, overflow  # Check for overflow 
    addiu $t2, $t2, 1         # Increment N
    addiu $t0, $t0, 4         # Move to the next position in FBN
    sw $t5, 0($t0)            # Store F(N+1) in FBN[N]
    j store_loop              # Repeat loop

overflow:
    sw $t2, NUM_FBN           # Store the last valid index in NUM_FBN
######################################################################################
 # Step 2: Print Fibonacci numbers from FBN array
    li $t2, 0                 # Initialize loop index i
    lw $s1, NUM_FBN           # Load last valid Fibonacci index
    la $t0, FBN               # Reload base address of FBN array
    jal fib_loop

fib_loop:
    #bgeu   $t2, $t3, exit
    sltu $s2, $t2, $s1 	      # when i < NUM_FBN, 
    beq $s2, $zero, exit      # Exit loop 
    lw $t6, 0($t0)            # Load Fibonacci number FBN[i]
    move $a2, $t2             # Move index to $a2
    move $a1, $t6             # Move Fibonacci number to $a1
    jal print
    addiu $t0, $t0, 4         # Move to the next position in FBN
    addiu $t2, $t2, 1         # Increment index
    j fib_loop                # Repeat loop
    
####################### Exit syscall #################################################
exit:
    li $v0, 10                # Exit program
    syscall
######################################################################################
# Print function to show the results
print:
    li $v0, 4                 # Load syscall code for print string
    la $a0, prompt            # Load address of prompt string
    syscall                   # Print prompt
    li $v0, 1                 # Load syscall code for print integer
    move $a0, $a2             # Move Fibonacci index to $a0
    syscall                   # Print index
    li $v0, 4                 # Load syscall code for print string
    la $a0, closing           # Load address of closing string
    syscall                   # Print closing
    
    li $v0, 1                 # Load syscall code for print integer
    move $a0, $a1             # Move Fibonacci number to $a0
    syscall                   # Print Fibonacci number
    print_space               # Load address of newline string
    jr $ra                    # Return from function
