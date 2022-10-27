#!/bin/bash
#PBS -l walltime=10:00:00
#PBS -l select=1:ncpus=40
#PBS -q cf40
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

filename=$(basename -- "$PBS_O_WORKDIR")

echo $filename
## copy the file from submission folder to the working directory
cp "${PBS_O_WORKDIR}"/"$filename".xyz .
cp "$PBS_O_WORKDIR"/water.xyz .

## environment variables for xtb
export OMP_STACKSIZE=350G     ## memory size
export OMP_NUM_THREADS=40,1  ## cores used

## execute command line
crest "$filename".xyz --qcg water.xyz --nsolv 25 --T 40 --gsolv --nclus 4 --gbsa water > crest.out

## copy back
rsync -a * "$PBS_O_WORKDIR"

## remove the tmp files
cd ..
echo $jobid
rm -r $jobid

exit

