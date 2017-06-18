#!/bin/ksh
#Copy Output.RData to local laptop
#Zhen 24th Sep 2016
 

fdir='/Users/zhang/Research/data/output/'
clmVar='ERA-Interim'

#set -A rcpArray CRU_2016_USDA_MLIT_PERMAFROST_SWAMPS CRU_2016_USDA_MLIT_PERMAFROST
#set -A rcpArray MERRA2_2016_USDA_DLIT_PERMAFROST_MONTHLY_SWAMPS MERRA2_2016_USDA_DLIT_PERMAFROST_MONTHLY MERRA2_2016_USDA_DLIT_PERMAFROST
set -A rcpArray ERA_2016_USDA_DLIT_PERMAFROST ERA_2016_USDA_DLIT_PERMAFROST_MONTHLY_SWAMPS ERA_2016_USDA_DLIT_PERMAFROST_MONTHLY
for rcp in ${rcpArray[@]}; do;
	inpath='w94w693@hyalite.rcg.montana.edu:/mnt/lustrefs/store/zhen.zhang/output/'${clmVar}'/'$rcp'/merge/Output.RData'
    outpath=$fdir'/'${clmVar}'/'$rcp'/stats/'
	    if [ ! -d $outpath ]; then
   	         mkdir -p $outpath
	    fi
	scp -rp $inpath $outpath
	echo $rcp
done
