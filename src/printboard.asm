.data
slash:
.asciiz  "-----------------------------\n"


verticalslash:
.asciiz "|      |      |      |      |\n"


digit1:
.asciiz "|    "
.align 2

digit2:
.asciiz "|   "
.align 2

digit3:
.asciiz "|  "
.align 2

 digit4:
.asciiz "| "
 .align 2
 
 nextline:
 .asciiz "|\n"
.align 2

space:
.ascii " "
.align 2
	.globl printboard

#
#a0 Address of the first field of the board
#
#	-----------------------------
#	|      |      |      |      |
#	| 2048 |  128 |    8 | 1024 |
#	|      |      |      |      |
#	-----------------------------
#	|      |      |      |      |
#	| 1024 |   64 |    4 |    8 |
#	|      |      |      |      |
#	-----------------------------
#	|      |      |      |      |
#	|  512 |   32 |  512 |  128 |
#	|      |      |      |      |
#	-----------------------------
#	|      |      |      |      |
#	|  256 |   16 | 2048 | 1024 |
#	|      |      |      |      |
#	-----------------------------
#









.text

printboard:
li $s5 4

begin:
addiu $s5 $s5 -1
move $t5 $a0
 la $a0 slash
li $v0 4
syscall 
la $a0 verticalslash
li $v0 4 
syscall
move $a0 $t5
                 #storing in some other register because we are loading a0 with 32 , because we always need a0 for syscall
  
  
  
 li $t9 5 
 b print_numbers
 
loopstart:
addiu $a0 $a0 2


print_numbers:
addiu $t9 $t9 -1
beqz $t9 last_slash
lh $t0, ($a0)
bgt $t0 999 digitnumber_4
bgt $t0 99 digitnumber_3
bgt $t0 9 digitnumber_2
bge  $t0  0 digitnumber_1
b loopstart
 
 last_slash:
 b endof_row




digitnumber_4:
move $t4, $a0
la $a0, digit4
li $v0 4
syscall
move $a0 $t0
 li $v0 1
 syscall
 
 move $t0 $a0
move $a0 $t4
b addspace

digitnumber_3:
move $t3, $a0
la $a0, digit3
li $v0 4
syscall
move $a0 $t0
li $v0 1
syscall
move $t0 $a0
move $a0 $t3
b addspace

digitnumber_2:
move $t2, $a0
la $a0, digit2
li $v0 4
syscall
move $a0  $t0
li $v0 1
syscall
move $t0 $a0
move $a0 $t2
b addspace

digitnumber_1:
move $t7, $a0
la $a0, digit1
li $v0 4
syscall 
move $a0 $t0
li $v0 1
syscall
move $t0 $a0
move $a0 $t7
b addspace
 
 endpart:
move $t6, $a0
 la $a0 verticalslash
  li $v0 4
  syscall 
  move $a0, $t6
  beqz $s5 breakloop  # mera same
  b begin
  
  breakloop:
  move $s7 $a0 
  la $a0 slash
  li $v0 4
  syscall
  move $a0 $s7
  jr $ra
  
 addspace:  #empty 11
 move $a3 $a0
 la $a0 space
 li $v0 4
 syscall
 move $a0 $a3
 b print_numbers
 
 endof_row:    #empty 12
 move $t2 $a0
la $a0 nextline
li $v0 4
syscall 
move $a0 $t2
b endpart
