#!/bin/ksh
#Process NETCDF outputs from CMIP5 simulations using CDO
#Written by zhen.zhang@wsl.ch
# Sep 4th 2015
fdirCMIP5='/mnt/lustrefs/work/zhen.zhang/w94w693/output'
set -A rcpArray rcp26 rcp45 rcp60 rcp85

for rcp in ${rcpArray[@]}; do;
	#For input for RCP data
	inpath=$fdirCMIP5'/'$rcp'/'
	modelListEns=( $( ls $inpath ) )     #To select all models
		for fullName in ${modelListEns[@]}; do;
	        workpath=$fdirCMIP5'/'$rcp'/'$fullName'/merge/'
		cdo seldate,2090-01-01,2099-12-31 ${workpath}LPJ_wet_frac.nc ${workpath}LPJ_wet_frac_2090-2099.nc
		cdo yseasmean ${workpath}LPJ_wet_frac_2090-2099.nc ${workpath}LPJ_wet_frac_2090-2099_yseasmean.nc
		cdo seltimestep,1 ${workpath}LPJ_wet_frac_2090-2099_yseasmean.nc ${workpath}LPJ_wet_frac_2090-2099_yseasmean_DJF.nc
		cdo seltimestep,2 ${workpath}LPJ_wet_frac_2090-2099_yseasmean.nc ${workpath}LPJ_wet_frac_2090-2099_yseasmean_MAM.nc
		echo $rcp'_'$fullName;
		done

done

