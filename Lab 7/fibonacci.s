.data
prompt:  .ascii "Enter a non-negative integer: "

main:
 	la $a0, prompt
 	li $v0, 4
 	syscall

 	li $v0, 5
 	syscall

 	move $a0, $v0

 	jal vfib
	
 	add  $a0, $v0, $zero  #display
 	li $v0, 1
 	syscall

 	li $v0, 10   #Exit
 	syscall


vfib: 
 #Test Values
 	addi $t0, $zero, 1  #Set $t0 to 1
 	beq $a0, $zero, fib0 #Go to return 0 if i = 0
 	beq $a0, $t0, fib1  #Go to return 1 if i = 1
 	jr fib

fib0:
	li $v0, 0
	jr $ra

fib1:
	li $v0, 1
	jr $ra

fib:
	#Free Stack Space
 	addi $sp, $sp, -16  #Make room for 4 elements in stack
        #$ra and i stored now, sums later
 	sw $ra, 0($sp)  #Save return address
 	sw $a0, 4($sp)  #Save i

 	#Calculate (fib(n-1))
 	addi $a0, $a0, -1  #Decrement i
 	jal vfib   #recurse for (fib(n-1))
 	sw $v0, 8($sp)  #Save value of (fib(n-1))

 	#Calculate (fib(n-2))
 	lw $a0, 4($sp)  #restore value of i from stack
 	addi $a0, $a0, -2  #Decrement i twice
 	jal vfib   #recurse for (fib(n-2))
 	sw $v0, 12($sp)  #save result of (fib(n-2))

 	#Restore from stack and sum
 	lw $ra, 0($sp)  #Load return address
 	lw $t0, 8($sp)  #load (fib(n-1))
 	lw $t1, 12($sp)  #load (fib(n-2))
 	addi $sp, $sp, 16  #free up 4 elements on stack
 	add $v0, $t0, $t1  #Sum (fib(n-1) + fib(n-2))

 	jr $ra

