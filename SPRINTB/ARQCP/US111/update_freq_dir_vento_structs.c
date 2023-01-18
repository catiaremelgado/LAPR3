#include <stdlib.h>
#include <stdio.h>
#include <stdint.h>
#include "sens_dir_vento.h"
#include "pcg32_random_r.h"
#include "reader.h"
#include "struct.h"
#include "count_errors.h"


Sensor * update_freq_dir_vento_structs(Sensor *dir_vento, int number_of_sensors, unsigned long frequency){


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
                        (*(dir_vento+j)).frequency = frequency;
                        (*(dir_vento+j)).readings_size = reads_size;

                        free((*(dir_vento+j)).readings);
                        (*(dir_vento+j)).readings = reads;
                        
			(*(dir_vento+j)).min_limit = (*(dir_vento)).min_limit;
			(*(dir_vento+j)).max_limit = (*(dir_vento)).max_limit;
                        (*(dir_vento+j)).errors = count_errors(reads, (*(dir_vento+j)).readings_size, (*(dir_vento+j)).min_limit, (*(dir_vento+j)).max_limit);
            
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
