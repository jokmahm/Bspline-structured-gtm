function togplot(N1,N2,N3,N4)

figure
subplot(2,2,1),
surf(X',T',N1)
title('N1(l,t)')
xlabel('Length (cm)')
ylabel('Time t')

subplot(2,2,2),
surf(X',T',N2)
title('N2(l,t)')
xlabel('Length (cm)')
ylabel('Time t')

subplot(2,2,3),
surf(X',T',N3)
title('N3(l,t)')
xlabel('Length (cm)')
ylabel('Time t')

subplot(2,2,4),
surf(X',T',N4)
title('N4(l,t)')
xlabel('Length (cm)')
ylabel('Time t')
