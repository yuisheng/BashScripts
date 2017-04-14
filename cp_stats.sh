#!/bin/ksh
#Written by zhen.zhang@wsl.ch
fdirCMIP5='/Users/zhang/Research/data/output'
set -A rcpArray rcp26 rcp45 rcp60 rcp85

for rcp in ${rcpArray[@]}; do;
	#For input for RCP data
	inpath='/mnt/lustrefs/work/zhen.zhang/output/'$rcp'/'

	modelListEns=( $( ls $inpath ) )     #To select all models
		for fullName in ${modelListEns[@]}; do;
			outpath='/Users/zhang/Research/data/output/'$rcp'/'$fullName'/stats'
	           	ssh zhang@153.90.240.159  \'mkdir -p ${outpath}\' 
		 	scp -rp ${inpath}${fullName}'/stats' zhang@153.90.240.159:$outpath
		done

done

