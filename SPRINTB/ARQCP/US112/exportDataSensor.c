#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include "struct.h"

void exportDataSensor(Sensor *dir_vento, Sensor *temp, Sensor *pluvio, Sensor *velc_vento, Sensor *humd_solo, Sensor *humd_atm,
 int n_dir_vento, int n_temp, int n_pluvio, int n_velc_vento, int n_humd_solo, int n_humd_atm, char *fileName){
    // Open a file for writing
    FILE *fp = fopen(fileName, "w");
    if (fp == NULL) {
        // Handle error
        return;
    }
    char *header[] = {
       "Id Sensor", "Tipo de Sensor", "Unidade de Medida", "Limite Máximo",
       "Limite Mínimo", "Frequencia de Leitura","Valor da Leitura","Leituras" ,"Erros"
    };

       /* fprintf(fp, "|        %-10s|        %-10s|        %-10s|        %-10s|        %-10s|        %-10s|        %-10s|        %-10s| ", header[0], header[1], header[2],
        header[3], header[4], header[5], header[6], header[7]);*/

      fprintf(fp, "%s,%s,%s,%s,%s,%s,%s,%s,%s\n", header[0], header[1], header[2],
        header[3], header[4], header[5], header[6], header[7], header[8]);
      int size;
      for (int i = 0; i < n_dir_vento; i++) {
           fprintf(fp, "%d,%s,%d,%d,%ld,%ld,", (*(dir_vento+i)).id, (*(dir_vento+i)).sensor_type, (*(dir_vento+i)).max_limit, (*(dir_vento+i)).min_limit,
                                                               (*(dir_vento+i)).frequency, (*(dir_vento+i)).readings_size);
            size = (*(dir_vento+i)).readings_size;
            for (int j = 0; j < size; j++) {
                  fprintf(fp, "%d,", (*(dir_vento+i)).readings[j]);
            }
            fprintf(fp, "%d\n", (*(dir_vento+i)).errors);
      }
      
      for (size_t i = 0; i < n_temp; i++) {            
            fprintf(fp, "%d,%s,%d,%d,%ld,%ld,", (*(temp+i)).id, (*(temp+i)).sensor_type, (*(temp+i)).max_limit, (*(temp+i)).min_limit,
                                                                  (*(temp+i)).frequency, (*(temp+i)).readings_size);
            size = (*(temp+i)).readings_size;
            for (int j = 0; j < size; j++) {
                  fprintf(fp, "%d,", (*(temp+i)).readings[j]);
            }
            fprintf(fp, "%d\n", (*(temp+i)).errors);
      }


      for (int i = 0; i < n_pluvio; i++) {
            fprintf(fp, "%d,%s,%d,%d,%ld,%ld,", (*(pluvio+i)).id, (*(pluvio+i)).sensor_type, (*(pluvio+i)).max_limit, (*(pluvio+i)).min_limit,
                                                            (*(pluvio+i)).frequency, (*(pluvio+i)).readings_size);
            size = (*(pluvio+i)).readings_size;
            for (int j = 0; j < size; j++) {
                  fprintf(fp, "%d,",(*(pluvio+i)).readings[j]);
            }
            fprintf(fp, "%d\n", (*(pluvio+i)).errors);
      }
      
            

      for (int i = 0; i < n_velc_vento; i++) {
            fprintf(fp, "%d,%s,%d,%d,%ld,%ld,", (*(velc_vento+i)).id, (*(velc_vento+i)).sensor_type, (*(velc_vento+i)).max_limit, (*(velc_vento+i)).min_limit,
                                                               (*(velc_vento+i)).frequency, (*(velc_vento+i)).readings_size);
            size = (*(velc_vento+i)).readings_size;
            for (int j = 0; j < size; j++) {
                     fprintf(fp, "%d,", (*(velc_vento+i)).readings[j]);
               }
            fprintf(fp, "%d\n", (*(velc_vento+i)).errors);
      }
      
        
      for (int i = 0; i < n_humd_solo; i++) {
            fprintf(fp, "%d,%s,%d,%d,%ld,%ld,", (*(humd_solo+i)).id, (*(humd_solo+i)).sensor_type,(*(humd_solo+i)).max_limit, (*(humd_solo+i)).min_limit,
                                                           (*(humd_solo+i)).frequency, (*(humd_solo+i)).readings_size);
            size = (*(humd_solo+i)).readings_size;
            for (int j = 0; j < size; j++) {
                     fprintf(fp, "%d,", (*(humd_solo+i)).readings[j]);
            }
            fprintf(fp, "%d\n", (*(humd_solo+i)).errors);
      }
      
      
      for (int i = 0; i < n_humd_atm; i++)
      {
            fprintf(fp, "%d,%s,%d,%d,%ld,%ld,",(*(humd_atm+i)).id, (*(humd_atm+i)).sensor_type, (*(humd_atm+i)).max_limit, (*(humd_atm+i)).min_limit,
                                                                (*(humd_atm+i)).frequency, (*(humd_atm+i)).readings_size);
            size = (*(humd_atm+i)).readings_size;
            for (int j = 0; j < size; j++) {
                  fprintf(fp, "%d,", (*(humd_atm+i)).readings[j]);
            }
            fprintf(fp, "%d\n", (*(humd_atm+i)).errors);
      }
      
       
       fclose(fp);

}
/*
printf("ID: %d\n", dir_vento->id);
               printf("Tipo de sensor: %s\n", dir_vento->sensor_type);
               printf("Unidade de medida: %s\n", dir_vento->unit_of_measurement);
               printf("Limite máximo: %d\n", dir_vento->max_limit);
               printf("Limite mínimo: %d\n", dir_vento->min_limit);
               printf("Frequência de leitura: %ld\n", dir_vento->frequency);
               printf("Tamanho do array de leituras: %ld\n", dir_vento->readings_size);
              for (int i = 0; i < dir_vento->readings_size; i++) {
                    printf("%d ", dir_vento->readings[i]);
                 }
                 printf("]\n");
                 printf("Erros: %d\n", dir_vento->errors);
                 */