#include <stdlib.h>

void free_double_pointer(int **matrix, int lines, int columns){

    for (int i = 0; i < lines ; i ++){
        free(*(matrix+i));
    }
    

    free(matrix);
}