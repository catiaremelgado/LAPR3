#include <stdio.h>
#include <string.h>
#include <stdlib.h>

void exportMatrix(int **daily_stats, int rows, int columns, char *fileName) {
//Direção vento, Temperatura, Pluviosidade, Velocidade Tempo, Humidade do Solo, Humidade Atmosférica
    char *sensorName[5];
    sensorName[0] = " Direção vento        ";
    sensorName[1] = " Temperatura          ";
    sensorName[2] = " Pluviosidade         ";
    sensorName[3] = " Velocidade vento     ";
    sensorName[4] = " Humidade do solo     ";
    sensorName[5] = " Humidade atmosférica ";

    // Open a file for writing
    FILE *fp = fopen(fileName, "w");
    if (fp == NULL) {
        // Handle error
        return;
    }

    // Write the header row
    fprintf(fp, "| Tipo de sensor           |      Mínimo      |      Máximo      |      Média       |Número de sensores|\n");
    //alinhar os valores todos em colunas

    // Write the data to the file
    for (int i = 0; i < rows; i++) {
        // Write the sensor name and unit
        fprintf(fp, "|%-11s    |", sensorName[i]);
        // Write the stats for this sensor
        for (int j = 0; j < columns; j++) {
            fprintf(fp, "        %-10i|", daily_stats[i][j]);
            if ((j+1) % 4 == 0) {
               fprintf(fp, "\n");
            }
        }

    }

    // Close the file
    fclose(fp);

   /** for (int i = 0; i < rows; i++) {
      free(*(daily_stats + i));
    }
    free(daily_stats);
    */
    //free(sensorName);


}
