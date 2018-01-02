// 0512: a0
// 0513: v0
// 0514: t0
// 0515: t1
// 0516: sp
// 0517: ra
//
// 1024: stack

// -----------------
// $t1(temp reuslt)  stack head
// -----------------
// $ra(return address)
// -----------------
// $a0(argument)
// -----------------

main:
          // init stack pointer
          LDA #1024
          STA #0516
          // lw $a0, N($zero)
          LDA #10
          STA #0512
          // ori $t1, $zero, 0
          LDA #0
          STA #0515
          // jal FIB
          LDA #exit
          STA #0517
          JMP #FIB
exit:
          LDA 0513
          HALT

FIB:
          //addi $sp, $sp, -12
          //sw $t1, 8($sp)
          LDA 0515
          STA 0516
          // increase sp
          LDA 0516
          ADA #1
          STA #0516

          //sw $ra, 4($sp)
          LDA 0517
          STA 0516
          // increase sp
          LDA 0516
          ADA #1
          STA #0516

          //sw $a0, 0($sp)
          LDA 0512
          STA 0516
          // increase sp
          LDA 0516
          ADA #1
          STA #0516

          //slti $t0, $a0, 2
          //beq $t0, $zero, L1
          //beq $a0, $zero case_zero
          //j case_one
          LDA 0512
          JZ #case_zero
          SUA #1
          JZ #case_one
          JMP #L1
case_zero:
          //ori $v0, $zero, 0
          LDA #0
          STA #0513
          //addi $sp, $sp, 12
          LDA 0516
          SUA #3
          STA #0516
          //jr $ra
          JMP 0517
case_one:
          //ori $v0, $zero, 1
          LDA #1
          STA #0513
          //addi $sp, $sp, 12
          LDA 0516
          SUA #3
          STA #0516
          //jr $ra
          JMP 0517

L1:
          //addi $a0, $a0, -1
          LDA 0512
          SUA #1
          STA #0512
          //jal FIB
          LDA #L1_1
          STA #0517
          JMP #FIB
L1_1:
          //add $t1, $v0, $zero
          LDA 0513
          STA #0515
          //addi $a0, $a0, -1
          LDA 0512
          SUA #1
          STA #0512
          //jal FIB
          LDA #L1_2
          STA #0517
          JMP #FIB
L1_2:
          //add $v0, $v0, $t1
          LDA 0513
          ADA 0515
          STA #0513
          //lw $a0, 0($sp)
          // decrease stack pointer
          LDA 0516
          SUA #1
          STA #0516
          // load and save
          LDA 0516
          LAA
          STA #0512
          
          //lw $ra, 4($sp)
          // decrease stack pointer
          LDA 0516
          SUA #1
          STA #0516
          // load and save
          LDA 0516
          LAA
          STA #0517

          //lw $t1, 8($sp)
          // decrease stack pointer
          LDA 0516
          SUA #1
          STA #0516
          // load and save
          LDA 0516
          LAA
          STA #0515
          //addi $sp, $sp, 12
          
          //jr $ra
          JMP 0517
