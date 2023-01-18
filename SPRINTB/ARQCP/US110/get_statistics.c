#include <limits.h>
#include <stdlib.h>
#include "struct.h"
#include <stdio.h>

void get_statistics(Sensor *sensors, int n_sensor, int * to_fill) {

	int minimum = INT_MAX;
	int maximum = INT_MIN;
	int average = 0;
	int size = (*(sensors)).readings_size;
	int control = 0;

	while (control != n_sensor) {

		int *vector = (*(sensors+control)).readings;

		/*int b = 0;
		printf("Leituras:\n");
		while (b != size) {
			printf("%i\n", *(vector+b));
			b++;
		}
		printf("\n\n\n");*/
		
		for (int i = 0; i < size; i++){
			if (minimum > *(vector+i)){
				minimum = *(vector+i);
			}
			
			if (maximum < *(vector+i)){
				maximum = *(vector+i);
			}

			average = average + *(vector+i);
		}
		control++;
	}

	//printf("minimo %i\nmaximo %i\nmedia %i\nsen %i\n\n\n", minimum, maximum, average/(size*n_sensor), n_sensor);

	*to_fill = minimum;
	*(to_fill + 1) = maximum;
	*(to_fill + 2) = average/(size*n_sensor);
	*(to_fill + 3) = n_sensor;
}