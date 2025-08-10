#!/bin/bash
# Template: generate SLURM sbatch files to run RF2 on many FASTA inputs (mock paths)

BASE_DIR="/path/to/RoseTTAFold2"
FASTA_DIR="${BASE_DIR}/all_fastas"
OUT_DIR="${BASE_DIR}/outputs"
JOB_DIR="${BASE_DIR}/generated_jobs"
mkdir -p "$OUT_DIR" "$JOB_DIR"

for fasta in "$FASTA_DIR"/*.fasta; do
  base=$(basename "$fasta" .fasta)
  sbatch_file="${JOB_DIR}/rf2_${base}.sbatch"
  cat > "$sbatch_file" <<EOF
#!/bin/bash
#SBATCH --job-name=rf2_${base}
#SBATCH --time=48:00:00
#SBATCH --partition=gpu
#SBATCH --gres=gpu:1
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=8
#SBATCH --mem=64G
#SBATCH --output=rf2_${base}_%j.out
#SBATCH --error=rf2_${base}_%j.err

module purge
apptainer exec --nv \\
  /path/to/RF2.sif \\
  /RoseTTAFold2/run_rf2_beta.sh -o ${OUT_DIR}/${base}_RF2_out ${FASTA_DIR}/${base}.fasta
EOF
  echo "Created: $sbatch_file"
done
