#ifndef ADD_TEMP_READINGS
#define ADD_TEMP_READINGS

#include "struct.h"


Sensor * add_temp_readings(Sensor *previousSensor,int number_of_previous_sensors,int number_of_new_sensors,short *ids);

#endif