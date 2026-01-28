#include "quicksort.h"
#include <stdio.h>

// Function to swap two elements
static void swap(int *a, int *b) {
    int temp = *a;
    *a = *b;
    *b = temp;
}

// Partition function 
static int partition(int *arr, int low, int high) {
    // Inject fault directly into array element (ASPIS can detect this)
    int pivot = arr[high];  // Last element is pivot
    int i = low - 1;  
    
    for (int j = low; j < high; j++) {
        if (arr[j] <= pivot) {
            i++;
            swap(&arr[i], &arr[j]);
        }
    }
    swap(&arr[i + 1], &arr[high]);
    return i + 1;
}

static void quicksort(int *arr, int low, int high) {
    if (low < high) {
        int pi = partition(arr, low, high);
        
        quicksort(arr, low, pi - 1);
        quicksort(arr, pi + 1, high);
    }
}

static int checkIfSorted(int *arr, size_t size) {
    for (size_t i = 0; i < size - 1; i++) {
        if (arr[i] > arr[i + 1]) {
            printf("[ERROR] Array not sorted: arr[%zu]=%d > arr[%zu]=%d\n", 
                   i, arr[i], i + 1, arr[i + 1]);
            return 0;  
        }
    }
    printf("[SUCCESS] Array is correctly sorted!\n");
    return 1;  
}

void runQuicksort(int *arr, size_t size) {
    if (size == 0) return;
    
    printf("Before sorting:\n");
    for (size_t i = 0; i < size; i++) {
        printf("%d ", arr[i]);
        if ((i + 1) % 10 == 0) printf("\n");
    }
    printf("\n\n");
    
    quicksort(arr, 0, size - 1);
    
    printf("After sorting:\n");
    for (size_t i = 0; i < size; i++) {
        printf("%d ", arr[i]);
        if ((i + 1) % 10 == 0) printf("\n");
    }
    printf("\n");
    
    // Verify the array is sorted
    checkIfSorted(arr, size);
}