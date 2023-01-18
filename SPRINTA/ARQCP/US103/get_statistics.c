#include <limits.h>
#include <stdlib.h>

int * get_statistics(int *vector, int size) {

	int minimum = INT_MAX;
	int maximum = INT_MIN;
	int average = 0;

	for (int i = 0; i < size; i++){
		if (minimum > *(vector+i)){
			minimum = *(vector+i);
		}
		
		if (maximum < *(vector+i)){
			maximum = *(vector+i);
		}

		average = average + *(vector+i);
	}

	average = average/size;

	int *pointer = (int *)malloc(3*sizeof(int));
	*pointer = minimum;
	*(pointer + 1) = maximum;
	*(pointer + 2) = average;

	return pointer;
}