# llc1080

qsub -I -q devel -l select=19:ncpus=20:model=ivy,walltime=2:00:00 -m abe
module load comp-intel mpi-hpe/mpt hdf4/4.2.12 hdf5/1.8.18_mpt netcdf/4.4.1.1_mpt

mkdir build
cd build
cp ../code/SIZE.h_snxxsnyxnprocs SIZE.h
../../MITgcm/tools/genmake2 -of=/home3/sreich/llc_hires/llc_1080/code/linux_amd64_ifort+mpi_ice_nas -mpi -mods=../code -rd=../../MITgcm
make depend
make -j 4
mv mitgcmuv mitgcmuv_snxxsnyxnprocs

mkdir run  
cd run  
cp ~/MITgcm_c68w/llc1080/build/mitgcmuv .  
ln -sf /nobackup/dmenemen/tarballs/llc_1080/run_template/* .  
ln -sf /nobackup/hzhang1/forcing/era5 .  
#ln -sf ~dmenemen/llc_1080/MITgcm/run_2011/pick*354240* .  
ln -sf ~dmenemen/llc_1080/4jan12/* .   
ln -sf /nobackup/dmenemen/forcing/SPICE/kernels .  
cp ~/MITgcm_c68w/llc1080/input/* .  
mv data.exch2_180x180x379 data.exch2  
mv data.exf_era5 data.exf  
mpiexec -n 379 ./mitgcmuv   


