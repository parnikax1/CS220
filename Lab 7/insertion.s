.data

numbers: .word 8, 100, 0, 3, 7, 9, 2, 7, -3, 0      #create array which holds numbers
message: .asciiz "Sorted Array: "                  #message to be printed

.text
main:
    la $s7, numbers               #load address of numbers into $s7

    li $s0, 1                     #initialize counter i for outer loop (start from 1)
    li $s6, 10                     #n - 1 (size of the array - 1)
    
    li $t3, 0                     #initialize counter for printing
    li $t4, 10                    #limit for printing numbers
    
    li $v0, 4                     #print out message
    la $a0, message
    syscall

insertion_outer_loop:
    li $s1, 0                     
    sll $t7, $s0, 2              
    add $t7, $s7, $t7            
    
    lw $t0, 0($t7)                #load numbers[i] into $t0 (key element)

    # Compare and shift elements larger than key to the right
    sub $s2, $s0, 1                #j = i - 1 (index before current element)

insertion_inner_loop:
    sll $t8, $s2, 2               #multiply j by 4 (word size) to get offset
    add $t8, $s7, $t8             #address of numbers[j]
    
    lw $t1, 0($t8)                #load numbers[j] into $t1

    # If key (numbers[i]) is smaller than numbers[j], shift numbers[j] to the right
    slt $t9, $t1, $t0             #if numbers[j] < key, then $t9 = 1
    beq $t9, $zero, insertion_end_inner_loop #if numbers[j] >= key, stop shifting
    
    sw $t1, 4($t8)                #shift numbers[j] to the right (numbers[j+1] = numbers[j])
    sub $s2, $s2, 1                #decrement j
    bge $s2, $zero, insertion_inner_loop  #continue inner loop if j >= 0

insertion_end_inner_loop:
    # Insert the key element into its correct position (numbers[j+1] = key)
    sll $t8, $s2, 2               #multiply j by 4 (word size)
    add $t8, $s7, $t8             #address of numbers[j+1]
    sw $t0, 4($t8)                #store the key in numbers[j+1]

    # Outer loop - increment i, check if we have processed all elements
    addi $s0, $s0, 1              #increment i
    bne $s0, $s6, insertion_outer_loop  #repeat outer loop if i <= n - 1

print:
    beq $t3, $t4, final           #if t3 = t4 go to final
    
    lw $t5, 0($s7)                #load number from array
    
    li $v0, 1                     #print the number
    move $a0, $t5
    syscall

    li $a0, 32                    #print space
    li $v0, 11
    syscall
    
    addi $s7, $s7, 4              #increment through the numbers
    addi $t3, $t3, 1              #increment counter

    j print

final:    
    li $v0, 10                    #end program
    syscall

