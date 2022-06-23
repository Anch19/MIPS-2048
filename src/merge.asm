.text
	.globl merge

#
#	$a0 buffer address
#	$a1 buffer length
#
#	|----|----|----|----|		|----|----|----|----|
#	|  2 |  2 |  0 |  4 |  => 	|  4 |  0 |  0 |  4 |
#	|----|----|----|----|		|----|----|----|----|
#
#   BONUS: Return the number of merges in $v0 and the
#          total base score of the merges in $v1. 


merge:
lw $s0 ($a0)
lh $s1 ($s0)
addiu $v0 $v0 0
bgtz $s1 nextsametile
beqz $s1 nextnonzero


nextsametile:
addiu $a0 $a0 4
addiu $a1 $a1 -1
beqz $a1 finish
lw $t0 ($a0)    #t3 bridge t2 element
lh $t1 ($t0)
beqz $t1 nextnonzero
beq $t1 $s1 mergetiles
bne  $t1 $s1  nicht_gleich

nicht_gleich:
move $s1 $t1
lw $s0 ($a0)
sh $s1 ($s0)
li $t1 0
b nextsametile


nextnonzero:
addiu $a0 $a0 4
addiu $a1 $a1 -1
beqz $a1 finish
lw $s0 ($a0)
lh $s1 ($s0)
beqz $s1 nextnonzero
bgtz $s1 nextsametile

mergetiles:  #s1 the first tile t1 the vqlue of 2nd tile
addiu $a0 $a0 -4
addiu $a1 $a1 1
addu $t1 $t1 $s1 
lw $t0 ($a0)
sh $t1 ($t0)
addiu $v0 $v0 1
addiu $a0 $a0 4
addiu $a1 $a1 -1
li $s1 0
lw $s0 ($a0)
sh $s1 ($s0)
beqz $a1 finish
b nextsametile

finish:
    jr $ra


