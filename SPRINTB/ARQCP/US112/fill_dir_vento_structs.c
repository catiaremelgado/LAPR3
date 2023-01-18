#include <stdlib.h>
#include <stdio.h>
#include <stdint.h>
#include "sens_dir_vento.h"
#include "pcg32_random_r.h"
#include "reader.h"
#include "struct.h"
#include "count_errors.h"


Sensor * fill_dir_vento_structs(char *name, char *unit, int number_of_sensors, unsigned long frequency, short *ids, int min_lim, int max_lim){

	Sensor *dir_vento = (Sensor *) malloc (number_of_sensors*sizeof(Sensor));
				
	if (dir_vento != NULL) {

		state = reader();
		inc = reader();

		short seed = (short) pcg32_random_r();

		unsigned long reads_size = 24*60*60 / frequency;
		int counter = number_of_sensors;
		int *reads = (int *) malloc (reads_size*sizeof(int));
		if (reads == NULL) {
			free(dir_vento);
		} else {
			unsigned short last_value = 1;
			for (unsigned long i = 0; i < reads_size; i++) {
				last_value = sens_dir_vento(last_value, seed);
				*(reads+i) = (int) last_value;
			}
		}
		int j = 0;

		/* fill id, name, unit, frequency, readings size, initialize *readings and erros*/
		while (counter != 0 && reads != NULL && dir_vento != NULL) {
			(*(dir_vento+j)).id = *(ids);
			(*(dir_vento+j)).sensor_type = name;
			(*(dir_vento+j)).unit_of_measurement = unit;
			(*(dir_vento+j)).frequency = frequency;
			(*(dir_vento+j)).readings_size = reads_size;
			(*(dir_vento+j)).readings = reads;
			(*(dir_vento+j)).min_limit = min_lim;
			(*(dir_vento+j)).max_limit = max_lim;
			(*(dir_vento+j)).errors = count_errors(reads, reads_size, min_lim, max_lim);
			*(ids) = *(ids) + 1;
			reads = (int *) malloc (reads_size*sizeof(int));
			if (reads == NULL) {
				free(dir_vento);
			} else {
				unsigned short last_value = 1;
				for (unsigned long i = 0; i < reads_size; i++) {
					last_value = sens_dir_vento(last_value, seed);
					*(reads+i) = (int) last_value;
				}
			}
			j++;
			counter--;
		}
		free(reads);
	}

	return dir_vento;
}