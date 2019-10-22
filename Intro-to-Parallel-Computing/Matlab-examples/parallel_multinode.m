
c.AdditionalProperties.QueueName = 'notchpeak-shared-short';
c.AdditionalProperties.Account = 'notchpeak-shared-short';
c.AdditionalProperties.WallTime = '1:00:00';
c.AdditionalProperties.ClusterName = 'notchpeak';

c = parcluster;
n = 400;
A = 1000;
a = zeros(1,n);
% run the heavy calculation through a job in a cluster
% see https://www.mathworks.com/help/parallel-computing/batch.html for the batch command options
% here we have (1) output argument and three {a,A,n} input arguments, and ask for 4 workers
disp('Submitting job, will wait till it is done');
j = c.batch(@loop_parallel, 1, {a,A,n}, 'Pool', 4);

% wait for the job results and then get the result
wait(j);
disp('Job done, fetching output');
a = j.fetchOutputs{:};

% clear matlab temporary job data
delete(j)
clear j


