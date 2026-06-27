#include <stdio.h>
#include <string.h>

int strcat_safe(char *dest, size_t dest_size, const char *src) {
    size_t dest_len = strlen(dest);
    size_t src_len = strlen(src);
    
    if (dest_len + src_len + 1 > dest_size) return -1; 
    
    char *ptr = dest + dest_len;
    while (*src) {
        *ptr++ = *src++; 
    }
    *ptr = '\0'; 
    
    return 0;
}

int main() {
    char buf[10] = "Hi ";
    
    if (strcat_safe(buf, sizeof(buf), "there!") == 0) {
        printf("Success: %s\n", buf);
    } else {
        printf("Error: Buffer too small\n");
    }
    
    return 0;
}