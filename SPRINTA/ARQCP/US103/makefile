# A Makefile with variables and suffix rules

# variaveis
INCLUDES = find_biggest_reads.h sens_humd_atm.h sens_humd_solo.h sens_pluvio.h sens_temp.h sens_dir_vento.h sens_velc_vento.h get_all_sensors_statistics.h get_statistics.h pcg32_random_r.h reader.h
SOURCES =  find_biggest_reads.c sens_humd_atm.s sens_humd_solo.s sens_pluvio.s sens_temp.s sens_dir_vento.s sens_velc_vento.s get_all_sensors_statistics.c get_statistics.c pcg32_random_r.s reader.c main.c
OBJFILES = find_biggest_reads.o sens_humd_atm.o sens_humd_solo.o sens_pluvio.o sens_temp.o sens_dir_vento.o sens_velc_vento.o get_all_sensors_statistics.o get_statistics.o pcg32_random_r.o reader.o main.o
EXEC = us103

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