#!/bin/ksh

fdirCMIP5='/Users/zhang/Research/data/output/cmip5'

set -A rcpArray rcp26 rcp45 rcp60 rcp85
for rcp in ${rcpArray[@]}; do;
        dirpath=$fdirCMIP5'/'$rcp'/'
	modelListEns=( $( ls $dirpath) )     #To select all models
	for model in ${modelListEns[@]}; do;
	     inpath='w94w693@hyalite.rcg.montana.edu:/mnt/lustrefs/store/zhen.zhang/output/CMIP5_CH4E/'$rcp'/'$model'/stats/*global.txt'
	     #inpath='zhang@153.90.240.137:'$fdirCMIP5'/'$rcp'/'$model'/stats'
	     #inpath='zhang@153.90.240.159:'$fdirCMIP5'/'$rcp'/'$model'/stats'
         outpath=$fdirCMIP5'/'$rcp'/'$model'/stats/'
	     if [ ! -d $outpath ]; then
   	         mkdir -p $outpath
	     fi
         scp -rp $inpath $outpath
	     echo $model
        done
done
