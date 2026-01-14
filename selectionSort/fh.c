#include <stdio.h>
#include <stdlib.h>


void DataCorruption_Handler(void) {
    fprintf(stderr, "[ASPIS] Data corruption detected! Exiting.\n");
    exit(1);
}

void SigMismatch_Handler(void) {
    fprintf(stderr, "[ASPIS] Control-flow signature mismatch! Exiting.\n");
    exit(1);
}

void InvalidInstr_Handler(void) {
    fprintf(stderr, "[ASPIS] Invalid instruction encountered! Exiting.\n");
    exit(1);
}





