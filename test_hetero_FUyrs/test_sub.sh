#!/bin/bash

#### common SBATCH options
SBATCHOPT="
#SBATCH --job-name=weight_change
#SBATCH --mail-type=NONE  # Alerts sent when job begins, ends, or aborts
#SBATCH --nodes=1   # Number of nodes required
#SBATCH --ntasks=1   # Number of nodes required
#SBATCH --time=01-00:00:00  # Wall Clock time (dd-hh:mm:ss) [max of 14 days]
#SBATCH --partition=general
"

prefix="test_hetero1"
echo "#!/bin/bash" >> tmp.out
echo "$SBATCHOPT" >> tmp.out
echo "#SBATCH --output=${prefix}.slog" >> tmp.out
echo "#SBATCH --error=${prefix}.error" >> tmp.out
echo "/proj/epi/CVDGeneNas/apps/SUGEN --pheno slope_residuals_model4_aa_wt_20181231.txt --id-col sampleid --family-col sampleid --unweighted --dosage --vcf /proj/epi/Genetic_Data_Center/whi_share/whi_1kgp3/AA/WHI_AA/chr22.dose.vcf.gz --model linear --out-prefix ${prefix} --formula invn_clean_slope_aa_wt_model4=" >> tmp.out
chmod 700 tmp.out
sbatch tmp.out
rm -rf tmp.out

prefix="test_hetero4"
echo "#!/bin/bash" >> tmp.out
echo "$SBATCHOPT" >> tmp.out
echo "#SBATCH --output=${prefix}.slog" >> tmp.out
echo "#SBATCH --error=${prefix}.error" >> tmp.out
echo "/proj/epi/CVDGeneNas/apps/SUGEN --pheno slope_residuals_model4_aa_wt_20181231.txt --id-col sampleid --family-col sampleid --unweighted --dosage --vcf /proj/epi/Genetic_Data_Center/whi_share/whi_1kgp3/AA/WHI_AA/chr22.dose.vcf.gz --model linear --out-prefix ${prefix} --formula invn_clean_slope_aa_wt_model4= --hetero-variance flag_q_fu_wt_aa" >> tmp.out
chmod 700 tmp.out
sbatch tmp.out
rm -rf tmp.out

prefix="test_hetero10"
echo "#!/bin/bash" >> tmp.out
echo "$SBATCHOPT" >> tmp.out
echo "#SBATCH --output=${prefix}.slog" >> tmp.out
echo "#SBATCH --error=${prefix}.error" >> tmp.out
echo "/proj/epi/CVDGeneNas/apps/SUGEN --pheno slope_residuals_model4_aa_wt_20181231.txt --id-col sampleid --family-col sampleid --unweighted --dosage --vcf /proj/epi/Genetic_Data_Center/whi_share/whi_1kgp3/AA/WHI_AA/chr22.dose.vcf.gz --model linear --out-prefix ${prefix} --formula invn_clean_slope_aa_wt_model4= --hetero-variance flag_q_fu_wt_aa10" >> tmp.out
chmod 700 tmp.out
sbatch tmp.out
rm -rf tmp.out

prefix="test_hetero20"
echo "#!/bin/bash" >> tmp.out
echo "$SBATCHOPT" >> tmp.out
echo "#SBATCH --output=${prefix}.slog" >> tmp.out
echo "#SBATCH --error=${prefix}.error" >> tmp.out
echo "/proj/epi/CVDGeneNas/apps/SUGEN --pheno slope_residuals_model4_aa_wt_20181231.txt --id-col sampleid --family-col sampleid --unweighted --dosage --vcf /proj/epi/Genetic_Data_Center/whi_share/whi_1kgp3/AA/WHI_AA/chr22.dose.vcf.gz --model linear --out-prefix ${prefix} --formula invn_clean_slope_aa_wt_model4= --hetero-variance flag_q_fu_wt_aa20" >> tmp.out
chmod 700 tmp.out
sbatch tmp.out
rm -rf tmp.out