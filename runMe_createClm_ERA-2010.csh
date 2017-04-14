#!/usr/bin/ksh
#Dec 2010
#Extend climate data to 2010 & create wet days input
#ERA-INTERIM data from http://data-portal.ecmwf.int/data/d/interim_daily/
#Total Precip = snow, convection, and 1 other type
#Select time for tair: 00:00 06:00 12:00 18:00 (step = 0)
#Select time for fluxes: 00:00 and 12:00, step = 12 (forecast begins at 00:00 and 12:00 and fluxes are integrated over 12 hour time step)
#Fluxes are total precip, 2 m temp, surface solar and surface thermal radiation
#Downloaded in one time slice 1989-2010 (except temperature)
#Send to cluster as:
#  'qsub cluster_runMeERA-v2.sge' (create sge file)

##################################################
#Set up parameters
fpathERA=/wsl/lud11/poulter/IPCC/data/era/orig/1989-2010/
fpathROI=/wsl/lud11/poulter/IPCC/scripts/roi_file/

#In/out names
fluxVar="prec swdown lwdown"
outVar="tair prec swdown lwdown"

skip='TRUE'
if [[ $skip == "FALSE" ]]; then
echo 'off'
fi

##################################################
#Unpack file (to remove scale factor and offset)
cdo -b 32 copy $fpathERA$'tair-1-pack-2010.nc' $fpathERA$var'tair-1-unp.nc'
cdo -b 32 copy $fpathERA$'tair-2-pack-2010.nc' $fpathERA$var'tair-2-unp.nc'
cdo -b 32 copy $fpathERA$'prec-2010.nc' $fpathERA$'prec-unp.nc'
cdo -b 32 copy $fpathERA$'swdown-2010.nc' $fpathERA$'swdown-unp.nc'
cdo -b 32 copy $fpathERA$'lwdown-2010.nc' $fpathERA$'lwdown-unp.nc'

##################################################
#Merge to single time series
cdo mergetime $fpathERA$'tair-1-unp.nc' $fpathERA$'tair-2-unp.nc' $fpathERA'tair-tmrg.nc'

##################################################
#Convert temperature units, and scale radiation and precipitation (incl units), to LPJ units
cdo subc,273.15 $fpathERA'tair-tmrg.nc' $fpathERA'tair-sec-c.nc'		#convert to degrees C
cdo mulc,10 $fpathERA'tair-sec-c.nc' $fpathERA'tair-hrly-c.nc'			#scale by 10 for LPJ

#Calculate daily sums
for var in $fluxVar; do 
	cdo daysum $fpathERA$var'-unp.nc' $fpathERA$var'-daysum.nc'
done

cdo mulc,1000 $fpathERA$'prec-daysum.nc' $fpathERA'prec-daily-wleap.nc'			#scale from m to mm for LPJ
cdo divc,86400 $fpathERA'swdown-daysum.nc' $fpathERA'swdown-daily-wleap.nc'
cdo divc,86400 $fpathERA'lwdown-daysum.nc' $fpathERA'lwdown-daily-wleap.nc'

##################################################
#Calculate daily mean
cdo daymean $fpathERA'tair-hrly-c.nc' $fpathERA'tair-daily-wleap.nc'

##################################################
#Delete leap day
for var in $outVar; do 
	cdo seldate,1989-01-01,1992-02-28 $fpathERA$var'-daily-wleap.nc' $fpathERA'tmp1.nc'
	cdo seldate,1992-03-01,1996-02-28 $fpathERA$var'-daily-wleap.nc' $fpathERA'tmp2.nc'
	cdo seldate,1996-03-01,2000-02-28 $fpathERA$var'-daily-wleap.nc' $fpathERA'tmp3.nc'
	cdo seldate,2000-03-01,2004-02-28 $fpathERA$var'-daily-wleap.nc' $fpathERA'tmp4.nc'
	cdo seldate,2004-03-01,2008-02-28 $fpathERA$var'-daily-wleap.nc' $fpathERA'tmp5.nc'
	cdo seldate,2008-03-01,2010-09-30 $fpathERA$var'-daily-wleap.nc' $fpathERA'tmp6.nc'
	cdo mergetime $fpathERA'tmp1.nc' $fpathERA'tmp2.nc' $fpathERA'tmp3.nc' $fpathERA'tmp4.nc' $fpathERA'tmp5.nc' $fpathERA'tmp6.nc' $fpathERA$var'-daily.nc'
	rm $fpathERA'tmp1.nc'
	rm $fpathERA'tmp2.nc'
	rm $fpathERA'tmp3.nc'
	rm $fpathERA'tmp4.nc'
	rm $fpathERA'tmp5.nc'
	rm $fpathERA'tmp6.nc'
done

##################################################
#Interpolate to LPJ
for var in $outVar; do
	cdo remapbil,$fpathROI'cru_05deg' $fpathERA$var'-daily.nc' $fpathERA$var'-daily-05-2010.nc'
done

##################################################
#Calculate monthly summaries
cdo monmean $fpathERA$'tair-daily-05-2010.nc' $fpathERA$'tair-monthly-05-2010tmp.nc'
cdo monmean $fpathERA$'swdown-daily-05-2010.nc' $fpathERA$'swdown-monthly-05-2010tmp.nc'
cdo monmean $fpathERA$'lwdown-daily-05-2010.nc' $fpathERA$'lwdown-monthly-05-2010tmp.nc'
cdo monsum $fpathERA$'prec-daily-05-2010.nc' $fpathERA$'prec-monthlysum-05-2010tmp.nc'

#Calculate wet days month
cdo gtc,0 $fpathERA$'prec-daily-05-2010.nc' $fpathERA$'prec-index-05-2010tmp.nc'
cdo monsum $fpathERA$'prec-index-05-2010tmp.nc' $fpathERA$'wet-monthly-05-2010tmp.nc'

#Crop 2009 missing months for 2010
cdo seldate,2009-10-01,2009-12-31 $fpathERA$'tair-monthly-05-2010tmp.nc' $fpathERA$'tair-monthly-05-2009.nc'
cdo seldate,2009-10-01,2009-12-31 $fpathERA$'swdown-monthly-05-2010tmp.nc' $fpathERA$'swdown-monthly-05-2009.nc'
cdo seldate,2009-10-01,2009-12-31 $fpathERA$'lwdown-monthly-05-2010tmp.nc' $fpathERA$'lwdown-monthly-05-2009.nc'
cdo seldate,2009-10-01,2009-12-31 $fpathERA$'prec-monthlysum-05-2010tmp.nc' $fpathERA$'prec-monthly-05-2009.nc'
cdo seldate,2009-10-01,2009-12-31 $fpathERA$'wet-monthly-05-2010tmp.nc' $fpathERA$'wet-monthly-05-2009.nc' 

#Reset year of cropped months
cdo setyear,2010 $fpathERA$'tair-monthly-05-2009.nc' $fpathERA$'tair-monthly-05-2010y.nc'
cdo setyear,2010 $fpathERA$'swdown-monthly-05-2009.nc' $fpathERA$'swdown-monthly-05-2010y.nc'
cdo setyear,2010 $fpathERA$'lwdown-monthly-05-2009.nc' $fpathERA$'lwdown-monthly-05-2010y.nc'
cdo setyear,2010 $fpathERA$'prec-monthly-05-2009.nc' $fpathERA$'prec-monthly-05-2010y.nc'
cdo setyear,2010 $fpathERA$'wet-monthly-05-2009.nc' $fpathERA$'wet-monthly-05-2010y.nc'

#Merge cropped months to data
cdo mergetime $fpathERA$'tair-monthly-05-2010y.nc' $fpathERA$'tair-monthly-05-2010tmp.nc' $fpathERA$'tair-monthly-05-2010.nc'
cdo mergetime $fpathERA$'swdown-monthly-05-2010y.nc' $fpathERA$'swdown-monthly-05-2010tmp.nc' $fpathERA$'swdown-monthly-05-2010.nc'
cdo mergetime $fpathERA$'lwdown-monthly-05-2010y.nc' $fpathERA$'lwdown-monthly-05-2010tmp.nc' $fpathERA$'lwdown-monthly-05-2010.nc'
cdo mergetime $fpathERA$'prec-monthly-05-2010y.nc' $fpathERA$'prec-monthlysum-05-2010tmp.nc' $fpathERA$'prec-monthly-05-2010.nc'
cdo mergetime $fpathERA$'wet-monthly-05-2010y.nc' $fpathERA$'wet-monthly-05-2010tmp.nc' $fpathERA$'wet-monthly-05-2010.nc'

#Copy
mv *-monthly-05-2010.nc /wsl/lud11/poulter/IPCC/data/era/

##################################################
#Clean up
rm $fpathERA*unp.nc
rm $fpathERA*tmrg.nc
rm $fpathERA*sec*
rm $fpathERA*hrly*
rm $fpathERA*wleap.nc
rm $fpathERA*daily*.nc
rm $fpathERA*daysum*.nc
rm $fpathERA*tmp.nc
rm $fpathERA*2009.nc
rm $fpathERA*y.nc
