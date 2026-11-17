.data
    prompt_u: .asciiz "Please insert u: "
    prompt_v: .asciiz "Please insert v: "
    prompt_a: .asciiz "Please insert a: "
    prompt_b: .asciiz "Please insert b: "
    prompt_c: .asciiz "Please insert c: "
    prompt_d: .asciiz "Please insert d: "
    prompt_e: .asciiz "Please insert e: "

    const_7: .float 7.0
    const_6: .float 6.0
    const_2: .float 2.0

.text
.globl main

main:
    # input f20 -> f26
    la $a0, prompt_u
    li $v0, 4
    syscall
    li $v0, 6
    syscall
    mov.s $f20, $f0

    la $a0, prompt_v
    li $v0, 4
    syscall
    li $v0, 6
    syscall
    mov.s $f21, $f0

    la $a0, prompt_a
    li $v0, 4
    syscall
    li $v0, 6
    syscall
    mov.s $f22, $f0

    la $a0, prompt_b
    li $v0, 4
    syscall
    li $v0, 6
    syscall
    mov.s $f23, $f0

    la $a0, prompt_c
    li $v0, 4
    syscall
    li $v0, 6
    syscall
    mov.s $f24, $f0

    la $a0, prompt_d
    li $v0, 4
    syscall
    li $v0, 6
    syscall
    mov.s $f25, $f0

    la $a0, prompt_e
    li $v0, 4
    syscall
    li $v0, 6
    syscall
    mov.s $f26, $f0
    
    # const

    lwc1 $f4, const_7
    lwc1 $f5, const_6
    lwc1 $f6, const_2

    # coeff
    div.s $f27, $f22, $f4
    div.s $f28, $f23, $f5
    div.s $f29, $f24, $f6

    # d^4 + e^3 -> f30
    mul.s $f7, $f25, $f25
    mul.s $f7, $f7, $f7
    mul.s $f8, $f26, $f26
    mul.s $f8, $f8, $f26
    add.s $f30, $f7, $f8

    # F(u)
    mul.s $f7, $f20, $f20
    mul.s $f8, $f7, $f20
    mul.s $f9, $f8, $f8
    mul.s $f10, $f9, $f20

    mul.s $f16, $f27, $f10
    mul.s $f17, $f28, $f9
    mul.s $f18, $f29, $f7

    add.s $f19, $f16, $f17
    add.s $f31, $f19, $f18

    # F(v)
    mul.s $f7, $f21, $f21
    mul.s $f8, $f7, $f21
    mul.s $f9, $f8, $f8
    mul.s $f10, $f9, $f21

    mul.s $f16, $f27, $f10
    mul.s $f17, $f28, $f9
    mul.s $f18, $f29, $f7

    add.s $f19, $f16, $f17
    add.s $f11, $f19, $f18

    # result
    sub.s $f12, $f31, $f11
    div.s $f12, $f12, $f30
    li $v0, 2
    syscall
exit:
    li $v0, 10
    syscall
