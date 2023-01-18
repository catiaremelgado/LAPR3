#ifndef FILL_TEMP_STRUCTS
#define FILL_TEMP_STRUCTS

#include "struct.h"

Sensor * fill_temp_structs(char *name, char *unit, int number_of_sensors, unsigned long frequency, short *ids, int min_lim, int max_lim);

#endif