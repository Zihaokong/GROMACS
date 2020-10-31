#!/bin/bash
#SBATCH --job-name=parallel_job      # Job name
#SBATCH --nodes=1                    # Run all processes on a single node	
#SBATCH --ntasks-per-node=4                   # Run a single task		
#SBATCH --time=00:05:00              # Time limit hrs:min:sec
#SBATCH --output=parallel_%j.log     # Standard output and error log
pwd; hostname; date

echo "Running prime number generator program on $SLURM_CPUS_ON_NODE CPU cores"

mpirun -np 4 a.out

date
