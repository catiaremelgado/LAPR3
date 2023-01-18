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


Sensor * update_freq_humd_solo_structs(Sensor *humd_solo , int number_of_sensors, unsigned long frequency){
	
	if (humd_solo != NULL) {

		state = reader();
		inc = reader();

		int last_value = 1;
		int last_value2 = 1;
		char last_value3 = 16;

		unsigned long reads_size = 24*60*60 / frequency;
		int counter = number_of_sensors;
		int *reads = (int *) malloc (reads_size*sizeof(int));
		if (reads == NULL) {
			free(humd_solo);
		} else {
			unsigned short last_value = 1;
			for (unsigned long i = 0; i < reads_size; i++) {
				last_value3 = sens_temp(last_value3, (char) pcg32_random_r());
				last_value2 = (int) sens_pluvio((unsigned char) last_value2, last_value3, (char) pcg32_random_r());
				last_value = (int) sens_humd_solo((unsigned char) last_value2,(char) last_value3, (char) pcg32_random_r());
				*(reads+i) = last_value;
			}
		}
		int j = 0;

		/* fill id, name, unit, frequency, readings size, initialize *readings and erros*/
		while (counter != 0 && reads != NULL && humd_solo != NULL) {
			(*(humd_solo+j)).frequency = frequency;
			(*(humd_solo+j)).readings_size = reads_size;

			free((*(humd_solo+j)).readings);
			(*(humd_solo+j)).readings = reads;

			(*(humd_solo+j)).min_limit = (*(humd_solo)).min_limit;
			(*(humd_solo+j)).max_limit = (*(humd_solo)).max_limit;
            (*(humd_solo+j)).errors = count_errors(reads, (*(humd_solo+j)).readings_size, (*(humd_solo+j)).min_limit, (*(humd_solo+j)).max_limit);
            			
			reads = (int *) malloc (reads_size*sizeof(int));
			if (reads == NULL) {
				free(humd_solo);
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

	return humd_solo;
}
