# Bucket Sort for Floating Point Numbers in MIPS Assembly

.data
arr:        .float 0.897, 0.565, 0.656, 0.1234, 0.665, 0.3434, 0.1126, 0.554, 0.3349, 0.678, 0.3656, 0.9989
arr_size:   .word 12              # Size of the array
num_buckets: .word 5              # Number of buckets
newline:    .asciiz "\n"

.text
.globl main

main:
    # Load array size and number of buckets
    lw $t0, arr_size       # $t0 = array size (p)
    lw $t1, num_buckets    # $t1 = number of buckets (n)

    # Create empty buckets (Just storing counts for simplicity)
    la $t2, buckets        # Address of buckets array
    li $t3, 0              # Initialize all buckets to zero

init_buckets:
    sw $t3, 0($t2)         # Store 0 in current bucket
    addi $t2, $t2, 4       # Move to the next bucket
    addi $t1, $t1, -1
    bnez $t1, init_buckets  # Repeat for all buckets

    # Iterate over input array
    la $t4, arr            # $t4 points to the array
    lw $t1, num_buckets    # Reload number of buckets (n)
    lw $t0, arr_size       # Reload array size (p)

iterate_array:
    l.s $f0, 0($t4)         # Load array[i] (floating point)
    mul.s $f1, $f0, $t1     # Multiply array[i] by number of buckets
    cvt.w.s $f2, $f1        # Convert to integer index
    mfc1 $t5, $f2           # Move integer result to $t5

    # Insert element into the correct bucket
    la $t6, buckets         # Base address of buckets
    sll $t5, $t5, 2         # Multiply index by 4 (size of word)
    add $t6, $t6, $t5       # Find the correct bucket address

    lw $t7, 0($t6)          # Load current count in bucket
    addi $t7, $t7, 1        # Increment count
    sw $t7, 0($t6)          # Store updated count

    # Move to the next element in the array
    addi $t4, $t4, 4
    addi $t0, $t0, -1
    bnez $t0, iterate_array  # Continue until all elements are processed

    # Now, sort the buckets using insertion sort (not implemented yet)

    # Print sorted elements (not implemented yet)

    # Exit
    li $v0, 10
    syscall

buckets: .space 20   # Allocate space for 5 buckets (5 words)
