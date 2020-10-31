#!/bin/bash
#SBATCH --job-name=grimacs     # Job name
#SBATCH --nodes=2                    # Run all processes on a single node	
#SBATCH --partition=htc
#SBATCH --ntasks-per-node=15
#SBATCH --cpus-per-task=4                   # Run a single task		
#SBATCH --time=00:59:00              # Time limit hrs:min:sec
#SBATCH --output=parallel_%j.log     # Standard output and error log


module purge
module load gcc-9.2.0
module load mpi/impi

source ~/gromacs2019-2/bin/GMXRC

mpirun -np 30 -genv I_MPI_PIN_DOMAIN=omp:compact -genv OMP_NUM_THREADS=4  gmx_mpi mdrun -s benchRIB.tpr

