#include <stdio.h>
#include <stdint.h>
uint64_t reader() {
    uint64_t buffer [64];
    FILE *f;
    int result;
    int i;
    f = fopen("/dev/urandom", "r");

    if (f == NULL) {
        //printf("Error: open() failed to open /dev/random for reading\n");
        return 1;
        }
    result = fread(buffer , sizeof(uint64_t), 64,f);

    if (result < 1) {
        //printf("error , failed to read and words\n");
        return 1;
        }
    //printf("Read %d words from /dev/urandom\n",result);

    return buffer[0];
}


