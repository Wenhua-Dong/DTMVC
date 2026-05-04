function [mresult] = per_eva(G,k,gt)

nv = length(G);
Yfusion = 0;
for v = 1:nv
    Yfusion = Yfusion+G{v}/nv;
end

[U,~,~]=svd(Yfusion','econ');
F = U(:,1:k);
F = F./repmat(sqrt(sum(F.^2,2))+eps,1,size(F,2));

result = zeros(5,6);
stream = RandStream.getGlobalStream;
reset(stream);
MAXiter = 200; % Maximum number of iterations for KMeans
REPlic = 20; % Number of replications for KMeans
for j = 1 : 5
    label = kmeans(F, k, 'maxiter', MAXiter, 'replicates', REPlic, 'emptyaction', 'singleton');
    result(j, : ) = measurement(label,gt); 
end
mresult = mean(result);
mstd = std(result);
end


