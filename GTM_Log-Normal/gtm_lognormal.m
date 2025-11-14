function G = gtm_lognormal(par_ln)
% gtm_lognormal  Build GTM using truncated Log-Normal increments
% par_ln = [Linf, K, CV]
% Uses donor midpoint l_j; Δ ~ LogNormal(m_j, s^2) with mean mu_j and CV.
% Truncate Δ∈[0, b_tr], integrate per receiving class, normalize columns.
% (Punt et al. 2016: midpoint integration Eq. (8); log-normal option Eq. (10c)). 

    global model
    Linf = par_ln(1); K = par_ln(2); CV = max(par_ln(3), 1e-6);

    Lm  = model.L_mids(:);
    Be  = model.L_edges(:);
    n   = numel(Lm);

    eK = exp(-K); one_meK = 1 - eK;
    s2 = log(1 + CV^2);                  % lognormal variance parameter
    s  = sqrt(s2);

    G = zeros(n,n);

    for j = 1:n
        lj = Lm(j);
        mu = (Linf - lj) * one_meK;      % mean increment from VB one-step
        mu = max(mu, 1e-12);
        m  = log(mu) - 0.5*s2;           % lognormal location

        a_tr = 0;                        % no negative growth
        b_tr = Be(end) - lj;             % cap at last class edge

        % truncation normalizer Z
        Z = logncdf(b_tr, m, s) - logncdf(a_tr, m, s);
        if Z <= 0
            G(j,j) = 1;  % fallback
            continue
        end

        % i<j => zero (no shrinking)
        for i = j:n
            lo = max(Be(i)   - lj, a_tr);
            hi = min(Be(i+1) - lj, b_tr);
            if hi <= lo
                pij = 0;
            else
                pij = ( logncdf(hi, m, s) - logncdf(lo, m, s) ) / Z;
            end
            G(i,j) = pij;
        end

        cs = sum(G(:,j));
        if cs > 0
            G(:,j) = G(:,j) / cs;
        else
            G(j,j) = 1;
        end
    end
end