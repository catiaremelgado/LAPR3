#include <stdlib.h>
#include <stdio.h>
#include <stdint.h>
#include "sens_temp.h"
#include "sens_pluvio.h"
#include "pcg32_random_r.h"
#include "reader.h"
#include "struct.h"
#include "count_errors.h"


Sensor * fill_pluvio_structs(char *name, char *unit, int number_of_sensors, unsigned long frequency, short *ids, int min_lim, int max_lim){

	Sensor *pluvio = (Sensor *) malloc (number_of_sensors*sizeof(Sensor));
	
	if (pluvio != NULL) {

		state = reader();
		inc = reader();

		unsigned long reads_size = 24*60*60 / frequency;
		int counter = number_of_sensors;
		int *reads = (int *) malloc (reads_size*sizeof(int));

		char last_value3 = 16;
		int last_value = 1;

		if (reads == NULL) {
			free(pluvio);
		} else {

			for (unsigned long i = 0; i < reads_size; i++) {
				last_value3 = sens_temp(last_value3, (char) pcg32_random_r());
				last_value = (int) sens_pluvio((unsigned char) last_value, (char) last_value3, (char) pcg32_random_r());
				*(reads+i) = last_value;
			}
		}
		int j = 0;

		/* fill id, name, unit, frequency, readings size, initialize *readings and erros*/
		while (counter != 0 && reads != NULL && pluvio != NULL) {
			(*(pluvio+j)).id = *(ids);
			(*(pluvio+j)).sensor_type = name;
			(*(pluvio+j)).unit_of_measurement = unit;
			(*(pluvio+j)).frequency = frequency;
			(*(pluvio+j)).readings_size = reads_size;
			(*(pluvio+j)).readings = reads;
			(*(pluvio+j)).min_limit = min_lim;
			(*(pluvio+j)).max_limit = max_lim;
			(*(pluvio+j)).errors = count_errors(reads, reads_size, min_lim, max_lim);
			*(ids) = *(ids) + 1;
			reads = (int *) malloc (reads_size*sizeof(int));
			if (reads == NULL) {
				free(pluvio);
			} else {
				for (unsigned long i = 0; i < reads_size; i++) {
				last_value3 = sens_temp(last_value3, (char) pcg32_random_r());
				last_value = (int) sens_pluvio((unsigned char) last_value, (char) last_value3, (char) pcg32_random_r());
				*(reads+i) = last_value;
				}
			}
			j++;
			counter--;
		}
		free(reads);	
	}

	return pluvio;
}