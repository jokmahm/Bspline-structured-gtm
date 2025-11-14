function G = gtm_normal(par_norm)
% par_norm = [Linf, K, sLinf, sK, rho]
    global model
    Linf = par_norm(1); K = par_norm(2); sL = par_norm(3); sK = par_norm(4); rho = par_norm(5);
    covLK = rho*sL*sK;

    Lm  = model.L_mids(:);
    Be  = model.L_edges(:);
    n   = numel(Lm);

    eK = exp(-K); one_meK = 1 - eK;
    G = zeros(n,n);

    for j = 1:n
        lj = Lm(j);
        mu = (Linf - lj) * one_meK;  % mean increment
        varDel = (sL^2)*(one_meK^2) + ((Linf-lj)^2)*(sK^2)*(eK^2) - 2*covLK*(one_meK)*(Linf-lj)*eK;
        sd = sqrt(max(varDel,1e-8));

        a_tr = 0;
        b_tr = Be(end) - lj;
        Z = normcdf((b_tr-mu)/sd) - normcdf((a_tr-mu)/sd);
        if Z<=0, G(j,j)=1; continue; end

        % i<j => zero (no shrinking)
        for i=j:n
            lo = max(Be(i)   - lj, a_tr);
            hi = min(Be(i+1) - lj, b_tr);
            if hi<=lo
                pij = 0;
            else
                pij = (normcdf((hi-mu)/sd)-normcdf((lo-mu)/sd))/Z;
            end
            G(i,j)=pij;
        end
        cs = sum(G(:,j)); if cs>0, G(:,j)=G(:,j)/cs; else, G(j,j)=1; end
    end
end