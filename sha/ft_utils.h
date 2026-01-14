#include <stdlib.h>

void DataCorruption_Handler();

void SigMismatch_Handler();

/* Declare a duplicated copy of the random string data for ASPIS to protect */
__attribute__((annotate("to_duplicate"))) extern unsigned char g_data_sha_dup[8192];

__attribute__((annotate("to_duplicate"))) void memcpy_to_duplicate(void *__restrict__ __dest, const void *__restrict__ __src, size_t __n);

__attribute__((annotate("to_duplicate"))) void memset_to_duplicate(void *__restrict__ __dest, const int __src, size_t __n);
