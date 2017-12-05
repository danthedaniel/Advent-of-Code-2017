.text
.globl main

main:
# void main() {
    # int[] table = {0, 0, 2, 0, 0, ...};
    la  $a0,table    # Get table pointer
    ori $a1,$0,1032  # Table size
    # int num_jumps = solve(&table, 1032);
    ori $t9,$ra,0    # Store old $ra
    jal solve
    ori $ra,$t9,0    # Restore old $ra
    # printf("%d\n", num_jumps);
    ori $a0,$s0,0    # Copy return value to SYSCALL argument
    ori $v0,$0,0x1   # set SYSCALL to 1 (display int)
    syscall
# }
    jr $ra

# Part 1
# a0 - table start
# a1 - table size
# t0 - table pointer
# t1 - next table offset
# t2 - jump counter
# t3 - temp
# t4 - table end
# t5 - temp
# t6 - temp
# s0 - return value (number of jumps)
solve:
# int solve(int* table, int size) {
    # int* table_ptr = table;
    ori  $t0,$a0,0   # Copy table start to table pointer
    # int* end = table_ptr + size * sizeof(int);
    sll  $a1,$a1,2   # Multiply size by 4 (to convert it to words)
    add  $t4,$t0,$a1 # Calculate table end
    # int counter = 0;
    ori  $t2,$0,0    # Initialize counter at 0
    # int offset;
loop:
    # while (true) {
        # offset = table[*table_ptr];
    lw   $t1,0($t0)  # Copy data at pointer
        # int* temp = table_ptr + offset * sizeof(int);
    sll  $t6,$t1,2   # Multiply offset by 4 (to convert it to words)
    add  $t3,$t0,$t6 # Add offset to table_ptr

        # if (table[*table_ptr] >= 3)
    addi $t6,$t1,-3
    bltz $t6,else
            # table[*table_ptr]--;
    addi $t1,$t1,-1
    j    store
        # else
else:
            # table[*table_ptr]++;
    addi $t1,$t1,1   # Increment jump by one word

store:
    sw   $t1,0($t0)  # Store incremented jump
        # table_ptr = temp;
    ori  $t0,$t3,0   # Update table pointer

        # counter++;
        # if (table_ptr < table)
            # break;
        # if (table_ptr > (table + size))
            # break;
    addi $t2,$t2,1   # Increment jump count
    sub  $t3,$t0,$a0 # The offset from the start
    sub  $t5,$t0,$t4 # The offset from the end

    bltz $t3,return  # Return if we've jumped before the array start
    bgtz $t5,return  # Return if we've jumped past the array end
    # }
    j    loop        # Go back to start of loop
return:
    # return counter;
# }
    ori  $s0,$t2,0   # Copy counter to return register
    jr   $ra         # Return

# INSERT THE INPUT FILE CONTENTS HERE
