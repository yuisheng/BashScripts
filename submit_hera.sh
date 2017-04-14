#!/bin/ksh
# ZZ 03.20 2015

inpath=/home/zhen.zhang/slurm/
modelListEns=( $( ls $inpath*transient.sh ) )   #To select all model names
for fullName in ${modelListEns[@]}; do #loop through models
sbatch $fullName
done
