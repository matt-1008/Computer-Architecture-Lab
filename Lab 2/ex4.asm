.data
error: .asciiz "A factorial for your number can not be found."

.text
main:
	input:
		li $v0, 5
		syscall
		add $a0, $v0, $0
		slt $t0, $a0, $0
		bne $t0, $0, print_error
		jal fact
		j print
	print_error:
		la $a0, error
		li $v0, 4
		syscall
		j exit
	print:
		add $a0, $v0, $0
		li $v0, 1
		syscall
	exit:
		li $v0, 10
		syscall
		
fact:
	addi $sp, $sp, -8
	sw $ra, 4($sp)
	sw $a0, 0($sp)

	slti $t0, $a0, 1
	beq $t0, $zero, call_fact
	addi $v0, $0, 1
	addi $sp, $sp, 8
	jr $ra
	
call_fact:
	addi $a0, $a0, -1
	jal fact

	lw $a0, 0($sp)
	lw $ra, 4($sp)
	addi $sp, $sp, 8
	mul $v0, $a0, $v0
	jr $ra
	