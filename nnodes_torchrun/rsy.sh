#!/bin/bash
#sh rsy.sh

dev_ids=(130 131 132)
for n in ${dev_ids[@]};do
    rsync -autP --delete --exclude={'65b_train','13b_train','7b_train','log_32gpu_13B','log_32gpu_65B','log_32gpu_7B'} ~/internLM_0808dev huangye@10.198.34.$n:~/
    sleep 1
done
