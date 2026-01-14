#include "fi.h"
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <unistd.h>
#include <time.h>




__attribute__((annotate("exclude")))
void fi_maybe_flip(int* x) {
    static int fi_done = 0;
    static int seeded = 0;
    if (!seeded) {
        srand(time(NULL) + getpid());
        seeded = 1;
    }
    if (fi_done >= 3) return;
    if ((rand() % 2) == 0) {  
        int bit = rand() % 16;  // Flip any bit in the 32-bit integer
        int mask = 1u << bit;
        *x ^= mask;
        fi_done++;
        fprintf(stderr, "[FI] Flipped bit %d in value %d (before) -> %d (after)\n", 
                bit, *x ^ mask, *x);
    }
};