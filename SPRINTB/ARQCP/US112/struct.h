#ifndef STRUCT_H
#define STRUCT_H

typedef struct {
    unsigned short id;
    char *sensor_type;
    char *unit_of_measurement;
    // o max e min representa o intervalo expectavel de leituras
    // isto é, por exemplo, para um dia de verão em Portugal o expectável
    // são temperaturas acima dos 0 graus celsius,
    // não se esperam temperaturas negativas, mas é possível que o sensor o leia
    unsigned short max_limit; // limites do sensor
    unsigned short min_limit;
    unsigned long frequency; // frequency de leituras (em segundos)
    unsigned long readings_size; // tamanho do array de leituras
    int *readings; // array de leituras diárias
    unsigned int errors; // número total de leituras que estão fora dos limites
    // ... // adicionar o que acharem conveniente
} Sensor;

#endif