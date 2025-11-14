clear
clc
close all

B= [5.1442 5.7329 7.8063 6.4174 4.7961 4.2474 4.1614 6.7148 3.8951 3.77821 4.2297 2.9643 0.85958 0.12033 0.10072 0.42754 0.8645 5.8307 7.2865 5.1502 0.7963 0.1991 0.19354 0.5024 0.9088 2.0562 2.7751 4.2731 3.6297 2.2103 0.5327 0.6279 0.324 0.7863 1.8787 4.4286 3.75571 3.49801 3.70768 3.585719 3.955411 1.949413 0.84243 0.328223 2.49801 1.57328606 0.4111473];
fileID = fopen('p1.txt','r');
formatSpec = '%f';
p1 = fscanf(fileID,formatSpec);
X = table(B',p1,'VariableNames',{'Cap Bio','p_1'});
figure
corrplot(X)

fileID = fopen('p2.txt','r');
p2 = fscanf(fileID,formatSpec);
X = table(B',p2,'VariableNames',{'Cap Bio','p_2'});
figure
corrplot(X)

fileID = fopen('p3.txt','r');
p3 = fscanf(fileID,formatSpec);
X = table(B',p3,'VariableNames',{'Cap Bio','p_3'});
figure
corrplot(X)

%X = table(B(28:47)',p1(28:47),p2(28:47),p3(28:47),'VariableNames',{'Cap Bio','p_1','p_2','p_3'});
X = table(B',p1,p2,p3,'VariableNames',{'Cap Bio','p_1','p_2','p_3'});
figure
corrplot(X)