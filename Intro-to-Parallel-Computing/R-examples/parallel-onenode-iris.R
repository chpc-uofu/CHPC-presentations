library(parallel)
library(foreach)
library(doParallel)
ntasks <- Sys.getenv("SLURM_NTASKS")
if (ntasks == '') {
  ntasks <- 2
} else {
  ntasks <- strtoi(ntasks) } 
cl <- makeCluster(ntasks)
registerDoParallel(cl)
x <- iris[which(iris[,5] != "setosa"), c(1,5)]
trials <- 10000
system.time({
  r <- foreach(icount(trials), .combine=rbind) %dopar% {
    ind <- sample(100, 100, replace=TRUE)
   result1 <- glm(x[ind,2]~x[ind,1], family=binomial(logit))
  coefficients(result1)
 }
})
stopCluster(cl)
