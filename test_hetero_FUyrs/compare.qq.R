rm(list=ls())
gc()
source("MyPairPlots.R")
library(grDevices)

combine = read.table("test_hetero1.wald.out", header=TRUE, sep="\t", as.is=TRUE)[,c("VCF_ID","REF","ALT","ALT_AF","BETA","SE","PVALUE")]

tmp = read.table("test_hetero4.wald.out", header=TRUE, sep="\t", as.is=TRUE)[,c("VCF_ID","REF","ALT","ALT_AF","BETA","SE","PVALUE")]
colnames(tmp)[-1] = paste(colnames(tmp)[-1], "hetero4", sep="_")
combine = merge(combine, tmp, by="VCF_ID")

tmp = read.table("test_hetero10.wald.out", header=TRUE, sep="\t", as.is=TRUE)[,c("VCF_ID","REF","ALT","ALT_AF","BETA","SE","PVALUE")]
colnames(tmp)[-1] = paste(colnames(tmp)[-1], "hetero10", sep="_")
combine = merge(combine, tmp, by="VCF_ID")

tmp = read.table("test_hetero20.wald.out", header=TRUE, sep="\t", as.is=TRUE)[,c("VCF_ID","REF","ALT","ALT_AF","BETA","SE","PVALUE")]
colnames(tmp)[-1] = paste(colnames(tmp)[-1], "hetero20", sep="_")
combine = merge(combine, tmp, by="VCF_ID")

print(dim(combine))

exclude = c()
# exclude = union(exclude, which(combine$ALT_AF < 0.01))
exclude = union(exclude, which(is.na(combine$BETA)))
exclude = union(exclude, which(is.na(combine$SE)))
exclude = union(exclude, which(is.na(combine$PVALUE)))
exclude = union(exclude, which(is.na(combine$BETA_hetero4)))
exclude = union(exclude, which(is.na(combine$SE_hetero4)))
exclude = union(exclude, which(is.na(combine$PVALUE_hetero4)))
exclude = union(exclude, which(is.na(combine$BETA_hetero10)))
exclude = union(exclude, which(is.na(combine$SE_hetero10)))
exclude = union(exclude, which(is.na(combine$PVALUE_hetero10)))
exclude = union(exclude, which(is.na(combine$BETA_hetero20)))
exclude = union(exclude, which(is.na(combine$SE_hetero20)))
exclude = union(exclude, which(is.na(combine$PVALUE_hetero20)))
if (length(exclude) > 0)
{
    combine = combine[-exclude,]
}

original.pvalue = -log10(combine$PVALUE)
hetero4.pvalue = -log10(combine$PVALUE_hetero4)
hetero10.pvalue = -log10(combine$PVALUE_hetero10)
hetero20.pvalue = -log10(combine$PVALUE_hetero20)
limits = c(0, max(original.pvalue, hetero4.pvalue, hetero10.pvalue, hetero20.pvalue))
exp.pvalue = -log10((1:nrow(combine))/(1+nrow(combine)))
original.lambda = round(median((combine$BETA/combine$SE)^2)/qchisq(0.5, df=1), 2) 
hetero4.lambda = round(median((combine$BETA_hetero4/combine$SE_hetero4)^2)/qchisq(0.5, df=1), 2)
hetero10.lambda = round(median((combine$BETA_hetero10/combine$SE_hetero10)^2)/qchisq(0.5, df=1), 2)
hetero20.lambda = round(median((combine$BETA_hetero20/combine$SE_hetero20)^2)/qchisq(0.5, df=1), 2)

png(paste("compare.qq.png", sep=""), width=8, height=8, units="in", res=300)
par(mfrow=c(2,2), cex.axis=1.2, cex.lab=1.2, cex=0.8, cex.main=1.4, oma=c(0,0,2,0))

qqplot(exp.pvalue, original.pvalue, main="Homogeneous Trait Variances", xlim=limits, ylim=limits, xlab="Expected -log10 p-value", ylab="Observed -log10 p-value")
abline(0, 1)
text(x=4, y=1, labels=as.expression(bquote(paste(lambda," = ",.(original.lambda)))), cex=1.2)

qqplot(exp.pvalue, hetero4.pvalue, main="4 FUyrs Strata", xlim=limits, ylim=limits, xlab="Expected -log10 p-value", ylab="Observed -log10 p-value")
abline(0, 1)
text(x=4, y=1, labels=as.expression(bquote(paste(lambda," = ",.(hetero4.lambda)))), cex=1.2)

qqplot(exp.pvalue, hetero10.pvalue, main="10 FUyrs Strata", xlim=limits, ylim=limits, xlab="Expected -log10 p-value", ylab="Observed -log10 p-value")
abline(0, 1)
text(x=4, y=1, labels=as.expression(bquote(paste(lambda," = ",.(hetero10.lambda)))), cex=1.2)

qqplot(exp.pvalue, hetero20.pvalue, main="20 FUyrs Strata", xlim=limits, ylim=limits, xlab="Expected -log10 p-value", ylab="Observed -log10 p-value")
abline(0, 1)
text(x=4, y=1, labels=as.expression(bquote(paste(lambda," = ",.(hetero20.lambda)))), cex=1.2)

dev.off()

