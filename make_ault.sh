#!/bin/bash

cd nccl

# module load cuda/11.6.2
# module load cuda/12.1.1
module load cuda/11.8.0
module list

make clean

export NPKIT_FLAG="-DENABLE_NPKIT"

export NPKIT_ALLREDUCE_FLAGS="-DENABLE_NPKIT_EVENT_ALL_REDUCE_RING_ENTRY -DENABLE_NPKIT_EVENT_ALL_REDUCE_RING_EXIT \
 -DENABLE_NPKIT_EVENT_SEND_ENTRY -DENABLE_NPKIT_EVENT_SEND_EXIT \
 -DENABLE_NPKIT_EVENT_RECV_REDUCE_SEND_ENTRY -DENABLE_NPKIT_EVENT_RECV_REDUCE_SEND_EXIT \
 -DENABLE_NPKIT_EVENT_DIRECT_RECV_REDUCE_COPY_SEND_ENTRY -DENABLE_NPKIT_EVENT_DIRECT_RECV_REDUCE_COPY_SEND_EXIT \
 -DENABLE_NPKIT_EVENT_DIRECT_RECV_COPY_SEND_ENTRY -DENABLE_NPKIT_EVENT_DIRECT_RECV_COPY_SEND_EXIT \
 -DENABLE_NPKIT_EVENT_DIRECT_RECV_ENTRY -DENABLE_NPKIT_EVENT_DIRECT_RECV_EXIT"

# export NPKIT_NCCLKERNEL_SENDRECV_FLAGS="-DENABLE_NPKIT_EVENT_NCCLKERNEL_SEND_RECV_SEND_ENTRY -DENABLE_NPKIT_EVENT_NCCLKERNEL_SEND_RECV_SEND_EXIT \
#  -DENABLE_NPKIT_EVENT_NCCLKERNEL_SEND_RECV_RECV_ENTRY -DENABLE_NPKIT_EVENT_NCCLKERNEL_SEND_RECV_RECV_EXIT"

export NPKIT_PRIMS_SIMPLE_FLAGS="-DENABLE_NPKIT_EVENT_PRIM_SIMPLE_DATA_PROCESS_ENTRY -DENABLE_NPKIT_EVENT_PRIM_SIMPLE_DATA_PROCESS_EXIT"
# export NPKIT_PRIMS_LL_FLAGS="-DENABLE_NPKIT_EVENT_PRIM_LL_DATA_PROCESS_ENTRY -DENABLE_NPKIT_EVENT_PRIM_LL_DATA_PROCESS_EXIT"
# export NPKIT_PRIMS_LL128_FLAGS="-DENABLE_NPKIT_EVENT_PRIM_LL128_DATA_PROCESS_ENTRY -DENABLE_NPKIT_EVENT_PRIM_LL128_DATA_PROCESS_EXIT"

export NPKIT_FLAGS="$NPKIT_FLAG $NPKIT_ALLREDUCE_FLAGS $NPKIT_PRIMS_SIMPLE_FLAGS"

# export TRACING_FLAGS="$NVTX_FLAGS $NPKIT_FLAGS"
# export TRACING_FLAGS="$NVTX_FLAGS"
export TRACING_FLAGS="$NPKIT_FLAGS"

make -j src.build CUDA_HOME=/apps/ault/spack/opt/spack/linux-centos8-zen/gcc-8.4.1/cuda-11.8.0-fjdnxm6yggxxp75sb62xrxxmeg4s24ml NVCC_GENCODE="-gencode=arch=compute_80,code=sm_80" TRACING_FLAGS="$TRACING_FLAGS"
# make -j src.build CUDA_HOME=/apps/ault/spack/opt/spack/linux-centos8-zen/gcc-8.4.1/cuda-11.8.0-fjdnxm6yggxxp75sb62xrxxmeg4s24ml NVCC_GENCODE="-gencode=arch=compute_80,code=sm_80"
