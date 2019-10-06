#!/bin/bash
#SBATCH --partition short
#SBATCH --nodes 1
#SBATCH --time 4:00:00
#SBATCH --mem-per-cpu 50G
#SBATCH --job-name tunnel
#SBATCH --output jupyter-log-%J.txt

## get tunneling info
XDG_RUNTIME_DIR=""
ipnport=$(shuf -i8000-9999 -n1)
ipnip=$(hostname -i)

## print tunneling instructions to jupyter-log-{jobid}.txt
echo -e "
    Copy/Paste this in your local terminal to ssh tunnel with remote
    -----------------------------------------------------------------
    ssh -i ~/.ssh/id_rsa2 -N -L $ipnport:$ipnip:$ipnport $USER@milgram.hpc.yale.edu
    -----------------------------------------------------------------

    Then open a browser on your local machine to the following address
    ------------------------------------------------------------------
    localhost:$ipnport  (prefix w/ https:// if using password)
    ------------------------------------------------------------------
    "

## start an ipcluster instance and launch jupyter server
#module load Langs/Python/3.5-anaconda
#module load Pypkgs/brainiak/0.5-anaconda
#module load Pypkgs/brainiak/0.7.1-anaconda
#module load Pypkgs/NILEARN/0.4.0-anaconda
#module load Pypkgs/Watchdog/0.8.3-anaconda

#module load MPI/OpenMPI
jupyter notebook --no-browser --port=$ipnport --ip=$ipnip
