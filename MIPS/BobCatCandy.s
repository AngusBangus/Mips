.data 
str0: .asciiz "Welcome to BobCat Candy, home to the famous BobCat Bars! \n"
str1: .asciiz "Please enter the price of a BobCat Bar: "
str2: .asciiz "Please enter the number of wrappers to bar ratio"
str3: .asciiz " Please enter total money "
running: .asciiz"Good! let me run the number...\n"
firstbuy: .asciiz"You first buy "
then: .asciiz "Then, you will get another "
bars: .asciiz " bars\n"
with: .asciiz "With $"
Maxbars: .asciiz ", you will receive a maximum of "
Bobcat: .asciiz " Bobcat Bars!"
newline: .asciiz "\n"
.text

main:
		#This is the main program.
		#It first asks user to enter the price of each BobCat Bar.
		#It then asks user to enter the number of bar wrappers needed to exchange for a new bar.  n= wrappera 
		#It then asks user to enter how much money he/she has.
		#It then calls maxBars function to perform calculation of the maximum BobCat Bars the user will receive based on the information entered. 
		#It then prints out a statement about the maximum BobCat Bars the user will receive.
		
		addi $sp, $sp -4	# Feel free to change the increment if you need for space.
		sw $ra, 0($sp)
	
		li $v0, 4
		la $a0, str0
		syscall 
		
		li $v0, 4
		la $a0, str1
		syscall 
		li $v0, 5
		syscall 
		add $a1, $zero, $v0 		#price
		
		li $v0, 4
		la $a0, str2
		syscall 
		li $v0, 5
		syscall 
		add $a2, $zero, $v0 		#bar ratio
		
		li $v0, 4
		la $a0, str3
		syscall 
		li $v0, 5
		syscall 
		add $a3, $zero, $v0 		#money
		


		jal maxBars 	# Call maxBars to calculate the maximum number of BobCat Bars

		li $v0, 4
		la $a0, with
		syscall
		addi    $a0, $a3, 0  # print my money
		li 	$v0, 1
		syscall
		li $v0, 4
		la $a0, Maxbars
		syscall
		
		addi	$a0, $s2, 0 #a0 now holds maxbars
		li 	$v0, 1
		syscall
		li $v0, 4
		la $a0, Bobcat
		syscall 
		

		j end			# Jump to end of program



maxBars:		#my actual candy being added
		# This function calculates the maximum number of BobCat Bars.
		# It takes in 3 arguments ($a0, $a1, $a2) as n, price, and money. It returns the maximum number of bars
		sw $ra, 0($sp) #saving main address
		div $s0, $a3, $a1 #intial bars, a3 money, a1 barprice
		li $v0, 4
		la $a0, running
		syscall 
		li $v0, 4
		la $a0, firstbuy
		syscall 
		addi	$a0, $s0, 0
		li 	$v0, 1
		syscall
		
		li $v0, 4
		la $a0, bars
		syscall
		jal newBars 	# Call a helper function to keep track of the number of bars.
		lw $ra, 0($sp)
		
		
		jr $ra
		# End of maxBars

newBars:   #how many wrappers after each division
		# This function calculates the number of BobCat Bars a user will receive based on n.
		# It takes in 2 arguments ($a0, $a1) as number of bars so far and n.
		
		div $s1, $s0, $a2 #amount of new bars now 8/2
		li $v0, 4
		la $a0, then
		syscall
		
		addi	$a0, $s1, 0
		li 	$v0, 1
		syscall
		
		li $v0, 4
		la $a0, bars
		syscall
		add $s2, $s1, $s0 
		
		bge $s1, $a2, else

		jr $ra
		# End of newBars
		
else: #do math recursion 
		div $s1, $s1, $a2 # if 4 bars then divide that by wrapper exhange
		add $s2, $s2, $s1 #add divided bars to max bars
	
		li $v0, 4
		la $a0, then
		syscall
	
		addi	$a0, $s1, 0

		li 	$v0, 1
		syscall
		li $v0, 4
		la $a0, bars
		syscall

		bge $s1, $a2, else
		jr $ra

end: 
		# Terminating the program
		lw $ra, 0($sp)
		addi $sp, $sp 4
		li $v0, 10 
		syscall
