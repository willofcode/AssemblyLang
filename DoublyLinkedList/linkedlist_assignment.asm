# william Ng
# linked list implementation instruction homework 
# add/remove implementation
	
	.data
note: 		.asciiz "linked list node are empty in the beginning. Insertion of 0 must be intialized to start adding element on the linked list. "
selection:	.asciiz	"Please select: \n [1]: insert node  [2]: next node  [3]: previous node \n [4]: remove node  [5]: print all node  [6]: exit \n "
enter:		.asciiz "enter here : "
input:		.asciiz	"\n Input an element into the node and press enter: "
isempty:	.asciiz	" "
currnode:	.asciiz	"\n The current node: "
array:		.asciiz "\n All nodes in the string: \n"
nextLine:	.asciiz	"\n"
spacing: 	.asciiz	"\t"
	
	.text
main:	
	#la 	$a0, note 		# load address of note string to provide guidance using this program
	#jal 	Print
intro:	
	beqz	$s1, empty	# if list is empty, use prompt	
	la	$a0, currnode 	# load the prompt for current element
	jal	Print		# excute print using preset print condition 
	move	$a0, $a1	# move the current input arguement into another arguement register
	jal	Print		# execute print function of current node
	la	$a0, nextLine 	# create a new line 
	jal	Print		# excecute print for a new line
	
# empty node array 	
empty:	
	la	$a0, isempty	# load address of prompt for starting node 
 	jal	Print		# execute print for the starting node
 	la	$a0, nextLine
	jal	Print		# execute print for starting node
	j	Menu		# jump to menu for additional function

Menu:	
	la	$a0, selection	# use print string syscall (to console) to show menu and prompt for input
	jal	Print
	la	$a0, enter	# load address of enter string
	jal	Print
	li	$v0, 5		# load read string syscall to input node response.
	syscall			# execute read string input node
	move	$t0, $v0	# move response to the another memory

	beq	$t0, 1, insert	# function input declaration to insert element
	beq	$t0, 2, next	# function input declaration traverse to next element
	beq	$t0, 3, previous# function input declaration traverse to previous element
	beq  	$t0, 4, remove	# function input declaration to remove element
	beq	$t0, 5, allNodes# function input declaration to print all current element
	beq	$t0, 6, exit	# function input declaration to exit program.

#insert element into the array
insert:	
	la	$a0, input	# load address for adding node into arguement 
	jal	Print		# execute print for the arguement
	jal 	alloSpace	# allocate space 
	move	$t1, $v0	# register t1 now has the address to the allocated space (12 bytes)
	sw	$zero, 0($t1)	# initialized previous to zero
	sw	$zero, 4($t1)	# initialized next to zero
	li	$v0, 8		# read input call for node
	la	$a0, 4($t1)	
	li	$a2, 10
	syscall	
# initializing the first node of the string
	beqz	$s1, first	#if list is empty, this is the first node
	lw	$t2, 16($a1)	# check for next node of current node
	beqz	$t2, addElement # add element when string content is empty
	move	$t0, $t2	# move current pointers into a temporary pointer
	la	$t2, 16($t1)	# load the address of new node string
	la	$t0, -4($t0)	# load the address of previous field of curent node
	sw	$t2, ($t0)	# store new string's address into previous field
	
addElement:			# when next node is empty, start adding new node
	lw	$t2, 12($a1)	# load address of next field of current node
	sw	$t2, 16($t1)	# store that address in new node's next field 
	la	$t0, 4($t1)	# get address of current string
	sw	$t0, 12($a1)	# store that address into current node's next field
	la	$t2, ($a1)	#load address of current node's string
	sw	$t2, ($t1)	#store that address into the current node's previous field
	la	$a1, 4($t1) 	# reset current node to be the new node
	j	intro		#done adding new node, declare that adding is done & jump back to main
	

remove:	
	beqz	$s1, intro	# remove element node, if list is empty, go to menu

# initializing deletion head node
	lw	$t2, -4($a1)	# load address of previous node
	lw	$t2, 12($a1)	# load address of next node, if empty, this is a head node
    	sw	$zero, -4($t2)	# store zero to previous node
	la	$s1, ($t2)	#
	la	$a1, ($t2)
	lw	$t3, 12($a1)	#load address of next node
# intializing deletion tail node	
	lw	$t2, -4($a1)	# if no previous node, this is a tail node
	sw	$zero, 12($t2)	# store zero to the current tail node
	la	$a1, ($t2)	# load content of tail node into the arguement
	
	lw	$t3, 12($a1)	# load address of next node
	sw	$t2, -4($t1)	# store address of previous node in next node's previous field
	
	lw	$t2, 12($a1)	# load address of next node
	lw	$t3, -4($a1)	# load address of previous node 
	sw	$t2, 12($t1)	# store address of next node in previous node's next field
	la	$a1, ($t2)	# the new current node is the next node
	jr	$ra

# Traversing node forward and backward
next:	
	beqz	$s1, intro	# if the list is empty, just run the menu again
	lw	$t5, 12($a1)	# load the address of current node
	bnez	$t5, nextval	# if we're not at the end of the list, we can get next node
	j 	intro
	
previous:
	beqz	$s1, intro	# if list is empty, just run the menu again
	beq	$s1, $a1, intro # if we're already at head then there's nothing else to do
	la	$t5, -4($a1) 	# if we have things before the current node, we can get the previous node
	lw	$a1, ($t5)	#
	j 	intro		# when list is not empty and at the start of list, run the menu again

# intializing function call		
first:	
	la	$s1, 4($t1)	# set head pointer to point to string in the new node
	la	$a1, 4($t1)	# set current  pointer to point to string in the new node
	jal	Print		# execute print function
	j	intro
	
nextval:
	la	$t5, 12($a1) 	# load current content into the next node
	lw	$a1, ($t5)	# load next nodes into arguement register to be printed later
	j	intro		# when list is not empty and at the end of list, return the menu again	

allNodes:			# print all element written on array
	la 	$a0, array	# load the string prompt to print all element
	jal	Print		# execute print function
	la	$t1, ($s1)	# store content of the current nodes into a temporary register
	beqz	$t1, intro	# if temporary memory empty, return back to menu
	
# Named funtion call for printing	
printEle:
	move 	$a0, $t1	# move tempory memory of current nodes to an arguement register
	jal 	Print		# execute print for the cureent nodes
	la	$a0, spacing	# load address of spacing between each nodes
	jal	Print		# execute print for the spacing
	lw	$t2, 12($t1)	# load the most recent element added to another temporary register
	beqz	$t2, intro	# return to menu if current element is empty
	la	$t1, ($t2)	# load current node content into temporary memory
	j	printEle	# return loop to instruct printing process
	
Print:	
	li	$v0, 4		# syscall to print string
	syscall			# execute print function
	jr	$ra		# return to recent address
	
# access allocate space for linked list operation
alloSpace:
	li	$v0, 9 		# allocate space in the heap
	li	$a0, 20 	# allocates 12 bytes, 4 to point to previous, 12 for string and 4 for next
	syscall			# execute allocation of space 
	jr	$ra		# return to recent address

# exit program
exit:	
	li	$v0, 17		# syscall to exit program
	syscall			# execute exit program
