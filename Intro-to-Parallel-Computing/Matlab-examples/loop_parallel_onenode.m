
tasks=getenv('SLURM_NTASKS');
% if tasks is empty we're running outside of SLURM (e.g. on a desktop)
if (isempty(tasks))
  tasks = feature('numcores');
else
  tasks = str2num(tasks);
end
% start the parallel pool
poolobj=parpool('local',tasks);
n = 400;
A = 1000;
a = zeros(1,n);
% run the heavy calculation
tic
parfor i = 1:n
    a(i) = max(abs(eig(rand(A))));
end
toc
% stop the parallel pool
delete(poolobj)
