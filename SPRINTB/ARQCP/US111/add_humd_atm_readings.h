#ifndef ADD_HUMD_ATM_READINGS
#define ADD_HUMD_ATM_READINGS

#include "struct.h"


Sensor * add_humd_atm_readings(Sensor *previousSensor,int number_of_previous_sensors,int number_of_new_sensors,short *ids);

#endif