#include "minimax.h"
#include "fi.h"
#include <stdio.h>
#include <limits.h>

// Game tree node
typedef struct {
    int value;
    int isLeaf;
} Node;

// Generate leaf nodes from array values
static void generateLeaves(Node *leaves, int *arr) {
    for (int i = 0; i < 16; i++) {
        leaves[i].value = arr[i];
        leaves[i].isLeaf = 1;
    }
}

// Minimax algorithm with alternating max/min
// depth: 0=root (MAX), 1(MIN), 2(MAX), 3(MIN), 4=leaves
// isMaximizing: 1 for MAX node, 0 for MIN node
static int minimax(Node *leaves, int nodeIndex, int depth, int isMaximizing) {
    // Base case: reached leaf node
    if (depth == 4) {
        // Inject fault directly into leaf node value (ASPIS can detect this)
        fi_maybe_flip(&leaves[nodeIndex].value);
        int leafValue = leaves[nodeIndex].value;
        return leafValue;
    }
    
    if (isMaximizing) {
        // MAX node: choose the maximum value
        int left = minimax(leaves, nodeIndex * 2, depth + 1, 0);      // MIN node
        int right = minimax(leaves, nodeIndex * 2 + 1, depth + 1, 0); // MIN node
        
        int maxEval = (left > right) ? left : right;
        return maxEval;
    } else {
        // MIN node: choose the minimum value
        int left = minimax(leaves, nodeIndex * 2, depth + 1, 1);      // MAX node
        int right = minimax(leaves, nodeIndex * 2 + 1, depth + 1, 1); // MAX node
        
        int minEval = (left < right) ? left : right;
        return minEval;
    }
}

void runMinimax(int *arr, size_t size) {
    if (size < 16) {
        printf("Array too small for minimax tree (needs at least 16 elements)\n");
        return;
    }
    
    printf("=== Minimax Adversarial Search ===\n");
    printf("Tree structure: 4 levels deep, binary choices at each node\n");
    printf("Players: MAX (root, depth 0,2) vs MIN (depth 1,3)\n\n");
    
    printf("Leaf node values:\n");
    for (int i = 0; i < 16; i++) {
        printf("%d ", arr[i]);
        if ((i + 1) % 8 == 0) printf("\n");
    }
    printf("\n\n");
    
    // Create leaf nodes
    Node leaves[16];
    generateLeaves(leaves, arr);
    
    // Run minimax starting from root (depth 0, MAX player, node index 0)
    int result = minimax(leaves, 0, 0, 1);
    
    printf("Minimax evaluation result: %d\n", result);
    printf("(This is the best value MAX can guarantee)\n");
}
