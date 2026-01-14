
#include <stdio.h>
#include <string.h>
#include "ft_utils.h"
#include "fault_injection.h"

/* Duplicated global copy of data for ASPIS to protect */
unsigned char g_data_sha_dup[8192];

void DataCorruption_Handler() {
    //while(1);
    printf("Data Corruption Detected by ASPIS!\n");
    return;
}

void SigMismatch_Handler() {
    //while(1);
    printf("Signature Mismatch Detected by ASPIS!\n");
    return;
}

__attribute__((annotate("to_duplicate"))) void memcpy_to_duplicate(void *__dest, const void *__src, size_t __n) {
    memcpy(__dest, __src, __n);
    
    /* Inject fault: flip one byte of destination after copy (original replica only) */
    static int call_count = 0;
    const char *force = getenv("FI_FORCE");
    if (force && force[0] == '1' && __n > 0) {
        call_count++;
        unsigned char *dest = (unsigned char *)__dest;
        if (call_count == 1) {
            unsigned char orig = dest[50];
            dest[50] ^= (1 << 4);
            fprintf(stderr, "[FI] memcpy call #%d: Flipped dest[50] bit 4: %02x -> %02x\n",
                    call_count, orig, dest[50]);
        }
    }
}


__attribute__((annotate("to_duplicate"))) void memset_to_duplicate(void *__dest, const int __src, size_t __n) {
    memset(__dest, __src, __n);
}
