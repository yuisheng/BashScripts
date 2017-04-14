#!/bin/ksh
# ZZ 03.20 2015
cdo ensmean /mnt/lustrefs/work/zhen.zhang/output/rcp26/bcc-csm1-1/merge/LPJ_acSoil.nc /mnt/lustrefs/work/zhen.zhang/output/rcp26/bcc-csm1-1-m/merge/LPJ_acSoil.nc /mnt/lustrefs/work/zhen.zhang/output/rcp26/BNU-ESM/merge/LPJ_acSoil.nc /mnt/lustrefs/work/zhen.zhang/output/rcp26/CanESM2/merge/LPJ_acSoil.nc /mnt/lustrefs/work/zhen.zhang/output/rcp26/CCSM4/merge/LPJ_acSoil.nc /mnt/lustrefs/work/zhen.zhang/output/rcp26/CESM1-CAM5/merge/LPJ_acSoil.nc /mnt/lustrefs/work/zhen.zhang/output/rcp26/CNRM-CM5/merge/LPJ_acSoil.nc /mnt/lustrefs/work/zhen.zhang/output/rcp26/CSIRO-Mk3-6-0/merge/LPJ_acSoil.nc /mnt/lustrefs/work/zhen.zhang/output/rcp26/FGOALS-g2/merge/LPJ_acSoil.nc /mnt/lustrefs/work/zhen.zhang/output/rcp26/FIO-ESM/merge/LPJ_acSoil.nc /mnt/lustrefs/work/zhen.zhang/output/rcp26/GFDL-CM3/merge/LPJ_acSoil.nc /mnt/lustrefs/work/zhen.zhang/output/rcp26/GISS-E2-H/merge/LPJ_acSoil.nc /mnt/lustrefs/work/zhen.zhang/output/rcp26/GISS-E2-R/merge/LPJ_acSoil.nc /mnt/lustrefs/work/zhen.zhang/output/rcp26/HadGEM2-AO/merge/LPJ_acSoil.nc /mnt/lustrefs/work/zhen.zhang/output/rcp26/HadGEM2-ES/merge/LPJ_acSoil.nc /mnt/lustrefs/work/zhen.zhang/output/rcp26/IPSL-CM5A-LR/merge/LPJ_acSoil.nc /mnt/lustrefs/work/zhen.zhang/output/rcp26/IPSL-CM5A-MR/merge/LPJ_acSoil.nc /mnt/lustrefs/work/zhen.zhang/output/rcp26/MIROC5/merge/LPJ_acSoil.nc /mnt/lustrefs/work/zhen.zhang/output/rcp26/MIROC-ESM/merge/LPJ_acSoil.nc /mnt/lustrefs/work/zhen.zhang/output/rcp26/MIROC-ESM-CHEM/merge/LPJ_acSoil.nc /mnt/lustrefs/work/zhen.zhang/output/rcp26/MPI-ESM-LR/merge/LPJ_acSoil.nc /mnt/lustrefs/work/zhen.zhang/output/rcp26/MPI-ESM-MR/merge/LPJ_acSoil.nc /mnt/lustrefs/work/zhen.zhang/output/rcp26/MRI-CGCM3/merge/LPJ_acSoil.nc /mnt/lustrefs/work/zhen.zhang/output/rcp26/NorESM1-M/merge/LPJ_acSoil.nc /mnt/lustrefs/work/zhen.zhang/output/rcp26/NorESM1-ME/merge/LPJ_acSoil.nc soilc_rcp26.nc
cdo ensmean /mnt/lustrefs/work/zhen.zhang/output/rcp45/ACCESS1-0/merge/LPJ_acSoil.nc /mnt/lustrefs/work/zhen.zhang/output/rcp45/ACCESS1-3/merge/LPJ_acSoil.nc /mnt/lustrefs/work/zhen.zhang/output/rcp45/bcc-csm1-1/merge/LPJ_acSoil.nc /mnt/lustrefs/work/zhen.zhang/output/rcp45/bcc-csm1-1-m/merge/LPJ_acSoil.nc /mnt/lustrefs/work/zhen.zhang/output/rcp45/BNU-ESM/merge/LPJ_acSoil.nc /mnt/lustrefs/work/zhen.zhang/output/rcp45/CanESM2/merge/LPJ_acSoil.nc /mnt/lustrefs/work/zhen.zhang/output/rcp45/CESM1-BGC/merge/LPJ_acSoil.nc /mnt/lustrefs/work/zhen.zhang/output/rcp45/CESM1-CAM5/merge/LPJ_acSoil.nc /mnt/lustrefs/work/zhen.zhang/output/rcp45/CMCC-CM/merge/LPJ_acSoil.nc /mnt/lustrefs/work/zhen.zhang/output/rcp45/CMCC-CMS/merge/LPJ_acSoil.nc /mnt/lustrefs/work/zhen.zhang/output/rcp45/CNRM-CM5/merge/LPJ_acSoil.nc /mnt/lustrefs/work/zhen.zhang/output/rcp45/CSIRO-Mk3-6-0/merge/LPJ_acSoil.nc /mnt/lustrefs/work/zhen.zhang/output/rcp45/FGOALS-g2/merge/LPJ_acSoil.nc /mnt/lustrefs/work/zhen.zhang/output/rcp45/FIO-ESM/merge/LPJ_acSoil.nc /mnt/lustrefs/work/zhen.zhang/output/rcp45/GISS-E2-H/merge/LPJ_acSoil.nc /mnt/lustrefs/work/zhen.zhang/output/rcp45/GISS-E2-H-CC/merge/LPJ_acSoil.nc /mnt/lustrefs/work/zhen.zhang/output/rcp45/GISS-E2-R/merge/LPJ_acSoil.nc /mnt/lustrefs/work/zhen.zhang/output/rcp45/GISS-E2-R-CC/merge/LPJ_acSoil.nc /mnt/lustrefs/work/zhen.zhang/output/rcp45/HadGEM2-AO/merge/LPJ_acSoil.nc /mnt/lustrefs/work/zhen.zhang/output/rcp45/HadGEM2-CC/merge/LPJ_acSoil.nc /mnt/lustrefs/work/zhen.zhang/output/rcp45/HadGEM2-ES/merge/LPJ_acSoil.nc /mnt/lustrefs/work/zhen.zhang/output/rcp45/inmcm4/merge/LPJ_acSoil.nc /mnt/lustrefs/work/zhen.zhang/output/rcp45/IPSL-CM5A-LR/merge/LPJ_acSoil.nc /mnt/lustrefs/work/zhen.zhang/output/rcp45/IPSL-CM5A-MR/merge/LPJ_acSoil.nc /mnt/lustrefs/work/zhen.zhang/output/rcp45/IPSL-CM5B-LR/merge/LPJ_acSoil.nc /mnt/lustrefs/work/zhen.zhang/output/rcp45/MIROC5/merge/LPJ_acSoil.nc /mnt/lustrefs/work/zhen.zhang/output/rcp45/MIROC-ESM/merge/LPJ_acSoil.nc /mnt/lustrefs/work/zhen.zhang/output/rcp45/MIROC-ESM-CHEM/merge/LPJ_acSoil.nc /mnt/lustrefs/work/zhen.zhang/output/rcp45/MPI-ESM-LR/merge/LPJ_acSoil.nc /mnt/lustrefs/work/zhen.zhang/output/rcp45/MPI-ESM-MR/merge/LPJ_acSoil.nc /mnt/lustrefs/work/zhen.zhang/output/rcp45/MRI-CGCM3/merge/LPJ_acSoil.nc soilc_rcp45.nc
cdo ensmean /mnt/lustrefs/work/zhen.zhang/output/rcp60/bcc-csm1-1/merge/LPJ_acSoil.nc /mnt/lustrefs/work/zhen.zhang/output/rcp60/bcc-csm1-1-m/merge/LPJ_acSoil.nc /mnt/lustrefs/work/zhen.zhang/output/rcp60/CCSM4/merge/LPJ_acSoil.nc /mnt/lustrefs/work/zhen.zhang/output/rcp60/CESM1-CAM5/merge/LPJ_acSoil.nc /mnt/lustrefs/work/zhen.zhang/output/rcp60/CSIRO-Mk3-6-0/merge/LPJ_acSoil.nc /mnt/lustrefs/work/zhen.zhang/output/rcp60/FIO-ESM/merge/LPJ_acSoil.nc /mnt/lustrefs/work/zhen.zhang/output/rcp60/GFDL-CM3/merge/LPJ_acSoil.nc /mnt/lustrefs/work/zhen.zhang/output/rcp60/GISS-E2-H/merge/LPJ_acSoil.nc /mnt/lustrefs/work/zhen.zhang/output/rcp60/GISS-E2-R/merge/LPJ_acSoil.nc /mnt/lustrefs/work/zhen.zhang/output/rcp60/HadGEM2-AO/merge/LPJ_acSoil.nc /mnt/lustrefs/work/zhen.zhang/output/rcp60/IPSL-CM5A-LR/merge/LPJ_acSoil.nc /mnt/lustrefs/work/zhen.zhang/output/rcp60/IPSL-CM5A-MR/merge/LPJ_acSoil.nc /mnt/lustrefs/work/zhen.zhang/output/rcp60/MIROC5/merge/LPJ_acSoil.nc /mnt/lustrefs/work/zhen.zhang/output/rcp60/MIROC-ESM/merge/LPJ_acSoil.nc /mnt/lustrefs/work/zhen.zhang/output/rcp60/MIROC-ESM-CHEM/merge/LPJ_acSoil.nc /mnt/lustrefs/work/zhen.zhang/output/rcp60/MRI-CGCM3/merge/LPJ_acSoil.nc /mnt/lustrefs/work/zhen.zhang/output/rcp60/NorESM1-M/merge/LPJ_acSoil.nc /mnt/lustrefs/work/zhen.zhang/output/rcp60/NorESM1-ME/merge/LPJ_acSoil.nc soilc_rcp60.nc
cdo ensmean /mnt/lustrefs/work/zhen.zhang/output/rcp85/ACCESS1-0/merge/LPJ_acSoil.nc /mnt/lustrefs/work/zhen.zhang/output/rcp85/ACCESS1-3/merge/LPJ_acSoil.nc /mnt/lustrefs/work/zhen.zhang/output/rcp85/bcc-csm1-1/merge/LPJ_acSoil.nc /mnt/lustrefs/work/zhen.zhang/output/rcp85/bcc-csm1-1-m/merge/LPJ_acSoil.nc /mnt/lustrefs/work/zhen.zhang/output/rcp85/BNU-ESM/merge/LPJ_acSoil.nc /mnt/lustrefs/work/zhen.zhang/output/rcp85/CanESM2/merge/LPJ_acSoil.nc /mnt/lustrefs/work/zhen.zhang/output/rcp85/CCSM4/merge/LPJ_acSoil.nc /mnt/lustrefs/work/zhen.zhang/output/rcp85/CESM1-BGC/merge/LPJ_acSoil.nc /mnt/lustrefs/work/zhen.zhang/output/rcp85/CESM1-CAM5/merge/LPJ_acSoil.nc /mnt/lustrefs/work/zhen.zhang/output/rcp85/CMCC-CESM/merge/LPJ_acSoil.nc /mnt/lustrefs/work/zhen.zhang/output/rcp85/CMCC-CM/merge/LPJ_acSoil.nc /mnt/lustrefs/work/zhen.zhang/output/rcp85/CMCC-CMS/merge/LPJ_acSoil.nc /mnt/lustrefs/work/zhen.zhang/output/rcp85/CNRM-CM5/merge/LPJ_acSoil.nc /mnt/lustrefs/work/zhen.zhang/output/rcp85/CSIRO-Mk3-6-0/merge/LPJ_acSoil.nc /mnt/lustrefs/work/zhen.zhang/output/rcp85/FIO-ESM/merge/LPJ_acSoil.nc /mnt/lustrefs/work/zhen.zhang/output/rcp85/GFDL-CM3/merge/LPJ_acSoil.nc /mnt/lustrefs/work/zhen.zhang/output/rcp85/GISS-E2-H/merge/LPJ_acSoil.nc /mnt/lustrefs/work/zhen.zhang/output/rcp85/GISS-E2-R/merge/LPJ_acSoil.nc /mnt/lustrefs/work/zhen.zhang/output/rcp85/HadGEM2-AO/merge/LPJ_acSoil.nc /mnt/lustrefs/work/zhen.zhang/output/rcp85/HadGEM2-CC/merge/LPJ_acSoil.nc /mnt/lustrefs/work/zhen.zhang/output/rcp85/inmcm4/merge/LPJ_acSoil.nc /mnt/lustrefs/work/zhen.zhang/output/rcp85/IPSL-CM5A-LR/merge/LPJ_acSoil.nc /mnt/lustrefs/work/zhen.zhang/output/rcp85/IPSL-CM5A-MR/merge/LPJ_acSoil.nc /mnt/lustrefs/work/zhen.zhang/output/rcp85/IPSL-CM5B-LR/merge/LPJ_acSoil.nc /mnt/lustrefs/work/zhen.zhang/output/rcp85/MIROC5/merge/LPJ_acSoil.nc /mnt/lustrefs/work/zhen.zhang/output/rcp85/MIROC-ESM/merge/LPJ_acSoil.nc /mnt/lustrefs/work/zhen.zhang/output/rcp85/MIROC-ESM-CHEM/merge/LPJ_acSoil.nc /mnt/lustrefs/work/zhen.zhang/output/rcp85/MPI-ESM-LR/merge/LPJ_acSoil.nc /mnt/lustrefs/work/zhen.zhang/output/rcp85/MPI-ESM-MR/merge/LPJ_acSoil.nc /mnt/lustrefs/work/zhen.zhang/output/rcp85/MRI-CGCM3/merge/LPJ_acSoil.nc /mnt/lustrefs/work/zhen.zhang/output/rcp85/NorESM1-M/merge/LPJ_acSoil.nc /mnt/lustrefs/work/zhen.zhang/output/rcp85/NorESM1-ME/merge/LPJ_acSoil.nc soilc_rcp85.nc
