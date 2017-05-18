#!/bin/ksh
#Copy Output.RData to local laptop
#Zhen 24th Sep 2016
 

fdir='/Users/zhang/Research/data/output/'
clmVar='CRU'

set -A rcpArray CRU_2015_USDA_MLIT_PERMAFROST_SWAMPS CRU_2015_USDA_MLIT_PERMAFROST
#set -A rcpArray MERRA2_2016_USDA_MLIT_PERMAFROST_MONTHLY_SWAMPS
for rcp in ${rcpArray[@]}; do;
	inpath='w94w693@hyalite.rcg.montana.edu:/mnt/lustrefs/store/zhen.zhang/output/'${clmVar}'/'$rcp'/merge/Output.RData'
    outpath=$fdir'/'${clmVar}'/'$rcp'/stats/'
	    if [ ! -d $outpath ]; then
   	         mkdir -p $outpath
	    fi
	scp -rp $inpath $outpath
	echo $rcp
done
