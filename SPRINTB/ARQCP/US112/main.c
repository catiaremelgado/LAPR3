#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>

#include "read_configuration.h"
#include "read_configuration_limits.h"
#include "struct.h"
#include "fill_dir_vento_structs.h"
#include "fill_temp_structs.h"
#include "fill_pluvio_structs.h"
#include "fill_velc_vento_structs.h"
#include "fill_humd_solo_structs.h"
#include "fill_humd_atm_structs.h"
#include "new_matrix.h"
#include "get_statistics.h"
#include "free_structs.h"
#include "free_double_pointer.h"
#include "exportMatrix.h"
#include "exportDataSensor.h"

uint64_t state=0;
uint64_t inc=0;

int main() {

    int *values = read_configuration("config.txt");

    unsigned int sensors_types_count = 6;

    /* Ver número atual de tipos de sensores */
    for (int i = 6; i < 12; i++) {
        if (*(values+i) <= 0 || *(values+i) > 86400  || *(values+i-6) <= 0) {
            *(values+i-6) = 0;
            sensors_types_count--;
        }
    }

    int *limits = read_configuration_limits("config_limits.txt");

    /*for (int i = 0; i < 12; i++)
    {
        printf("%i\n", *(values+i));
    }

    for (int i = 0; i < 12; i++)
    {
        printf("%i\n", *(limits+i));
    }*/



    printf("\n\n");

    if (sensors_types_count != 0){

        char nome_dir_vento[] = "Sensor de direção do vento";
        char nome_temp[] = "Sensor de temperatura";
        char nome_pluvio[] = "Sensor de pluviosidade";
        char nome_velc_vento[] = "Sensor de velocidade vento";
        char nome_humd_solo[] = "Sensor de humidade solo";
        char nome_humd_atm[] = "Sensor de humidade atmosferica";

        char u_graus_temp[] = "graus centígrados";
        char u_vel[] = "kilómetros por hora";
        char u_graus_dir[] = "graus relativamente ao Norte";
        char u_perc[] = "percentagem";
        char u_pluvio[] = "milimetros";

        short id = 1;
        short *ids = &id;

		Sensor *dir_vento;
        if (*values != 0) {
            dir_vento = fill_dir_vento_structs(nome_dir_vento, u_graus_dir, *(values+0), (unsigned long) *(values+6), ids, *(limits+0), *(limits+1));
           
            if (dir_vento == NULL){
                *(values+0) = 0;
                sensors_types_count--;
            }
        }

        Sensor *temp;
        if (*(values+1) != 0) {
            temp = fill_temp_structs(nome_temp, u_graus_temp, *(values+1), (unsigned long) *(values+1+6), ids, *(limits+2), *(limits+3));
            
            if (temp == NULL){
                *(values+1) = 0;
                sensors_types_count--;
            }
        }

        Sensor *pluvio;
        if (*(values+2) != 0) {
            pluvio = fill_pluvio_structs(nome_pluvio, u_pluvio, *(values+2), (unsigned long) *(values+2+6), ids, *(limits+4), *(limits+5));
            
            if (pluvio == NULL){
                *(values+2) = 0;
                sensors_types_count--;
            }
        }

        Sensor *velc_vento;
        if (*(values+3) != 0) {
            velc_vento = fill_velc_vento_structs(nome_velc_vento, u_vel, *(values+3), (unsigned long) *(values+3+6), ids, *(limits+6), *(limits+7));
           
            if (pluvio == NULL){
                *(values+3) = 0;
                sensors_types_count--;
            }
        }

        Sensor *humd_solo;
        if (*(values+4) != 0) {
            humd_solo = fill_humd_solo_structs(nome_humd_solo, u_perc, *(values+4), (unsigned long) *(values+4+6), ids, *(limits+8), *(limits+9));
            
            if (humd_solo == NULL){
                *(values+4) = 0;
                sensors_types_count--;
            }
        }

        Sensor *humd_atm;
        if (*(values+5) != 0) {
            humd_atm = fill_humd_atm_structs(nome_humd_atm, u_perc, *(values+5), (unsigned long) *(values+5+6), ids, *(limits+10), *(limits+11));
           
            if (humd_atm == NULL){
                *(values+5) = 0;
                sensors_types_count--;
            }
        }

        if (sensors_types_count == 0) {
            printf("Parece que algo correu mal...");
        } else {
            int **daily_stats = new_matrix(sensors_types_count, 4);

            if (daily_stats != NULL) {

                int to_control=0;

                //printf("num sens %i\n\n", sensors_types_count);


                printf("| Tipo de sensor       |      Mínimo      |      Máximo      |      Média       |Número de sensores|\n");

                if (*(values+0) != 0) {
                    get_statistics(dir_vento, *(values+0), *(daily_stats));
                    printf("| Direção vento        |        %-10i|        %-10i|        %-10i|        %-10i|\n", *(*daily_stats), *(*daily_stats+1), *(*daily_stats+2), *(*daily_stats+3));
                    to_control++;
                }

                if (*(values+1) != 0) {
                    get_statistics(temp, *(values+1), (daily_stats)[to_control]);
                    printf("| Temperatura          |        %-10i|        %-10i|        %-10i|        %-10i|\n", (*(*(daily_stats+to_control)+0)), (*(*(daily_stats+to_control)+1)), (*(*(daily_stats+to_control)+2)), (*(*(daily_stats+to_control)+3)));
                    to_control++;
                }


                if (*(values+2) != 0) {
                    get_statistics(pluvio, *(values+2), (daily_stats)[to_control]);
                    printf("| Pluviosidade         |        %-10i|        %-10i|        %-10i|        %-10i|\n", (*(*(daily_stats+to_control)+0)), (*(*(daily_stats+to_control)+1)), (*(*(daily_stats+to_control)+2)), (*(*(daily_stats+to_control)+3)));
                    to_control++;
                }


                if (*(values+3) != 0) {
                    get_statistics(velc_vento, *(values+3), (daily_stats)[to_control]);
                    printf("| Velocidade vento     |        %-10i|        %-10i|        %-10i|        %-10i|\n", (*(*(daily_stats+to_control)+0)), (*(*(daily_stats+to_control)+1)), (*(*(daily_stats+to_control)+2)), (*(*(daily_stats+to_control)+3)));
                    to_control++;
                }


                if (*(values+4) != 0) {
                    get_statistics(humd_solo, *(values+4), (daily_stats)[to_control]);
                    printf("| Humidade do solo     |        %-10i|        %-10i|        %-10i|        %-10i|\n", (*(*(daily_stats+to_control)+0)), (*(*(daily_stats+to_control)+1)), (*(*(daily_stats+to_control)+2)), (*(*(daily_stats+to_control)+3)));
                    to_control++;
                }


                if (*(values+5) != 0) {
                    get_statistics(humd_atm, *(values+5), (daily_stats)[to_control]);
                    printf("| Humidade atmosférica |        %-10i|        %-10i|        %-10i|        %-10i|\n", (*(*(daily_stats+to_control)+0)), (*(*(daily_stats+to_control)+1)), (*(*(daily_stats+to_control)+2)), (*(*(daily_stats+to_control)+3)));
                    to_control++;
                }

                printf("\n\n");
                /**for (int i = 0; i < 6; i++) {
                    for (int j = 0; j < 4; j++) {
                        printf("%i\n", (*(*(daily_stats+i)+j)));
                    }

                }*/
                char name[] = "matriz.txt";
                char name1[] = "sens.txt";
			

		        exportDataSensor(dir_vento, temp, pluvio, velc_vento, humd_solo, humd_atm, *(values+0), *(values+1),
                *(values+2), *(values+3),*(values+4), *(values+5), name1);
                exportMatrix(daily_stats, sensors_types_count, 4, name);
                free_double_pointer(daily_stats, sensors_types_count, 4);



            } else {
                printf("Ocurreu algum erro.");
            }
            
        }
    
        /*if (*(values+0) != 0 ) {            
            free_structs(dir_vento, *(values+0));
        }
        
        if (*(values+1) != 0 ) {            
            free_structs(temp, *(values+1));
        }

        if (*(values+2) != 0 ) {            
            free_structs(pluvio, *(values+2));
        }

        if (*(values+3) != 0 ) {            
            free_structs(velc_vento, *(values+3));
        }

        if (*(values+4) != 0 ) {            
             free_structs(humd_solo, *(values+4));
        }

        if (*(values+5) != 0 ) {            
            free_structs(humd_atm, *(values+5));
        }*/
        
        if (dir_vento != NULL) {            
            free_structs(dir_vento, *(values+0));
        }
        
        if (temp != NULL) {            
            free_structs(temp, *(values+1));
        }

        if (pluvio != NULL) {            
            free_structs(pluvio, *(values+2));
        }

        if (velc_vento != NULL) {            
            free_structs(velc_vento, *(values+3));
        }

        if (humd_solo != NULL) {            
             free_structs(humd_solo, *(values+4));
        }

        if (humd_atm != NULL) {            
            free_structs(humd_atm, *(values+5));
        }

	} else {
		printf("\n\nNão existem sensores.\n\n");
	}

    free(values);
    free(limits);
    return 0;
}
