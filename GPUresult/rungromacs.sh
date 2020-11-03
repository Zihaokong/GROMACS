mpirun -np 4 gmx_mpi mdrun -ddorder pp_pme -nb gpu -pme gpu -npme 1 -s benchMEM.tpr
rm confout.gro ener.edr state.cpt
