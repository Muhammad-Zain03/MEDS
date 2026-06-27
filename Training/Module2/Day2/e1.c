#include <stdio.h>
#include <stdlib.h>

int global_var = 10;

int main() {
    static int static_var = 20; 
    int local_var = 30;   
    int *heap_var = malloc(sizeof(int));

    printf("Text (Code): %p\n", (void*)main);
    printf("Data (Global): %p\n", (void*)&global_var);
    printf("Data (Static): %p\n", (void*)&static_var);
    printf("Heap: %p\n", (void*)heap_var);
    printf("Stack: %p\n", (void*)&local_var);

    free(heap_var);
    return 0;
}