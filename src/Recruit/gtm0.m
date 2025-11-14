function [R, m1,m2,m3, ps] = gtm0(n,N)
global model
model.N = N;
P = N/sum(N);
R = n*P;
model.R = R;
lb = [1e-2,1e-3,1e-2,0];
ub = [0.5,0.2,0.7,1];
%%%%%% method PSO
options = optimoptions('particleswarm','SwarmSize',50,'HybridFcn',@fmincon);
[Epar,fval,exitflag,output] = particleswarm(@LossFun,4,lb,ub,options);
m1 = Epar(1);
m2 = Epar(2);
m3 = Epar(3);
ps = Epar(4);