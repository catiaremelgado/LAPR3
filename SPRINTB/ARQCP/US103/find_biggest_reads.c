int find_biggest_reads(int freq_sens_temp, int  n_sens_temp, int  freq_sens_velc_vento, int  n_sens_velc_vento,
int freq_sens_dir_vento, int  n_sens_dir_vento, int  freq_sens_humd_atm, int  n_sens_humd_atm, int  freq_sens_humd_solo,
int  n_sens_humd_solo, int freq_sens_pluvio, int  n_sens_pluvio){

	int smallest = 0;
	int day = 24*60;

	
	if (smallest <  (day/freq_sens_temp)*n_sens_temp && n_sens_temp != 0 && freq_sens_temp != 0){
		smallest = (day/freq_sens_temp)*n_sens_temp;
	}

	if (smallest <  (day/freq_sens_velc_vento)*n_sens_velc_vento && n_sens_velc_vento != 0 && freq_sens_velc_vento != 0 ){
		smallest = (day/freq_sens_velc_vento)*n_sens_velc_vento;
	}
	

	if (smallest <  (day/freq_sens_dir_vento)*n_sens_dir_vento && n_sens_dir_vento != 0 && freq_sens_dir_vento != 0){
		smallest = (day/freq_sens_dir_vento)*n_sens_dir_vento;
	}
	

	if (smallest <  (day/freq_sens_humd_atm)*n_sens_humd_atm && n_sens_humd_atm != 0 && freq_sens_humd_atm != 0){
		smallest = (day/freq_sens_humd_atm)*n_sens_humd_atm;
	}
	

	if (smallest <  (day/freq_sens_humd_solo)*n_sens_humd_solo && n_sens_humd_solo != 0  && freq_sens_humd_solo != 0){
		smallest = (day/freq_sens_humd_solo)*n_sens_humd_solo;
	}

	if (smallest <  (day/freq_sens_pluvio)*n_sens_pluvio && n_sens_pluvio != 0  && freq_sens_pluvio != 0){
		smallest = (day/freq_sens_pluvio)*n_sens_pluvio;
	}

	return smallest;	
}