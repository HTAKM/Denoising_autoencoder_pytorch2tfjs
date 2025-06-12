# Exit on error
set -e

# Create and activate conda environment
echo "Creating conda environment..."
conda create -n experiment_env python=3.9 -y
source activate project_env

# Install required packages
echo "Installing required packages..."
pip install jupyter
pip install -r requirements.txt

# Unfinished...
# TODO: Finish this part

# Deactivate conda environment
echo "Deactivating conda environment..."
conda deactivate