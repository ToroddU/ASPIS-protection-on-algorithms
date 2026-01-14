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
    if (fi_done >= 1) return;
    if ((rand() % 200) == 0) {  
        int bit = rand() % 8;        
        int mask = 1u << bit;
        *x ^= mask;
        fi_done++;
        fprintf(stderr, "[FI] Flipped bit %d\n", bit);
    }
};