.data
prompta: .asciiz "a = "
promptb: .asciiz "b = "
printGCD: .asciiz "GCD = "
printLCM: .asciiz ", LCM = "
promptError: .asciiz "In valid input!"

.text
main:
	input:	# a-> $s0, b ->$s1
		la $a0, prompta
		li $v0, 4
		syscall
		li $v0, 5
		syscall
		add $s0, $v0, $0
		slt $t0, $0, $s0
		beq $t0, $0, error
		
		la $a0, promptb
		li $v0, 4
		syscall
		li $v0, 5
		syscall
		add $s1, $v0, $0
		slt $t0, $0, $s1
		beq $t0, $0, error
	gcd:	# gcd -> $s3
		add $s3, $s0, $0
		add $t0, $s1, $0
		loop:
			beq $t0, $0, lcm
			div $s3, $t0
			mfhi $t2
			add $s3, $t0, $0
			add $t0, $t2, $0
			j loop
	lcm:	# lcm -> $s4
		div $s0, $s3
		mflo $t0
		mul $s4, $t0, $s1
	print:	la $a0, printGCD
		li $v0, 4
		syscall
		add $a0, $s3, $0
		li $v0, 1
		syscall
		
		la $a0, printLCM
		li $v0, 4
		syscall
		add $a0, $s4, $0
		li $v0, 1
		syscall
		j exit
	error:	la $a0, promptError
		li $v0, 4
		syscall
	exit:	li $v0, 10
		syscall
