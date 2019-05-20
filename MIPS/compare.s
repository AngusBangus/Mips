.data

n:	.word 25
str1: 	.asciiz	"\n Less than \n"
str2:	.asciiz	"\n Less than or equal to\n"
str3:	.asciiz	"\n Greater than\n"
str4:	.asciiz	"\n Greater than or equal to\n"
.text

main:

li		$v0, 5
syscall
move		$t0, $v0
la      	$t3, n
lw      	$t3, 0($t3)

slt		$s1, $t0, $t3
#slt		$s1, $t3, $t0
bne		$s1, $0,LP
beq		$s1, $0,GEP

#bne		$s1, $0,GP
#beq		$s1, $0,LEP


LP:		li	$v0, 4
		la	$a0, str1
		syscall
		j	Finish


LEP:		li	$v0, 4
		la	$a0, str2
		syscall
		j	Finish
		
GP:		li	$v0, 4
		la	$a0, str3
		syscall
		j	Finish
		
GEP:		li	$v0, 4
		la	$a0, str4
		syscall
		j	Finish
	
Finish:		li	$v0, 10
		syscall
