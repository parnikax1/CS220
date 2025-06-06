.data
string1: .asciiz "Enter a number: "
string2: .asciiz "nth Fib is: "

.text
fib:
 addi $sp,$sp , -16
 sw $ra , 4($sp)
 sw $a0 , 0($sp)
 sw $zero , 8($sp)
 sw $zero , 12($sp)
 beq $a0 , $zero, L0
 addi $t5, $zero, 1
 beq $a0, $t5 , L0
 addi $a0, $a0 , -1
 jal fib
 sw $v0 , 8($sp)
 lw $a0 , 0($sp)
 addi $a0, $a0, -2
 jal fib
 sw $v0 ,12($sp)
 lw $t0 , 8($sp)
 lw $t1 , 12($sp)
 lw $a0 , 0($sp)
 lw $ra , 4($sp)
 addi $sp, $sp,16
 add $v0, $t0,$t1
 jr $ra
 L0:
 addi $v0, $zero, 1
 addi $sp,$sp,16
 jr $ra
main:
 li $v0,4
 la $a0,string1
 syscall

 li $v0,5
 syscall
 move $a0,$v0
 jal fib
 move $t4,$v0
 li $v0,4
 la $a0,string2
 syscall
 li $v0, 1, #print out message
 move $a0, $t4
 syscall
 li $v0, 10 #end program
 syscall
