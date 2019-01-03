rm(list=ls())
gc()

FN.pheno = "/proj/epi/CVDGeneNas/justanne/WHI_wtchg/slope_residuals_model4_aa_wt.txt"
FN.out = "slope_residuals_model4_aa_wt_20181231.txt"

dat = read.table(FN.pheno, header=TRUE, as.is=TRUE, sep="\t")
table(dat$flag_q_fu_wt_aa, useNA="ifany")
plot(dat$flag_q_fu_wt_aa, dat$FUyrs_wt)

mykurtosis = function (x) {
    cx = x[which(is.na(x) == F)]
    m4 = mean((cx-mean(cx))^4)
    return(m4/(sd(cx)^4)-3)
}

mykurtosis(dat$clean_slope_aa_wt_model4)
clean_slope_aa_wt_model4.obs = which(!is.na(dat$clean_slope_aa_wt_model4))
clean_slope_aa_wt_model4.rank = rank(dat$clean_slope_aa_wt_model4[clean_slope_aa_wt_model4.obs], ties.method="average")
dat$invn_clean_slope_aa_wt_model4 = rep(NA, nrow(dat))
dat$invn_clean_slope_aa_wt_model4[clean_slope_aa_wt_model4.obs] = qnorm((clean_slope_aa_wt_model4.rank-3/8)/(length(clean_slope_aa_wt_model4.rank)+1/4))
qqnorm(dat$invn_clean_slope_aa_wt_model4, main="invn_clean_slope_aa_wt_model4")
qqline(dat$invn_clean_slope_aa_wt_model4)
mykurtosis(dat$invn_clean_slope_aa_wt_model4)

cut_fuyrs = cut(dat$FUyrs_wt, breaks=quantile(dat$FUyrs_wt, probs=seq(0, 1, 1/10)), include.lowest = TRUE)
dat$flag_q_fu_wt_aa10 = NA
for (i in 1:10) {
    dat$flag_q_fu_wt_aa10[cut_fuyrs == names(table(cut_fuyrs))[i]] = i
}
plot(dat$flag_q_fu_wt_aa10, dat$FUyrs_wt)

cut_fuyrs = cut(dat$FUyrs_wt, breaks=quantile(dat$FUyrs_wt, probs=seq(0, 1, 1/20)), include.lowest = TRUE)
dat$flag_q_fu_wt_aa20 = NA
for (i in 1:20) {
    dat$flag_q_fu_wt_aa20[cut_fuyrs == names(table(cut_fuyrs))[i]] = i
}
plot(dat$flag_q_fu_wt_aa20, dat$FUyrs_wt)

write.table(dat, file=FN.out, sep="\t", quote=FALSE, row.names=FALSE)

