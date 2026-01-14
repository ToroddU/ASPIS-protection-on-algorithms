// examples/c-benchmarks/sha/fault_injection.h
#pragma once
#include <stdint.h>

/* Returns input with a possible bit flip injected. */
uint64_t fi_maybe_flip32(uint64_t x);
