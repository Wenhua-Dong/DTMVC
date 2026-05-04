function [ sum_loss ] = cal_obj(X,C,F,A,G,Q,S,Delta1,Delta2,stnnq,stnns,ag,mu1,mu2,vo)

nv = length(X);
loss = zeros(nv, 1);
for v=1:nv
    D1 = norm(X{v}-C{v}*F{v})^2;
    D2 = ag(v)*norm(F{v}-A{v}*G{v})^2;
    D3 = mu1*norm(Q{v}-F{v}+Delta1{v}/mu1)^2;
    D4 = mu2*norm(S{v}-G{v}+Delta2{v}/mu2)^2;
    loss(v) = loss(v)+(D1+D2+D3+D4)/2;
    if v ~= vo
        D5 = norm(G{v}-G{vo})^2;
        loss(v) = loss(v)+D5/2;
    end
end
sum_loss = sum(loss)+stnnq+stnns;
end
