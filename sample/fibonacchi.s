	.data
N:	.word 7
ANS:	.space 4

	.text
main:
	lw $a0, N($zero)
	ori $t1, $zero, 0
	jal FIB
	sw $v0, ANS($zero)
exit:	
	ori, $v0, $zero, 10
	syscall
	j exit

FIB:
	addi $sp, $sp, -12
	sw $t1, 8($sp)
	sw $ra, 4($sp)
	sw $a0, 0($sp)

	slti $t0, $a0, 2
	beq $t0, $zero, L1

	beq $a0, $zero CASE_ZERO
	j CASE_ONE
CASE_ZERO:
	ori $v0, $zero, 0
	addi $sp, $sp, 12
	jr $ra
CASE_ONE:
	ori $v0, $zero, 1
	addi $sp, $sp, 12
	jr $ra

L1:
	addi $a0, $a0, -1
	jal FIB
	add $t1, $v0, $zero
	addi $a0, $a0, -1
	jal FIB
	add $v0, $v0, $t1

	lw $a0, 0($sp)
	lw $ra, 4($sp)
	lw $t1, 8($sp)
	addi $sp, $sp, 12
	
	jr $ra
