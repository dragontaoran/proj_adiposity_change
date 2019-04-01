args = commandArgs(trailingOnly=TRUE)
max.degree = as.integer(args[1])
fn.out = args[2]

fn = "corrected_GHS_Freeze_90K_close_relationships_summary.txt"

fi = read.table(fn, stringsAsFactors=FALSE, header=TRUE)
print(paste("NOTE: #Pairs in ", fn, ": ", nrow(fi), sep=""))
head(fi)
table(fi$degree)

all.id = unique(c(fi$RID1, fi$RID2))
nsub = length(all.id)

fi = fi[which(fi$degree %in% 0:max.degree),]
print(paste("NOTE: # degree pairs:", nrow(fi)))

people = unique(c(fi$RID1, fi$RID2))
npeople = length(people)
npair = nrow(fi)
group = list()
ngroup = 1
grp1 = 0
grp2 = 0
group[[1]] = c(fi$RID1[1], fi$RID2[1])
for (i in 2:npair)
{
    grp1 = 0
    grp2 = 0
    for (j in 1:ngroup)
    {
        if(fi$RID1[i] %in% group[[j]]) grp1 = j
        if(fi$RID2[i] %in% group[[j]]) grp2 = j
    }

    if (grp1 == 0 & grp2 == 0)
    {
        ngroup = ngroup+1
        group[[ngroup]] = c(fi$RID1[i], fi$RID2[i])
    }
    else if (grp1 > 0 & grp2 == 0)
    {
        group[[grp1]] = c(group[[grp1]], fi$RID2[i])
    }
    else if (grp1 == 0 & grp2 > 0)
    {
        group[[grp2]] = c(group[[grp2]], fi$RID1[i])
    }
    else
    {
        if (grp1 != grp2)
        {
            grp.min = min(grp1, grp2)
            grp.max = max(grp1, grp2)
            group[[grp.min]] = c(group[[grp.min]], group[[grp.max]])
            group[[grp.max]] = NULL
            ngroup = ngroup-1
        }
    }
    if (i%%100 == 0)
    {
        print(paste("NOTE: processed", i, "pairs"))
    }
}
group.num = sapply(group, length)
sum(group.num)
print("NOTE: Distribution of famliy size:")
print(table(group.num))
print(paste("NOTE: Number of families:", ngroup))

fid = rep(NA, nsub)
for (i in 1:ngroup)
{
    fid[match(group[[i]], all.id)] = i
}
j = ngroup+1
for (i in 1:nsub)
{
    if (is.na(fid[i]))
    {
        fid[i] = j
        j = j+1
    }
}
print("NOTE: Distribution of famliy size:")
print(table(table(fid)))

res = data.frame(IID=all.id, FID=fid)
write.table(res, file=fn.out, sep="\t", quote=F, row.names=F)
