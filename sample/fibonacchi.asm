// Initialize stack pointer
// Stack Pointer: 512word = 8192 bit
// Stack begins from: 513word = 8208 bit
          LDA #8028
          STA #8192

fib:

          // save argument into stack
          LDA #0000
          STA 8192

          // proceed stack pointer
          LDA 8192
          ANA #2

          // if( n == 0 )
          LDA #0000
          JZ retone

          // if( n == 1 )


retone:
          LDA #8192


