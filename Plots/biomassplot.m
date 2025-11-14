function biomassplot(B1,B2,B3,B4,B,C,t)
figure
plot(t,B1,'b')
xlabel('time')
ylabel('Biomass')
hold on
plot(t,B2,'g')
plot(t,B3,'k')
plot(t,B4,'r')
legend('Age 1','Age 2','Age 3','Age 4')
hold off

figure
subplot(2,2,1),
plot(t,B1,'g')
xlabel('time')
ylabel('Biomass')
title('Biomass Age 1')

subplot(2,2,2),
plot(t,B2,'g')
xlabel('time')
ylabel('Biomass')
title('Biomass Age 2')

subplot(2,2,3),
plot(t,B3,'k')
xlabel('time')
ylabel('Biomass')
title('Biomass Age 3')

subplot(2,2,4),
plot(t,B4,'r')
xlabel('time')
ylabel('Biomass')
title('Biomass Age 4')

figure
plot(t,B,'r')
xlabel('time')
ylabel('Biomass')
title('Total Biomass')

figure
plot(1:length(C)-1,C(1:end-1),'r')
xlabel('time')
ylabel('Catch')
title('Total Catch')

