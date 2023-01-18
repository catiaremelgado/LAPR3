#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <string.h>
#include "get_all_sensors_statistics.h"

int freq_sens_temp = 6;
int freq_sens_velc_vento = 7;
int freq_sens_dir_vento = 7;
int freq_sens_humd_atm = 15;
int freq_sens_humd_solo = 13;
int freq_sens_pluvio = 60;

int n_sens_temp = 1;
int n_sens_velc_vento = 1;
int n_sens_dir_vento = 1;
int n_sens_humd_atm = 1;
int n_sens_humd_solo = 1;
int n_sens_pluvio = 1;

int main() {

	if (freq_sens_temp == 0){
		n_sens_temp = 0;
		freq_sens_temp = 60;
	}
	if (freq_sens_velc_vento == 0){
		n_sens_velc_vento = 0;
		freq_sens_velc_vento = 60;
	}
	if (freq_sens_dir_vento == 0){
		n_sens_dir_vento = 0;
		freq_sens_dir_vento = 60;
	}
	if (freq_sens_humd_atm == 0){
		n_sens_humd_atm = 0;
		freq_sens_humd_atm=60;
	}
	if (freq_sens_humd_solo == 0){
		n_sens_humd_solo = 0;
		freq_sens_humd_solo=60;
	}
	if (freq_sens_pluvio == 0){
		n_sens_pluvio = 0;
		freq_sens_pluvio=60;
	}

	if (n_sens_temp + n_sens_velc_vento + n_sens_dir_vento + n_sens_humd_atm + n_sens_humd_solo + n_sens_pluvio != 0){
		
		int * pointer;
		pointer = (int *)malloc(18 * sizeof(int));

		if (pointer == NULL) {
			printf("Tente novamente.\n");
		
		} else {

			int *pointer_temp;
			pointer_temp = pointer;

			get_all_sensors_statistics(pointer_temp, freq_sens_temp, n_sens_temp, freq_sens_velc_vento, n_sens_velc_vento,
				freq_sens_dir_vento, n_sens_dir_vento, freq_sens_humd_atm, n_sens_humd_atm, freq_sens_humd_solo, n_sens_humd_solo, 
				freq_sens_pluvio, n_sens_pluvio);


			printf("\n");
		
			printf("----------------------------------------------------------------------------------------------------\n");
			printf("|                      |      Mínimo      |      Máximo      |      Média       |Número de sensores|\n");	
			if (n_sens_temp != 0)
			{
				printf("| Temperatura          |        %-10i|        %-10i|        %-10i|        %-10i|\n", *(pointer_temp), *(pointer_temp+1), *(pointer_temp+2), n_sens_temp);
			}
			if (n_sens_velc_vento != 0)
			{
				printf("| Velocidade vento     |        %-10i|        %-10i|        %-10i|        %-10i|\n", *(pointer_temp+3), *(pointer_temp+4), *(pointer_temp+5), n_sens_velc_vento);	
			}
			if (n_sens_dir_vento != 0)
			{
				printf("| Direção vento        |        %-10i|        %-10i|        %-10i|        %-10i|\n", *(pointer_temp+6), *(pointer_temp+7), *(pointer_temp+8), n_sens_dir_vento);
			}
			if (n_sens_humd_atm != 0)
			{
				printf("| Humidade atmosférica |        %-10i|        %-10i|        %-10i|        %-10i|\n", *(pointer_temp+9), *(pointer_temp+10), *(pointer_temp+11), n_sens_humd_atm);
			}
			if (n_sens_humd_solo != 0)
			{
				printf("| Humidade do solo     |        %-10i|        %-10i|        %-10i|        %-10i|\n", *(pointer_temp+12), *(pointer_temp+13), *(pointer_temp+14), n_sens_humd_solo);
			}
			if (n_sens_pluvio != 0)
			{
				printf("| Pluviosidade         |        %-10i|        %-10i|        %-10i|        %-10i|\n", *(pointer_temp+15), *(pointer_temp+16), *(pointer_temp+17), n_sens_pluvio);
			}
			printf("----------------------------------------------------------------------------------------------------\n\n\n");

    	}

		free(pointer);

	} else {
		printf("\n\nNão há um único tipo de sensor para fazer estatística.\n\n");
	}
	return 0;
}