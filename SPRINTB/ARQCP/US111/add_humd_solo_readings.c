#include <stdlib.h>
#include <stdio.h>
#include <stdint.h>
#include "sens_temp.h"
#include "sens_pluvio.h"
#include "sens_humd_solo.h"
#include "pcg32_random_r.h"
#include "reader.h"
#include "struct.h"
#include "count_errors.h"


Sensor * add_humd_solo_readings(Sensor *previousSensor,int number_of_previous_sensors,int number_of_new_sensors,short *ids){

	Sensor * sensor = (Sensor *) realloc (previousSensor,(number_of_previous_sensors+number_of_new_sensors)*sizeof(Sensor));
    if (sensor != NULL) {

		state = reader();
		inc = reader();

		int last_value = 1;
        int last_value2 = 1;
        char last_value3 = 16;

		unsigned long reads_size = (*(sensor)).readings_size;
		int counter = number_of_previous_sensors+number_of_new_sensors;
		int *reads = (int *) malloc (reads_size*sizeof(int));

		if (reads == NULL) {
			free(sensor);
		} else {
			unsigned short last_value = 1;
            for (unsigned long i = 0; i < reads_size; i++) {
                last_value3 = sens_temp(last_value3, (char) pcg32_random_r());
                last_value2 = (int) sens_pluvio((unsigned char) last_value2, last_value3, (char) pcg32_random_r());
                last_value = (int) sens_humd_solo((unsigned char) last_value2,(char) last_value3, (char) pcg32_random_r());
                *(reads+i) = last_value;
            }
		}
		int j = number_of_previous_sensors;

		/* fill id, name, unit, frequency, readings size, initialize *readings and erros*/
		while (counter != number_of_previous_sensors && reads != NULL && sensor != NULL) {
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

			reads = (int *) malloc (reads_size*sizeof(int));
			if (reads == NULL) {
				free(sensor);
			} else {
				for (unsigned long i = 0; i < reads_size; i++) {
                    last_value3 = sens_temp(last_value3, (char) pcg32_random_r());
                    last_value2 = (int) sens_pluvio((unsigned char) last_value2, last_value3, (char) pcg32_random_r());
                    last_value = (int) sens_humd_solo((unsigned char) last_value2,(char) last_value3, (char) pcg32_random_r());
                    *(reads+i) = (int) last_value;
                }
			}
			j++;
			counter--;
		}
		free(reads);
	}

	return sensor;
}