# A Makefile with variables and suffix rules

# variaveis
INCLUDES = sens_temp.h pcg32_random_r.h sens_dir_vento.h sens_velc_vento.h sens_humd_atm.h sens_humd_solo.h sens_pluvio.h reader.h
SOURCES = sens_temp.s  pcg32_random_r.s sensor_testing.c sens_dir_vento.s sens_velc_vento.s sens_humd_atm.s sens_humd_solo.s sens_pluvio.s reader.c
OBJFILES = sens_temp.o pcg32_random_r.o sensor_testing.o sens_dir_vento.o sens_velc_vento.o sens_humd_atm.o sens_humd_solo.o sens_pluvio.o reader.o
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