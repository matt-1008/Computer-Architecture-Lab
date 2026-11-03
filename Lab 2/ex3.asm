.data
prompt1: .asciiz "Second largest value is "
prompt2: .asciiz ", found in index "
comma: .asciiz ", "
dot: .asciiz "."
integer: .space 40

.text
main:
	# integer -> $s0
	la $s0, integer
	add $t0, $0, $0
	input:
		slti $t1, $t0, 10
		beq $t1, $0, end_input
		li $v0, 5
		syscall
		sll $t2, $t0, 2
		add $t2, $s0, $t2
		sw $v0, 0($t2)
		addi $t0, $t0, 1
		j input
	end_input:
		add $t0, $0, $0
		lw $s1, 0($s0)
		lw $s2, 0($s0)
		
	# 1st & 2nd largest -> $s1, $s2
	findNum:
		slti $t1, $t0, 10
		beq $t1, $0, print1

		sll $t1, $t0, 2
		add $t1, $s0, $t1
		lw $t1, 0($t1)
		
		slt $t2, $s1, $t1
		beq $t2, $0, checkSecondsltNum
		add $s2, $s1, 0
		add $s1, $t1, 0
		j continue_findNum
	checkSecondsltNum:
		beq $t1, $s1, continue_findNum
		beq $s1, $s2, update_s2
		slt $t2, $s2, $t1
		beq $t2, $0, continue_findNum
	update_s2: add $s2, $t1, $0
	continue_findNum:
		addi $t0, $t0, 1
		j findNum
	print1:
		beq $s1, $s2, exit
		la $a0, prompt1
		li $v0, 4
		syscall
		add $a0, $s2, $0
		li $v0, 1
		syscall
		la $a0, prompt2
		li $v0, 4
		syscall
	
	# flag -> $s3
	add $s3, $0, $0
	add $t0, $0, $0
	findIndex:
		slti $t1, $t0, 10
		beq $t1, $0, exit
		sll $t1, $t0, 2
		add $t1, $s0, $t1
		lw $t1, 0($t1)
		
		bne $t1, $s2, continue_findIndex
			beq $s3, $0, printIndex
			la $a0, comma
			li $v0, 4
			syscall
	    printIndex: add $a0, $t0, $0
			li $v0, 1
			syscall
			addi $s3, $0, 1
	continue_findIndex:
		addi $t0, $t0, 1
		j findIndex

	exit:
	la $a0, dot
	li $v0, 4
	syscall
	li $v0, 10
	syscall
