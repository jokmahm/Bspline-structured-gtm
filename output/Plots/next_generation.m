function next_generation(N1,N2,N3,N4,x)
figure
plot(x,N1(:,1))
hold on
plot(x,N2(:,2))
plot(x,N3(:,3))
plot(x,N4(:,4))
xlabel('length'); ylabel('number');
legend('year 2005','year 2006','year 2007','year 2008')
title('Dynamics of first generation during 4 consecutive years');
