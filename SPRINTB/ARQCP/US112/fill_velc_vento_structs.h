#ifndef FILL_VELC_VENTO_STRUCTS
#define FILL_VELC_VENTO_STRUCTS

#include "struct.h"

Sensor * fill_velc_vento_structs(char *name, char *unit, int number_of_sensors, unsigned long frequency, short *ids, int min_lim, int max_lim);

#endif