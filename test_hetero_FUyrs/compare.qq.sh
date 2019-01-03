#!/bin/bash

#### common SBATCH options
SBATCHOPT="
#SBATCH --job-name=compare
#SBATCH --mail-type=NONE  # Alerts sent when job begins, ends, or aborts
#SBATCH --nodes=1   # Number of nodes required
#SBATCH --ntasks=1   # Number of nodes required
#SBATCH --time=01-00:00:00  # Wall Clock time (dd-hh:mm:ss) [max of 14 days]
#SBATCH --partition=general
"

echo "#!/bin/bash" >> tmp.out
echo "$SBATCHOPT" >> tmp.out
echo "#SBATCH --output=$compare.qq.slog" >> tmp.out
echo "#SBATCH --error=$compare.qq.error" >> tmp.out
echo "R CMD BATCH --no-save compare.qq.R" >> tmp.out
chmod 700 tmp.out
sbatch tmp.out
rm -rf tmp.out
