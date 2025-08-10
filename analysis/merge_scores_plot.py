import pandas as pd
import matplotlib.pyplot as plt

rmsd_df = pd.read_csv('scores/all_rmsd.csv')      # mock path
plddt_df = pd.read_csv('scores/plddt_scores.csv') # mock path

merged = rmsd_df.merge(plddt_df, left_on='pdb', right_on='PDB_ID')
merged = merged.rename(columns={'pLDDT':'plddt'})

plt.figure(figsize=(6,6))
plt.scatter(merged['plddt'], merged['rmsd'])
plt.xlabel('pLDDT')
plt.ylabel('RMSD to native (Å)')
plt.title('pLDDT vs RMSD (template)')
plt.axvspan(70, 100, alpha=0.15)   # "confidence" zone (mock)
plt.axhspan(0, 2, alpha=0.15)
plt.tight_layout()
plt.savefig('analysis/plddt_vs_rmsd.png', dpi=200)
