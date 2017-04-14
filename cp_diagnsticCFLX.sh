#!/bin/ksh
# Copy major LPJ diagnostic outputs from remote path to local path
indir='/mnt/lustrefs/store/zhen.zhang/output/MERRA2/MERRA2_2016_USDA_MLIT_PERMAFROST/merge/'
outdir='/Users/zhang/Research/data/output/MERRA2/MERRA2_2016_USDA_MLIT_PERMAFROST/merge/'

#Make the output directory if it doesn't exist
if [ ! -d $outdir ]; then
    mkdir $outdir
fi

scp -rp 'w94w693@hyalite.rcg.montana.edu:'${indir}'grid.out' $outdir

set -A varArray mgpp mnpp mrh firec flux_luc flux_harvest vegc flux_estab soilc litc ch4e
for var in ${varArray[@]}; do;
	     inpath='w94w693@hyalite.rcg.montana.edu:'${indir}${var}'.bin'
         outpath=${outdir}
	     scp -rp $inpath $outpath
	     echo $var
done
