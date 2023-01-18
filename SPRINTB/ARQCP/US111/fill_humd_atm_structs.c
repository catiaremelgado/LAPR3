#include <stdlib.h>
#include <stdio.h>
#include <stdint.h>
#include "sens_temp.h"
#include "sens_pluvio.h"
#include "sens_humd_atm.h"
#include "pcg32_random_r.h"
#include "reader.h"
#include "struct.h"
#include "count_errors.h"


Sensor * fill_humd_atm_structs(char *name, char *unit, int number_of_sensors, unsigned long frequency, short *ids, int min_lim, int max_lim){

	Sensor *humd_atm = (Sensor *) malloc (number_of_sensors*sizeof(Sensor));
	
	if (humd_atm != NULL) {

		state = reader();
		inc = reader();

		int last_value = 1;
		int last_value2 = 0;
		char last_value3 = 16;

		unsigned long reads_size = 24*60*60 / frequency;
		int counter = number_of_sensors;
		int *reads = (int *) malloc (reads_size*sizeof(int));
		if (reads == NULL) {
			free(humd_atm);
		} else {
			unsigned short last_value = 1;
			for (unsigned long i = 0; i < reads_size; i++) {
				last_value3 = sens_temp((char) last_value3, (char) pcg32_random_r());
				last_value2 = (int) sens_pluvio((unsigned char) last_value2, last_value3, (char) pcg32_random_r());
				last_value = (int) sens_humd_atm((unsigned char) last_value, (char) last_value2,(char) pcg32_random_r());
				*(reads+i) = last_value;
			}
		}
		int j = 0;

		/* fill id, name, unit, frequency, readings size, initialize *readings and erros*/
		while (counter != 0 && reads != NULL && humd_atm != NULL) {
			(*(humd_atm+j)).id = *(ids);
			(*(humd_atm+j)).sensor_type = name;
			(*(humd_atm+j)).unit_of_measurement = unit;
			(*(humd_atm+j)).frequency = frequency;
			(*(humd_atm+j)).readings_size = reads_size;
			(*(humd_atm+j)).readings = reads;
			(*(humd_atm+j)).min_limit = min_lim;
			(*(humd_atm+j)).max_limit = max_lim;
			(*(humd_atm+j)).errors = count_errors(reads, reads_size, min_lim, max_lim);
			*(ids) = *(ids) + 1;
			reads = (int *) malloc (reads_size*sizeof(int));
			if (reads == NULL) {
				free(humd_atm);
			} else {
				for (unsigned long i = 0; i < reads_size; i++) {
					last_value3 = sens_temp((char) last_value3, (char) pcg32_random_r());
					last_value2 = (int) sens_pluvio((unsigned char) last_value2, last_value3, (char) pcg32_random_r());
					last_value = (int) sens_humd_atm((unsigned char) last_value, (char) last_value2,(char) pcg32_random_r());
					*(reads+i) = last_value;
				}
			}
			j++;
			counter--;
		}
		free(reads);
	}

	return humd_atm;
}