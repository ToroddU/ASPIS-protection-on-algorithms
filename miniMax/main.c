#include "minimax.h"
#include "fh.h"

int arr[16] = {
    17, 4, 2, 6, 1, 8, 3, 7, 5, 9,
    -2, -3, 8, 6, 15, 4};


int main() {
    const int array_size = 16;
    runMinimax(arr, array_size);
    return 0;
}