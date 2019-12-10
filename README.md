# Running WRF-GC on Massively Parallel Architectures Test on AWS

**Disclaimer:** These results are *preliminary*. They will need to be verified and validated. But the results are too exciting to be kept private and thus this repository was created to archive the results. Please contact hplin at seas.harvard.edu (Haipeng Lin) with any questions.

## What is this?

This repository contains logs of a massively parallel, thousand-core run of WRF-GC (WRF coupled with GEOS-Chem chemistry, http://wrf.geos-chem.org) on the Amazon Web Services (AWS) Cloud.

We conducted a multi-thousand core run of WRF-GC using `c5n.18xlarge` nodes on the AWS cloud, on a private HPC cluster created using `aws-parallelcluster`. The system was configured with one Lustre file system using Amazon FSx. The capacity was 14 TB.

## Software configuration

You can read about the software configuration [in my blog post about setting up WRF-GC on AWS](https://jimmielin.me/2019/wrf-gc-aws/). In short: Intel C/Fortran compiler, Intel MPI with EFA by AWS, and standard **serial** netCDF, hdf5. **We used a high-performance file system but not parallel I/O in this run.**

We used WRF-GC release 1.0.1 (GEOS-Chem 12.2.1) for this test. It is the same as WRF-GC public release for the Part 1 paper submitted by Lin et al., to Geosci. Model Dev. with [an added minor fix](https://github.com/geoschem/geos-chem/pull/165).

## Configuration Files

Configuration files for this scalability test are permanently archived in this repository. The results may be later published in a paper by the authors.

`aws-parallelcluster` was configured in the following way (sensitive information removed).
```
[aws]
aws_region_name = us-east-2

[cluster default]
key_name = ...
vpc_settings = hplintest1

master_instance_type = c5n.large
compute_instance_type = c5n.18xlarge
cluster_type = spot
initial_queue_size = 2
scheduler = slurm
placement_group = DYNAMIC

ebs_settings = hplinebs
base_os = centos7

enable_efa = compute

fsx_settings = fs


[fsx fs]
shared_dir = /fsx
storage_capacity = 14400

[vpc hplintest1]
vpc_id = vpc-...
master_subnet_id = subnet-...

[ebs hplinebs]
shared_dir = shared
volume_type = st1
volume_size = 500
```