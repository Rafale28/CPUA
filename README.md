# CPUA
## Description
CPUA is a simple CPU.

## Instructions
|   Instruction   | z |   OPCODE   |     Operation                      |
|:----------------|:-:|:----------:|:-----------------------------------|
| LDA #xxx        | X | 1002       | A := xxx                           |
| ANA #xxx        | X | 1005       | A := A & xxx                       |
| ORA #xxx        | X | 1006       | A := A \| xxx                      |
| XRA #xxx        | X | 1007       | A := A ^ xxx                       |
| ADA #xxx        | X | 1008       | A := A + xxx                       |
| SUA #xxx        | X | 1009       | A := A - xxx                       |
| MUA #xxx        | X | 100A       | A := A * xxx                       |
| SRA #xxx        | X | 100B       | A := A >> xxx (sign ext)           |
| SLA #xxx        | X | 100C       | A := A << xxx (sign ext)           |
| SRL #xxx        | X | 100D       | A := A >> xxx                      |
| SLL #xxx        | X | 100E       | A := A >> xxx                      |
| JMP #xxx        |   | 2002       | PC := xxx                          |
| JZ  #xxx        |   | 2102       | PC := xxx if Z==1 else PC := PC+2  |
| CALL #xxx       |   | 2012       | PC := xxx, ST := PC+2              |
| STA #xxx        |   | 3000       | (xxx) := A                         |
| RET             |   | 4000       | PC := ST                           |
| LDA xxx         | X | 9002       | A := (xxx)                         |
| ANA xxx         | X | 9005       | A := A & (xxx)                     |
| ORA xxx         | X | 9006       | A := A \| (xxx)                    |
| XRA xxx         | X | 9007       | A := A ^ (xxx)                     |
| ADA xxx         | X | 9008       | A := A + (xxx)                     |
| SUA xxx         | X | 9009       | A := A - (xxx)                     |
| MUA xxx         | X | 900A       | A := A * (xxx)                     |
| SRA xxx         | X | 900B       | A := A >> (xxx) (sign ext)         |
| SLA xxx         | X | 900C       | A := A << (xxx) (sign ext)         |
| SRL xxx         | X | 900D       | A := A >> (xxx)                    |
| SLL xxx         | X | 900E       | A := A >> (xxx)                    |
| JMP xxx         |   | A002       | PC := (xxx)                        |
| JZ  xxx         |   | A102       | PC := (xxx) if Z==1 else PC := PC+2|
| CALL xxx        |   | A012       | PC := (xxx), ST := PC+2            |
| STA xxx         |   | B000       | ((xxx)) := A                       |
| LAA xxx         | X | D000       | A := (A)                           |

A value with brackets means it fetches a memory value at the address xxx.
