#!/bin/ksh
#May 2017
#ERA-INTERIM data from http://data-portal.ecmwf.int/data/d/interim_daily/
#for processing temperature input
#Use variable 2 m temp
#Select time for tair: 00:00 06:00 12:00 18:00 (step=0)
#Send to cluster as:
#  'qsub cluster_runMeERA-v2.sge' (create sge file)

##################################################
#Set up parameters
fpathERA='/Users/zhang/Research/data/input/ERA-Interim/'
fname='era_tmp.nc'
gridpath='Users/zhang//Research/data/input/grid/cru_05deg'
#In/out names
set -A fluxVar prec swdown lwdown
set -A outVar tair prec swdown lwdown

#Regrid to 0.5deg
cdo remapbil,${gridpath} $ffpathERA${fname} $fpathERA'tair_tmp.nc'
##################################################
#Unpack file (to remove scale factor and offset)
cdo -b 32 copy $fpathERA'' $fpathERA'tair_tmp1.nc'
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
cdo daymean $fpathERA'tair_tmp1.nc' $fpathERA'tair_tmp2.nc'

##################################################
#Convert temperature units, and scale radiation and precipitation (incl units), to LPJ units
cdo subc,273.15 $fpathERA'tair_tmp2.nc' $fpathERA'tair_tmp3.nc'		#convert to degrees C

##################################################
#Delete leap day
	cdo seldate,2016-01-01,2016-02-28 $fpathERA'tair_tmp3.nc' $fpathERA'tair_tmp4.nc'
	cdo seldate,2016-03-01,2016-12-31 $fpathERA'tair_tmp3.nc' $fpathERA'tair_tmp5.nc'
	cdo mergetime $fpathERA'tair_tmp4.nc' $fpathERA'tair_tmp5.nc' $fpathERA'tair_tmp6.nc'
##################################################
#Modify Attributes
cdo setunit,degC $fpathERA'tair_tmp6.nc' $fpathERA'tair_tmp7.nc'
ncap -s 't2m=double(t2m)' $fpathERA'tair_tmp7.nc' $fpathERA'tair_tmp8.nc'
ncrename -d longitude,lon -d latitude,lat $fpathERA'tair_tmp8.nc' $fpathERA'tair_tmp9.nc'
#
#Clean up
#rm $fpathERA*unp.nc
rm $fpathERA'tair_tmp1.nc'
rm $fpathERA'tair_tmp2.nc'
rm $fpathERA'tair_tmp3.nc'
rm $fpathERA'tair_tmp4.nc'
rm $fpathERA'tair_tmp5.nc'
rm $fpathERA'tair_tmp6.nc'
rm $fpathERA'tair_tmp7.nc'
rm $fpathERA'tair_tmp8.nc'
rm $fpathERA'tair_tmp9.nc'
#rm $fpathERA*tmrg.nc
#rm $fpathERA*sec*
#rm $fpathERA*hrly*
#rm $fpathERA*wleap.nc
#rm $fpathERA*daily.nc
