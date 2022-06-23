.text
	.globl check_victory


#
#	$a0 board address
#	$a1 board length
#
#	$v0 == 1 iff 2048 found
#

check_victory:
    li $v0 0
    
     loop:
     lh $t4 0($a0)
     beq $t4 2048 result
     beq $a1 0 lost
     addiu $a0 $a0 2
     addiu $a1 $a1 -1
     b loop
      result:
      li $v0 1 
      jr $ra
      
      lost:
	jr $ra
