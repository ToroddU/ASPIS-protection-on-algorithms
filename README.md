# ASPIS-protection-on-algorithms



This directory contains C benchmark programs that have been protected using the ASPIS framework. The benchmarks include implementations of sorting algorithms and the minimax algorithm, which are commonly used in various applications.


To run the benchmarks with ASPIS protection, use the provided `test_aspis_protection.sh` script. This script compiles the benchmarks with ASPIS instrumentation and applies fault injection to test the robustness of the protected code.

./test_aspis_protection.sh

This will compile the benchmarks with ASPIS protection and run them, allowing you to observe the effects of fault injection on the algorithms.

Each benchmark consists of a main C file, a header file defining the algorithm, and a fault injection file that introduces faults into the execution to test the resilience of the ASPIS protection.