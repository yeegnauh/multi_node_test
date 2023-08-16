#!/bin/bash
#sh test_Ngpu_Mb_rankX.sh $RANK 32 13
rankX=$1
Ngpu=$2
Mb=$3

log_dir="log_${Ngpu}gpu_${Mb}B"
mkdir -p $log_dir
conf_dir="config_${Ngpu}gpu_${Mb}B"

config_ids=(1 2 3)
for n in ${config_ids[@]};do
#for n in {1..3};do
    conf_file=./${conf_dir}/${Mb}B_sft_$n.py
    log_file=$log_dir/${Mb}B_sft_$n.log
    ls ${conf_file} 2>&1 | tee ${log_file}
    echo `grep -E "checkpoint=|micro_num=|micro_bsz=|zero1=|pipeline=|tensor=" ${conf_file}` 2>&1 | tee -a  ${log_file}
    torchrun --nnodes=4 --nproc_per_node=8 --node_rank=$1 --master_addr=10.198.34.129 --master_port=29600 train.py --config ${conf_file} --launcher "torch" 2>&1 | tee -a ${log_file}
    sleep 10
done
