#ifndef FILL_HUMD_SOLO_STRUCTS
#define FILL_HUMD_SOLO_STRUCTS

#include "struct.h"

Sensor * fill_humd_solo_structs(char *name, char *unit, int number_of_sensors, unsigned long frequency, short *ids, int min_lim, int max_lim);

#endif