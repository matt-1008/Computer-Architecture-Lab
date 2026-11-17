.data
    prompta: .asciiz "Please insert a: "
    promptb: .asciiz "Please insert b: "
    promptc: .asciiz "Please insert c: "
    promptnosol: .asciiz "There is no real solution\n"
    promptx: .asciiz "There is one solution, x = "
    promptx1: .asciiz "x1 = "
    promptx2: .asciiz "x2 = "
    promptand: .asciiz " and "
    promptinfinite: .asciiz "Infinite solutions\n"

    zero: .float 0.0
    two:  .float 2.0
    four: .float 4.0

.text
.globl main

main:
    # const: f4, f5, f6
    lwc1 $f4, zero
    lwc1 $f5, two
    lwc1 $f6, four
    
    # input: f20, f21, f22
    la $a0, prompta
    li $v0, 4
    syscall
    li $v0, 6
    syscall
    mov.s $f20, $f0
    
    la $a0, promptb
    li $v0, 4
    syscall
    li $v0, 6
    syscall
    mov.s $f21, $f0
    
    la $a0, promptc
    li $v0, 4
    syscall
    li $v0, 6
    syscall
    mov.s $f22, $f0
    
    # partition
    c.eq.s $f20, $f4
    bc1t linear_sol
    
    # delta: f7
    mul.s $f7, $f21, $f21
    mul.s $f8, $f20, $f6
    mul.s $f8, $f8, $f22
    sub.s $f7, $f7, $f8
    
    c.lt.s $f7, $f4
    bc1t no_sol
    c.eq.s $f7, $f4
    bc1t one_sol
    j two_sol

linear_sol:
    c.eq.s $f21, $f4
    bc1f calc_linear
    c.eq.s $f22, $f4
    bc1f no_sol
    
    la $a0, promptinfinite
    li $v0, 4
    syscall
    j exit

calc_linear:
    sub.s $f8, $f4, $f22
    div.s $f12, $f8, $f21
    
    la $a0, promptx
    li $v0, 4
    syscall
    li $v0, 2
    syscall
    j exit

no_sol:
    la $a0, promptnosol
    li $v0, 4
    syscall
    j exit
    
one_sol:
    sub.s $f8, $f4, $f21  
    mul.s $f9, $f20, $f5
    div.s $f12, $f8, $f9
    
    la $a0, promptx
    li $v0, 4
    syscall
    li $v0, 2
    syscall
    j exit
    
two_sol:
    sqrt.s $f10, $f7        
    mul.s $f9, $f20, $f5    
    sub.s $f8, $f4, $f21    
    
    add.s $f13, $f8, $f10
    div.s $f23, $f13, $f9
    sub.s $f14, $f8, $f10
    div.s $f24, $f14, $f9
    
    la $a0, promptx1
    li $v0, 4
    syscall
    mov.s $f12, $f23
    li $v0, 2
    syscall
    la $a0, promptand
    li $v0, 4
    syscall
  
    la $a0, promptx2
    li $v0, 4
    syscall
    
    mov.s $f12, $f24
    li $v0, 2
    syscall
    
    j exit

exit:
    li $v0, 10
    syscall
