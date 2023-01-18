#include <stdlib.h>
#include <stdio.h>
#include <stdint.h>
#include "sens_temp.h"
#include "pcg32_random_r.h"
#include "reader.h"
#include "struct.h"
#include "count_errors.h"


Sensor * fill_temp_structs(char *name, char *unit, int number_of_sensors, unsigned long frequency, short *ids, int min_lim, int max_lim){

	Sensor *temp = (Sensor *) malloc (number_of_sensors*sizeof(Sensor));
	
	if (temp != NULL) {

		state = reader();
		inc = reader();

		//char seed = (char) pcg32_random_r();

		unsigned long reads_size = 24*60*60 / frequency;
		int counter = number_of_sensors;
		int *reads = (int *) malloc (reads_size*sizeof(int));

		if (reads == NULL) {
			free(temp);
		} else {
			char last_value = 16;
			for (unsigned long i = 0; i < reads_size; i++) {
				last_value = sens_temp(last_value, (char) pcg32_random_r());
				*(reads+i) = (int) last_value;
			}
		}
		int j = 0;

		/* fill id, name, unit, frequency, readings size, initialize *readings and erros*/
		while (counter != 0 && reads != NULL && temp != NULL) {
			(*(temp+j)).id = *(ids);
			(*(temp+j)).sensor_type = name;
			(*(temp+j)).unit_of_measurement = unit;
			(*(temp+j)).frequency = frequency;
			(*(temp+j)).readings_size = reads_size;
			(*(temp+j)).readings = reads;
			(*(temp+j)).min_limit = min_lim;
			(*(temp+j)).max_limit = max_lim;
			(*(temp+j)).errors = count_errors(reads, reads_size, min_lim, max_lim);
			*(ids) = *(ids) + 1;
			reads = (int *) malloc (reads_size*sizeof(int));
			if (reads == NULL) {
				free(temp);
			} else {
				char last_value = 16;
				for (unsigned long i = 0; i < reads_size; i++) {
					last_value = sens_temp(last_value, (char) pcg32_random_r());
					*(reads+i) = (int) last_value;
				}
			}
			j++;
			counter--;
		}	
		free(reads);
	}

	return temp;
}