.data
str1:	.asciiz "Enter integer: \n"

.text
main:		
		# TPS 2 #3 (display statement)
	addi	$sp, $sp, -4
	
	la $a0, str1	
	li $v0, 4
	syscall
	li $v0, 5	
	syscall
	move $a0, $v0
			# TPS 2 #4 (read user input)
	jal recursion
			# TPS 2 #6 (read user input)
	sw	$v0, 0($sp)	
	lw	$a0, 0($sp)
	li 	$v0, 1
	syscall
	j end
	

recursion:
		addi	$sp, $sp, -12
		sw	$ra, 0($sp)
				# TPS 2 #7 
		seq 	$t0, $a0, 10		
		beq	$t0, $0, not_ten
				# TPS 2 #8 (update returned value)
		li 	$v0, 2
		j end_recur
		
not_ten:
			# TPS 2 #9 (update returned value)
		seq	$t0, $a0, 11		
		beq	$t0, $0, not_eleven
		
		li	$v0, 1
		j end_recur
		
not_eleven:
		# TPS 2 #11 (Prepare new input argument, i.e. m - 2)
		sw	$a0, 4($sp)	
		addi	$a0, $a0, 2
		
		jal recursion
				# TPS 2 #12 
		sw	$v0, 8($sp)	
		
			# TPS 2 #13 (Prepare new input argument, i.e. m - 1)
		lw	$a0, 4($sp)
		addi	$a0, $a0, 1
		
		jal recursion
				# TPS 2 #14 (update returned value)
		lw	$t0, 8($sp)	
		lw	$t1, 4($sp)	
		add	$v0, $v0, $t0	
		add	$v0, $v0, $t1
		lw	$a0, 4($sp)
		j end_recur
# End of recursion function			
end_recur:
		lw	$ra, 0($sp)
		addi	$sp, $sp, 12
		jr $ra
# Terminating the program	
end:		
		addi $sp, $sp 4	
		li $v0, 10 
		syscall
