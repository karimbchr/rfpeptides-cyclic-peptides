# Predict structures with RF2 for designed sequences (mock paths)
apptainer exec --nv /path/to/RF2.sif \
  /RoseTTAFold2/run_rf2_beta.sh -o outputs/rf2_predictions inputs/sequences.fasta
