#ifndef FILL_PLUVIO_STRUCTS
#define FILL_PLUVIO_STRUCTS

#include "struct.h"

Sensor * fill_pluvio_structs(char *name, char *unit, int number_of_sensors, unsigned long frequency, short *ids, int min_lim, int max_lim);

#endif