#include <stdlib.h>
#include "get_statistics.h"
#include "sens_dir_vento.h"
#include "sens_humd_solo.h"
#include "sens_humd_atm.h"
#include "sens_pluvio.h"
#include "sens_temp.h"
#include "sens_velc_vento.h"
#include <stdint.h>
#include "pcg32_random_r.h"
#include "reader.h"
#include "find_biggest_reads.h"
uint64_t state=0;
uint64_t inc=0;

void get_all_sensors_statistics(int * final_pointer, int freq_sens_temp, int  n_sens_temp, int  freq_sens_velc_vento, int  n_sens_velc_vento,
int freq_sens_dir_vento, int  n_sens_dir_vento, int  freq_sens_humd_atm, int  n_sens_humd_atm, int  freq_sens_humd_solo, int  n_sens_humd_solo,
int freq_sens_pluvio, int n_sens_pluvio){
	state = reader();
	inc = reader(); 
	
	/* Initialize value for temperature*/
	int last_value = 16;
	/* Find the sensor type that together will have more values, because that one will make the biggest array */
	int freq = find_biggest_reads(freq_sens_temp, n_sens_temp, freq_sens_velc_vento, n_sens_velc_vento,
			freq_sens_dir_vento, n_sens_dir_vento, freq_sens_humd_atm, n_sens_humd_atm, freq_sens_humd_solo, n_sens_humd_solo, 
			freq_sens_pluvio, n_sens_pluvio);

	int size = freq;
	int matrix[size];
	int * p;
	p = matrix;

	int last_value2 = 0;
	char last_value3 = 16;

	int ma[3] = {0};
	int * point;
	point = ma;

	if(freq_sens_temp != 0 && n_sens_temp != 0){
		
		/* data of temperature sensor */
		size = ((24*60)/(freq_sens_temp))*n_sens_temp;

		for (int i = 0; i < size; i++) {
			last_value = (int) sens_temp((char) last_value, pcg32_random_r());
			*(p+i) = last_value;
		}

		
		point = get_statistics(p, size);
		
		for (int i = 0; i < 3; i++) {
			*(final_pointer+i) = *(point+i);
		}
	
		free(point);
	}

	if (freq_sens_velc_vento != 0 && n_sens_velc_vento != 0) {
		
		/* data for velocidade vento */
		last_value = 1;
		size = ((24*60)/(freq_sens_velc_vento))*n_sens_velc_vento;

		for (int i = 0; i < size; i++) {
			last_value = (int) sens_velc_vento((unsigned char) last_value, (char) pcg32_random_r());
			*(p+i) = last_value;
		}
		
		point = get_statistics(p, size);

		for (int i = 0; i < 3; i++) {
			*(final_pointer+(3+i)) = *(point+i);
		}

		free(point);
	}

	if (freq_sens_dir_vento != 0 && n_sens_dir_vento != 0){

		/* data for direcao vento */
		last_value = 1;
		size = ((24*60)/(freq_sens_dir_vento))*n_sens_dir_vento;

		for (int i = 0; i < size; i++) {
			last_value = (int) sens_dir_vento((unsigned short) last_value, (short) pcg32_random_r());
			*(p+i) = last_value;
		}
		
		point = get_statistics(p, size);

		for (int i = 0; i < 3; i++) {
			*(final_pointer+6+i) = *(point+i);
		}
		free(point);
	}

	if (freq_sens_humd_atm != 0 && n_sens_humd_atm != 0){
		
		/* data for humidade atmosferica */
		last_value = 1;
		last_value2 = 0;
		last_value3 = 16;
		size = ((24*60)/(freq_sens_humd_atm))*n_sens_humd_atm;

		for (int i = 0; i < size; i++) {
			last_value3 = sens_temp((char) last_value3, (char) pcg32_random_r());
			last_value2 = (int) sens_pluvio((unsigned char) last_value2, last_value3, (char) pcg32_random_r());
			last_value = (int) sens_humd_atm((unsigned char) last_value, (char) last_value2,(char) pcg32_random_r());
			*(p+i) = last_value;
		}


		point = get_statistics(p, size);

		for (int i = 0; i < 3; i++) {
			*(final_pointer+9+i) = *(point+i);
		}
		free(point);
	}

	if (freq_sens_humd_solo != 0 && n_sens_humd_solo != 0){

		/* data for humidade solo */
		last_value = 1;
		last_value2 = 1;
		last_value3 = 16;
		size = ((24*60)/(freq_sens_humd_solo))*n_sens_humd_solo;

		for (int i = 0; i < size; i++) {
			last_value3 = sens_temp(last_value3, (char) pcg32_random_r());
			last_value2 = (int) sens_pluvio((unsigned char) last_value2, last_value3, (char) pcg32_random_r());
			last_value = (int) sens_humd_solo((unsigned char) last_value2,(char) last_value3, (char) pcg32_random_r());
			*(p+i) = last_value;
		}

		point = get_statistics(p, size);

		for (int i = 0; i < 3; i++) {
			*(final_pointer+12+i) = *(point+i);
		}
		free(point);
	}

	if (freq_sens_pluvio != 0 && n_sens_pluvio != 0){
		
		/* data for pluviosidade*/
		last_value = 1;
		last_value3 = 16;
		size = ((24*60)/(freq_sens_pluvio))*n_sens_pluvio;

		for (int i = 0; i < size; i++) {
			last_value3 = sens_temp(last_value3, (char) pcg32_random_r());
			last_value = (int) sens_pluvio((unsigned char) last_value, (char) last_value3, (char) pcg32_random_r());
			*(p+i) = last_value;
		}

		point = get_statistics(p, size);

		for (int i = 0; i < 3; i++) {
			*(final_pointer+15+i) = *(point+i);
		}
		free(point);
	}
}