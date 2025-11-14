function [G, p1,p2,m1,m2,m3, Linf,K,CV, fval, exitflag] = GTMfun_Gamma(A1, A2, C, L_mids, L_edges)
% GTMfun_Gamma  Truncated Gamma-increment GTM (Cronin-Fine & Punt "Fixed" method)
% par = [p1 p2 m1 m2 m3   Linf K CV]

    global model
    model.A1 = A1(:);                  % N_{y-1,a-1}
    model.A2 = A2(:);                  % N_{y,a}
    model.C  = C(:);
    model.L_mids  = L_mids(:);         % l_i midpoints
    model.L_edges = L_edges(:);        % class edges
    model.nx = numel(L_mids);

    % Bounds (tune as needed; mirror Normal setup where possible)
    lb = [0.06, 12, 1e-2, 1e-5, 1e-2,   max(L_mids), 0.01, 0.02];
    ub = [1.2,  16, 0.7,  0.2,  0.7,    2*max(L_mids), 2.0,  1.00];
    par0 = lb + 0.5*(ub-lb);

    options = optimoptions('fmincon','Display','off','Algorithm','interior-point', ...
                           'MaxFunctionEvaluations',5e4);
    [par, fval, exitflag] = fmincon(@CostFun_Gamma, par0, [],[],[],[], lb, ub, [], options);

    p1=par(1); p2=par(2); m1=par(3); m2=par(4); m3=par(5);
    Linf=par(6); K=par(7); CV=par(8);

    % Final GTM with estimated parameters
    G = gtm_gamma([Linf, K, CV]);
end