.text
	.globl complete_move
	

#
#	$a0 buffer address
#	$a1 buffer length
#
#	|----|----|----|----|		|----|----|----|----|
#	|  2 |  2 |  0 |  4 |  => 	|  4 |  4 |  0 |  0 |
#	|----|----|----|----|		|----|----|----|----|
#
#   BONUS: Return the number of merges in $v0 and the
#          total base score of the merges in $v1. 


complete_move:
addiu $sp $sp -12  #we store our values to the stack
sw $a0 0($sp)
sw $ra 4($sp)
sw $a1 8($sp)

merge_and_move:
jal move_left  #now our funtion will jump to move_left funtion
lw $a0 0($sp)  
lw $ra 4($sp)      # after coming back from move_left it will load the stored values in stack
lw $a1 8($sp)
addiu $sp $sp 12
addiu $sp $sp -12   #again it will store the values to the stack
sw $a0 0($sp)
sw $ra 4($sp)
sw $a1 8($sp)
jal merge          # our funtion now jumps to the merge funtion
lw $a0 0($sp)        # after returning from the merge it will load the stored values
lw $ra 4($sp)
lw $a1 8($sp)
addiu $sp $sp 12
addiu $sp $sp -12       # after the merge has happened it will again store the value before jumping again to the move_left funtion
sw $a0 0($sp)
sw $ra 4($sp)
sw $a1 8($sp)
jal move_left
lw $a0 0($sp)        
lw $ra 4($sp)
lw $a1 8($sp)
addiu $sp $sp 12
jr $ra


    
