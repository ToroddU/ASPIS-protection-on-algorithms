

#include "sha.h"
#include <stdint.h>
#include <stdlib.h>
#include <sys/types.h>
#include <time.h>
#include <unistd.h>
#include <stdio.h>



uint64_t fi_maybe_flip32(uint64_t x) {
    static int seeded = 0;
    static int call_count = 0;

    if (!seeded) {
        srand(time(NULL) ^ getpid());
        seeded = 1;
    }

    call_count++;

    /* With FI_FORCE=1, always flip on first call; else flip probabilistically once */
    static int flipped = 0;
    const char *force = getenv("FI_FORCE");
    
    int should_flip = 0;
    if (force && force[0] == '1') {
        /* Force mode: flip on the first call only */
        if (call_count == 1) {
            should_flip = 1;
        }
    } else {
        /* Probabilistic mode: flip once with 1/1000 chance */
        if (!flipped && (rand() % 1000) == 0) {
            should_flip = 1;
        }
    }

    if (should_flip) {
        int max_bits = (x <= 0xFFu) ? 8 : 64;
        int bit = rand() % max_bits;
        uint64_t mask = (uint64_t)1u << bit;
        x ^= mask;
        flipped = 1;
        fprintf(stderr, "[FI] Call %d: Flipped bit %d, result=%016lx\n", 
                call_count, bit, (unsigned long)x);
    }
    return x;
}
