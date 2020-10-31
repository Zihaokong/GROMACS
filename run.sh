#!/bin/bash
# modified for default Azure SLURM cluster
#SBATCH --job-name="gromacs"
#SBATCH --output="gromacs.%j.%N.out"
#SBATCH --partition=hpc
#SBATCH --nodes=2
#SBATCH --ntasks-per-node=240
#SBATCH --export=ALL
#SBATCH -t 00:10:00

## Environment
module purge
module load mpi/openmpi-4.0.4
source /mnt/exports/shared/home/ccuser/spack/share/spack/setup-env.sh
spack compiler find
spack load fftw
source ./mnt/exports/shared/home/ccuser/gromacs2019-2/bin/GMXRC

## Use srun to run the job

mpirun -np 200 mpirun gmx_mpi mdrun -s topol.tpr

