
#include <stdio.h>
#include <time.h>
#include <stdlib.h>
#include "insertionSort.h"
#include "fi.h" 
#include <unistd.h>
#include <sys/types.h>  


void insertionSort(int arr[], int n){
    for (int i = 1; i < n; ++i) {
        fi_maybe_flip(&i);             // disturb loop index
        int key = arr[i];
        fi_maybe_flip(&key);           // disturb key value
        int j = i - 1;
        while (j >= 0 && arr[j] > key) {
            arr[j + 1] = arr[j];
            j = j - 1;
        }
        fi_maybe_flip(&j);             // disturb j after loop (CF mismatch)
        arr[j + 1] = key;
    }
}

int is_sorted(const int arr[], int n) {
    for (int i = 1; i < n; ++i) {
        if (arr[i - 1] > arr[i]) {
            return 0;
        }
    }
    return 1;
}


void printArray(const int arr[], int n)
{
    for (int i = 0; i < n; ++i)
        printf("%d ", arr[i]);
    printf("\n");
}

// Unprotected version - no verification, silent failures
void runInsertionsort(int* arr, int array_size){
    insertionSort(arr, array_size);
    
    if (is_sorted(arr, array_size)) {
        printf("Array is sorted successfully.\n");
    } else {
        printf("Array is NOT sorted.\n");
    }
    printArray(arr, array_size);
}

// ASPIS-protected version with duplication ONLY (no manual verification)
__attribute__((annotate("to_duplicate"))) void runInsertionsort_aspis_only(int* arr, int array_size){
    insertionSort(arr, array_size);
    
    // No manual verification - relying solely on ASPIS duplication
    if (is_sorted(arr, array_size)) {
        printf("Array is sorted successfully.\n");
    } else {
        printf("Array is NOT sorted.\n");
    }
    printArray(arr, array_size);
}

// ASPIS-protected version with duplication AND manual verification
__attribute__((annotate("to_duplicate"))) void runInsertionsort_protected(int* arr, int array_size){
    insertionSort(arr, array_size);
    
    // Verify data integrity using ASPIS-protected duplicated function
    // If duplication detects corruption, call the handler
    if (!is_sorted(arr, array_size)) {
        fprintf(stderr, "[ASPIS] Data corruption detected! Exiting.\n");
        DataCorruption_Handler();
    }
    
    if (is_sorted(arr, array_size)) {
        printf("Array is sorted successfully.\n");
    } else {
        printf("Array is NOT sorted.\n");
    }
    printArray(arr, array_size);
}