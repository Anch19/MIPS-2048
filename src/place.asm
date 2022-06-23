.text
	

	.globl place
	
# 	$a0 board address
# 	$a1 board length
#	$a2 field number to place into
#	$a3 number to place
#
#	$v0 == 0 iff place succesfull else 1
#

    addtile:
       sh  $a3, ($a0)
       li $v0 0
       jr $ra
    
place:
	li $v0 1
	b check
	
	
loop:
	addiu $a0 $a0 2
	addiu $a1 $a1 -1
	
check:
       bgtz $a2 loop
       lhu $s1 ($a0)
       beq $s1 0 addtile
       jr $ra
   
   
	
	 
