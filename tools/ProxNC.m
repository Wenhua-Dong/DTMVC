function mat=ProxNC(B,lambda)
    [U,S,V] = svd(B,'econ');
    sigv=diag(S);
    n=length(sigv(sigv>lambda));
    mat=U(:,1:n)*S(1:n,1:n)*V(:,1:n)';
end