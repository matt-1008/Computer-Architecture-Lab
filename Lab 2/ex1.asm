.data
integer: .space 20
comma: .asciiz ", "

.text
main:
	la $s0, integer
	addi $s1, $s0, 20
	add $t0, $s0, $0
	input:
		slt $t1, $t0, $s1
		beq $t1, $0, print
		li $v0, 5
		syscall
		add $t1, $v0, $0
		
		addi $t1, $t1, 1
		li $t2, -4
		and $t1, $t1, $t2
		
		sw $t1, 0($t0)
		addi $t0, $t0, 4
		j input
	print:
		add $t0, $s0, $0
	loop:	lw $a0, 0($t0)
		li $v0, 1
		syscall
		
		addi $t0, $t0, 4
		slt $t1, $t0, $s1
		beq $t1, $0, exit
		la $a0, comma
		li $v0, 4
		syscall
		j loop
	exit:	li $v0, 10
		syscall