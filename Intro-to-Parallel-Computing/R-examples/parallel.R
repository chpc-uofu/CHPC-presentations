library(parallel)
library(foreach)
library(doParallel)
hostlist <- paste(unlist(read.delim(file="hostlist.txt", header=F, sep =" ")))
cl <- makeCluster(hostlist)
registerDoParallel(cl)
clusterEvalQ(cl,.libPaths("/uufs/chpc.utah.edu/sys/installdir/RLibs/3.5.2i"))
x <- iris[which(iris[,5] != "setosa"), c(1,5)]
trials <- 10000
system.time({
  r <- foreach(icount(trials), .combine=rbind) %dopar% {
    ind <- sample(100, 100, replace=TRUE)
   result1 <- glm(x[ind,2]~x[ind,1], family=binomial(logit))
  coefficients(result1)
 }
})
