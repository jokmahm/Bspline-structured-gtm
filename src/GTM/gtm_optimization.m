function P = gtm_optimization(par)
global model
nx = model.nx;
I1 = model.I1;  % integral of B-spline basis functions over l_j to l_max
I2 = model.I2;  % integral of B-spline basis functions over l_i^- to l_i^+

NonZeroIndices = model.NonZeroIndices;
n_knote = model.nknote;
par_dim = n_knote+1;

coeff = zeros(1,par_dim);
coeff(NonZeroIndices) = par;

P = zeros(nx,nx);

S = coeff*I1;

for j = 1:nx 
    for i = j:nx 
        if S(j)~=0
            P(i,j) = coeff*I2(:,i)/S(j);
        end
    end
end
for j = 1:nx   
    if sum(P(:,j))~=0
        P(:,j) = P(:,j)/sum(P(:,j)); 
    end
end