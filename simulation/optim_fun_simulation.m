function [p1,p2,m1,m2,m3,fval,exitflag] = optim_fun_simulation(A1,A2,C,G)
% This function finds matrix G that satisfy N_k+1=G*N_k 
global simula
simula.A1 = A1;
simula.A2 = A2;
simula.C = C;
simula.G = G;

%n_knote = model.nknote;
% nx = n_knote+1;
% par = [p1,p2,m1,m2,m3,c0, ..., cn]

% Optimization 
lb = [0.06,12,1e-2,1e-5,1e-2];
ub = [1.2,16,0.7,0.2,0.7];

par = lb + (ub-lb)/2; %20


%%%%%% method PSO
%options = optimoptions('particleswarm','SwarmSize',50,'HybridFcn',@fmincon);
%[Epar,fval,exitflag,output] = particleswarm(@CostFun,nx+5,lb,ub,options); %nx+5



%%%%%% constrained Graidient-based optimization
options = optimoptions('fmincon', 'Display', 'iter', 'Algorithm', 'interior-point', 'MaxFunctionEvaluations', 50000);
[Epar, fval, exitflag, output] = fmincon(@CostFun_simulation, par, [], [], [], [], lb, ub, [], options);

% Add nonlinear constraint
%nonlcon = @(par) constraintFun(par);
%[Epar, fval, exitflag, output] = fmincon(@CostFun, par, [], [], [], [], lb, ub, nonlcon, options);

%%%%%% unconstrained Graidient-based optimization
%options = optimoptions('fminunc', 'Display', 'iter', 'Algorithm', 'quasi-newton', 'MaxFunctionEvaluations', 50000);
%[Epar, fval, exitflag, output] = fminunc(@CostFun, par, options);

p1 = Epar(1);
p2 = Epar(2);
m1 = Epar(3);
m2 = Epar(4);
m3 = Epar(5);