export LC_ALL=C

# open mpi
module load mpi/impi
module load gcc-9.2.0
sudo mv /usr/bin/python /usr/bin/python-origin
sudo ln -s python2.7 /usr/bin/python

# Add software repositories
sudo yum -y install epel-release

# Install system software metapackages
sudo yum -y groupinstall "Development Tools"
sudo yum -y groupinstall "Additional Development"
sudo yum -y groupinstall "Compatibility Libraries"

# Update all software packages to their latest versions
sudo yum -y check-update && sudo yum -y update

# cmake3 
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



git clone https://github.com/spack/spack
cd spack 
git checkout releases/v0.15
. share/spack/setup-env.sh
spack compiler find
spack install hwloc@2.1.0 % gcc@9.2.0
spack load hwloc
cd ~

wget http://developer.download.nvidia.com/compute/cuda/11.0.2/local_installers/cuda-repo-rhel7-11-0-local-11.0.2_450.51.05-1.x86_64.rpm
sudo rpm -i cuda-repo-rhel7-11-0-local-11.0.2_450.51.05-1.x86_64.rpm
sudo yum clean all
sudo yum -y install nvidia-driver-latest-dkms cuda
sudo yum -y install cuda-drivers

PATH=$PATH:/usr/local/cuda-11.0/bin
LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/cuda-11.0/lib64


PATH=$PATH:/usr/local/cuda-11.0/bin
LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/cuda-11.0/lib64


wget ftp://ftp.gromacs.org/pub/gromacs/gromacs-2020.4.tar.gz
tar xfz gromacs-2020.4.tar.gz
cd gromacs-2020.4
mkdir build
cd build



module load gcc-9.2.0
module load mpi/impi

cmake3 .. -DCMAKE_C_COMPILER=mpicc -DCMAKE_CXX_COMPILER=mpicxx -DGMX_PREFER_STATIC_LIBS=ON  -DBUILD_SHARED_LIBS=OFF -DGMX_EXTERNAL_BLAS=OFF -DGMX_BUILD_OWN_FFTW=ON -DGMX_MPI=ON -DGMX_OPENMP=ON  -DGMX_GPU=ON -DGMX_SIMD=AVX2_256 -DCMAKE_INSTALL_PREFIX="$HOME/gromacs2020"
make -j $(nproc)
make -j $(nproc) check
make install


source ~/gromacs2020/bin/GMXRC
wget https://www.mpibpc.mpg.de/15101317/benchMEM.zip
unzip benchMEM.zip
rm benchMEM.zip
