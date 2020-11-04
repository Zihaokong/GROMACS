#!/bin/bash
#SBATCH --job-name=gromacs     # Job name
#SBATCH --nodes=4                    # Run all processes on a single node
#SBATCH --partition=hpc
#SBATCH --ntasks-per-node=60
#SBATCH --time=04:00:00              # Time limit hrs:min:sec
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


if [[ ! -d water-cut1.0_GMX50_bare ]]; then
  if [[ ! -f water_GMX50_bare.tar.gz ]]; then
    wget ftp://ftp.gromacs.org/pub/benchmarks/water_GMX50_bare.tar.gz
  fi
  tar -xzvf water_GMX50_bare.tar.gz
fi

cp water-cut1.0_GMX50_bare/3072/pme.mdp ./
cp water-cut1.0_GMX50_bare/3072/conf.gro ./
cp water-cut1.0_GMX50_bare/3072/topol.top ./

mpirun -np 1 gmx_mpi grompp -f 'pme.mdp' -c 'conf.gro' -p 'topol.top'
mpirun -np 240 gmx_mpi mdrun -nb cpu -pin on -resethway -noconfout -nsteps 8000  -g md260.log -v;


