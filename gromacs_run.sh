#!/bin/bash
#SBATCH --job-name=gromacs     # Job name
#SBATCH --nodes=2                    # Run all processes on a single node	
#SBATCH --partition=hpc
#SBATCH --ntasks-per-node=30
#SBATCH --cpus-per-task=4                   # Run a single task		
#SBATCH --time=00:59:00              # Time limit hrs:min:sec
#SBATCH --output=parallel_%j.log     # Standard output and error log


module purge
module load gcc-9.2.0
module load mpi/impi
source ~/spack/share/spack/setup-env.sh
spack compiler find
spack load hwloc
PATH=$PATH:/usr/local/cuda-11.0/bin
LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/cuda-11.0/lib64

source ~/gromacs2020/bin/GMXRC

mpirun -np 30 -genv I_MPI_PIN_DOMAIN=omp:compact -genv OMP_NUM_THREADS=4  gmx_mpi mdrun -s benchMEM.tpr

