function y = BS_values(x,k)
% This function find B-splines values of degree p at vector x

global model
p = model.degree;
n = length(x);
if n == 1
    phi = B_spline(p,x);
    y = phi(k);
else
    y = zeros(n,1);
    for i = 1:n
        phi = B_spline(p,x(i));
        y(i) = phi(k);
    end
end