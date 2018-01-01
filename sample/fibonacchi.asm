// 0000: a0
// 0001: v0
// 0002: t0
// 0003: t1
// 0004: sp
// 0005: ra
//
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
          //ori $v0, $zero, 0
          LDA #0
          STA #0001
          //addi $sp, $sp, 12
          LDA 0004
          SUA #3
          STA #0004
          //jr $ra
          JUMP 0005
case_one:
          ori $v0, $zero, 1
          LDA #1
          STA #0001
          //addi $sp, $sp, 12
          LDA 0004
          SUA #3
          STA #0004
          //jr $ra
          JUMP 0005

L1:
          //addi $a0, $a0, -1
          LDA 0000
          SUA 1
          STA #0000
          //jal FIB
          LDA #L1_1
          STA #0005
          JUMP #FIB
L1_1:
          add $t1, $v0, $zero
          LDA 0001
          STA #0003
          //addi $a0, $a0, -1
          LDA 0000
          SUA 1
          //jal FIB
          LDA #L1_2
          STA #0004
          JUMP #FIB
L1_2:
          //add $v0, $v0, $t1
          LDA 0001
          ADA 0003
          STA #0001
          //lw $a0, 0($sp)
          // decrease stack pointer
          LDA 0004
          SUA #1
          STA #0004
          // load and save
          
          //lw $ra, 4($sp)
          //lw $t1, 8($sp)
          //addi $sp, $sp, 12
          
          //jr $ra
