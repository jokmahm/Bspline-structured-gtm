function plot_mid_growth(year,April_age1,April_age2,April_age3,N2,N3,N4)
global la1 lb4
y = la1:0.5:lb4;

for i=2:3
figure
subplot(2,2,1), 
plot(y,April_age1(:,i),'k--')
hold on
plot(y,N2(:,i))
xlabel('length'); ylabel('number');
title('age 1 to 2')
legend('April','October','fontsize', 5)

subplot(2,2,2)
plot(y,April_age2(:,i),'k--')
hold on
plot(y,N3(:,i))
xlabel('length'); ylabel('number');
title('age 2 to 3')
legend('April','October','fontsize', 5,'Location','northwest')

subplot(2,2,3)
plot(y,April_age3(:,i),'k--')
hold on
plot(y,N4(:,i))
xlabel('length'); ylabel('number');
title('age 3 to 4')
legend('April','October','fontsize', 5,'Location','northwest')


a = axes;
t1 = title(sprintf('%d',year+i-1));
a.Visible = 'off'; % set(a,'Visible','off');
t1.Visible = 'on'; % set(t1,'Visible','on');
end