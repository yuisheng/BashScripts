#!/bin/ksh
#June 16 th 2017, processing JRA-55 reanalysis
#Written by zhen.zhang@wsl.ch
#This script processes MERAA-2 data
#   - first download raw data:
#   - Temperature (tmp)
#   - Total Precipitation (tprat)
#   - Downward Solar Radiation Flux (dswrf)
#   - Downward Longwave Radiation Flux (dlwrf)
#   - use download script from NAR website
#   - merge into single file by using cdo mergetime
#   - aggregate to daily files
#   - For flux variable use daysum
#   - For state variable use daymean

#   - rename variable(lon,lat,var)
#ncrename -d g0_lon_2,lon -d g0_lat_1,lat -d initial_time0_hours,time -v g0_lon_2,lon -v g0_lat_1,lat -v initial_time0_hours,time -v TMP_GDS0_HTGL,tair tair.nc tair_tmp1.nc
#ncrename -d g0_lon_2,lon -d g0_lat_1,lat -d initial_time0_hours,time -v g0_lon_2,lon -v g0_lat_1,lat -v initial_time0_hours,time -v TPRAT_GDS0_SFC_ave3h,tp prec.nc prec_tmp1.nc
#ncrename -d g0_lon_2,lon -d g0_lat_1,lat -d initial_time0_hours,time -v g0_lon_2,lon -v g0_lat_1,lat -v initial_time0_hours,time -v DSWRF_GDS0_SFC_ave3h,ssrd swdown.nc swdown_tmp1.nc
#ncrename -d g0_lon_2,lon -d g0_lat_1,lat -d initial_time0_hours,time -v g0_lon_2,lon -v g0_lat_1,lat -v initial_time0_hours,time -v DLWRF_GDS0_SFC_ave3h,strd lwdown.nc lwdown_tmp1.nc

cdo daysum prec_tmp1.nc prec_tmpA.nc
cdo daysum swdown_tmp1.nc swdown_tmpA.nc
cdo daysum lwdown_tmp1.nc lwdown_tmpA.nc
cdo daymean tair_tmp1.nc tair_tmpA.nc
#   - Unit convert
cdo subc,273.15 tair_tmpA.nc tair_tmpB.nc
cdo divc,4 swdown_tmpA.nc swdown_tmpB.nc  # 6-hours outputs
cdo divc,4 lwdown_tmpA.nc lwdown_tmpB.nc  # 6-hours outputs
cdo divc,4 prec_tmpA.nc prec_tmpB.nc  # 6-hours outputs


#   - change attritubtes (Unit,)
cdo setunit,degC tair_tmpB.nc tair_tmp3.nc
cdo setunit,W\/m2\/s swdown_tmpB.nc swdown_tmp3.nc
cdo setunit,W\/m2\/s lwdown_tmpB.nc lwdown_tmp3.nc
mv prec_tmpB.nc prec_tmp3.nc

#   - delete leap day
outVar="tair prec swdown lwdown"
for var in $outVar; do
    cdo seldate,1980-01-01,1980-02-28 ${var}_tmp3.nc ${var}_tmp4.nc
    cdo seldate,1980-03-01,1984-02-28 ${var}_tmp3.nc ${var}_tmp5.nc
    cdo seldate,1984-03-01,1988-02-28 ${var}_tmp3.nc ${var}_tmp6.nc
    cdo seldate,1988-03-01,1992-02-28 ${var}_tmp3.nc ${var}_tmp7.nc
    cdo seldate,1992-03-01,1996-02-28 ${var}_tmp3.nc ${var}_tmp8.nc
    cdo seldate,1996-03-01,2000-02-28 ${var}_tmp3.nc ${var}_tmp9.nc
    cdo seldate,2000-03-01,2004-02-28 ${var}_tmp3.nc ${var}_tmp10.nc
    cdo seldate,2004-03-01,2008-02-28 ${var}_tmp3.nc ${var}_tmp11.nc
    cdo seldate,2008-03-01,2012-02-28 ${var}_tmp3.nc ${var}_tmp12.nc
    cdo seldate,2012-03-01,2016-02-28 ${var}_tmp3.nc ${var}_tmp13.nc
    cdo seldate,2016-03-01,2016-12-31 ${var}_tmp3.nc ${var}_tmp14.nc
    cdo mergetime ${var}_tmp4.nc ${var}_tmp5.nc ${var}_tmp6.nc ${var}_tmp7.nc ${var}_tmp8.nc ${var}_tmp9.nc ${var}_tmp10.nc ${var}_tmp11.nc ${var}_tmp12.nc ${var}_tmp13.nc ${var}_tmp14.nc ${var}_tmp15.nc
done

#   - unpack file 
cdo -b 32 select,name=tair tair_tmp15.nc tair_tmp16.nc
cdo -b 32 select,name=tp prec_tmp15.nc prec_tmp16.nc
cdo -b 32 select,name=ssrd swdown_tmp15.nc swdown_tmp16.nc
cdo -b 32 select,name=strd lwdown_tmp15.nc lwdown_tmp16.nc
#   - convert to double
ncap -s 'tair=double(tair)' tair_tmp16.nc tair_tmp17.nc
ncap -s 'tp=double(tp)' prec_tmp16.nc prec_tmp17.nc
ncap -s 'ssrd=double(ssrd)' swdown_tmp16.nc swdown_tmp17.nc
ncap -s 'strd=double(strd)' lwdown_tmp16.nc lwdown_tmp17.nc

#   - Aggregate to 0.5 degree
for var in $outVar; do
    cdo remapbil,/mnt/lustrefs/work/zhen.zhang/data/grid/cru_05deg ${var}_tmp17.nc ${var}_daily.nc
done

# set time attritubte days from 1980-01-01
cdo setunit,degC tair-daily.nc tair-daily_new.nc
cdo setunit,W\/m2\/s swdown_daily.nc swdown_daily_new.nc
cdo setunit,W\/m2\/s lwdown_daily.nc lwdown_daily_new.nc

#add 2016-12-31 to the three fluxes files by using 2016-12-30 obs
cdo seldate,2016-12-30,2016-12-31 prec-daily_new.nc prec-lastday2016.nc
cdo seldate,2016-12-30,2016-12-31 swdown-daily_new.nc swdown-lastday2016.nc
cdo seldate,2016-12-30,2016-12-31 lwdown-daily_new.nc lwdown-lastday2016.nc

cdo setdate,2016-12-31 prec-lastday2016.nc prec-lastday2016_new.nc
cdo setdate,2016-12-31 swdown-lastday2016.nc swdown-lastday2016_new.nc
cdo setdate,2016-12-31 lwdown-lastday2016.nc lwdown-lastday2016_new.nc

cdo mergetime prec-daily_new.nc prec-lastday2016_new.nc prec-daily_new.nc
cdo mergetime swdown-daily_new.nc swdown-lastday2016_new.nc swdown-daily_new.nc
cdo mergetime lwdown-daily_new.nc lwdown-lastday2016_new.nc lwdown-daily_new.nc


