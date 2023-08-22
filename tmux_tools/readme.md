1. append ~/.ssh/config  

2. ssh machine  

2.1 jump -> target machine, test if it works, enter password and verification code manually once, so that no need to input again before the expiration date:  
ssh hy-jump-control  

then, test if it works:   
./jump node1  

2.2 login target machine through plaintext password:  
expect login node1  

3. write node_list file  

4. create a tmux window, run it:  
./jump_control node_list

replace the `jump` in `jump_control` with `login` as appropriate.

