# ASPIS-protection-on-algorithms



This directory contains C benchmark programs that have been protected using the ASPIS framework. The benchmarks include implementations of sorting algorithms and the minimax algorithm, which are commonly used in various applications.


ASPIS (Adaptive Security Protection for Information Systems) is a framework designed to enhance the security of software applications by protecting them against bit-flip faults caused by radiation or other environmental factors. The framework employs various techniques such as redundancy and error detection to ensure the integrity of the program's execution.


# Testing the Benchmarks

To provoke faults during the execution of these benchmarks, you can use gdb or other similar tools. These tools allow you to simulate bit-flip faults in the program's memory or registers, enabling you to test the effectiveness of the ASPIS protection mechanisms.

Using gdb, you can set breakpoints and modify memory values to simulate faults at specific points in the program's execution. This will help you observe how the ASPIS framework responds to these faults and whether it successfully detects and mitigates them.

One way to simulate faults is:
    1. gdb ./selectionSort_aspis (start debugging)
    2. b runSelectionSort_dup (break when runSelectionSort is duplicated)
    3. b SigMismatch_Handler (added break at each fault handler)
    4. b DataCorruption_Handler
    5. b InvalidInstr_Handler
    6. Run (Ran the program until first break (runSelectionSort))
    7. info registers rdi rsi rdx (finding the register containing the array)
    8. x/10dw $rdi
       x/10dw $rsi
       x/10dw $rdx
    9. set $arr = $rdi (Save address of the Array being sorted)
    10. Ni x5 (Continued a few iterations (4-5))
    11. find $rsp, $rbp, $arr (found the duplicates of the array, 0x7fffffffdc98 and 0x7fffffffdc70 in this case)
    12. set *(long*)0x7fffffffdc98 = 0x555555559040 ^ 0x8 (changed the address being pointed to by one of the duplicates)
    13. Continue 
    14. And then the breakpoint in DataCorruption_Handler triggered.

