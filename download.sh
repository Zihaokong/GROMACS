wget ftp://ftp.gromacs.org/pub/benchmarks/water_GMX50_bare.tar.gz
tar -xzvf water_GMX50_bare.tar.gz
cp water-cut1.0_GMX50_bare/3072/pme.mdp ./
cp water-cut1.0_GMX50_bare/3072/conf.gro ./
cp water-cut1.0_GMX50_bare/3072/topol.top ./
 mpirun -np 1 gmx_mpi grompp -f 'pme.mdp' -c 'conf.gro' -p 'topol.top'
