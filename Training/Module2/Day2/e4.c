#include <stdio.h>
#include <stdint.h>

void reverse_array(uint32_t *arr, size_t size) {
    uint32_t *start = arr;
    uint32_t *end = arr + size - 1;
    
    while (start < end) {
        uint32_t temp = *start;
        *start = *end;
        *end = temp;
        
        start++; 
        end--;   
    }
}

int main() {
    uint32_t arr[] = {1, 2, 3, 4, 5};
    reverse_array(arr, 5);
    
    for (int i = 0; i < 5; i++) {
        printf("%u ", arr[i]); 
    }
    printf("\n");
    return 0;
}