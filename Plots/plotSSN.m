function plotSSN(SSN,SSB,nt,year)
d = load('data_SSN');
b = load('data_SSB');

figure
plot(year:year+nt-1,d.data_SSN(year-1971:year-1972+nt,5),'--o')
hold on
plot(year:year+nt-1,SSN,'--*')
curtick = get(gca, 'xTick');          % make the x axis
xticks(unique(round(curtick)));       % having integer numbers
box off
xlabel('year'); ylabel('SSN');
legend('Emperical data','TM simulation','fontsize', 7,'Location','northwest')
title('Stock spawning numbers');

figure
plot(year:year+nt-1,b.data_SSB(year-1971:year-1972+nt,5)/(10^3),'--o')
hold on
plot(year:year+nt-1,SSB/(10^3),'--*')
curtick = get(gca, 'xTick');          % make the x axis
xticks(unique(round(curtick)));       % having integer numbers
box off
xlabel('year'); ylabel('SSB');
legend('Emperical data','operating model','fontsize', 7,'Location','northwest')
title('spawning stock biomass (tonne)');

fprintf('Simulation results of Stock Spawning Biomass (SSB )in tonne:\n')
fprintf('Year           : %12d, %12d, %12d, %12d, %12d\n',[year, year+1, year+2, year+3, year+4])
fprintf('Empirical data : %e, %e, %e, %e, %e\n',b.data_SSB(year-1971:year-1972+nt,5)/(10^3))
fprintf('TM Simulation  : %e, %e, %e, %e, %e\n',SSB/(10^3))