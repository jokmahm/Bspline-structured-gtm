function [G, p1,p2,m1,m2,m3, Linf,K,CV, fval, exitflag] = GTMfun_Lognormal(A1, A2, C, L_mids, L_edges)
% GTMfun_Lognormal  Truncated Log-Normal increment GTM per Punt et al. (2016)
% par = [p1 p2 m1 m2 m3   Linf K CV]
% Mean increment mu_j = (Linf - l_j) * (1 - exp(-K))
% Lognormal on Δ with CV: s^2 = log(1+CV^2), m = log(mu) - s^2/2
% Column-wise truncation at Δ∈[0, b_tr] and normalization (no shrinking).

    global model
    model.A1 = A1(:);                  % N_{y-1,a-1}
    model.A2 = A2(:);                  % N_{y,a}
    model.C  = C(:);
    model.L_mids  = L_mids(:);
    model.L_edges = L_edges(:);
    model.nx = numel(L_mids);

    % Bounds (tune if needed)
    lb = [0.06, 12, 1e-2, 1e-5, 1e-2,   max(L_mids), 0.01, 0.02];
    ub = [1.2,  16, 0.7,  0.2,  0.7,    2*max(L_mids), 2.0,  1.00];
    par0 = lb + 0.5*(ub-lb);

    options = optimoptions('fmincon','Display','off','Algorithm','interior-point', ...
                           'MaxFunctionEvaluations',5e4);
    [par, fval, exitflag] = fmincon(@CostFun_Lognormal, par0, [],[],[],[], lb, ub, [], options);

    p1=par(1); p2=par(2); m1=par(3); m2=par(4); m3=par(5);
    Linf=par(6); K=par(7); CV=par(8);

    G = gtm_lognormal([Linf, K, CV]);
end