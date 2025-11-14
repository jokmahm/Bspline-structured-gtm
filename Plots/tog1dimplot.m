function tog1dimplot(N1,N2,N3,N4,x)

figure
plot(x,N1,'-.b')
xlabel('Length (cm)')
ylabel('Numbers')

hold on
plot(x,N2,'--g')

plot(x,N3,':k')

plot(x,N4,'--r')

legend('Age 1','Age 2','Age 3','Age 4')
