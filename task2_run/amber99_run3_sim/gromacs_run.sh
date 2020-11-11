#!/bin/bash
#SBATCH --job-name=amber99     # Job name
#SBATCH --nodes=6                    # Run all processes on a single node	
#SBATCH --partition=hpc
#SBATCH --ntasks-per-node=30
#SBATCH --cpus-per-task=4                   # Run a single task		
#SBATCH --time=09:00:00              # Time limit hrs:min:sec
#SBATCH --output=parallel_%j.log     # Standard output and error log


module purge
module load gcc-9.2.0
module load mpi/impi
source ~/spack/share/spack/setup-env.sh
spack compiler find
spack load hwloc
export PATH=$PATH:/usr/local/cuda-11.0/bin
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/cuda-11.0/lib64

source ~/gromacs2020/bin/GMXRC

{ time mpirun -np 150 -genv I_MPI_PIN_DOMAIN=omp:compact -genv OMP_NUM_THREADS=4  gmx_mpi mdrun -s production.tpr -g md_replica_amber99_0_4ns.log -o md_replica_amber99_0_4ns.trr -e md_replica_amber99_0_4ns.edr; } 2> time1.txt
{ time mpirun -np 150 -genv I_MPI_PIN_DOMAIN=omp:compact -genv OMP_NUM_THREADS=4  gmx_mpi mdrun -s production.tpr -g md_replica_amber99_1_4ns.log -o md_replica_amber99_1_4ns.trr -e md_replica_amber99_1_4ns.edr; } 2> time2.txt
{ time mpirun -np 150 -genv i_mpi_pin_domain=omp:compact -genv omp_num_threads=4  gmx_mpi mdrun -s production.tpr -g md_replica_amber99_2_4ns.log -o md_replica_amber99_2_4ns.trr -e md_replica_amber99_2_4ns.edr; } 2> time3.txt



























