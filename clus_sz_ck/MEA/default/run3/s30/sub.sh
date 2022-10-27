#!/bin/bash
#PBS -l walltime=10:00:00
#PBS -l select=1:ncpus=25:mem=160gb
#PBS -q ct160
#PBS -P MST111382
#PBS -j oe
#PBS -M andy420811tmp@gmail.com
#PBS -m e

## go to the working directory and create a folder with the name using JOBID
work=/work1/andy420811
cd $work
mkdir $PBS_JOBID
cd $PBS_JOBID
jobid=$PBS_JOBID


## copy the file from submission folder to the working directory
cp "$PBS_O_WORKDIR"/input.xyz .
cp "$PBS_O_WORKDIR"/water.xyz .
##rsync -a "$PBS_O_WORKDIR"/* .


## environment variables for xtb
export OMP_STACKSIZE=160G     ## memory size
export OMP_NUM_THREADS=25,1  ## cores used

## execute command line
crest input.xyz --qcg water.xyz --chrg 0 --uhf 0 --nsolv 30  --T 25 --gsolv --nclus 20 --gbsa water > crest.out

## copy back
rsync -a * "$PBS_O_WORKDIR"

## remove the tmp files
cd ..
echo $jobid
rm -r $jobid

exit

