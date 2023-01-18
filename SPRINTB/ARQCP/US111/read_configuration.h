#ifndef _READ_CONFIGURATION_H_
#define _READ_CONFIGURATION_H_

// Size of the char array buffer.
#define BUFFER_SIZE 128

// The total number of sensors (each as is own frequency).
#define NUMBER_FREQUENCES 12

// The frequency variable name maximum size.
#define VARNAME_MAX_SIZE 20
#define SPLIT_CHAR ":"

// Declare the array parameters name to be available outside the module.
extern char parameters[][VARNAME_MAX_SIZE];

int* read_configuration_file(char*);
int get_sensor_varname(char*);
int* read_configuration(char*);

#endif