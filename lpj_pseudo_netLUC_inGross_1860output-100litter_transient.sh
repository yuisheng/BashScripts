#!/bin/sh
#$ -cwd
#$ -m e

# Running a job managed by Slurm
# -N number of nodes
# -n number of tasks, requests number of processor cores on cluster
# -c this many CPUs per task
# --ntasks-per-node= requests processor cores on a node
# --time= time limit to batch job
# --mail-type=END send user email at end of job
# -o create an out file of log
# -e create an error file

#SBATCH -J netIGTR1860
#SBATCH -o slurm_netIG1860TR_lpj.out
#SBATCH -p priority
#SBATCH --exclusive
#SBATCH --no-requeue
#SBATCH -N 1
#SBATCH -n 32
#SBATCH --time=06:00:00
# -e slurm_gr1860LU_lpj.err
# --mail-user leonardo.calle@msu.montana.edu
# --mail-type=ALL
# --mail-type=END

index=0
p=32 #number of processors
n=67420 #number of cells

lpj_model=LPJ_SecForest_1860output
mkdir /local/job/$SLURM_JOB_ID/LCoutput
mkdir /local/job/$SLURM_JOB_ID/LCinput
mkdir /local/job/$SLURM_JOB_ID/LC${lpj_model}
mkdir /local/job/$SLURM_JOB_ID/LCrestart_files

#Set work dir path
outDir=/local/job/$SLURM_JOB_ID/LCoutput
inputDir=/local/job/$SLURM_JOB_ID/LCinput
restartDir=/local/job/$SLURM_JOB_ID/LCrestart_files
lpjDir=/local/job/$SLURM_JOB_ID/LC${lpj_model}

#Copy files to work directory
echo "copying lpj model and input files to node..."
rsync -av /mnt/lustrefs/store/leonardo.calle/LPJ/${lpj_model}/* ${lpjDir}
rsync -av /mnt/lustrefs/store/benjamin.poulter/poulterlab/Climate/Original/Global/CRU/ts322/cru_ts3.22.1901.2013.tmp.dat.nc ${inputDir}/cru_ts3.22.1901.2013.tmp.dat.nc
rsync -av /mnt/lustrefs/store/benjamin.poulter/poulterlab/Climate/Original/Global/CRU/ts322/cru_ts3.22.1901.2013.pre.dat.nc ${inputDir}/cru_ts3.22.1901.2013.pre.dat.nc
rsync -av /mnt/lustrefs/store/benjamin.poulter/poulterlab/Climate/Original/Global/CRU/ts322/cru_ts3.22.1901.2013.cld.dat.nc ${inputDir}/cru_ts3.22.1901.2013.cld.dat.nc
rsync -av /mnt/lustrefs/store/benjamin.poulter/poulterlab/Climate/Original/Global/CRU/ts322/cru_ts3.22.1901.2013.wet.dat.nc ${inputDir}/cru_ts3.22.1901.2013.wet.dat.nc
rsync -av /mnt/lustrefs/store/benjamin.poulter/poulterlab/Climate/Original/Global/CRU/ts322/cru_ts3.22.1901.2013.cld.dat.nc ${inputDir}/cru_ts3.22.1901.2013.cld.dat.nc
rsync -av /mnt/lustrefs/store/benjamin.poulter/poulterlab/Climate/Original/Global/CRU/ts322/cru_ts3.22.1901.2013.cld.dat.nc ${inputDir}/cru_ts3.22.1901.2013.cld.dat.nc
rsync -av /mnt/lustrefs/store/benjamin.poulter/poulterlab/LPJ_drivers/* ${inputDir}
rsync -av /mnt/lustrefs/store/benjamin.poulter/poulterlab/CO2/TRENDY/global_co2_ann_1860_2013.out ${inputDir}
rsync -av /mnt/lustrefs/store/leonardo.calle/data/LUH/processed_final_allvars/LUHv1_BeniStocker_1500-2013.nc ${inputDir}/LUHv1_merged_1500-2013.nc
rsync -av /mnt/lustrefs/store/leonardo.calle/data/LUH/gicew.nc ${inputDir}

rsync -av /mnt/lustrefs/store/leonardo.calle/input/gross_secforest_runs_1860output/restart_files/* ${restartDir}
echo "rynced input files to compute node ..."

#-----------------------------------------------------------------------------------------------
#Make all the lpj.conf files
while ((${index} < $p))
  do
  start=$((  n*index / p ))
  stop=$(( n*(index+1)/p-1 ))

cat  >|${lpjDir}/lpj${index}.conf <<EOF
/*********************************************************************/
/*                                                                   */
/*                   l  p  j    .  c  o  n  f                  */
/*                                                                   */
/* Configuration file for LPJ C Version, created by distribute.sh    */
/*                                                                   */
/* Last change: 29.09.2004                                           */
/*                                                                   */
/*********************************************************************/

#include "include/conf.h" /* include constant definitions */

/*#define ISRANDOM*/  /* random generation of daily precipitation */

${lpjDir}/par/pft.par  /* PFT Parameter file */
${lpjDir}/par/soil.par  /* Soil Parameter file */
${lpjDir}/par/manage.par /* Management Parameter file */
${lpjDir}/par/manage_reg.par /* Management Parameter file */

#include "${lpjDir}/lpj_secforest_gross_hyalite.conf" /* Input files of CRU dataset */
#ifdef ISRANDOM
100
#endif
80	             /* number of outputfiles */
${outDir}/grid${index}.out
${outDir}/fpc${index}.bin
${outDir}/mnpp${index}.bin
${outDir}/mrh${index}.bin
${outDir}/mtransp${index}.bin
${outDir}/mrunoff${index}.bin
${outDir}/mdischarge${index}.bin
${outDir}/mevap${index}.bin
${outDir}/minterc${index}.bin
${outDir}/mswc1${index}.bin
${outDir}/mswc2${index}.bin
${outDir}/firec${index}.bin
${outDir}/firef${index}.bin
${outDir}/vegc${index}.bin
${outDir}/soilc${index}.bin
${outDir}/litc${index}.bin
${outDir}/flux_estab${index}.bin
${outDir}/flux_harvest${index}.bin
${outDir}/mirrig_wd${index}.bin
${outDir}/sdate${index}.bin
${outDir}/pft_npp${index}.bin
${outDir}/pft_harvest${index}.bin
${outDir}/pft_rharvest${index}.bin
${outDir}/waterstress${index}.bin
${outDir}/pft_fO3uptake${index}.bin
${outDir}/pft_transp${index}.bin
${outDir}/pft_gc${index}.bin
${outDir}/pft_lai${index}.bin
${outDir}/pft_gpp${index}.bin
${outDir}/pft_vegc${index}.bin
${outDir}/pft_nind${index}.bin
${outDir}/pft_mort${index}.bin
${outDir}/mgpp${index}.bin
${outDir}/msoiltemp${index}.bin
${outDir}/mpet${index}.bin
${outDir}/mra${index}.bin
${outDir}/pft_maxphenday${index}.bin
${outDir}/pft_bimonfpar${index}.bin
${outDir}/flux_luc${index}.bin
${outDir}/msnowpack${index}.bin
${outDir}/mpft_lai${index}.bin
${outDir}/mpft_gc${index}.bin
${outDir}/mpft_ci${index}.bin
${outDir}/mpft_transp${index}.bin
${outDir}/mpft_gpp${index}.bin
${outDir}/wtd${index}.bin
${outDir}/wet_frac${index}.bin
${outDir}/ch4e${index}.bin
${outDir}/mtsoil_0${index}.bin
${outDir}/mtsoil_10${index}.bin
${outDir}/mtsoil_25${index}.bin
${outDir}/mtsoil_50${index}.bin
${outDir}/mtsoil_100${index}.bin
${outDir}/mtsoil_150${index}.bin
${outDir}/mtsoil_200${index}.bin
${outDir}/mtemp_soil${index}.bin
${outDir}/mthaw_depth${index}.bin
${outDir}/mFwater${index}.bin
${outDir}/mFice${index}.bin
${outDir}/msnowdepth${index}.bin
${outDir}/mice_frac1${index}.bin
${outDir}/mice_frac2${index}.bin
${outDir}/woodharvest_100yr${index}.bin
${outDir}/woodharvest_10yr${index}.bin
${outDir}/woodharvest_1yr${index}.bin
${outDir}/woodharvest_100yr_remain${index}.bin
${outDir}/woodharvest_10yr_remain${index}.bin
${outDir}/woodharvest_1yr_remain${index}.bin
${outDir}/mnpp_primary${index}.bin
${outDir}/mgpp_primary${index}.bin
${outDir}/mrh_primary${index}.bin
${outDir}/vegc_primary${index}.bin
${outDir}/soilc_primary${index}.bin
${outDir}/litc_primary${index}.bin
${outDir}/mnpp_secforest${index}.bin
${outDir}/mgpp_secforest${index}.bin
${outDir}/mrh_secforest${index}.bin
${outDir}/vegc_secforest${index}.bin
${outDir}/soilc_secforest${index}.bin
${outDir}/litc_secforest${index}.bin

FIRE /* fire disturbance enabled */ 
${start} /* first grid cell */
${stop} /* last grid cell  */

#ifndef FROM_RESTART

1000 /* spinup years */
1901 /* first year of simulation */
1901 /* last year of simulation */
NO_RESTART /* do not start from restart file */
RESTART /* create restart file: the last year of simulation=restart-year */
${outDir}/restart${index}.lpj /* filename of restart file : THIS NAME NEVER CHANGES - ALWAYS USED TO WRITE FROM SPIN UP*/

#else

41 /* no spinup years */
1901 /* first year of simulation */
2013 /* last year of simulation */
RESTART /* start from restart file */
${restartDir}/restart${index}.lpj 
/* 1. USE restart0.lpj to read from spin up (for LUC initialization) */
/* 2. USE restart_final0.lpj to read from land use init (for transient) */
RESTART /* create restart file */
${outDir}/restart_final${index}.lpj

#endif
EOF
let index=index+1
done

#rsync --ignore-times ${lpjDir}/lpj*.conf /mnt/lustrefs/store/leonardo.calle/LPJ/
echo "copied conf files to LPJ directory..."

#------------------------------------------------------------------------------------------------------
#Upddate lpj_$X_conf file for climate data
#Link to WORKDIR
workDL=$LOCAL_JOB_DIR
workDL=${inputDir}
echo $workDL
 
#!!! LC: why isn't there a radiation input 9/10/2015
#Update climate inputs location in lpj conf file
sed -i "14d" ${lpjDir}/lpj_secforest_gross_hyalite.conf
sed -i "14i ${lpjDir}/grid.bin" ${lpjDir}/lpj_secforest_gross_hyalite.conf
sed -i "15d" ${lpjDir}/lpj_secforest_gross_hyalite.conf
sed -i "15i ${inputDir}/soil_global_hd_filled.nc" ${lpjDir}/lpj_secforest_gross_hyalite.conf
sed -i "16d" ${lpjDir}/lpj_secforest_gross_hyalite.conf
sed -i "16i ${inputDir}/cow_mg_2006.bin" ${lpjDir}/lpj_secforest_gross_hyalite.conf
sed -i "17d" ${lpjDir}/lpj_secforest_gross_hyalite.conf
sed -i "17i ${inputDir}/gicew.nc" ${lpjDir}/lpj_secforest_gross_hyalite.conf
sed -i "18d" ${lpjDir}/lpj_secforest_gross_hyalite.conf
sed -i "18i ${inputDir}/LUHv1_merged_1500-2013.nc" ${lpjDir}/lpj_secforest_gross_hyalite.conf
sed -i "19d" ${lpjDir}/lpj_secforest_gross_hyalite.conf
sed -i "19i ${inputDir}/drainage.bin" ${lpjDir}/lpj_secforest_gross_hyalite.conf
sed -i "20d" ${lpjDir}/lpj_secforest_gross_hyalite.conf
sed -i "20i ${inputDir}/neighb_irrigation.bin" ${lpjDir}/lpj_secforest_gross_hyalite.conf
sed -i "21d" ${lpjDir}/lpj_secforest_gross_hyalite.conf
sed -i "21i ${inputDir}/cru_ts3.22.1901.2013.tmp.dat.nc" ${lpjDir}/lpj_secforest_gross_hyalite.conf
sed -i "22d" ${lpjDir}/lpj_secforest_gross_hyalite.conf
sed -i "22i ${inputDir}/cru_ts3.22.1901.2013.pre.dat.nc" ${lpjDir}/lpj_secforest_gross_hyalite.conf
sed -i "23d" ${lpjDir}/lpj_secforest_gross_hyalite.conf
sed -i "23i ${inputDir}/cru_ts3.22.1901.2013.cld.dat.nc" ${lpjDir}/lpj_secforest_gross_hyalite.conf
sed -i "24d" ${lpjDir}/lpj_secforest_gross_hyalite.conf
sed -i "24i ${inputDir}/cru_ts3.22.1901.2013.cld.dat.nc" ${lpjDir}/lpj_secforest_gross_hyalite.conf
sed -i "25d" ${lpjDir}/lpj_secforest_gross_hyalite.conf
sed -i "25i ${inputDir}/cru_ts3.22.1901.2013.cld.dat.nc" ${lpjDir}/lpj_secforest_gross_hyalite.conf
sed -i "26d" ${lpjDir}/lpj_secforest_gross_hyalite.conf
sed -i "26i ${inputDir}/o3.2030cle.nc" ${lpjDir}/lpj_secforest_gross_hyalite.conf
sed -i "27d" ${lpjDir}/lpj_secforest_gross_hyalite.conf
sed -i "27i ${inputDir}/topmodel.nc" ${lpjDir}/lpj_secforest_gross_hyalite.conf
sed -i "28d" ${lpjDir}/lpj_secforest_gross_hyalite.conf
sed -i "28i ${inputDir}/msoiltemp.nc" ${lpjDir}/lpj_secforest_gross_hyalite.conf

sed -i "29d" ${lpjDir}/lpj_secforest_gross_hyalite.conf
sed -i "29i ${inputDir}/drainage.bin" ${lpjDir}/lpj_secforest_gross_hyalite.conf
sed -i "30d" ${lpjDir}/lpj_secforest_gross_hyalite.conf
sed -i "30i ${inputDir}/luyssaert_age.bin" ${lpjDir}/lpj_secforest_gross_hyalite.conf
sed -i "31d" ${lpjDir}/lpj_secforest_gross_hyalite.conf
sed -i "31i ${inputDir}/global_co2_ann_1860_2013.out" ${lpjDir}/lpj_secforest_gross_hyalite.conf
sed -i "37d" ${lpjDir}/lpj_secforest_gross_hyalite.conf
sed -i "37i ${inputDir}/cru_ts3.22.1901.2013.wet.dat.nc" ${lpjDir}/lpj_secforest_gross_hyalite.conf

#----------------------------------------------------------------------------------------------------------
#update makefile.inc

sed -i "18d" "${lpjDir}/Makefile.inc"
sed -i "18i CFLAGS  = -g -O3 -Wall -DSAFE -DUSE_CPP -DUSE_UNAME -DUSE_RAND48 -DDEBUGEFENCE -DCLM_NCDF -DMONTHLY -DCRU -DLUC_NCDF -DHURTT -DUSDA -DSITCHCO2 -DGROSS_LUC -DNOWDHARVEST -DNETinGROSS" ${lpjDir}/Makefile.inc
cd ${lpjDir}
make clean
make
#----------------------------------------------------------------------------------------------------------
#submit jobs
# Use -DNAT_VEG for spinup
# Use -DFROM_RESTART for landuse,transient runs
# Use -DGROSS_LUC for gross transitions
# Use -DSPIN_LUC for LU spinup (only works with gross luc)

index=0

while ((${index} < ${p}))
do
srun -n 1 ${lpjDir}/lpj -DISRANDOM -DFROM_RESTART ${lpjDir}/lpj${index}.conf &
let index=index+1
sleep 1
done
wait

model_run=transient
rsync --ignore-times ${outDir}/*bin /mnt/lustrefs/store/leonardo.calle/output/net_secforest_runs_luha1_wStands_100litter/${model_run}/
rsync --ignore-times  ${outDir}/*out /mnt/lustrefs/store/leonardo.calle/output/net_secforest_runs_luha1_wStands_100litter/${model_run}/
rsync --ignore-times  ${outDir}/restart* /mnt/lustrefs/store/leonardo.calle/input/net_secforest_runs_luha1_wStands_100litter/restart_files/
echo "cleaning up workspace..."
rm -rf /local/*
wait
wait
