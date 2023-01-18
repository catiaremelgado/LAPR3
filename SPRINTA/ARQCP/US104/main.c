#include <stdio.h>
#include <stdint.h>

#include "pcg32_random_r.h"
#include "reader.h"
#include "sens_dir_vento.h"
#include "sens_temp.h"
#include "sens_velc_vento.h"
#include "sens_humd_solo.h"
#include "sens_humd_atm.h"
#include "sens_pluvio.h"

uint64_t state=0;
uint64_t inc=0;

void checkValuesSensTemp(char limMin,char limMax,int N){
	 state = reader();
     inc = reader();
	int count=N;
	char temp=15;


	while(count>0){
       char random = pcg32_random_r();
       temp=sens_temp(temp,random);

      if(temp<limMin || temp>limMax){
         printf("Error: Sens Temp with a value not in the interval\n");
         count--;
      }else{
          printf("%d\n",temp);}
	}
}


void checkValuesSensDir(unsigned short limMin,unsigned short limMax,int N){
	
	int count=N;
	unsigned short dir=155;

	
	while(count>0){
		short random = pcg32_random_r();
		dir=sens_dir_vento(dir,random);
		
		if(dir<limMin || dir>limMax){
			printf("Error: Sens Dir with a value not in the interval\n");
			count--;
		}else{
		printf("%d\n",dir);}
	}
}


void checkValuesSensVelc(unsigned char limMin,unsigned char limMax,int N){
	
	int count=N;
	unsigned char velc=15;
	
	while(count>0){
		char random = pcg32_random_r();
		velc = sens_velc_vento(velc,random);
		
		if(velc<limMin || velc>limMax){
			printf("Error: Sens Velc with a value not in the interval\n");
			count--;
		}else{
		printf("%d\n",velc);}
	}
}

//unsigned char sens_pluvio(unsigned char ult_pluvio, char ult_temp, char comp_rand);
void checkValuesSensPluvio(unsigned char limMin,unsigned char limMax,int N){

    int count=N;
    unsigned char pluvio=15;
    char temp=15;

    while(count>0){
        char random = pcg32_random_r();
        pluvio=sens_pluvio(pluvio,temp,random);

        if(pluvio<limMin || pluvio>limMax){
            printf("Error: Sens Pluvio with a value not in the interval\n");
            count--;
        }else{
        printf("%d\n",pluvio);}
    }
}
//unsigned char sens_humd_solo(unsigned char ult_hmd_solo, unsigned char ult_pluvio, char comp_rand);
 void checkValuesSensHumdsolo(unsigned char limMin, unsigned char limMax,int N){
	
	int count=N;
	char temp=15;
	int pluvio = 10;
	
	while(count>0){
		char random = pcg32_random_r();
		char auxTemp = sens_temp(temp, (char) random);
        pluvio = (int) sens_pluvio((unsigned char) pluvio, auxTemp, (char) random);

		if(pluvio<limMin || pluvio>limMax){
			printf("Error: Sens Velc with a value not in the interval\n");
			count--;
		}else{
		printf("%d\n",pluvio);}
	}
}


void checkValuesSensHumdatm(unsigned char limMin,unsigned char limMax,int N){

    int count=N;
    int atm=15;
    char temp=15;
    int auxPluvio = 10;


     while(count>0){
        char random = pcg32_random_r();
        temp = (char) sens_temp(temp, (char) random);
        auxPluvio = (int) sens_pluvio((unsigned char) auxPluvio, temp, (char) random);
        atm = (int) sens_humd_atm((unsigned char) atm, (unsigned char) auxPluvio, (char) random);

        if(atm<limMin || atm>limMax){
            printf("Error: Sens humd atm with a value not in the interval\n " );
            count--;
        }else{
        printf("%d\n",atm);
        }
     }


}


int main(){
     state = reader();
     inc = reader();

    printf("------------\n");
	printf(" SENS TEMP: \n");
	printf("------------\n");

	checkValuesSensTemp(10,20,5);

	printf("------------\n");
	printf(" SENS DIR: \n");
	printf("------------\n");

	checkValuesSensDir(100,200,5);

	printf("------------\n");
	printf(" SENS VELC: \n");
	printf("------------\n");

	checkValuesSensVelc(10,20,5);

    printf("------------\n");
	printf(" SENS HUMD SOLO: \n");
	printf("------------\n");

	checkValuesSensHumdsolo(10,30,5);

	printf("------------\n");
	printf(" SENS HUMD ATM: \n");
	printf("------------\n");

    checkValuesSensHumdatm(40,50,3);


	printf("------------\n");
	printf(" SENS Pluvio: \n");
	printf("------------\n");

	checkValuesSensPluvio(10,20,5);

	return 0;
}

/**
/usr/bin/ld: main.o: in function `main':
/media/sf_partilha/testing/main.c:135: undefined reference to `reader'

collect2: error: ld returned 1 exit status
make: *** [makefile:20: prog] Error 1
*/
//

// I'm trying to use the pcg32_random_r() function to generate random numbers, but I'm getting the following error: undefined reference to `reader'



