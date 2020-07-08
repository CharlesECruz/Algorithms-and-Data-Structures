void swap(int* a, int* b) {
    int temp = *a;
    *a = *b;
    *b = temp;
}
int partition(int myArray[], int start, int end) {
    int pivot = myArray[end];
    int left = (start - 1);
    for (int index = start; index <= end - 1; index++) {
        if (myArray[index] < pivot) {
            left++;
            swap(&myArray[left], &myArray[index]);
        }
    }
    swap(&myArray[left + 1], &myArray[end]);
    return (left + 1);
}
void quickSort(int myArray[], int start, int end) {
    if (start <= end) {
        int part = partition(myArray, start, end);
        quickSort(myArray, start, end - 1);
        quickSort(myArray, part + 1, end);
    }
}