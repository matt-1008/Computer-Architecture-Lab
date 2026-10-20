.data
inserta: .asciiz "Insert a: "
insertb: .asciiz "Insert b: "
insertc: .asciiz "Insert c: "
insertd: .asciiz "Insert d: "
outputF: .asciiz "F = "
outputR: .asciiz ", remainder "

.text
main:
	li $v0, 4
	la $a0, inserta
	syscall
	li $v0, 5
	syscall
	add $s0, $v0, $0
	
	li $v0, 4
	la $a0, insertb
	syscall
	li $v0, 5
	syscall
	add $s1, $v0, $0
	
	li $v0, 4
	la $a0, insertc
	syscall
	li $v0, 5
	syscall
	add $s2, $v0, $0
	
	li $v0, 4
	la $a0, insertd
	syscall
	li $v0, 5
	syscall
	add $s3, $v0, $0

	addi $t0, $s0, 10
	sub $t1, $s1, $s3
	sll $t2, $s0, 1
	sub $t2, $s2, $t2
	mul $t0, $t0, $t1
	mul $t0, $t0, $t2
	
	add $t1, $s0, $s1
	add $t1, $t1, $s2
	
	div $t0, $t1
	mflo $t0
	mfhi $t1
	
	li $v0, 4
	la $a0, outputF
	syscall
	li $v0, 1
	add $a0, $t0, $0
	syscall
	
	li $v0, 4
	la $a0, outputR
	syscall
	li $v0, 1
	add $a0, $t1, $0
	syscall

	li $v0, 10
	syscall