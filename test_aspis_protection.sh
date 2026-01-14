#!/bin/bash

# Script to compile and test ASPIS protection on sorting/minimax algorithms

ASPIS_ROOT="/home/toroddu/utveksling/embeded/prosjekt/ASPIS"
ASPIS_SCRIPT="$ASPIS_ROOT/aspis.sh"
LLVM_BIN="$ASPIS_ROOT/llvm16-bin"
BUILD_DIR="./aspis_build"

# Color codes for output
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo "=========================================="
echo "ASPIS Protection Testing Suite"
echo "=========================================="
echo ""

# Function to compile with ASPIS
compile_with_aspis() {
    local name=$1
    local dir=$2
    local main_src=$3
    local other_srcs=$4
    
    echo -e "${YELLOW}Compiling ${name} with ASPIS protection...${NC}"
    
    mkdir -p "$BUILD_DIR/$name"
    
    # Create a combined source file for ASPIS compilation
    cd "$dir"
    
    # Compile with ASPIS using EDDI + CFCSS (Error Detection + Control Flow Checking)
    $ASPIS_SCRIPT --llvm-bin "$LLVM_BIN" \
        $main_src $other_srcs fh.c fi.c \
        -o "${name}_aspis" \
        --build-dir "$BUILD_DIR/$name" \
        --seddi --cfcss 2>&1 | tail -20
    
    if [ -f "$BUILD_DIR/$name/${name}_aspis" ]; then
        echo -e "${GREEN}✓ Successfully compiled ${name} with ASPIS${NC}"
        return 0
    else
        echo -e "${RED}✗ Failed to compile ${name} with ASPIS${NC}"
        return 1
    fi
}

# Function to test a benchmark
test_benchmark() {
    local name=$1
    local dir=$2
    
    echo ""
    echo "=========================================="
    echo "Testing: $name"
    echo "=========================================="
    
    cd "$dir"
    
    echo ""
    echo "--- Running WITHOUT ASPIS (10 runs) ---"
    for i in {1..10}; do
        echo -n "Run $i: "
        ./${name} 2>&1 | grep -E "\[FI\]|\[SUCCESS\]|\[ERROR\]|result:" | head -2
    done
    
    if [ -f "$BUILD_DIR/$name/${name}_aspis" ]; then
        echo ""
        echo "--- Running WITH ASPIS (10 runs) ---"
        for i in {1..10}; do
            echo -n "Run $i: "
            $BUILD_DIR/$name/${name}_aspis 2>&1 | grep -E "\[FI\]|\[SUCCESS\]|\[ERROR\]|\[ASPIS\]|result:" | head -2
        done
    fi
    
    cd - > /dev/null
}

# Compile all benchmarks with ASPIS
echo ""
echo "=== COMPILATION PHASE ==="
echo ""

compile_with_aspis "quicksort" "$ASPIS_ROOT/examples/c-benchmarks/quicksort" \
    "main.c" "quicksort.c"

compile_with_aspis "selectionSort" "$ASPIS_ROOT/examples/c-benchmarks/selectionSort" \
    "main.c" "selectionSort.c"

compile_with_aspis "minimax" "$ASPIS_ROOT/examples/c-benchmarks/miniMax" \
    "main.c" "minimax.c"

echo ""
echo "=== TESTING PHASE ==="

# Test each benchmark
test_benchmark "quicksort" "$ASPIS_ROOT/examples/c-benchmarks/quicksort"
test_benchmark "selectionSort" "$ASPIS_ROOT/examples/c-benchmarks/selectionSort"
test_benchmark "minimax" "$ASPIS_ROOT/examples/c-benchmarks/miniMax"

echo ""
echo "=========================================="
echo "Testing Complete!"
echo "=========================================="
echo ""
echo "Summary:"
echo "- ASPIS-protected binaries are in: $BUILD_DIR/"
echo "- Look for [ASPIS] handlers being triggered when faults are detected"
echo "- Compare fault detection rates between protected and unprotected versions"
