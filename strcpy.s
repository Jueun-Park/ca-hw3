    .data
source_string: .asciiz "hello mips"
string_buffer: .space 256
    .text
main:
    la   $a0, string_buffer	# init dest $a0 
    la   $a1, source_string	# init source string $a1
    jal  strcpy			# call strcpy
    li   $v0, 4			# print string
    syscall			# print $a0
    li   $v0, 10		# terminate program
    syscall
strcpy:
    addi $sp, $sp, -4		# adjust stack for 1 item
    sw   $s0, 0($sp)		# save $s0
    add  $s0, $zero, $zero	# i = 0
L1:
    add  $t1, $s0, $a1		# addr of y[i] in $t1
    lbu  $t2, 0($t1)		# $t2 = y[i] 
    add  $t3, $s0, $a0		# addr of x[i] in $t3
    sb   $t2, 0($t3)		# x[i] = y[i]
    beq  $t2, $zero, L2		# exit loop if y[i] == 0
    addi $s0, $s0, 1		# i = i + 1
    j    L1			# next iteration of loop
L2:
    lw   $s0, 0($sp)		# restore saved $s0
    addi $sp, $sp, 4		# pop 1 item from stack
    jr   $ra			# and return

