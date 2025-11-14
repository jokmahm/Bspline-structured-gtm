function N = Num(par,N1,C)

    P = gtm_optimization(par(6:end)); 

    Survived = N1.*(1-maturity(par(1),par(2)));
    Mortality = mortality(par(3),par(4),par(5));
    N = P*((exp(-6*Mortality).*Survived-C).*exp(-6*Mortality));
    %N = P*(exp(-Mortality).*Survived-exp(-0.5*Mortality).*C);

    N(N<0) = 0;
end
