#include "selectionSort.h"
#include "fi.h"
#include <stdio.h>

// Function to swap two elements
static void swap(int *a, int *b) {
    int temp = *a;
    *a = *b;
    *b = temp;
}

// Selection sort function
static void selectionSort(int *arr, size_t size) {
    for (size_t i = 0; i < size - 1; i++) {
        // Find the minimum element in the remaining unsorted portion
        size_t minIdx = i;
        // Inject fault directly into array element (ASPIS can detect this)
        fi_maybe_flip(&arr[i]);
        int minVal = arr[i];  
        
        for (size_t j = i + 1; j < size; j++) {
            if (arr[j] < minVal) {
                minIdx = j;
                minVal = arr[j];
            }
        }
        
        // Swap the minimum element with the current element
        swap(&arr[i], &arr[minIdx]);
    }
}



static int checkIfSorted(int *arr, size_t size) {
    for (size_t i = 0; i < size - 1; i++) {
        if (arr[i] > arr[i + 1]) {
            printf("[ERROR] Array not sorted: arr[%zu]=%d > arr[%zu]=%d\n", 
                   i, arr[i], i + 1, arr[i + 1]);
            return 0;  // Not sorted
        }
    }
    printf("[SUCCESS] Array is correctly sorted!\n");
    return 1;  // Sorted
}

void runSelectionSort(int *arr, size_t size) {
    if (size == 0) return;
    
    printf("Before sorting:\n");
    for (size_t i = 0; i < size; i++) {
        printf("%d ", arr[i]);
        if ((i + 1) % 10 == 0) printf("\n");
    }
    printf("\n\n");
    
    selectionSort(arr, size);
    
    printf("After sorting:\n");
    for (size_t i = 0; i < size; i++) {
        printf("%d ", arr[i]);
        if ((i + 1) % 10 == 0) printf("\n");
    }
    printf("\n");
    
    // Verify the array is sorted
    checkIfSorted(arr, size);
}