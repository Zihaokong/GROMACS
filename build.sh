export LC_ALL=C

# Add software repositories
sudo yum -y install epel-release

# Install system software metapackages
sudo yum -y groupinstall "Development Tools"
sudo yum -y groupinstall "Additional Development"
sudo yum -y groupinstall "Compatibility Libraries"

# Update all software packages to their latest versions
sudo yum -y check-update && sudo yum -y update

sudo yum -y install bc
sudo yum -y install cmake3
sudo yum -y install curl
sudo yum -y install expect
sudo yum -y install mlocate
sudo yum -y install python3
sudo yum -y install rsync
sudo yum -y install time
sudo yum -y install vim-minimal
sudo yum -y install wget

sudo yum install centos-release-scl
sudo yum install devtoolset-8
scl enable devtoolset-8 bash

git clone https://github.com/Zihaokong/GROMACS.git

wget ftp://ftp.gromacs.org/pub/gromacs/gromacs-2019.tar.gz
tar -xvf gromacs-2019.tar.gz
rm gromacs-2019.tar.gz
git clone https://github.com/spack/spack ~/spack
cd spack 
git checkout releases/v0.15
. share/spack/setup-env.sh
spack compiler find
spack install fftw@3.3.8 % gcc@9.2.0
spack load fftw
