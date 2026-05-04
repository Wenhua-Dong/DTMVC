function [result] = measurement(label,gt)

[A NMI avgent] = compute_nmi(gt,label);
[F,P,R] = compute_f(gt,label);
ARI = RandIndex(gt,label);
label = bestMap(gt,label);
ACC = length(find(gt == label))/length(gt);
result = [ACC,NMI,F,ARI,P,R];
end