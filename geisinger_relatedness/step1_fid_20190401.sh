#!/bin/bash

#### common SBATCH options
SBATCHOPT="
#SBATCH --job-name=fid
#SBATCH --mail-type=NONE  # Alerts sent when job begins, ends, or aborts
#SBATCH --nodes=1   # Number of nodes required
#SBATCH --ntasks=1   # Number of nodes required
#SBATCH --time=01-00:00:00  # Wall Clock time (dd-hh:mm:ss) [max of 14 days]
#SBATCH --partition=general
"

prefix="step1_GHS_Freeze_90K_FID1_for_SUGEN_20190401"
echo "#!/bin/bash" >> tmp.out
echo "$SBATCHOPT" >> tmp.out
echo "#SBATCH --output=${prefix}.slog" >> tmp.out
echo "#SBATCH --error=${prefix}.error" >> tmp.out
echo "R CMD BATCH --no-save --no-restore --slave \"--args 1 ${prefix}.txt\" step1_fid_20190401.R ${prefix}.Rout" >> tmp.out
# cat tmp.out
sbatch tmp.out
rm -rf tmp.out
