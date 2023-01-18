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
#include "update_freq_dir_vento_structs.h"
#include "update_freq_temp_structs.h"
#include "update_freq_pluvio_structs.h"
#include "update_freq_velc_vento_structs.h"
#include "update_freq_humd_solo_structs.h"
#include "update_freq_humd_atm_structs.h"
#include "add_dir_vento_readings.h"
#include "add_velc_vento_readings.h"
#include "add_humd_atm_readings.h"
#include "add_humd_solo_readings.h"
#include "add_temp_readings.h"
#include "add_pluvio_readings.h"
#include "delete_readings.h"

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
                /*or (int i = 0; i < 6; i++) {
                    for (int j = 0; j < 4; j++) {
                        printf("%i\n", (*(*(daily_stats+i)+j)));
                    }
                    
                }*/

                free_double_pointer(daily_stats, sensors_types_count, 4);

		        char answer;

                printf("Deseja alterar a frequência de algum sensor? - digite f\n");
                printf("Deseja acrescentar sensores? - digite a\n");
                printf("Deseja remover sensores (serão removidos os últimos inseridos)? - digite r\n");
                //printf("Pressione f se assim o desejar.\n");
                scanf("%s", &answer);

                int * daily_stats = ( int *) calloc (4 , sizeof (int));
                
                if(answer == 'f' || answer == 'F'){

                    printf("\nQual seria o valor da frequencia?\n");
                    int freq=0;
                    scanf("%i", &freq);

                    printf("\nInsira a letra correspondente ao sensor que terá a sua frequência alterada:\n\n");
                    printf("(a) %s\n", nome_dir_vento);
                    printf("(b) %s\n", nome_temp);
                    printf("(c) %s\n", nome_pluvio);
                    printf("(d) %s\n", nome_velc_vento);
                    printf("(e) %s\n", nome_humd_solo);
                    printf("(f) %s\n", nome_humd_atm);
			
                	scanf("%s", &answer);




                    if( freq > 0 && freq <= 8400){
                        if(answer == 'a' || answer == 'A'){


                            update_freq_dir_vento_structs(dir_vento, *(values+0), freq);

                            *(values+0+6) = freq;
                            printf("| Tipo de sensor       |      Mínimo      |      Máximo      |      Média       |Número de sensores|\n");

                            if (*(values+0) != 0) {
                                get_statistics(dir_vento, *(values+0), daily_stats);
                                printf("| Direção vento        |        %-10i|        %-10i|        %-10i|        %-10i|\n", *daily_stats, *daily_stats+1, *daily_stats+2, *daily_stats+3);
                            }

                        }else if(answer == 'b' || answer == 'B'){

                            update_freq_temp_structs(temp, *(values+1), freq);

                            *(values+1+6) = freq;
                            printf("| Tipo de sensor       |      Mínimo      |      Máximo      |      Média       |Número de sensores|\n");

                            if (*(values+1) != 0) {
                                get_statistics(temp, *(values+1), daily_stats);
                                printf("| Temperatura          |        %-10i|        %-10i|        %-10i|        %-10i|\n", *(daily_stats+0), *(daily_stats+1), *(daily_stats+2), *(daily_stats+3));

                            }
                        }else if(answer =='c' || answer == 'C'){
                            update_freq_pluvio_structs(pluvio, *(values+2), freq);

                            *(values+2+6) = freq;
                            printf("| Tipo de sensor       |      Mínimo      |      Máximo      |      Média       |Número de sensores|\n");

                            if (*(values+2) != 0) {
                                get_statistics(pluvio, *(values+2), daily_stats);
                                printf("| Pluviosidade         |        %-10i|        %-10i|        %-10i|        %-10i|\n", *(daily_stats+0), *(daily_stats+1), *(daily_stats+2), *(daily_stats+3));
                            }
                        }else if(answer == 'd' || answer == 'D'){
                            update_freq_velc_vento_structs(velc_vento, *(values+3), freq);

                            *(values+3+6) = freq;
                            printf("| Tipo de sensor       |      Mínimo      |      Máximo      |      Média       |Número de sensores|\n");

                            if (*(values+3) != 0) {
                                get_statistics(velc_vento, *(values+3), daily_stats);
                                printf("| Velocidade vento     |        %-10i|        %-10i|        %-10i|        %-10i|\n", *(daily_stats+0), *(daily_stats+1), *(daily_stats+2), *(daily_stats+3));
                            }
                        }else if(answer == 'e' || answer == 'E'){
                            update_freq_humd_solo_structs(humd_solo, *(values+4), freq);

                            *(values+4+6) = freq;
                            printf("| Tipo de sensor       |      Mínimo      |      Máximo      |      Média       |Número de sensores|\n");

                            if (*(values+4) != 0) {
                                get_statistics(humd_solo, *(values+4), daily_stats);
                                printf("| Humidade do solo     |        %-10i|        %-10i|        %-10i|        %-10i|\n", *(daily_stats+0), *(daily_stats+1), *(daily_stats+2), *(daily_stats+3));
                            }
                        }else if(answer == 'f' || answer == 'F'){
                            update_freq_humd_atm_structs(humd_atm, *(values+5), freq);

                            *(values+5+6) = freq;
                            printf("| Tipo de sensor       |      Mínimo      |      Máximo      |      Média       |Número de sensores|\n");

                            if (*(values+5) != 0) {
                                get_statistics(humd_atm, *(values+5), daily_stats);
                                printf("| Humidade atmosférica |        %-10i|        %-10i|        %-10i|        %-10i|\n", *(daily_stats+0), *(daily_stats+1), *(daily_stats+2), *(daily_stats+3));
                            }
                        }
					}

                }else if(answer == 'a' || answer == 'A'){

                    int quant=0;


                    printf("\nInsira a letra correspondente ao tipo de sensor que quer adicionar:\n\n");
                    printf("(a) %s\n", nome_dir_vento);
                    printf("(b) %s\n", nome_temp);
                    printf("(c) %s\n", nome_pluvio);
                    printf("(d) %s\n", nome_velc_vento);
                    printf("(e) %s\n", nome_humd_solo);
                    printf("(f) %s\n", nome_humd_atm);

                    scanf("%s", &answer);
                    printf("\nInsira o número de sensores a adicionar:\n\n");
                    scanf("%i", &quant);

                    if(answer == 'a' || answer == 'A'){


                        dir_vento=add_dir_vento_readings(dir_vento, *(values+0),quant,ids);

                        *(values+0) += quant;

                        printf("| Tipo de sensor       |      Mínimo      |      Máximo      |      Média       |Número de sensores|\n");

                        if (*(values+0) != 0) {
                            get_statistics(dir_vento, *(values+0), daily_stats);
                            printf("| Direção vento        |        %-10i|        %-10i|        %-10i|        %-10i|\n", *daily_stats, *(daily_stats+1), *(daily_stats+2), *(daily_stats+3));
                        }

                    }else if(answer == 'b' || answer == 'B'){

                        temp=add_temp_readings(temp, *(values+1),quant,ids);

                        *(values+1) += quant;

                        printf("| Tipo de sensor       |      Mínimo      |      Máximo      |      Média       |Número de sensores|\n");

                        if (*(values+1) != 0) {
                            get_statistics(temp, *(values+1), daily_stats);
                            printf("| Temperatura          |        %-10i|        %-10i|        %-10i|        %-10i|\n", *(daily_stats), *(daily_stats+1), *(daily_stats+2), *(daily_stats+3));

                        }
                    }else if(answer =='c' || answer == 'C'){

                       pluvio=add_pluvio_readings(pluvio, *(values+2),quant,ids);

                        *(values+2) += quant;

                        printf("| Tipo de sensor       |      Mínimo      |      Máximo      |      Média       |Número de sensores|\n");

                        if (*(values+2) != 0) {
                            get_statistics(pluvio, *(values+2), daily_stats);
                            printf("| Pluviosidade         |        %-10i|        %-10i|        %-10i|        %-10i|\n", *(daily_stats), *(daily_stats+1), *(daily_stats+2), *(daily_stats+3));
                        }
                    }else if(answer == 'd' || answer == 'D'){

                        velc_vento=add_velc_vento_readings(temp, *(values+3),quant,ids);

                        *(values+3) += quant;

                        printf("| Tipo de sensor       |      Mínimo      |      Máximo      |      Média       |Número de sensores|\n");

                        if (*(values+3) != 0) {
                            get_statistics(velc_vento, *(values+3),daily_stats);
                            printf("| Velocidade vento     |        %-10i|        %-10i|        %-10i|        %-10i|\n", *(daily_stats), *(daily_stats+1), *(daily_stats+2), *(daily_stats+3));
                        }
                    }else if(answer == 'e' || answer == 'E'){

                        humd_solo=add_humd_solo_readings(humd_solo, *(values+4),quant,ids);

                        *(values+4) += quant;

                        printf("| Tipo de sensor       |      Mínimo      |      Máximo      |      Média       |Número de sensores|\n");

                        if (*(values+4) != 0) {
                            get_statistics(humd_solo, *(values+4), daily_stats);
                            printf("| Humidade do solo     |        %-10i|        %-10i|        %-10i|        %-10i|\n", *(daily_stats), *(daily_stats+1), *(daily_stats+2), *(daily_stats+3));
                        }
                    }else if(answer == 'f' || answer == 'F'){

                        humd_atm=add_humd_atm_readings(temp, *(values+5),quant,ids);

                        *(values+5) += quant;
                        printf("| Tipo de sensor       |      Mínimo      |      Máximo      |      Média       |Número de sensores|\n");

                        if (*(values+5) != 0) {
                            get_statistics(humd_atm, *(values+5), daily_stats);
                            printf("| Humidade atmosférica |        %-10i|        %-10i|        %-10i|        %-10i|\n", *(daily_stats), *(daily_stats+1), *(daily_stats+2), *(daily_stats+3));
                        }
                    }

                }else if(answer == 'r' || answer == 'R'){

                    int quant=0;
                    int success=0;

                    printf("\nInsira a letra correspondente ao tipo de sensor que quer remover:\n\n");
                    printf("(a) %s\n", nome_dir_vento);
                    printf("(b) %s\n", nome_temp);
                    printf("(c) %s\n", nome_pluvio);
                    printf("(d) %s\n", nome_velc_vento);
                    printf("(e) %s\n", nome_humd_solo);
                    printf("(f) %s\n", nome_humd_atm);

                    scanf("%s", &answer);
                    printf("\nInsira o número de sensores a remover:\n\n");
                    scanf("%i", &quant);



                    if(answer == 'a' || answer == 'A'){

                        success=delete_readings(dir_vento, *(values+0),quant);

                        if(success==1){
                            *(values+0) -= quant;

                            printf("| Tipo de sensor       |      Mínimo      |      Máximo      |      Média       |Número de sensores|\n");

                            if (*(values+0) != 0) {
                                get_statistics(dir_vento, *(values+0), daily_stats);
                                printf("| Direção vento        |        %-10i|        %-10i|        %-10i|        %-10i|\n", *daily_stats, *(daily_stats+1), *(daily_stats+2), *(daily_stats+3));
                            }
                        }

                    }else if(answer == 'b' || answer == 'B'){

                        success=delete_readings(temp, *(values+1),quant);
                        if(success==1){
                            *(values+1) -= quant;

                            printf("| Tipo de sensor       |      Mínimo      |      Máximo      |      Média       |Número de sensores|\n");

                            if (*(values+1) != 0) {
                                get_statistics(temp, *(values+1), daily_stats);
                                printf("| Temperatura          |        %-10i|        %-10i|        %-10i|        %-10i|\n", *(daily_stats), *(daily_stats+1), *(daily_stats+2), *(daily_stats+3));

                            }
                        }
                    }else if(answer =='c' || answer == 'C'){

                        success=delete_readings(pluvio, *(values+2),quant);
                        if(success==1){
                            *(values+2) -= quant;

                            printf("| Tipo de sensor       |      Mínimo      |      Máximo      |      Média       |Número de sensores|\n");

                            if (*(values+2) != 0) {
                                get_statistics(pluvio, *(values+2), daily_stats);
                                printf("| Pluviosidade         |        %-10i|        %-10i|        %-10i|        %-10i|\n", *(daily_stats), *(daily_stats+1), *(daily_stats+2), *(daily_stats+3));
                            }
                        }
                    }else if(answer == 'd' || answer == 'D'){

                        success=delete_readings(velc_vento, *(values+3),quant);
                        if(success==1){
                            *(values+3) -= quant;

                            printf("| Tipo de sensor       |      Mínimo      |      Máximo      |      Média       |Número de sensores|\n");

                            if (*(values+3) != 0) {
                                get_statistics(velc_vento, *(values+3),daily_stats);
                                printf("| Velocidade vento     |        %-10i|        %-10i|        %-10i|        %-10i|\n", *(daily_stats), *(daily_stats+1), *(daily_stats+2), *(daily_stats+3));
                            }
                        }
                    }else if(answer == 'e' || answer == 'E'){

                        success=delete_readings(temp, *(values+4),quant);
                        if(success==1){
                            *(values+4) -= quant;

                            printf("| Tipo de sensor       |      Mínimo      |      Máximo      |      Média       |Número de sensores|\n");

                            if (*(values+4) != 0) {
                                get_statistics(humd_solo, *(values+4), daily_stats);
                                printf("| Humidade do solo     |        %-10i|        %-10i|        %-10i|        %-10i|\n", *(daily_stats), *(daily_stats+1), *(daily_stats+2), *(daily_stats+3));
                            }
                        }
                    }else if(answer == 'f' || answer == 'F'){

                        success=delete_readings(temp, *(values+5),quant);
                        if(success==1){
                            *(values+5) -= quant;
                            printf("| Tipo de sensor       |      Mínimo      |      Máximo      |      Média       |Número de sensores|\n");

                            if (*(values+5) != 0) {
                                get_statistics(humd_atm, *(values+5), daily_stats);
                                printf("| Humidade atmosférica |        %-10i|        %-10i|        %-10i|        %-10i|\n", *(daily_stats), *(daily_stats+1), *(daily_stats+2), *(daily_stats+3));
                            }
                        }
                    }

                    if(success==1){
                        printf("\nSensores removidos com sucesso!\n\n");

                    }else{
                        printf("\nSensores não foram removidos\n\n");
                    }
                }
                free(daily_stats);

            } else {
                printf("Ocorreu algum erro.\n\n");
            }

        }






    
        if (*(values+0) != 0 ) {
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
        }

        /*
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
        }*/

	} else {
		printf("\n\nNão existem sensores.\n\n");
	}

    free(values);
    free(limits);
    return 0;
}
