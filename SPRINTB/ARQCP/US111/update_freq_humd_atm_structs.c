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


Sensor * update_freq_humd_atm_structs( Sensor *humd_atm, int number_of_sensors, unsigned long frequency){
	
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
			(*(humd_atm+j)).frequency = frequency;
			(*(humd_atm+j)).readings_size = reads_size;

			free((*(humd_atm+j)).readings);
			(*(humd_atm+j)).readings = reads;

			(*(humd_atm+j)).min_limit = (*(humd_atm)).min_limit;
			(*(humd_atm+j)).max_limit = (*(humd_atm)).max_limit;
            (*(humd_atm+j)).errors = count_errors(reads, (*(humd_atm+j)).readings_size, (*(humd_atm+j)).min_limit, (*(humd_atm+j)).max_limit);
            
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
