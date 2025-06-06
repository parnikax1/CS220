.data

array: .word 12, 78, 45, 33, 15, 90, 22, 88, 47, 16
arraySize: .word 10

# 10 buckets × 10 words each = 40 bytes per bucket
bucket0:    .space 40
bucket1:    .space 40
bucket2:    .space 40
bucket3:    .space 40
bucket4:    .space 40
bucket5:    .space 40
bucket6:    .space 40
bucket7:    .space 40
bucket8:    .space 40
bucket9:    .space 40

# Table of bucket base addresses
buckets:    .word bucket0,bucket1,bucket2,bucket3,bucket4,bucket5,bucket6,bucket7,bucket8,bucket9

# Count of elements in each bucket (init all to 0)
counts: .word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0

.text
main:
    la $s0, array       # $s0 ← &array[0]
    la $s1, buckets     # $s1 ← &buckets[0]
    la $s2, counts      # $s2 ← &counts[0]
    lw $t1, arraySize   # $t1 = N
    li $t0, 0           # i = 0

    #── Phase 1: Distribute into buckets ────────────────────────────────────
    # assume:
    #   $s0 = &array[0]
    #   $s1 = &buckets[0]
    #   $s2 = &counts[0]
    #   $t1 = arraySize
    #   $t0 = 0               # i = 0

dist_loop:
    beq   $t0,$t1,sort_buckets    # done distributing?

    # load array[i]
    sll   $t6,$t0,2               # t6 = i*4
    addu  $t8,$s0,$t6             # &array[i]
    lw    $t2,0($t8)              # t2 = array[i]

    # bucket index = array[i] / 10
    li    $t9,10
    div   $t2,$t9
    mflo  $t3                     # t3 = bucket #

    # --- read old count[t3] into t4 ---
    sll   $t6,$t3,2               # t6 = t3*4
    addu  $t8,$s2,$t6             # &counts[t3]
    lw    $t4,0($t8)              # t4 = old count

    # --- compute &bucket[t3][ old count ] ---
    addu  $t8,$s1,$t6             # &buckets[t3] table entry
    lw    $t5,0($t8)              # t5 = base addr of bucket t3
    sll   $t6,$t4,2               # t6 = old_count*4
    addu  $t8,$t5,$t6             # &bucket[t3][old_count]

    # --- store the element there ---
    sw    $t2,0($t8)

    # --- now increment count and write it back ---
    addi  $t4,$t4,1
    sll   $t6, $t3, 2      # t6 = t3 * 4
    addu  $t8, $s2, $t6    # t8 = &counts[t3]
    sw    $t4, 0($t8)      # counts[t3] = t4

    addi  $t0,$t0,1               # i++
    j     dist_loop


    #── Phase 2: Insertion sort each bucket ─────────────────────────────────
sort_buckets:
    li   $t3,0                  # b = 0
sb_loop:
    li   $t7,10
    beq  $t3,$t7,concatenate    # if b==10 go concat

    # load count[b] into t4
    sll  $t6,$t3,2
    addu $t8,$s2,$t6
    lw   $t4,0($t8)
    blez $t4,next_bucket        # skip if count≤0

    # bucket base in t5
    addu $t8,$s1,$t6
    lw   $t5,0($t8)

    # insertion sort on bucket[0..t4-1]
    li   $t6,1                  # j = 1
in_outer:
    bge  $t6,$t4,next_bucket    # if j≥count, done
    sll  $t7,$t6,2
    addu $t8,$t5,$t7
    lw   $t2,0($t8)             # key = bucket[j]
    move $t9,$t6                # i = j

in_inner:
    addi $t9,$t9,-1
    blt  $t9,$zero,in_insert
    sll  $t7,$t9,2
    addu $t8,$t5,$t7
    lw   $t1,0($t8)             # t1 = bucket[i]
    ble  $t1,$t2,in_insert
    addi $t7,$t9,1
    sll  $t7,$t7,2
    addu $t8,$t5,$t7
    sw   $t1,0($t8)             # shift up
    j    in_inner

in_insert:
    sll  $t7,$t9,2
    addu $t8,$t5,$t7
    sw   $t2,0($t8)             # insert key
    addi $t6,$t6,1
    j    in_outer

next_bucket:
    addi $t3,$t3,1
    j    sb_loop

    #── Phase 3: Concatenate back into array ────────────────────────────────
concatenate:
    li   $t0,0                  # b = 0
    la   $s3,array              # $s3 = write‐pointer into array

cb_loop:
    li   $t7,10
    beq  $t0,$t7,print_out

    sll  $t6,$t0,2
    addu $t8,$s2,$t6
    lw   $t4,0($t8)             # t4 = count[b]

    addu $t8,$s1,$t6
    lw   $t5,0($t8)             # t5 = bucket base

    li   $t9,0                  # j = 0
cat_inner:
    beq  $t9,$t4,cb_next
    sll  $t6,$t9,2
    addu $t8,$t5,$t6
    lw   $t2,0($t8)             # bucket[b][j]
    sw   $t2,0($s3)             # array[k++] = t2
    addi $s3,$s3,4
    addi $t9,$t9,1
    j    cat_inner

cb_next:
    addi $t0,$t0,1
    j    cb_loop

    #── Phase 4: Print sorted array ────────────────────────────────────────
print_out:
    la   $s3,array
    lw   $t1,arraySize
    li   $t7,0

pr_loop:
    beq  $t7,$t1,done
    sll  $t6,$t7,2
    addu $t8,$s3,$t6
    lw   $a0,0($t8)
    li   $v0,1
    syscall
    li   $a0,32
    li   $v0,11
    syscall
    addi $t7,$t7,1
    j    pr_loop

done:
    li   $v0,10
    syscall

