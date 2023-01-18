#include <stdlib.h>
#include <stdio.h>
#include <stdint.h>
#include "struct.h"

int delete_readings(Sensor *previousSensor,int number_of_previous_sensors,int number_of_deleted_sensors){

    //should automatically free the sensors that were "deleted"

    if(number_of_previous_sensors-number_of_deleted_sensors>=0){

        for (int i = number_of_previous_sensors-1; i >=number_of_previous_sensors-number_of_deleted_sensors ; i--) {

               free((*(previousSensor+i)).readings);
        }

        previousSensor = (Sensor *) realloc (previousSensor,(number_of_previous_sensors-number_of_deleted_sensors)*sizeof(Sensor));

    }else{
        return 0;
    }

	return 1;
}