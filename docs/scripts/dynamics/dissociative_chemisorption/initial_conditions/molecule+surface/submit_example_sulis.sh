#!/bin/bash
#SBATCH --job-name=ini_cond
#SBATCH --time=12:00:00
#SBATCH --nodes=2
#SBATCH --ntasks-per-node=128
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=3850
#SBATCH --account=su007-rjm
#SBATCH --mail-type=END
#SBATCH --mail-user=<wojciech.stark@warwick.ac.uk>

module purge
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/m/msrmnk2/2_software/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/m/msrmnk2/2_software/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/m/msrmnk2/2_software/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/m/msrmnk2/2_software/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

conda activate mace_exp

export OMP_NUM_THREADS=1
export MKL_NUM_THREADS=1
export MKL_DYNAMIC=FALSE
ulimit -s unlimited

# CALCULATION DETAILS
export H2CU_ML_INIT_COND=/home/m/msrmnk2/1_calculations/1_ml/5_sticking_probabilities/0_initial_conditions
export MODEL_FOLDER=31_MACE/5_4_ad/1
export H2CU_ML_MODELS=/home/m/msrmnk2/1_calculations/1_ml/2_training/2_h2cu/31_MACE/5_4_ad/1/checkpoints/MACE_model_run-123.model
export SURF_FILE_PATH=/home/m/msrmnk2/1_calculations/1_ml/5_sticking_probabilities/0_initial_conditions/surface/

echo $MODEL_FOLDER
echo $SURF_FILE_PATH

julia initial_conditions.jl


