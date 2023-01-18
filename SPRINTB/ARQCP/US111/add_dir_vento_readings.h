#ifndef ADD_DIR_VENTO_READINGS
#define ADD_DIR_VENTO_READINGS

#include "struct.h"

Sensor * add_dir_vento_readings(Sensor *previousSensor,int number_of_previous_sensors,int number_of_new_sensors,short *ids);

#endif