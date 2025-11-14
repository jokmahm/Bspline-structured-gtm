function Cost = CostFun_simulation(par)
global simula
A1 = simula.A1;
A2 = simula.A2;
C = simula.C;
G = simula.G;

simN = Num_simulation(par,A1,C,G);
Cost = norm(simN-A2);