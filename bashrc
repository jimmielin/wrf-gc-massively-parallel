export PATH=/shared/spack/bin:$PATH

module load intelmpi
export I_MPI_CC=icc
export I_MPI_CXX=icpc
export I_MPI_FC=ifort
export I_MPI_F77=ifort
export I_MPI_F90=ifort

export CC=icc
export FC=ifort
export CXX=icpc


source $(spack location -i intel)/bin/compilervars.sh -arch intel64

export PATH=$(spack location -i netcdf-c)/bin:$PATH
export PATH=$(spack location -i netcdf-fortran)/bin:$PATH
# Environment variables required by WRF
export HDF5=$(spack location -i hdf5)
export NETCDF=$(spack location -i netcdf-fortran)

# run-time linking
export LD_LIBRARY_PATH=$HDF5/lib:$NETCDF/lib:$LD_LIBRARY_PATH

# this prevents segmentation fault when running the model
ulimit -s unlimited

# WRF-specific settings
export WRF_EM_CORE=1
export WRFIO_NCD_NO_LARGE_FILE_SUPPORT=0
export WRF_CHEM=1

export ESMF_COMM=intelmpi
export ESMF_COMPILER=intel

export I_MPI_PMI_LIBRARY=/opt/slurm/lib/libpmi.so  # enable slurm

export I_MPI_FABRICS=shm:ofi  # use libfabric (default)
export FI_PROVIDER=efa  #  enable EFA  (default)
source /opt/intel/compilers_and_libraries/linux/mpi/intel64/bin/mpivars.sh -ofi_internal=0  # do not use intel-provided libfabr$
# Some quick aliases to work with
alias vn="vi namelist.input"
alias vrc="vi ~/.bashrc"

alias tt="tail -f rsl.out.0000"
alias te="tail -n 50 rsl.* | less"

alias mco="rm rsl.*; rm wrfout_*"

alias itr="srun -N 1 --ntasks-per-node 36 --pty /bin/bash"

# NCL
export NCARG_ROOT="/shared/ncl"
export PATH="$NCARG_ROOT/bin:$PATH"