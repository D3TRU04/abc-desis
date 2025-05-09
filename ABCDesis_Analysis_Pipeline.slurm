#!/bin/bash
#--------------------------------------------------
# Desi Reddit Data Analysis Pipeline
#--------------------------------------------------

#SBATCH -J desis_analysis_pipeline        # Job name
#SBATCH -o desis_analysis_pipeline.%j.out # Stdout output file
#SBATCH -e desis_analysis_pipeline.%j.err # Stderr error file
#SBATCH -p normal                         # Queue name
#SBATCH -N 1                              # Number of nodes
#SBATCH -n 1                              # Number of tasks
#SBATCH -t 02:00:00                       # Runtime (hh:mm:ss)
#SBATCH --mail-type=ALL                   # Email notifications
#SBATCH --mail-user=ian.blakley@utexas.edu  # Replace with your email
#SBATCH -A CDA24004                       # Project allocation

# Load necessary modules
module load cuda
module load python3

# Navigate to working directory
cd /scratch/10602/dt27584

# Activate virtual environment (if you have one)
source llama_env/bin/activate

# Convert JSONL to CSV
python3 jsonl_to_csv.py

echo "✅ Pipeline execution complete."
