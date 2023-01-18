#include <stdio.h>
#include <stdint.h>

#include "random.h"
#include "sens_dir_vento.h"
#include "sens_temp.h"
#include "sens_velc_vento.h"


int main() {


	char temp=20;
	unsigned short dir= 200;
	unsigned char velc = 15;

	for (int i = 0 ; i < 20; i++) {
		char random = pcg32_random_r();
		short random1 =pcg32_random_r();



		temp = sens_temp(temp,random);
		dir = sens_dir_vento(dir,random1);
		velc = sens_velc_vento(velc,random);


		printf("%d Temp \n", temp);
		printf("%d Dir \n", dir);
		printf("%d Velc \n",velc);
		printf("----\n");
	}


	return 0;
}