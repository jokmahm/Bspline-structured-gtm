function test(start,year,x,N3)
s = load('data_N32.mat');

n3 = s.data_N32(:,3,year-1972);
n3 = n3/max(n3);

figure()
%bar(x,s.data_N(:,3,year-1972),'w')
bar(x,n3,'w')
hold on
plot(x,N3(:,year-start),'b')
xlabel('length'); ylabel('Normalized fish abundance');
%title('age 3')
legend('Emperical data','TM simulation','fontsize', 5,'Location','northwest')
ylim([0 1.05])

a = axes;
t1 = title(sprintf('%d',year-1));
a.Visible = 'off'; % set(a,'Visible','off');
t1.Visible = 'on'; % set(t1,'Visible','on');