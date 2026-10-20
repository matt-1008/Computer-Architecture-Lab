.data
str1: .asciiz "Hello, "
name: .space 100
str2: .asciiz "!"

.text
main:
	la $a0, name
	li $a1, 100
	li $v0, 8
	syscall

	li $v0, 4
	la $a0, str1
	syscall
	
	li $v0, 4
	la $a0, name
	syscall
	
	li, $v0, 4
	la $a0, str2
	syscall
	
	li $v0, 10
	syscall
