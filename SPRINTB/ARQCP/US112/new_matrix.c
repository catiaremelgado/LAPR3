#include <stdlib.h>

int **new_matrix(int lines, int columns){

    int ** matrix;

    /* allocate an array of int* with "lines" size */
    matrix = ( int **) calloc (lines , sizeof ( int *));

    /* if allocation was sucessful */
    if (matrix != NULL)
    {
        /* reserve for each position of the pointer matrix
         "columns" integers*/
        for (int i = 0; i < lines ; i ++){

            *(matrix+i) = (int *) calloc (columns , sizeof ( int ));

            //printf("%p\n", *(matrix+i));
            
            /* if reservation was not successful there's no need in continuing */
            if(*(matrix+i) == NULL ){
                i = lines + 1;
            }
        }
    }

    return matrix;

}