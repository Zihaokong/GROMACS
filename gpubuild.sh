#!/bin/bash
# modified for default Azure SLURM cluster
#SBATCH --job-name="gromacs"
#SBATCH --output="gromacs.%j.%N.out"
#SBATCH --partition=hpc
#SBATCH --nodes=5
#SBATCH --ntasks-per-node=40
#SBATCH --export=ALL
#SBATCH -t 00:10:00

## Environment

## Use srun to run the job


sudo yum install kernel-devel-$(uname -r) kernel-headers-$(uname -r)

sudo rpm -i cuda-repo-rhel7-11-0-local-11.0.2_450.51.05-1.x86_64.rpm
sudo yum clean all
sudo yum -y install nvidia-driver-latest-dkms cuda
sudo yum -y install cuda-drivers
export PATH=$PATH:/usr/local/cuda-11.1/bin
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/cuda-11.1/lib64
