function M = Bspline_int2(x,step)
% Itegrate B-spline functions over l_i^- to l_i^+
global model
n_knote = model.nknote;
n = length(x);
M = zeros(n_knote+1,n);

for i = 1:n_knote+1
    for j = 1:n
        B = @ (u) BS_values(u,i);
        M(i,j) = simpson(B,x(j)-step/2,x(j)+step/2);
    end
end