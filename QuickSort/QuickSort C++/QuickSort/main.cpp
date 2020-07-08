#include <iostream>
#include "quickSort.h"
using namespace std;

void printArray(int arr[], int size){
    for (int i = 0; i < size; i++)
        cout << arr[i] << " ";
    cout << "\n";
}

int main()
{
    int myArray[] = { 100,2,5,9,6,6,8,18,2,1 };
    int size = sizeof(myArray) / sizeof(myArray[0]);
    quickSort(myArray, 0, size - 1);
    cout << "Sorted array: \n";
    printArray(myArray, size);
}