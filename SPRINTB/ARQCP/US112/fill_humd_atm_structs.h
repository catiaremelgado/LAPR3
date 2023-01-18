#ifndef FILL_HUMD_ATM_STRUCTS
#define FILL_HUMD_ATM_STRUCTS

#include "struct.h"

Sensor * fill_humd_atm_structs(char *name, char *unit, int number_of_sensors, unsigned long frequency, short *ids, int min_lim, int max_lim);

#endif