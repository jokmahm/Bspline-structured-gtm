function Cost = CostFun_Gamma(par)
    global model
    N1 = model.A1;  Nobs = model.A2;  C = model.C;
    Nhat = Num_Gamma(par, N1, C);
    Cost = norm(Nhat - Nobs);
end