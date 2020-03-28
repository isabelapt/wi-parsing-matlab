rx=;
filename_cir='';
ilename_paths='';




[powerpaths_dbm,powerphase_deg,rx_paths] =cir_insite(rx,filename_cir,paths_max,rx_max);
[total_paths,paths_summary] = paths_insite(rx,rx_paths,filename_paths,paths_max);