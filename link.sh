
#--- 0.load modules ------
#ulimit -s unlimited
module purge
module load comp-intel/2018.3.222
module load szip/2.1.1
module load mpi-hpe/mpt
module load hdf4/4.2.12
module load hdf5/1.8.18_mpt
module load netcdf/4.4.1.1_mpt

echo $LD_LIBRARY_PATH

ulimit -s hard
ulimit -u hard

#---- 1.set variables ------
#note for bash: can not have any space around =

nprocs=1342
snx=90
sny=90
#pickupts1="0001051920"
extpickup=
forwadj=

# --------------------------------------------
#whichcode="_ad_obsfit"
whichcode=
# --------------------------------------------

jobfile=submit${whichcode}.bash

#--- 2.set dir ------------
basedir=/home3/sreich/MITgcm_c68w/llc1080/
scratchdir=/nobackup/sreich/llc1080_c68w_runs/
codedir=$basedir/code${whichcode}
builddir=$basedir/build${whichcode}_${snx}x${sny}x${nprocs}
inputdir=$basedir/input${whichcode}

workdir=$scratchdir/run${whichcode}

mkdir $workdir
cd $workdir


#--- 3. link forcing -------------
ln -sf /nobackup/hzhang1/forcing/era5 .

#--- 4. linking binary ---------

ln -sf /nobackup/dmenemen/tarballs/llc_1080/run_template/* .
ln -sf /nobackup/dmenemen/forcing/SPICE/kernels .
ln -sf /home6/dmenemen/llc_1080/4jan12/Eta.0000703680.data .
ln -sf /home6/dmenemen/llc_1080/4jan12/Salt.0000703680.data .
ln -sf /home6/dmenemen/llc_1080/4jan12/Theta.0000703680.data .
ln -sf /home6/dmenemen/llc_1080/4jan12/U.0000703680.data .
ln -sf /home6/dmenemen/llc_1080/4jan12/V.0000703680.data .
ln -sf /home6/dmenemen/llc_1080/4jan12/SIarea.0000703680.data .
ln -sf /home6/dmenemen/llc_1080/4jan12/SIhsnow.0000703680.data .
ln -sf /home6/dmenemen/llc_1080/4jan12/SIhsalt.0000703680.data .
ln -sf /home6/dmenemen/llc_1080/4jan12/SIheff.0000703680.data .
ln -sf /home6/dmenemen/llc_1080/4jan12/SIuice.0000703680.data .
ln -sf /home6/dmenemen/llc_1080/4jan12/SIvice.0000703680.data .



#
#=================================================================================
#--- 6. NAMELISTS ---------
cp -f ${inputdir}/* .
mv data.exch2_180x180x379 data.exch2
mv data.exf_era5 data.exf

#--- 7. executable --------
cp -f ${builddir}/mitgcmuv_${snx}x${sny}x${nprocs}${mitgcmext}${forwadj} ./mitgcmuv${forwadj}
cp -f ${builddir}/Makefile ./

#--- 8. pickups -----------
#NOTE: for pickup: copy instead of link to prevent accidental over-write
#  if [[ ${pickupts1} ]]; then
#    pickupdir=$scratchdir/run_pk0001051920
#    cp -f ${pickupdir}/pickup${extpickup}.${pickupts1}.data ./pickup.${pickupts1}.data
#    cp -f ${pickupdir}/pickup${extpickup}.${pickupts1}.meta ./pickup.${pickupts1}.meta
#  fi

#--- 9. make a list of all linked files ------

#  \rm -f command_ln_input
#  ls -l input_*/* > command_ln_input

  \rm -f command_ln_binary
  ls -l *.bin >> command_ln_binary
  ls -l tile* >> command_ln_binary
#
