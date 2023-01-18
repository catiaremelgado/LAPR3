#include <stdio.h>
#include <stdint.h>

#include "pcg32_random_r.h"
#include "sens_dir_vento.h"
#include "sens_temp.h"
#include "sens_velc_vento.h"
#include "sens_pluvio.h"
#include "sens_humd_atm.h"
#include "sens_humd_solo.h"
#include "reader.h"

uint64_t state=0;
uint64_t inc=0;

int main() {

    state = reader();
	inc = reader();

	char temp=20;
	unsigned short dir= 200;
	unsigned char velc = 15;
	unsigned char pluvio = 15;
	unsigned char atm = 15;
	unsigned char solo = 5;

	for (int i = 0 ; i < 20; i++) {
		char random = pcg32_random_r();
		short random1 =pcg32_random_r();



		temp = sens_temp(temp,random);
		dir = sens_dir_vento(dir,random1);
		velc = sens_velc_vento(velc,random);
		pluvio = sens_pluvio(pluvio,temp,random);
		atm = sens_humd_atm(atm,pluvio,random);
		solo = sens_humd_solo(solo,pluvio,random);


		printf("%d Temp \n", temp);
		printf("%d Dir \n", dir);
		printf("%d Velc \n",velc);
		printf("%d Pluvio \n",pluvio);
		printf("%d Atm \n",atm);
		printf("%d Solo \n",solo);
		printf("----\n");
	}


	return 0;
}