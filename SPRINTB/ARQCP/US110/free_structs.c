#include <stdlib.h>
#include "struct.h"

void free_structs(Sensor *sensors, int number){

    for (int i = 0; i < number; i++) {
       free((*(sensors+i)).readings);
    }

    free(sensors);
}