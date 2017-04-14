#!/bin/ksh
#June 2015, processing MERAA-2 reanalysis
#Written by zhen.zhang@wsl.ch
#This script processes MERAA-2 data
#	- Extract precipitation, temperature, shortwave radiation, long-wave radiation (1-hours time step to daily)
#	- processing variable: MERRA-2 variable name, aggregate method
#	- Precipitation: PRECTOTCORR mean (preciptation rate) M2T1NXFLX
#	- Temperature:  TLML mean M2T1NXFLX
#	- SW: SWGDN mean M2T1NXLFO
#	- LW: LWGAB  mean M2T1NXLFO
#	- Merge separate daily data to one single data for each month
#	- Aggregate to 0.5 degree
#	- Generate final single output for 1980-2015
#	- Unit Convertion
#Outputs
	# Global corrected datasets at 0.5 degree for 1980-2015
	# No 29th Feb in the outputs
#Set up parameters


#In/out names
finpath=/mnt/lustrefs/work/zhen.zhang/data/MERRA2/M2T1NXFLX.5.12.4
fname=MERRA2_100.tavg1_2d_flx_Nx. #1992 200;2001 300;2011 400;
#finpath=/mnt/lustrefs/work/zhen.zhang/data/MERRA2/M2T1NXRAD.5.12.4
#fname=MERRA2_100.tavg1_2d_rad_Nx.

Invar=TLML # PRECTOTCORR, TLML, SWGDN, LWGAB
Outvar=strd			# tp, t2m, ssrd, strd
aggMed=daymean		#daysum, daymean, daymax

#List the array
daysofmonth=(0 31 28 31 30 31 30 31 31 30 31 30 31)

for year in `seq 1980 2015`; do
	if [ ${year} -gt 2010 ]; then
	fname=MERRA2_400.tavg1_2d_flx_Nx.
	elif [ ${year} -gt 2000 ]; then
	fname=MERRA2_300.tavg1_2d_flx_Nx.
	elif [ ${year} -gt 1991 ]; then
	fname=MERRA2_200.tavg1_2d_flx_Nx.
	else
	fname=MERRA2_100.tavg1_2d_flx_Nx.
	fi

	for month in `seq 1 12`; do
		for day in `seq -f %02g ${daysofmonth[${month}]}`; do
            		echo Date=${year}_${month}_${day}
			fmonth=`printf "%02d" ${month}`
			cdo -s -b 32 ${aggMed} -select,name=${Invar} ${finpath}'/'${year}'/'${fmonth}'/'${fname}${year}${fmonth}${day}'.nc4' ${finpath}'/'${year}'/'${fmonth}'/MERRA2_'${Invar}'_'${year}${fmonth}${day}'.nc'
		done
		cd  ${finpath}'/'${year}'/'${fmonth}
		cdo -s mergetime `echo MERRA2_${Invar}*` 'MERRA2_'${Invar}'_'${year}${fmonth}'.nc'
        mv 'MERRA2_'${Invar}'_'${year}${fmonth}'.nc' ${finpath}'/'
	done
done
cd ${finpath}'/'

#Merge all the time slices
cdo -s mergetime `echo MERRA2_${Invar}*` 'MERRA2_'${Invar}'.nc'

#Unit Conversion
#Preciptation
#cdo mulc,86400 
#cdo remapbil,
#cdo setunit,mm

