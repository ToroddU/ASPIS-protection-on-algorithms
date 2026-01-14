
#ifndef INSERTIONSORT_H
#define INSERTIONSORT_H


#include <stddef.h>

void insertionSort(int arr[], int n);
int is_sorted(const int arr[], int n);
void runInsertionsort(int* arr, int array_size);
void runInsertionsort_aspis_only(int* arr, int array_size);
void runInsertionsort_protected(int* arr, int array_size);
void printArray(const int arr[], int n);
void DataCorruption_Handler(void);

#endif