#include <stdlib.h>
#include <stdio.h>
#include <stdint.h>
#include "sens_velc_vento.h"
#include "pcg32_random_r.h"
#include "reader.h"
#include "struct.h"
#include "count_errors.h"


Sensor * update_freq_velc_vento_structs(Sensor *velc_vento, int number_of_sensors, unsigned long frequency){
	
	if (velc_vento != NULL) {

		state = reader();
		inc = reader();

		//char seed = (char) pcg32_random_r();

		int last_value = 1;

		unsigned long reads_size = 24*60*60 / frequency;
		int counter = number_of_sensors;
		int *reads = (int *) malloc (reads_size*sizeof(int));
		if (reads == NULL) {
			free(velc_vento);
		} else {
			
			for (unsigned long i = 0; i < reads_size; i++) {
				last_value = (int) sens_velc_vento((unsigned short) last_value, (short) pcg32_random_r());
				*(reads+i) = (int) last_value;
			}
		}
		int j = 0;

		/* fill id, name, unit, frequency, readings size, initialize *readings and erros*/
		while (counter != 0 && reads != NULL && velc_vento != NULL) {
			(*(velc_vento+j)).frequency = frequency;
			(*(velc_vento+j)).readings_size = reads_size;
			
			free((*(velc_vento+j)).readings);
			(*(velc_vento+j)).readings = reads;
			
			(*(velc_vento+j)).min_limit = (*(velc_vento)).min_limit;
			(*(velc_vento+j)).max_limit = (*(velc_vento)).max_limit;
            (*(velc_vento+j)).errors = count_errors(reads, (*(velc_vento+j)).readings_size, (*(velc_vento+j)).min_limit, (*(velc_vento+j)).max_limit);
            
			reads = (int *) malloc (reads_size*sizeof(int));
			if (reads == NULL) {
				free(velc_vento);
			} else {
				for (unsigned long i = 0; i < reads_size; i++) {
					last_value = (int) sens_velc_vento((unsigned short) last_value, (short) pcg32_random_r());
					*(reads+i) = (int) last_value;
				}
			}
			j++;
			counter--;
		}
		free(reads);
	}

	return velc_vento;
}
