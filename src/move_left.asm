.text
	.globl move_left
	
#
#	$a0 buffer address
#	$a1 buffer length
#
#	|----|----|----|----|		|----|----|----|----|	
#	|  0 |  2 |  0 |  4 |	=> 	|  2 |  4 |  0 |  0 |
#	|----|----|----|----|		|----|----|----|----|	
#
	

	
move_left:
lw $s0 ($a0)
lh $s1 ($s0)
beqz $s1 nextnonzero
bnez $s1 nexttile

nexttile:         #if the first loaded tile was nnon zero
addiu $a0 $a0 4
addiu $a1 $a1 -1
    beqz $a1 end
lw $s0 ($a0)
lh $t2 ($s0)
beqz $t2 nextnonzero
bnez $t2 nexttile


nextnonzero:
        addiu $a0 $a0 4
        addiu $a1 $a1 -1
    beqz $a1 end
        lw $t0 ($a0)
        lh $t1 ($t0)
        bnez $t1 leanleft
        beqz $t1 nextnonzero

leanleft:
addiu $a0 $a0 -4


sw $s0 ($a0)
sh $t1 ($s0)
sw $t0 0($a0)
sh $s1 ($t0)
#addiu $a0 $a0 4
b nextnonzero
 
end:
li $v0 10
    jr $ra
