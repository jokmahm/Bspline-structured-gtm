function y = LossFun(par)
global model
R = model.R;
N = model.N;
x = model.x_mid;

N_hat = par(4)*exp(-12*mortality(x',par(1),par(2),par(3))).*R;

s = N_hat-N;
y = norm(s);