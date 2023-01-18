#include <stdlib.h>
#include <stdio.h>
#include <stdint.h>
#include "sens_dir_vento.h"
#include "pcg32_random_r.h"
#include "reader.h"
#include "struct.h"
#include "count_errors.h"

Sensor * add_dir_vento_readings(Sensor *previousSensor,int number_of_previous_sensors,int number_of_new_sensors,short *ids){

	Sensor * sensor = (Sensor *) realloc (previousSensor,(number_of_previous_sensors+number_of_new_sensors)*sizeof(Sensor));
    //printf("num sens novo %i\n\n", number_of_previous_sensors+number_of_new_sensors);
	if (sensor != NULL) {

		state = reader();
		inc = reader();

		short seed = (short) pcg32_random_r();

		unsigned long reads_size = (*(sensor)).readings_size;

		int counter = number_of_previous_sensors+number_of_new_sensors;
		int *reads = (int *) malloc (reads_size*sizeof(int));

		if (reads == NULL) {
			free(sensor);
		} else {

			unsigned short last_value = 1;
            //printf("counter %i\n\n",counter);
			for (unsigned long i = 0; i < reads_size; i++) {
				last_value = sens_dir_vento(last_value, seed);
				*(reads+i) = (int) last_value;
				//printf("value %i is %i\n\n",i,(int) last_value);
			}
		}
		int j = number_of_previous_sensors; //j equivale ao número da reading do sensor deste tipo


		/* fill id, name, unit, frequency, readings size, initialize *readings and erros*/
		while (counter != number_of_previous_sensors && reads != NULL && sensor != NULL){

            (*(sensor+j)).id = *(ids);
            (*(sensor+j)).sensor_type = (*(sensor)).sensor_type;
            (*(sensor+j)).unit_of_measurement = (*(sensor)).unit_of_measurement;
            (*(sensor+j)).frequency = (*(sensor)).frequency;
            (*(sensor+j)).readings_size = (*(sensor)).readings_size;
            (*(sensor+j)).readings = reads;
			(*(sensor+j)).min_limit = (*(sensor)).min_limit;
			(*(sensor+j)).max_limit = (*(sensor)).max_limit;
            (*(sensor+j)).errors = count_errors(reads, (*(sensor+j)).readings_size, (*(sensor+j)).min_limit, (*(sensor+j)).max_limit);
            *(ids) = *(ids) + 1;
            /*
            printf("j %i\n\n",j);
            printf("id %i\n\n",(*(sensor+j)).id);
            printf("type %s\n\n",(*(sensor+j)).sensor_type);
            printf("unit %s\n\n",(*(sensor+j)).unit_of_measurement);
            printf("freq %li\n\n",(*(sensor+j)).frequency);
            printf("readssize %li\n\n",(*(sensor+j)).readings_size);*/


			reads = (int *) malloc (reads_size*sizeof(int));

			if (reads == NULL) {
				free(sensor);
			} else {
			    //printf("counter %i\n\n",counter);
				unsigned short last_value = 1;
				for (unsigned long i = 0; i < reads_size; i++) {
					last_value = sens_dir_vento(last_value, seed);
					*(reads+i) = (int) last_value;
					//printf("value %li is %i\n\n",i,(int) last_value);

				}
			}
			j++;
			counter--;
		}

		free(reads);
	}

	return sensor;
}