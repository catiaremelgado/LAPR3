#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <limits.h>

#include "read_configuration_limits.h"

char parameters_limits[][VARNAME_MAX_SIZE_LIMITS] = {
"lim_min_dir_vent",
"lim_max_dir_vent",
"lim_min_temp",
"lim_max_temp",
"lim_min_pluvio",
"lim_max_pluvio",
"lim_min_vel_vent",
"lim_max_vel_vent",
"lim_min_humd_solo",
"lim_max_humd_solo",
"lim_min_humd_atm",
"lim_max_humd_atm"
};

int get_sensor_varname_limits(char* sensor) {

    for (int i = 0; i < NUMBER_FREQUENCES_LIMITS; i++) {
        if (strcmp(sensor, parameters_limits[i]) == 0) {
            return i;
        }
    }

    return -1;
}

int* read_configuration_file_limits(char* filename) {

    //int control = INT_MAX;
    FILE *file = NULL;
    char *token, buffer[BUFFER_SIZE_LIMITS];
    int i, *values = (int*) malloc(sizeof(int) *NUMBER_FREQUENCES_LIMITS);

    // Open file filename in reading mode.
    if ((file = fopen(filename, "r")) == NULL) {
        return values;
    }

    // Discard of the 1st line.
    fgets(buffer, BUFFER_SIZE_LIMITS - 1, file);

    // Read values from file, until END OF FILE (EOF).
    i = 0;
    while(fgets(buffer, BUFFER_SIZE_LIMITS - 1, file) != NULL) {
        
        token = strtok(buffer, SPLIT_CHAR);
        int index = token != NULL ? get_sensor_varname_limits(token) : -1;

        if (index >= 0) {
            
            token = strtok(NULL, SPLIT_CHAR);

            int is = check_if_only_spaces(token);

            if (is == 1) {
                token = NULL; }
            
            
            int frequence = token != NULL ? atoi(token) : INT_MAX; //convert string to integer
            values[i++] = frequence;
           
        }
    }
    fclose (file);
    return values;
}

int * read_configuration_limits(char *filename) {
    int value;
    int value_two;
    int *values = read_configuration_file_limits(filename); 

    for (int i = 0; i < NUMBER_FREQUENCES_LIMITS; i++) {
        if (values[i] == INT_MAX) {
            printf ("%s: ", parameters_limits[i]);
            scanf("%d", &value);
            values[i] = value;
        }
    }

    for (int i = 0; i < NUMBER_FREQUENCES_LIMITS-1; i= i + 2) {
        while (*(values+i) > *(values+i+1)) {
           printf("O valor mínimo não pode ser maior que o máximo, insira novamente os valores:\n");
           printf ("%s: ", parameters_limits[i]);
           scanf("%d", &value);
           printf ("%s: ", parameters_limits[i+1]);
           scanf("%d", &value_two);
           printf("\n");
           *(values+i) = value;
           *(values+i+1) = value_two;           
        }
    }
    
    return values;
}

int check_if_only_spaces(char * token){
    int is = 1;
    int i = 0;

    /*printf("estou no spaces\n");
    while (*(token+i)!='\0')
    {
       printf("%d\n", *(token+i));
       i++;
    }*/
    
    i = 0;
    // to print ascii code: %d
    // 10 and 13 are control characters that have no relevance for this problem
    // https://www.ascii-code.com/
     
    while (is == 1 && *(token+i) != '\0') {
        if (*(token+i) != 32 && *(token+i)!= 10  && *(token+i)!= 13) {
            is = 0;
        }
        i++;
    }
    
    return is;
}