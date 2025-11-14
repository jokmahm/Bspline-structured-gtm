function G = gtm_gamma(par_gam)
% gtm_gamma  Build GTM from Gamma increments (Fixed method)
% par_gam = [Linf, K, CV]
% Uses donor midpoint l_i, mean increment mu_i=(Linf-l_i)*(1-exp(-K)),
% Gamma(a_i,b_i) with a_i=1/CV^2 and b_i=a_i/mu_i. No negative growth; normalize columns.

    global model
    Linf = par_gam(1); K = par_gam(2); CV = max(par_gam(3), 1e-6);

    Lm  = model.L_mids(:);     % l_i
    Be  = model.L_edges(:);    % edges b_0..b_n
    n   = numel(Lm);

    a_shape = 1/(CV^2);        % a_i = 1/CV^2 (same for all i)
    eK = exp(-K);
    one_meK = 1 - eK;

    G = zeros(n,n);

    for j = 1:n             % donor class index (column)
        lj = Lm(j);

        % mean increment for donor j from VB one-year step
        mu = (Linf - lj) * one_meK;
        mu = max(mu, 1e-8);                        % avoid zero/negative means
        b_rate = a_shape / mu;                      % b_i = a_i / mu_i

        % Allowed increment range: Δ >= 0; upper cap to last class edge
        a_tr = 0;
        b_tr = Be(end) - lj;

        % Normalizer for truncated gamma over [0, b_tr]
        Z = gamcdf(b_tr, a_shape, 1/b_rate) - gamcdf(a_tr, a_shape, 1/b_rate);
        if Z <= 0
            G(j,j) = 1;  % fallback: stay
            continue
        end

        % Receiving classes i >= j (no shrinking)
        for i = j:n
            lo = max(Be(i)   - lj, a_tr);   % Δ lower bound in this class
            hi = min(Be(i+1) - lj, b_tr);   % Δ upper bound
            if hi <= lo
                pij = 0;
            else
                pij = ( gamcdf(hi, a_shape, 1/b_rate) - gamcdf(lo, a_shape, 1/b_rate) ) / Z;
            end
            G(i,j) = pij;
        end

        % Column normalization (numeric tidy and to catch tail)
        cs = sum(G(:,j));
        if cs > 0
            G(:,j) = G(:,j) / cs;
        else
            G(j,j) = 1;
        end
    end
end