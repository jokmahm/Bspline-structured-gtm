function Cost = CostFun(par)
global model
A1 = model.A1;
A2 = model.A2;
C = model.C;

simN = Num(par,A1,C);

%N = A2;
%nu = par(6);
%nll = 0;
%for i = 1:length(simN)
    %if (N(i) ~= 0 && simN(i)~= 0)
        %nll = nll - nu*log(nu*N(i)/simN(i)) + gammaln(nu) + nu*N(i)/simN(i) + log(N(i));
    %end
%end
%Cost = nll;

s = simN-A2;
Cost = norm(s);
