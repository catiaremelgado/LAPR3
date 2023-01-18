INCLUDES = pcg32_random_r.h reader.h
SOURCES = pcg32_random_r.s reader.c main.c
OBJFILES = pcg32_random_r.o reader.o main.o
EXEC = main

.SUFFIXES : .c .o .s

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
