    .section .init
    .globl _start
    .type _start,@function


_start:
    li x1, 42

done:
    j done


