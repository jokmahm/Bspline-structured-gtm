function N = Num_Gamma(par, N1, C)
% par = [p1 p2 m1 m2 m3 Linf K CV]
    p1=par(1); p2=par(2); m1=par(3); m2=par(4); m3=par(5);
    P  = gtm_gamma(par(6:end));
    Survived = N1 .* (1 - maturity(p1,p2));
    Mortality = mortality(m1,m2,m3);
    % same timing as your main
    N = P * ( (exp(-12*Mortality).*Survived) - (exp(-6*Mortality).*C) );
    N(N<0) = 0;
end