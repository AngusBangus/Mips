        .data


str:	.asciiz	"\n Please enter a number:\n"
str1:	.asciiz	"\n Positive sum: \n"
str2:	.asciiz	"\n Negative sum: \n"
        .text
 
 
main:
	addi	$t3, $t3, 1
	addi	$t7, $t7, 1

 

while:	
	beqz 	$t3, endwhile
	li	$v0, 4
	la	$a0,str
	syscall
	li	$v0, 5
	syscall
	move	$t3, $v0
	slt	$at,$t3,$0
	bnez 	$at,posAdd
	j	negAdd



posAdd:move	$t2,$t3
	add	$t4,$t4,$t2


	j	while
	
negAdd:move	$t1,$t3
	add	$t5,$t5,$t1

	j	while
endwhile:
	li	$v0, 4
	la	$a0,str1
	syscall
	li	$v0,1
	move	$a0,$t5
	syscall
	li	$v0, 4
	la	$a0,str2
	syscall
	li	$v0,1
	move	$a0,$t4
	syscall
	



	li $v0, 10
	syscall

