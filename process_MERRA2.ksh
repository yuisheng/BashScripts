#!/bin/ksh
#June 2015, processing MERAA-2 reanalysis
#Written by zhen.zhang@wsl.ch
#This script processes MERAA-2 data
#	- Extract precipitation, temperature, shortwave radiation, long-wave radiation (1-hours time step to daily)
#	- processing variable: MERRA-2 variable name, aggregate method
#	- Precipitation: PRECTOTCORR mean (preciptation rate) M2T1NXFLX
#	- Temperature:  TLML mean M2T1NXFLX
#	- SW: SWGDN daymax M2T1NXRAD
#	- LW: LWGAB  daymax M2T1NXRAD
#	- Merge separate daily data to one single data for each month
#	- Aggregate to 0.5 degree
#	- Generate final single output for 1980-2016
#	- Unit Convertion
#Outputs
	# Global corrected datasets at 0.5 degree for 1980-2016
	# No 29th Feb in the outputs
#Set up parameters


#In/out names
frpath=/mnt/lustrefs/work/zhen.zhang/data/MERRA2
#frpath=/mnt/lustrefs/work/zhen.zhang/data/MERRA2/M2T1NXRAD.5.12.4
gridpath=/mnt/lustrefs/work/zhen.zhang/data/grid/cru_05deg

#List the array
daysofmonth=(0 31 28 31 30 31 30 31 31 30 31 30 31)
set -A vpath M2T1NXFLX M2T1NXFLX M2T1NXRAD M2T1NXRAD
set -A ftype tavg1_2d_flx_Nx tavg1_2d_flx_Nx tavg1_2d_rad_Nx tavg1_2d_rad_Nx
set -A Invar PRECTOTCORR TLML SWGDN LWGAB
set -A Outvar tp t2m ssrd strd
set -A aggMed daymean daymean daysum daysum

for varID in `seq 1 4`; do
    for year in `seq 1980 2016`; do
	    if [ ${year} -gt 2010 ]; then
	    fname=MERRA2_400.${ftype[${varID}]}.
	    elif [ ${year} -gt 2000 ]; then
	    fname=MERRA2_300.${ftype[${varID}]}.
	    elif [ ${year} -gt 1991 ]; then
	    fname=MERRA2_200.${ftype[${varID}]}.
	    else
	    fname=MERRA2_100.${ftype[${varID}]}.
	    fi

	    for month in `seq 1 12`; do
		    for day in `seq -f %02g ${daysofmonth[${month}]}`; do
            	echo Date=${year}_${month}_${day}
			    fmonth=`printf "%02d" ${month}`
			    cdo -s -b 32 ${aggMed[${varID}]} -select,name=${Invar[${varID}]} ${frpath}'/'${vpath[${varID}]}'/'${year}'/'${fname}${year}${fmonth}${day}'.nc4' ${frpath}'/'${vpath}'/'${year}'/MERRA2_'${Invar[${varID}]}'_'${year}${fmonth}${day}'.nc'
		    done
	    done
		    
        cd  ${frpath}'/'${vpath}'/'${year}'/'
		cdo -s mergetime `echo MERRA2_${Invar[${varID}]}*` 'MERRA2_'${Invar[${varID}]}'_'${year}'.nc'
        mv 'MERRA2_'${Invar[${varID}]}'_'${year}'.nc' ${frpath}'/'
    
    cd ${frpath}'/'
    #cdo remapbil
    cdo remapbil,${gridpath} 'MERRA2_'${Invar[${varID}]}'_'${year}'.nc' 'MERRA2_'${Invar[${varID}]}'_'${year}'_tmp1.nc'
    #change varname
    ncrename -v ${Invar[${varID}]}','${Outvar[${varID}]} 'MERRA2_'${Invar[${varID}]}'_'${year}'_tmp1.nc' 'MERRA2_'${Invar[${varID}]}'_'${year}'_tmp2.nc'
    #convert to double    
    ncap -s "${Outvar[${varID}]}=double(${Outvar[${varID}]})" 'MERRA2_'${Invar[${varID}]}'_'${year}'_tmp2.nc' 'MERRA2_'${Invar[${varID}]}'_'${year}'_tmp3.nc'
    
    done

    
    #unit converion
    if [ ${varID} -eq 0 ]; then #prec
        cdo mulc,86400 'MERRA2_'${Invar[${varID}]}'_'${year}'_tmp3.nc' 'MERRA2_'${Invar[${varID}]}'_'${year}'_tmp4.nc'
        cdo setunit,tp 'MERRA2_'${Invar[${varID}]}'_'${year}'_tmp4.nc' 'MERRA2_'${Invar[${varID}]}'_'${year}'_final.nc'
    elif [ ${varID} -eq 1 ]; then #tair
        cdo subc,273.15 'MERRA2_'${Invar[${varID}]}'_'${year}'_tmp3.nc' 'MERRA2_'${Invar[${varID}]}'_'${year}'_tmp4.nc'
        cdo setunit,mm  'MERRA2_'${Invar[${varID}]}'_'${year}'_tmp4.nc'  'MERRA2_'${Invar[${varID}]}'_'${year}'_final.nc'
    else # swdown; lwdown
        cdo divc,24 'MERRA2_'${Invar[${varID}]}'_'${year}'_tmp3.nc' 'MERRA2_'${Invar[${varID}]}'_'${year}'_tmp4.nc'
        cdo setunit,W\/m2\/s 'MERRA2_'${Invar[${varID}]}'_'${year}'_tmp4.nc'  'MERRA2_'${Invar[${varID}]}'_'${year}'_final.nc'
    fi

    rm 'MERRA2_'${Invar[${varID}]}'_'${year}'_tmp?.nc'

    cdo -s mergetime `echo 'MERRA2_'${Invar[${varID}]}'*_final.nc'` 'MERRA2_'${Invar[${varID}]}'.nc'
done

#Merge all the time slices


