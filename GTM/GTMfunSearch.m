function [G, p1,p2,m1,m2,m3,fvalopt,exitflagopt,x0] = GTMfunSearch(A1,A2,C)
% This function finds matrix G that satisfy N_k+1=G*N_k 
global model
model.A1 = A1;
model.A2 = A2;
model.C = C;
n_knote = model.nknote;
nx = n_knote+1;
% par = [p1,p2,m1,m2,m3,c0, ..., cn]

% Optimization 
lb = [0.06,12,1e-2,1e-5,1e-2,zeros(1,nx)];
ub = [0.99,16,0.7,0.2,0.7,ones(1,nx)];

fvalopt = 1;
x0 = zeros(2,1);

for i=2:25
    par = lb + (ub-lb)/i; %20

    %%%%%% constrained Graidient-based optimization
    options = optimoptions('fmincon', 'Display', 'iter', 'Algorithm', 'interior-point', 'MaxFunctionEvaluations', 50000);
    [Epar, fval, exitflag] = fmincon(@CostFun, par, [], [], [], [], lb, ub, [], options);

    if ((fval<fvalopt)&&(exitflag==1))
        x0(1,1) = i;
        x0(2,1) = 1;
        fvalopt = fval;
        exitflagopt = exitflag;
    end



    par = ub - (ub-lb)/i; %20

    %%%%%% constrained Graidient-based optimization
    options = optimoptions('fmincon', 'Display', 'iter', 'Algorithm', 'interior-point', 'MaxFunctionEvaluations', 50000);
    [Epar, fval, exitflag] = fmincon(@CostFun, par, [], [], [], [], lb, ub, [], options);

    if ((fval<fvalopt)&&(exitflag==1))
        x0(1,1) = i;
        x0(2,1) = -1;
        fvalopt = fval;
        exitflagopt = exitflag;
    end
end

    
G = gtm_optimization(Epar(6:end));  % Estimated growth transition matrix
p1 = Epar(1);
p2 = Epar(2);
m1 = Epar(3);
m2 = Epar(4);
m3 = Epar(5);
