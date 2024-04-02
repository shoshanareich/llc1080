# llc1080

mkdir run  
cd run  
cp ~/MITgcm_c68w/llc1080/build/mitgcmuv .  
ln -sf /nobackup/dmenemen/tarballs/llc_1080/run_template/* .  
ln -sf /nobackup/hzhang1/forcing/era5 .  
ln -sf ~dmenemen/llc_1080/MITgcm/run_2011/pick*354240* .  
ln -sf /nobackup/dmenemen/forcing/SPICE/kernels .  
cp ~/MITgcm_c68w/llc1080/input/* .  
mv data.exch2_180x180x379 data.exch2  
mv data.exf_era5 data.exf  
mpiexec -n 379 ./mitgcmuv   


