.data
.text
.globl main

main:
    li $v0, 5
    syscall
    move $s0, $v0

    move $a0, $v0
    jal fib
    move $a0, $v0

    li $v0, 1
    syscall

    li $v0, 10
    syscall

fib:
    bgt $a0, 1, recurse
    move $v0, $a0
    jr $ra

recurse:
    # Save $ra and the argument $a0
    addi $sp, $sp, -12
    sw $ra, 0($sp)
    sw $a0, 4($sp)

    # Implement fib(n-1) call, the result is put into the stack
    addi $a0, $a0, -1
    jal fib
    sw $v0, 8($sp)
   
    # Retrieve n, and then call fib(n-2)
    lw $a0, 4($sp)
    addi $a0, $a0, -2
    jal fib

    # The results are summed and put in $v0
    lw $v1, 8($sp)
    add $v0, $v0, $v1

    # Retrieve return address and restore the stack pointer
    lw $ra, 0($sp)
    addi $sp, $sp, 12
    jr $ra
