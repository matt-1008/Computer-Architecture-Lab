.data
prompt: .asciiz "Please enter a positive integer less than 16: "
output: .asciiz "Its binary form is: "
.text
main:
	li $v0, 4
	la $a0, prompt
	syscall
	li $v0, 5
	syscall
	add $s0, $v0, $0
	
	addi $s1, $0, 2
	
	li $v0, 4
	la $a0, output
	syscall
	
	div $s0, $s1
	mflo $t0
	mfhi $t1
	
	div $t0, $s1
	mflo $t0
	mfhi $t2
	
	div $t0, $s1
	mflo $t0
	mfhi $t3
	
	div $t0, $s1
	mflo $t0
	mfhi $t4
	
	li $v0, 1
	add $a0, $t4, $0
	syscall
	
	li $v0, 1
	add $a0, $t3, $0
	syscall
	
	li $v0, 1
	add $a0, $t2, $0
	syscall
	
	li $v0, 1
	add $a0, $t1, $0
	syscall
	
	li $v0, 10
	syscall
