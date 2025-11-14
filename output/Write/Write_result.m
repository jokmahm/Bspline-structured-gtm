function fileID = Write_result(B,C,VB)

A = [B; C; VB];
fileID = fopen('data.txt','w');
fprintf(fileID,'%15s %15s %15s\n','Biomass','Catch','ValBiomass');
fprintf(fileID,'%15d %15d %15d\n',A);
fclose(fileID);

% VB=VB+0.01*randn(size(VB));
% A = [1965:1988; C(1:end-1); VB(1:end-1); B(1:end-1)];
% fileID = fopen('data.txt','w');
% fprintf(fileID,'%15s %15s %15s %15s\n','time','Catch','ValBiomass','Biomass');
% fprintf(fileID,'%15d %15d %15d %15d\n',A);
% fclose(fileID);