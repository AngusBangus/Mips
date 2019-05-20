	.data
x:		.word 5
y:		.word 10

	.text
Main:	la $t0, x
	lw $s0, 0($t0)	# x = $s0
	la $t0, y
	lw $s1, 0($t0)	# y = $s1
	
	add $a0, $zero, $s0	# stores x into a0 to pass to SUM
	add $a1, $zero, $s1	# stores y into a1, to pass to SUM
	jal SUM			# Sum should be 15
	add $t0, $s1, $s0
	add $s1, $v1, $t0	# v1 is the sum return value
	add $a0, $s1, $zero
	li $v0, 1
	syscall
	li $v0, 10
	syscall
	
	
	
SUM:	addi $sp, $sp, -16
	sw $ra, 0($sp)
	sw $a0, 4($sp)	
	sw $a1, 8($sp)
	sw $s0, 12($sp)
	sw $s1, 16($sp)
	
	addi $a0, $a1, 1	# Begin calc for p, a0=11
	addi $a1, $s0, 1	# Use s0 since value of a0 changed in previous line, a1=6
	jal SUB
	add $s0, $v0, $zero	# Stores difference of b - a into $s0/p
	
	lw $a0, 4($sp)		# Restores values of m and n to create q
	lw $a1, 8($sp)
	addi $a0, $a0, -1	# a0=4
	addi $a1, $a1, -1	# a1=9
	jal SUB
	add $s1, $v0, $zero
	add $v1, $s0, $s1	#sum is -5 + 5 =0
	
	lw $ra, 0($sp)		#epilogue
	lw $a0, 4($sp)	
	lw $a1, 8($sp)
	lw $s0, 12($sp)
	lw $s1, 16($sp)
	addi $sp, $sp, 16
	jr $ra
		
SUB:
	sub $v0, $a1, $a0 #First call: 6-11, second call: 9-4
	jr $ra
	