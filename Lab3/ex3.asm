.data
header: .asciiz "-Student personal information-"
name: .asciiz "\nName: "
id: .asciiz "\nID: "
addr: .asciiz "\nAddress: "
age: .asciiz "\nAge: "
rel: .asciiz "\nReligion: "
newline: .asciiz "\n"
fin: .asciiz "E:/AnhPham/MARS/Lab3/raw_input.txt"
fout: .asciiz "E:/AnhPham/MARS/Lab3/formatted_result.txt"

.text
.globl main

main:
    # allocate: input -> s0, output -> s1
    li $v0, 9
    li $a0, 256
    syscall
    move $s0, $v0
    
    li $v0, 9
    li $a0, 512
    syscall
    move $s1, $v0

    # open file -> s6
    li $v0, 13
    la $a0, fin
    li $a1, 0
    li $a2, 0
    syscall
    move $s6, $v0
    
    # read file
    li $v0, 14
    move $a0, $s6
    move $a1, $s0
    li $a2, 256
    syscall
    move $s7, $v0
    
    # close file
    li $v0, 16
    move $a0, $s6
    syscall
    
    # process
    move $t0, $s0
    move $t1, $s1
    li $t2, 0 # count var
    
    la $a0, header
    jal copy_to_buffer
    la $a0, name
    jal copy_to_buffer
    
    loop:
    	lb $t3, 0($t0)
    	beqz $t3, end_loop
    	beq $t3, 44, comma
    	sb $t3, 0($t1)
    	addi $t0, $t0, 1
    	addi $t1, $t1, 1
    	j loop
    comma:
    	addi $t0, $t0, 1
    	addi $t2, $t2, 1
    insert_prefix:
    	beq $t2, 1, insert_id
    	beq $t2, 2, insert_addr
    	beq $t2, 3, insert_age
    	beq $t2, 4, insert_rel
    	j loop	
    end_loop:
    	sb $0, 0($t1)
    	sub $s2, $t1, $s1
    
    print:	
    	li $v0, 4
        move $a0, $s1
        syscall
    copy_to_fout:
    li $v0, 13
    la $a0, fout
    li $a1, 1
    li $a2, 0
    syscall
    move $s6, $v0

    li $v0, 15
    move $a0, $s6
    move $a1, $s1
    move $a2, $s2
    syscall

    li $v0, 16
    move $a0, $s6
    syscall
exit:
    li $v0, 10
    syscall

insert_id:
    la $a0, id
    jal copy_to_buffer
    j loop
insert_addr:
    la $a0, addr
	jal copy_to_buffer
    j loop
insert_age:
    la $a0, age
    jal copy_to_buffer
    j loop
insert_rel:
    la $a0, rel
    jal copy_to_buffer
    j loop
    
copy_to_buffer:
    move $t8, $a0
copy_loop:
    lb $t9, 0($t8)
    beqz $t9, copy_end
    sb $t9, 0($t1)
    addi $t8, $t8, 1
    addi $t1, $t1, 1
    j copy_loop
copy_end:
    jr $ra