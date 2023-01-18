# A Makefile with variables and suffix rules

# variaveis
INCLUDES = pcg32_random_r.h reader.h read_configuration.h read_configuration_limits.h struct.h fill_dir_vento_structs.h sens_dir_vento.h fill_temp_structs.h sens_temp.h fill_pluvio_structs.h sens_pluvio.h fill_velc_vento_structs.h sens_velc_vento.h fill_humd_solo_structs.h sens_humd_solo.h fill_humd_atm_structs.h sens_humd_atm.h new_matrix.h get_statistics.h free_structs.h free_double_pointer.h add_dir_vento_readings.h delete_readings.h add_humd_atm_readings.h add_pluvio_readings.h add_temp_readings.h add_velc_vento_readings.h add_humd_solo_readings.h update_freq_dir_vento_structs.h update_freq_temp_structs.h update_freq_pluvio_structs.h update_freq_velc_vento_structs.h update_freq_humd_solo_structs.h update_freq_humd_atm_structs.h count_errors.h

SOURCES = pcg32_random_r.s reader.c read_configuration.c read_configuration_limits.c main.c fill_dir_vento_structs.c sens_dir_vento.s fill_temp_structs.c sens_temp.s fill_pluvio_structs.c sens_pluvio.s fill_velc_vento_structs.c sens_velc_vento.s fill_humd_solo_structs.c sens_humd_solo.s fill_humd_atm_structs.c sens_humd_atm.s new_matrix.c get_statistics.c free_structs.c free_double_pointer.c add_dir_vento_readings.c delete_readings.c add_humd_atm_readings.c add_pluvio_readings.c add_temp_readings.c add_velc_vento_readings.c add_humd_solo_readings.c update_freq_dir_vento_structs.c update_freq_temp_structs.c update_freq_pluvio_structs.c update_freq_velc_vento_structs.c update_freq_humd_solo_structs.c update_freq_humd_atm_structs.c count_errors.c

OBJFILES = pcg32_random_r.o reader.o read_configuration.o read_configuration_limits.o main.o fill_dir_vento_structs.o sens_dir_vento.o fill_temp_structs.o sens_temp.o fill_pluvio_structs.o sens_pluvio.o fill_velc_vento_structs.o sens_velc_vento.o fill_humd_solo_structs.o sens_humd_solo.o fill_humd_atm_structs.o sens_humd_atm.o new_matrix.o get_statistics.o free_structs.o free_double_pointer.o add_dir_vento_readings.o delete_readings.o add_humd_atm_readings.o add_pluvio_readings.o add_temp_readings.o add_velc_vento_readings.o add_humd_solo_readings.o update_freq_dir_vento_structs.o update_freq_temp_structs.o update_freq_pluvio_structs.o update_freq_velc_vento_structs.o update_freq_humd_solo_structs.o update_freq_humd_atm_structs.o count_errors.o

EXEC = prog

# Suffix rules
.SUFFIXES : .c .o .s

# How to build an object .o from a code file .c ; $< -- file name
.c.o:
	gcc -Wall -g -c $<

.s.o:
	gcc -Wall -g -c $<

${EXEC}: ${OBJFILES}
	gcc -Wall -g -o ${EXEC} ${OBJFILES}

${OBJFILES}: ${SOURCES} ${INCLUDES}

run: ${EXEC}
	./${EXEC}

clean:
	rm -f ${OBJFILES} ${EXEC}
