#!/bin/ksh

#############################################################################
##                                                                         ##
##         o  u  t  p  u  t  _  b  s  q  .  k  s  h                        ##
##                                                                         ##
## ksh script to create bsq output files from LPJ-C output                 ##
##                                                                         ##
## Usage:  output.ksh jobnumber                                            ##
##                                                                         ##
## Last change: 23.05.2006                                                 ##
##                                                                         ##
#############################################################################

fpath=/mnt/lustrefs/store/zhen.zhang/output/MERRA2/MERRA2_2016_USDA_DLIT_PERMAFROST/
inpath=$fpath/transient
outpath=$fpath/merge
compath=/home/zhen.zhang/LPJ/LPJ_permafrost
nyears=116
ndailyyears=2
n=32 #number of individual files

#Make the output directory if it doesn't exist
if [ ! -d $outpath ]; then
    mkdir $outpath
fi

#if [ $# -lt 1 ] 
#then
#  echo >&2 usage: output.ksh jobnumber
#  exit 1
#fi
#n=$1
#if [ $n -lt 1 ]
#then
#  echo >&2 Error: number of jobs less than one.
#  exit 1
#fi  
$compath/cat2bsq $inpath/grid out $outpath/grid.out $n 1 1
$compath/cat2bsq $inpath/fpc bin $outpath/fpc.bin $n $(($nyears*10)) 0
$compath/cat2bsq $inpath/mnpp bin $outpath/mnpp.bin $n $(($nyears*12)) 0
$compath/cat2bsq $inpath/mrh bin $outpath/mrh.bin $n $(($nyears*12)) 0
$compath/cat2bsq $inpath/mtransp bin $outpath/mtransp.bin $n $(($nyears*12)) 0
$compath/cat2bsq $inpath/mrunoff bin $outpath/mrunoff.bin $n $(($nyears*12)) 0
$compath/cat2bsq $inpath/mdischarge bin $outpath/mdischarge.bin $n $(($nyears*12)) 0
$compath/cat2bsq $inpath/mevap bin $outpath/mevap.bin $n $(($nyears*12)) 0
$compath/cat2bsq $inpath/minterc bin $outpath/minterc.bin $n $(($nyears*12)) 0
$compath/cat2bsq $inpath/mswc1 bin $outpath/mswc1.bin $n $(($nyears*12)) 0
$compath/cat2bsq $inpath/mswc2 bin $outpath/mswc2.bin $n $(($nyears*12)) 0
$compath/cat2bsq $inpath/firec bin $outpath/firec.bin $n $(($nyears)) 0
$compath/cat2bsq $inpath/firef bin $outpath/firef.bin $n $(($nyears)) 0
$compath/cat2bsq $inpath/vegc bin $outpath/vegc.bin $n $(($nyears)) 0
$compath/cat2bsq $inpath/soilc bin $outpath/soilc.bin $n $(($nyears)) 0
$compath/cat2bsq $inpath/litc bin $outpath/litc.bin $n $(($nyears)) 0
$compath/cat2bsq $inpath/flux_estab bin $outpath/flux_estab.bin $n $(($nyears)) 0
$compath/cat2bsq $inpath/flux_harvest bin $outpath/flux_harvest.bin $n $(($nyears)) 0
$compath/cat2bsq $inpath/pft_npp bin $outpath/pft_npp.bin $n $((33*$nyears)) 0
$compath/cat2bsq $inpath/waterstress bin $outpath/waterstress.bin $n $(($nyears*33)) 0
#$compath/cat2bsq $inpath/pft_fO3uptake bin $outpath/pft_fO3uptake.bin $n $((33*$nyears)) 0
#$compath/cat2bsq $inpath/pft_transp bin $outpath/pft_transp.bin $n $((33*$nyears)) 0
#$compath/cat2bsq $inpath/pft_gc bin $outpath/pft_gc.bin $n $((33*$nyears)) 0
#$compath/cat2bsq $inpath/pft_lai bin $outpath/pft_lai.bin $n $((33*$nyears)) 0
#$compath/cat2bsq $inpath/pft_gpp bin $outpath/pft_gpp.bin $n $((33*$nyears)) 0
#$compath/cat2bsq $inpath/pft_vegc bin $outpath/pft_vegc.bin $n $((9*$nyears)) 0
$compath/cat2bsq $inpath/mgpp bin $outpath/mgpp.bin $n $(($nyears*12)) 0
$compath/cat2bsq $inpath/msoiltemp bin $outpath/msoiltemp.bin $n $(($nyears*12)) 0
$compath/cat2bsq $inpath/mpet bin $outpath/mpet.bin $n $(($nyears*12)) 0
$compath/cat2bsq $inpath/mra bin $outpath/mra.bin $n $(($nyears*12)) 0
$compath/cat2bsq $inpath/flux_luc bin $outpath/flux_luc.bin $n $(($nyears)) 0
$compath/cat2bsq $inpath/msnowpack bin $outpath/msnowpack.bin $n $(($nyears*12)) 0
#$compath/cat2bsq $inpath/mpft_lai bin $outpath/mpft_lai.bin $n $(($nyears*12*9)) 0
#$compath/cat2bsq $inpath/mpft_gc bin $outpath/mpft_gc.bin $n $(($nyears*12*9)) 0
#$compath/cat2bsq $inpath/mpft_ci bin $outpath/mpft_ci.bin $n $(($nyears*12*9)) 0
#$compath/cat2bsq $inpath/mpft_transp bin $outpath/mpft_transp.bin $n $(($nyears*12*9)) 0
#$compath/cat2bsq $inpath/mpft_gpp bin $outpath/mpft_gpp.bin $n $(($nyears*12*9)) 0
$compath/cat2bsq $inpath/wtd bin $outpath/wtd.bin $n $(($nyears*12)) 0
$compath/cat2bsq $inpath/wet_frac bin $outpath/wet_frac.bin $n $(($nyears*12)) 0
$compath/cat2bsq $inpath/ch4e bin $outpath/mch4e.bin $n $(($nyears*12)) 0
$compath/cat2bsq $inpath/mtsoil_0 bin $outpath/mtsoil_0.bin $n $(($nyears*12)) 0
$compath/cat2bsq $inpath/mtsoil_10 bin $outpath/mtsoil_10.bin $n $(($nyears*12)) 0
$compath/cat2bsq $inpath/mtsoil_25 bin $outpath/mtsoil_25.bin $n $(($nyears*12)) 0
$compath/cat2bsq $inpath/mtsoil_50 bin $outpath/mtsoil_50.bin $n $(($nyears*12)) 0
$compath/cat2bsq $inpath/mtsoil_100 bin $outpath/mtsoil_100.bin $n $(($nyears*12)) 0
$compath/cat2bsq $inpath/mtsoil_150 bin $outpath/mtsoil_150.bin $n $(($nyears*12)) 0
$compath/cat2bsq $inpath/mtsoil_200 bin $outpath/mtsoil_200.bin $n $(($nyears*12)) 0
$compath/cat2bsq $inpath/mtemp_soil bin $outpath/mtemp_soil.bin $n $(($nyears*12)) 0
$compath/cat2bsq $inpath/mthaw_depth bin $outpath/mthaw_depth.bin $n $(($nyears*12)) 0
$compath/cat2bsq $inpath/mFwater bin $outpath/mFwater.bin $n $(($nyears*12)) 0
$compath/cat2bsq $inpath/mFice bin $outpath/mFice.bin $n $(($nyears*12)) 0
$compath/cat2bsq $inpath/msnowdepth bin $outpath/msnowdepth.bin $n $(($nyears*12)) 0
$compath/cat2bsq $inpath/mice_frac1 bin $outpath/mice_frac1.bin $n $(($nyears*12)) 0
$compath/cat2bsq $inpath/mice_frac2 bin $outpath/mice_frac2.bin $n $(($nyears*12)) 0
$compath/cat2bsq $inpath/frozen_days bin $outpath/frozen_days.bin $n $(($nyears*12)) 0
$compath/cat2bsq $inpath/dch4e bin $outpath/dch4e.bin $n $(($ndailyyears*365)) 0
$compath/cat2bsq $inpath/dgpp bin $outpath/dgpp.bin $n $(($ndailyyears*365)) 0
$compath/cat2bsq $inpath/dnpp bin $outpath/dnpp.bin $n $(($ndailyyears*365)) 0
$compath/cat2bsq $inpath/drh bin $outpath/drh.bin $n $(($ndailyyears*365)) 0
$compath/cat2bsq $inpath/dsm1 bin $outpath/dsm1.bin $n $(($ndailyyears*365)) 0
$compath/cat2bsq $inpath/dsm2 bin $outpath/dsm2.bin $n $(($ndailyyears*365)) 0

