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

# STEP 1: Convert JSONL to CSV
python3 jsonl_to_csv.py

# STEP 2: Clean & filter posts
python3 clean_and_filter.py

# STEP 3: Categorize into themes
python3 categorize_posts.py

# STEP 4: Extract text and image links
python3 extract_text_and_images.py

# STEP 5: Analyze text with AI
python3 ai_text_analysis.py

# STEP 6: Analyze images with CLIP or vision model
python3 image_analysis.py

# STEP 7: Generate deliverables (summary reports, structured data, etc.)
python3 generate_outputs.py

echo "✅ Pipeline execution complete."
