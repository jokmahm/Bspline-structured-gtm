function [G, p1,p2,m1,m2,m3, Linf,K,sLinf,sK,rho, fval,exitflag] = GTMfun_Normal(A1,A2,C, L_mids, L_edges)
% GTMfun_NormalA: truncated Normal increment GTM (Chen-style VB step)

    global model
    model.A1 = A1(:);
    model.A2 = A2(:);
    model.C  = C(:);
    model.L_mids  = L_mids(:);
    model.L_edges = L_edges(:);
    model.nx = numel(L_mids);

    % par = [p1 p2 m1 m2 m3   Linf K sLinf sK rho]
    lb = [0.06,12,1e-2,1e-5,1e-2,  max(L_mids), 0.01, 0,    0,   -0.99];
    ub = [1.2, 16, 0.7, 0.2, 0.7,  2*max(L_mids), 2.0,  50,  1.0,  0.99];
    par0 = lb + 0.5*(ub-lb);

    options = optimoptions('fmincon','Display','off','Algorithm','interior-point','MaxFunctionEvaluations',5e4);
    [par, fval, exitflag] = fmincon(@CostFun_Normal, par0, [],[],[],[], lb, ub, [], options);

    p1=par(1); p2=par(2); m1=par(3); m2=par(4); m3=par(5);
    Linf=par(6); K=par(7); sLinf=par(8); sK=par(9); rho=par(10);

    G = gtm_normal([Linf,K,sLinf,sK,rho]);
end
