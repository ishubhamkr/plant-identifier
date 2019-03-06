function [Acc] = Result(Exp,Emp)


tp = 0;
tn = 0;
fp = 0;
fn = 0;

A = unique(Exp);

for k = 1:length(A)
for i = 1:size(Exp,1)
    for j = 1:size(Exp,2)
        if (Exp(i,j) == A(k)) && (Emp(i,j) == A(k))
            tp = tp +1;
        elseif (Exp(i,j) == A(k)) && (Emp(i,j) ~= A(k))
            fp = fp + 1;
        elseif (Exp(i,j) ~= A(k)) && (Emp(i,j) ~= A(k))
            tn = tn + 1;
        else
            fn = fn + 1;
        end
    end
end

tpdata(k) = tp;
tndata(k) = tn;
fpdata(k) = fp;
fndata(k) = fn;

end

tp = [];
tn = [];
fp = [];
fn = [];

tp = sum(tpdata);
tn = sum(tndata);
fp = sum(fpdata);
fn = sum(fndata);

Sen = tp / (tp + fn);

Spec = tn / (tn + fp);

Acc = (tp + tn) / (tp + tn + fp + fn);

