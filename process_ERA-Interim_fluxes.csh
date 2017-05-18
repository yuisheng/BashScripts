#!/bin/ksh
#May 2017
#ERA-INTERIM data from http://data-portal.ecmwf.int/data/d/interim_daily/
#for prcessing precipitation, shortwave and longwave radiation
#Select time for fluxes: 00:00 and 12:00, step = 12 (forecast begins at 00:00 and 12:00 and fluxes are integrated over 12 hour time step)
#Fluxes are total precip, 2 m temp, surface solar and surface thermal radiation downwards
#Send to cluster as:
#  'qsub cluster_runMeERA-v2.sge' (create sge file)

##################################################
#Set up parameters
fpathERA='/Users/zhang/Research/data/input/ERA-Interim/'
fname='era_fluxes.nc'
gridpath='/Users/zhang/Research/data/input/grid/cru_05deg'
#In/out names
set -A fluxVar tp ssrd strd
set -A outVar prec sw lw

##################################################
#Unpack file (to remove scale factor and offset)
cdo -b 32 select,name=tp   $fpathERA$fname $fpathERA'prec_tmp.nc'
cdo -b 32 select,name=ssrd $fpathERA$fname $fpathERA'sw_tmp.nc'
cdo -b 32 select,name=strd $fpathERA$fname $fpathERA'lw_tmp.nc'

##################################################
cdo remapbil,${gridpath} $fpathERA'prec_tmp.nc' $fpathERA'prec_tmp1.nc'
cdo remapbil,${gridpath} $fpathERA'sw_tmp.nc' $fpathERA'sw_tmp1.nc'
cdo remapbil,${gridpath} $fpathERA'lw_tmp.nc' $fpathERA'lw_tmp1.nc'

##################################################
#Generate daily output
#Calculate daily sums
cdo daysum $fpathERA'prec_tmp1.nc' $fpathERA'prec_tmp2.nc'
cdo daysum $fpathERA'sw_tmp1.nc'   $fpathERA'sw_tmp2.nc'
cdo daysum $fpathERA'lw_tmp1.nc'   $fpathERA'lw_tmp2.nc'

##################################################
#Convert temperature units, and scale radiation and precipitation (incl units), to LPJ units
cdo mulc,1000 $fpathERA'prec_tmp2.nc' $fpathERA'prec_tmp3.nc'			#scale from m to mm for LPJ
cdo divc,86400 $fpathERA'sw_tmp2.nc' $fpathERA'sw_tmp3.nc'
cdo divc,86400 $fpathERA'lw_tmp2.nc' $fpathERA'lw_tmp3.nc'

##################################################
#Delete leap day
for var in ${outVar[@]}; do;
	cdo seldate,2016-01-01,2016-02-28 $fpathERA$var'_tmp3.nc' $fpathERA$var'_tmp4.nc'
	cdo seldate,2016-03-01,2016-12-31 $fpathERA$var'_tmp3.nc' $fpathERA$var'_tmp5.nc'
    cdo mergetime $fpathERA$var'_tmp4.nc' $fpathERA$var'_tmp5.nc' $fpathERA$var'_tmp6.nc'
done
##################################################
#Modify Attributes
cdo setunit,mm $fpathERA'prec_tmp6.nc' $fpathERA'prec_tmp7.nc'
cdo setunit,W\/m2\/s $fpathERA'sw_tmp6.nc' $fpathERA'sw_tmp7.nc'
cdo setunit,W\/m2\/s $fpathERA'lw_tmp6.nc' $fpathERA'lw_tmp7.nc'

ncap -s 'tp=double(tp)' $fpathERA'prec_tmp7.nc' $fpathERA'prec_tmp8.nc'
ncap -s 'ssrd=double(ssrd)' $fpathERA'sw_tmp7.nc' $fpathERA'sw_tmp8.nc'
ncap -s 'strd=double(strd)' $fpathERA'lw_tmp7.nc' $fpathERA'lw_tmp8.nc'

ncrename -d longitude,lon -d latitude,lat $fpathERA'prec_tmp8.nc' $fpathERA'prec-daily_2016.nc'
ncrename -d longitude,lon -d latitude,lat $fpathERA'sw_tmp8.nc' $fpathERA'swdown-daily_2016.nc'
ncrename -d longitude,lon -d latitude,lat $fpathERA'lw_tmp8.nc' $fpathERA'lwdown-daily_2016.nc'

#Clean up
for var in ${outVar[@]}; do;
    rm $fpathERA$var'_tmp*.nc'
done
#rm $fpathERA*unp.nc
#rm $fpathERA*tmrg.nc
#rm $fpathERA*sec*
#rm $fpathERA*hrly*
#rm $fpathERA*wleap.nc
#rm $fpathERA*daily.nc
