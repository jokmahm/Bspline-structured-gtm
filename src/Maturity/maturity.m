function f = maturity(p1,p2)
    global model
    x_mid = model.x_mid;
    f = 1./(1+exp(4*p1*(p2-x_mid)));
    f = f';
end