#ifndef _READ_CONFIGURATION_LIMITS
#define _READ_CONFIGURATION_LIMITS

// Size of the char array buffer.
#define BUFFER_SIZE_LIMITS 128

// The total number of sensors (each as is own frequency).
#define NUMBER_FREQUENCES_LIMITS 12

// The frequency variable name maximum size.
#define VARNAME_MAX_SIZE_LIMITS 25
#define SPLIT_CHAR ":"

// Declare the array parameters name to be available outside the module.
extern char parameters_limits[][VARNAME_MAX_SIZE_LIMITS];

int* read_configuration_file_limits(char*);
int get_sensor_varname_limits(char*);
int* read_configuration_limits(char*);
int check_if_only_spaces(char *);

#endif