function v=valnerability(x)
global Lf
v=1./(1+exp(-x+Lf+2));