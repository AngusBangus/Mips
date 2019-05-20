.data
str1:	.asciiz "Enter integer: \n"

.text
main:		
	addi	$sp, $sp, -4
	
	la $a0, str1	#asks for user input
	li $v0, 4
	syscall
	li $v0, 5	# Reads user input
	syscall
	move $a0, $v0
	
	jal recursion
	
	sw	$v0, 0($sp)	# Prints final value
	lw	$a0, 0($sp)
	li 	$v0, 1
	syscall
	j end
	

recursion:
		addi	$sp, $sp, -12
		sw	$ra, 0($sp)
		
		seq 	$t0, $a0, 10		# If not equal to 10 then branch
		beq	$t0, $0, not_ten
		
		li 	$v0, 2
		j end_recur
		
not_ten:
		seq	$t0, $a0, 11		# If not equal to 11 then branch
		beq	$t0, $0, not_eleven
		
		li	$v0, 1
		j end_recur
		
not_eleven:
		sw	$a0, 4($sp)	# Does recursion for m+2
		addi	$a0, $a0, 2
		
		jal recursion
		
		sw	$v0, 8($sp)	# Saves first recursion value
		
		# Does recursion for m+1
		lw	$a0, 4($sp)
		addi	$a0, $a0, 1
		
		jal recursion
		
		lw	$t0, 8($sp)	# Restores first recursion
		lw	$t1, 4($sp)	# Restores original m for addition
		add	$v0, $v0, $t0	# Adds all values
		add	$v0, $v0, $t1
		lw	$a0, 4($sp)
		j end_recur
		
end_recur:
		lw	$ra, 0($sp)
		addi	$sp, $sp, 12
		jr $ra
		
end:		
		addi $sp, $sp 4	# Moving stack pointer back (pop the stack frame)
		li $v0, 10 
		syscall