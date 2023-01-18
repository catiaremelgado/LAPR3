#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "read_configuration.h"

char parameters[][VARNAME_MAX_SIZE] = {
    "n_sens_dir_vento",
    "n_sens_temp",
    "n_sens_pluvio",
    "n_velc_vento",
    "n_sens_humd_solo",
    "n_sens_humd_atm",
    "f_sens_dir_vento",
    "f_sens_temp",
    "f_sens_pluvio",
    "f_velc_vento",
    "f_sens_humd_solo",
    "f_sens_humd_atm"
};

int get_sensor_varname(char* sensor) {

    for (int i = 0; i < NUMBER_FREQUENCES; i++) {
        if (strcmp(sensor, parameters[i]) == 0) {
            return i;
        }
    }

    return -1;
}

int* read_configuration_file(char* filename) {

    FILE *file = NULL;
    char *token, buffer[BUFFER_SIZE];
    int i, *values = (int*) malloc(sizeof(int) *NUMBER_FREQUENCES);

    // Initialize the values array.
    for (i = 0; i < NUMBER_FREQUENCES; i++) {
        values[i] = -1;
    }

    // Open file filename in reading mode.
    if ((file = fopen(filename, "r")) == NULL) {
        return values;
    }

    // Discard of the 1st line.
    fgets(buffer, BUFFER_SIZE - 1, file);

    // Read values from file, until END OF FILE (EOF).
    i = 0;
    while(fgets(buffer, BUFFER_SIZE - 1, file) != NULL) {
        
        token = strtok(buffer, SPLIT_CHAR);
        int index = token != NULL ? get_sensor_varname(token) : -1;

        if (index >= 0) {
            token = strtok(NULL, SPLIT_CHAR);
            int frequence = token != NULL ? atoi(token) : -1; //convert string to integer
            values[i++] = frequence > 0 ? frequence : -1;
        }
    }
    fclose(file);
    return values;
}

int * read_configuration(char *filename) {
    int value;

    int *values = read_configuration_file(filename); 

    for (int i = 0; i < NUMBER_FREQUENCES; i++) {
        if (values[i] == -1) {
            printf ("%s: ", parameters[i]);
            scanf("%d", &value);
            values[i] = value;
        }
    }

    return values;
}