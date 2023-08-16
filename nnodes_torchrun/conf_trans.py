''' config.csv
id,zero,pp,tp,micro_num,micro_bsz
1,-1,4,1,64,2
2,-1,4,1,128,2
3,-1,4,1,256,2
'''
''' demo.py -> config files
[huangye@SH-IDC1-10-198-34-129 13B_config]$ cat 13B_sft_demo.py | grep flag
    micro_num=flag_micro_num,
    zero1=flag_zero,
    pipeline=dict(size=flag_pp, interleaved_overlap=True),
    tensor=flag_tensor,
'''

import pandas as pd
import subprocess
csvfile = open('./config.csv', encoding='utf-8')
df = pd.read_csv(csvfile, engine='python')

print(len(df))
for i in range(len(df)):
    flag_micro_num = df["micro_num"][i]
    flag_zero = df["zero"][i]
    flag_pp = df["pp"][i]
    flag_tensor = df["tp"][i]
    print(flag_zero,flag_pp,flag_tensor,flag_micro_num)
    cmd=f"sed 's/flag_micro_num/{flag_micro_num}/g;s/flag_zero/{flag_zero}/g;s/flag_pp/{flag_pp}/g;s/flag_tensor/{flag_tensor}/g' 13B_sft_demo.py > 13B_sft_{i}.py"
    subprocess.call([cmd], shell=True)
