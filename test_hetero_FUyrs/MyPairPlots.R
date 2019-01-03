MyPairPlots = function (n, upper.dat=NULL, lower.dat=NULL, diag.labels=NULL,
	cex.labels=NULL, font.labels=NULL, upper.lim=NULL, lower.lim=NULL, oma=NULL, mar=NULL,
    upper.lab=NULL, lower.lab=NULL, 
	line.lab=NULL, cex.lab=NULL) {
	
	if (is.null(upper.lab)) {
		top.lab = rep("", n)
		right.lab = rep("", n)
	} else if (length(upper.lab) == 1) {
		top.lab = c("", rep(upper.lab, n-1))
		right.lab = c(rep(upper.lab, n-1), "")
	} else if (length(upper.lab) == n) {
		top.lab = c("", upper.lab[-1])
		right.lab = c(upper.lab[-n], "")
	}
	
	if (is.null(lower.lab)) {
		bottom.lab = rep("", n)
		left.lab = rep("", n)
	} else if (length(lower.lab) == 1) {
		left.lab = c("", rep(lower.lab, n-1))
		bottom.lab = c(rep(lower.lab, n-1), "")
	} else if (length(lower.lab) == n) {
		left.lab = c("", lower.lab[-1])
		bottom.lab = c(lower.lab[-n], "")
	}
	
	if (!is.null(diag.labels) | (!is.null(upper.dat) & !is.null(lower.dat))) {
		par(mfrow=c(n,n), mar=c(rep(0,2), rep(mar,2)), oma=rep(oma, 4))
		flag_reduce = FALSE
	} else {
		par(mfrow=c(n-1,n-1), mar=c(rep(0,2), rep(mar,2)), oma=rep(oma, 4))
		flag_reduce = TRUE
	}

    for (i in 1:n) {
        for (j in 1:n) {
			
			if (i == j) { # diagonal panel
				if (is.null(diag.labels)) {
					if (!flag_reduce) {
						plot.new()
						print(paste(i, j, "diag_null"))
					}
				} else {
					plot(seq(0,1,10), seq(0,1,10), type="n", xlim=c(0,1), ylim=c(0,1), xlab="", ylab="", xaxt='n', yaxt='n')
					text(x=0.5, y=0.5, diag.labels[i], cex=cex.labels, font=font.labels)
					print(paste(i, j, "diag"))
				}				
			} else if (i > j) { # lower panel
				if (is.null(lower.dat)) {
					if (!flag_reduce) {
						plot.new()
						print(paste(i, j, "lower_null"))
					} else if (i < n) {
						plot.new()
						print(paste(i, j, "lower_null"))						
					}
				} else {
					if (j == 1 & i > 1 & i < n) {
						plot(lower.dat[,j], lower.dat[,i], xlim=lower.lim, ylim=lower.lim, xaxt='n', yaxt='n', xlab='', ylab='')
						abline(0,1)
						axis(2)
						mtext(left.lab[i], side=2, line=line.lab, cex=cex.lab)
						print(paste(i, j, "lower"))
					} else if (j == 1 & i == n) {
						plot(lower.dat[,j], lower.dat[,i], xlim=lower.lim, ylim=lower.lim, xaxt='n', yaxt='n', xlab='', ylab='')
						abline(0,1)
						axis(1)
						axis(2)
						mtext(bottom.lab[j], side=1, line=line.lab, cex=cex.lab)
						mtext(left.lab[i], side=2, line=line.lab, cex=cex.lab)
						print(paste(i, j, "lower"))
					} else if (i > 1 & i < n & j > 1 & j < n) {
						plot(lower.dat[,j], lower.dat[,i], xlim=lower.lim, ylim=lower.lim, xaxt='n', yaxt='n', xlab='', ylab='')
						abline(0,1)
						print(paste(i, j, "lower"))
					} else if (j > 1 & j< n & i == n) {
						plot(lower.dat[,j], lower.dat[,i], xlim=lower.lim, ylim=lower.lim, xaxt='n', yaxt='n', xlab='', ylab='')
						abline(0,1)
						axis(1)
						mtext(bottom.lab[j], side=1, line=line.lab, cex=cex.lab)
						print(paste(i, j, "lower"))
					}					
				}
            } else if (i < j) { # upper panel
				if (is.null(upper.dat)) {
					if (!flag_reduce) {
						plot.new()
						print(paste(i, j, "upper_null"))
					} else if (i > 1) {
						plot.new()
						print(paste(i, j, "upper_null"))
					}
				} else {
					if (i == 1 & j > 1 & j < n) {
						plot(upper.dat[,j], upper.dat[,i], xlim=upper.lim, ylim=upper.lim, xaxt='n', yaxt='n', xlab='', ylab='')
						abline(0,1)
						axis(3)
						mtext(top.lab[j], side=3, line=line.lab, cex=cex.lab)
						print(paste(i, j, "upper"))
					} else if (i == 1 & j == n) {
						plot(upper.dat[,j], upper.dat[,i], xlim=upper.lim, ylim=upper.lim, xaxt='n', yaxt='n', xlab='', ylab='')
						abline(0,1)
						axis(3)
						axis(4)
						mtext(top.lab[j], side=3, line=line.lab, cex=cex.lab)
						mtext(right.lab[i], side=4, line=line.lab, cex=cex.lab)
						print(paste(i, j, "upper"))
					} else if (i > 1 & i < n & j > 1 & j < n) {
						plot(upper.dat[,j], upper.dat[,i], xlim=upper.lim, ylim=upper.lim, xaxt='n', yaxt='n', xlab='', ylab='')
						abline(0,1)
						print(paste(i, j, "upper"))
					} else if (i > 1 & i < n & j == n) {
						plot(upper.dat[,j], upper.dat[,i], xlim=upper.lim, ylim=upper.lim, xaxt='n', yaxt='n', xlab='', ylab='')
						abline(0,1)
						axis(4)
						mtext(right.lab[i], side=4, line=line.lab, cex=cex.lab)
						print(paste(i, j, "upper"))
					}
				}
            } 
        }
    }
}