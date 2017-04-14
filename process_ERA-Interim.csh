#!/bin/ksh
#Apr 2016
#ERA-INTERIM data from http://data-portal.ecmwf.int/data/d/interim_daily/
#Total Precip = snow, convection, and 1 other type
#Select time for tair: 00:00 06:00 12:00 18:00 (step = 0)
#Select time for fluxes: 00:00 and 12:00, step = 12 (forecast begins at 00:00 and 12:00 and fluxes are integrated over 12 hour time step)
#Fluxes are total precip, 2 m temp, surface solar and surface thermal radiation downwards
#Downloaded in one time slice 19790101-20130201 (except temperature)
#Send to cluster as:
#  'qsub cluster_runMeERA-v2.sge' (create sge file)

##################################################
#Set up parameters
fpathERA='/mnt/lustrefs/work/zhen.zhang/ERA-Interim/'

#In/out names
set -A fluxVar prec swdown lwdown
set -A outVar tair prec swdown lwdown

##################################################
#Unpack file (to remove scale factor and offset)
#cdo -b 32 copy $fpathERA$'tair-1-pack.nc' $fpathERA$var'tair-1-unp.nc'
#cdo -b 32 copy $fpathERA$'tair-2-pack.nc' $fpathERA$var'tair-2-unp.nc'
#cdo -b 32 copy $fpathERA$'prec.nc' $fpathERA$'prec-unp.nc'
#cdo -b 32 copy $fpathERA$'snowf.nc' $fpathERA$'snowf-unp.nc'
#cdo -b 32 copy $fpathERA$'swdown.nc' $fpathERA$'swdown-unp.nc'
#cdo -b 32 copy $fpathERA$'lwdown.nc' $fpathERA$'lwdown-unp.nc'

##################################################
#Merge to single time series
#cdo mergetime $fpathERA$'tair-1-unp.nc' $fpathERA$'tair-2-unp.nc' $fpathERA'tair-tmrg.nc'
##################################################
#Generate daily output
cdo daymean $fpathERA'tair_19790101-20160201.nc' $fpathERA'tair_19790101-20160201_daily.nc'
#Calculate daily sums
for var in ${fluxVar[@]}; do;
	cdo daysum $fpathERA$var'_19790101-20160201.nc' $fpathERA$var'_19790101-20160201_daily.nc'
done

##################################################
#Convert temperature units, and scale radiation and precipitation (incl units), to LPJ units
cdo subc,273.15 $fpathERA'tair_19790101-20160201_daily.nc' $fpathERA'tair-daily-wleap.nc'		#convert to degrees C
cdo mulc,1000 $fpathERA'prec_19790101-20160201_daily.nc' $fpathERA'prec-daily-wleap.nc'			#scale from m to mm for LPJ
cdo divc,86400 $fpathERA'swdown_19790101-20160201_daily.nc' $fpathERA'swdown-daily-wleap.nc'
cdo divc,86400 $fpathERA'lwdown_19790101-20160201_daily.nc' $fpathERA'lwdown-daily-wleap.nc'

##################################################
#Delete leap day
for var in ${outVar[@]}; do;
	cdo seldate,1979-01-01,1980-02-28 $fpathERA$var'-daily-wleap.nc' $fpathERA'tmp1.nc'
	cdo seldate,1980-03-01,1984-02-28 $fpathERA$var'-daily-wleap.nc' $fpathERA'tmp2.nc'
	cdo seldate,1984-03-01,1988-02-28 $fpathERA$var'-daily-wleap.nc' $fpathERA'tmp3.nc'
	cdo seldate,1988-03-01,1992-02-28 $fpathERA$var'-daily-wleap.nc' $fpathERA'tmp4.nc'
	cdo seldate,1992-03-01,1996-02-28 $fpathERA$var'-daily-wleap.nc' $fpathERA'tmp5.nc'
	cdo seldate,1996-03-01,2000-02-28 $fpathERA$var'-daily-wleap.nc' $fpathERA'tmp6.nc'
	cdo seldate,2000-03-01,2004-02-28 $fpathERA$var'-daily-wleap.nc' $fpathERA'tmp7.nc'
	cdo seldate,2004-03-01,2008-02-28 $fpathERA$var'-daily-wleap.nc' $fpathERA'tmp8.nc'
	cdo seldate,2008-03-01,2012-02-28 $fpathERA$var'-daily-wleap.nc' $fpathERA'tmp9.nc'
	cdo seldate,2012-03-01,2016-02-01 $fpathERA$var'-daily-wleap.nc' $fpathERA'tmp10.nc'
	cdo mergetime $fpathERA'tmp1.nc' $fpathERA'tmp2.nc' $fpathERA'tmp3.nc' $fpathERA'tmp4.nc' $fpathERA'tmp5.nc' $fpathERA'tmp6.nc' $fpathERA'tmp7.nc' $fpathERA'tmp8.nc' $fpathERA'tmp9.nc' $fpathERA'tmp10.nc' $fpathERA$var'-daily_final.nc'
	rm $fpathERA'tmp1.nc'
	rm $fpathERA'tmp2.nc'
	rm $fpathERA'tmp3.nc'
	rm $fpathERA'tmp4.nc'
	rm $fpathERA'tmp5.nc'
	rm $fpathERA'tmp6.nc'
	rm $fpathERA'tmp7.nc'
	rm $fpathERA'tmp8.nc'
	rm $fpathERA'tmp9.nc'
	rm $fpathERA'tmp10.nc'
done
##################################################
#Modify Attributes
cdo setunit,mm prec-daily_final.nc prec-daily_final_new.nc
cdo setunit,degC tair-daily_final.nc tair-daily_final_new.nc
cdo setunit,W\/m2\/s swdown-daily_final.nc swdown-daily_final_new.nc
cdo setunit,W\/m2\/s lwdown-daily_final.nc lwdown-daily_final_new.nc
cdo seldate,1979-01-01,2015-12-31 lwdown-daily_final_new.nc lwdown-daily_1979-2015.nc
cdo seldate,1979-01-01,2015-12-31 swdown-daily_final_new.nc swdown-daily_1979-2015.nc
cdo seldate,1979-01-01,2015-12-31 tair-daily_final_new.nc tair-daily_final_1979-2015.nc
cdo seldate,1979-01-01,2015-12-31 prec-daily_final_new.nc prec-daily_1979-2015.nc
#Clean up
#rm $fpathERA*unp.nc
#rm $fpathERA*tmrg.nc
#rm $fpathERA*sec*
#rm $fpathERA*hrly*
#rm $fpathERA*wleap.nc
#rm $fpathERA*daily.nc
