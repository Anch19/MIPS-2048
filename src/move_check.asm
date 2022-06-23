.text
	.globl move_check
#
#	$a0 buffer address
#	$a1 buffer length
#
#   $v0 == 1 iff left move possible and would change something
#            else 0
#

move_check:
lw $s0 ($a0)
lh $s1 ($t0)
beqz $s1 lookfornextnonzero     #we now look for the next nonzero tile
bnez $s1 lookfornextsame        #we now searchfor next same


lookfornextnonzero:
addiu $a0 $a0 4
addiu $a1 $a1 -1
beqz $a1 move_notpossible
lw $t0 ($a0)
lh $t1 ($t0)
beqz $t1 lookfornextnonzero
bnez $t1 move_possible

lookfornextsame:
addiu $a0 $a0 4
addiu $a1 $a1 -1
beqz $a1 move_notpossible
lw $t0 ($a0)
lh $t2 ($t0)
beq $s1 $t2 move_possible
beqz $t2 lookfornextnonzero
bnez $t2 lookfornextsame

move_possible:
li $v0 1
jr $ra

move_notpossible:
li $v0 0
jr $ra








	
