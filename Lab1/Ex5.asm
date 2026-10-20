.data
integer: .word 2 5 1 0 2 7 2
comma: .asciiz ", "

.text
main:
	la $s0, integer
	addi $t0, $0, 6
	sll $t0, $t0, 2
	add $t0, $s0, $t0
	
	li $v0, 1
	lw $a0, 0($t0)
	syscall
	addi $t0, $t0, -4
	li $v0, 4
	la $a0, comma
	syscall
	
	li $v0, 1
	lw $a0, 0($t0)
	syscall
	addi $t0, $t0, -4
	li $v0, 4
	la $a0, comma
	syscall
		
	li $v0, 1
	lw $a0, 0($t0)
	syscall
	addi $t0, $t0, -4
	li $v0, 4
	la $a0, comma
	syscall
	
	
	li $v0, 1
	lw $a0, 0($t0)
	syscall
	addi $t0, $t0, -4
	li $v0, 4
	la $a0, comma
	syscall
	
	li $v0, 1
	lw $a0, 0($t0)
	syscall
	addi $t0, $t0, -4
	li $v0, 4
	la $a0, comma
	syscall
	
	li $v0, 1
	lw $a0, 0($t0)
	syscall
	addi $t0, $t0, -4
	li $v0, 4
	la $a0, comma
	syscall
	
	li $v0, 1
	lw $a0, 0($t0)
	syscall
	addi $t0, $t0, -4
	
	li $v0, 10
	syscall
