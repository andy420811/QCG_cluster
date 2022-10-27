#!/bin/bash
#PBS -l walltime=00:30:00
#PBS -l select=1:ncpus=40
#PBS -q ctest
#PBS -P TRI1112802
#PBS -j oe
#PBS -M andy420811@gmail.com
#PBS -m be

## go to the working directory and create a folder with the name using JOBID
work=/work1/andy420811
cd $work
mkdir $PBS_JOBID
cd $PBS_JOBID
jobid=$PBS_JOBID
## copy the file from submission folder to the working directory
cp $PBS_O_WORKDIR/benezene.coord .
cp $PBS_O_WORKDIR/pentanol.xyz .

## environment variables for xtb
export OMP_STACKSIZE=12G     ## memory size
export OMP_NUM_THREADS=40,1  ## cores used

## execute command line
crest pentanol.xyz --qcg benezene.coord --nsolv 25 --T 40 --gsolv --nclus 4 --fscal 0.65 --gbsa benzene > crest.out

## copy back
rsync -a * $PBS_O_WORKDIR/Gsol_benz_pent

## remove the tmp files
cd ..
echo $jobid
rm -r $jobid

exit

