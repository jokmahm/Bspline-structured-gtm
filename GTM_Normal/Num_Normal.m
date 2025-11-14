function N = Num_Normal(par, N1, C)
    p1=par(1); p2=par(2); m1=par(3); m2=par(4); m3=par(5);
    P  = gtm_normal(par(6:end));
    Survived = N1.*(1 - maturity(p1,p2));
    Mortality = mortality(m1,m2,m3);
    N = P * ((exp(-12*Mortality).*Survived - exp(-6*Mortality).*C));  % mirrors your main
    N(N<0)=0;
end