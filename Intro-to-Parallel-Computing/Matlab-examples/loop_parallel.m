function a = parloop(a,A,n)
parfor i = 1:n
    a(i) = max(abs(eig(rand(A))));
end
