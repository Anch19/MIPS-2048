.text 
	.globl move_one
	
#
#	$a0 buffer address
#	$a1 buffer length
#
#	|----|----|----|----|----|		|----|----|----|----|----|	
#	|  2 |  0 |  2 |  0 |  4 |	=> 	|  2 |  2 |  0 |  4 |  0 |
#	|----|----|----|----|----|		|----|----|----|----|----|
#
#	$v0 1 iff something changed else 0

move_one:
       
       lw $s0 ($a0)
        lh $s1 ($s0)
        beqz $a1 exit   #s0 is the bridge
	beqz $s1 looknextnonzerotile  #s1 is the first tile
	bnez $s1  loadnexttile
	
	loadnexttile:  #when the first tile was non zero 
	addiu $a0 $a0 4
	addiu $a1 $a1 -1
	beqz $a1 exit
	lw $s0 ($a0)
	sh  $s1 ($s0)
	beqz $s1 looknextnonzerotile
	bnez $s1 loadnexttile

	
looknextnonzerotile:            # because 1st tile was zero
	
	addiu $a0 $a0 4
	addiu $a1 $a1 -1
	 beqz $a1 exit
	lw $t4 ($a0)  #s2 is the next tile
	lh $s2 ($t4)
        bnez $s2 movetoleft
       beqz $s2  looknextnonzerotile
    

	
movetoleft:
	addiu $a0 $a0 -4
	addiu $a1 $a1 1
	lw $t4 ($a0)
	sh $s2 ($t4)
	addiu $a0 $a0 4
	addiu $a1 $a1 -1
	lw $s0 ($a0)
	sh $s1 ($s0)
	 beqz $a1 madeamove
        

       zerotileaftermove:
       addiu $a0 $a0 4
       addiu $a1 $a1 -1
       beqz $a1 madeamove
          lw $t4 ($a0)
          lh  $s2 ($t4)
       bnez   $s2 movetoleft
       beqz  $s2 nonzeroaftermove
       
       nonzeroaftermove:
       addiu $a0 $a0 4
       addiu $a1 $a1 -1
       beqz $a1 madeamove
       move $s1   $s2
        lw $t4 ($a0)
          lh  $s2 ($t4)
          beqz $s2 nonzeroaftermove
          bnez $s2 movetoleft
exit:
	li $v0 0
	jr $ra
	
	madeamove:
	li $v0 1
	jr $ra
	

