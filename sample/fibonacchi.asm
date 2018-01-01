// 0000: a0
// 0001: v0
// 0002: t0
// 0003: t1
// 0004: sp
// 0005: ra
// 0512: stack

// -----------------
// $t1(temp reuslt)  stack head
// -----------------
// $ra(return address)
// -----------------
// $a0(argument)
// -----------------

main:
          // init stack pointer
          LDA #512
          STA #0004
          // lw $a0, N($zero)
          LDA #3
          STA #0000
          // ori $t1, $zero, 0
          LDA #0
          STA #0003
          // jal FIB
          LDA #exit
          STA #0005
          JUMP #FIB
          HALT

          // sw $v0, ANS($zero)
exit:	

FIB:
          //addi $sp, $sp, -12
          //sw $t1, 8($sp)
          LDA 0003
          STA 0004
          // increase sp
          LDA 0004
          ADA #1
          STA #0004

          //sw $ra, 4($sp)
          LDA #0005
          STA 0004
          // increase sp
          LDA 0004
          ADA #1
          STA #0004

          //sw $a0, 0($sp)
          LDA 0000
          STA 0004
          // increase sp
          LDA 0004
          ADA #1
          STA #0004

          //slti $t0, $a0, 2
          //beq $t0, $zero, L1
          //beq $a0, $zero case_zero
          //j case_one
          LDA 0000
          JZ case_zero
          SUA 1
          JZ case_one
          JUMP #L1
case_zero:
          ori $v0, $zero, 0
          addi $sp, $sp, 12
          jr $ra
case_one:
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
