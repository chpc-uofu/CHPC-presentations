# example with rslurm - launching SLURM job from R
# more info at https://cran.r-project.org/web/packages/rslurm/rslurm.pdf
# in there, "nodes" are effectively independent jobs that are part of a SLURM job array.
# "cpus_per_node" does not seem ot do anything
# other SLURM job options like walltime, account and partition need to go to slurm_options

library(rslurm)

# Create a data frame of mean/sd values for normal distributions
pars <- data.frame(par_m = seq(-10, 10, length.out = 1000),par_sd = seq(0.1, 10, length.out = 1000))

# Create a function to parallelize
ftest <- function(par_m, par_sd) {
samp <- rnorm(10^7, par_m, par_sd)
c(s_m = mean(samp), s_sd = sd(samp))
}

sjob1 <- slurm_apply(ftest, pars, nodes=2, slurm_options = list(account="notchpeak-shared-short", partition="notchpeak-shared-short"))

print_job_status(sjob1)

# this waits till the job is done and the result is returned
# but it submits another job to the default account/partition, which may result in not immediate execution
res <- get_slurm_out(sjob1, "table")

all.equal(pars, res) # Confirm correct output
cleanup_files(sjob1)

