int count_errors(int *verify, int size, int min_lim, int max_lim){
	int i = 0;
	int counter = 0;
	while (i < size) {
		if (*(verify+i)<min_lim || *(verify+i)>max_lim) {
			counter++;
		}
		i++;
	}
	
	return counter;
}