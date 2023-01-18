#ifndef ADD_PLUVIO_READINGS
#define ADD_PLUVIO_READINGS

#include "struct.h"


Sensor * add_pluvio_readings(Sensor *previousSensor,int number_of_previous_sensors,int number_of_new_sensors,short *ids);

#endif