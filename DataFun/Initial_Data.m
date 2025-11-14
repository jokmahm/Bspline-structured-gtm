function [a1, a2, a3, a4] = Initial_Data(year)

    % Data from 1999 to 2014
    s = load('data_N32.mat');

    a1 = s.data_N32(:,1,year-1971);
    a2 = s.data_N32(:,2,year-1971);
    a3 = s.data_N32(:,3,year-1971);
    a4 = s.data_N32(:,4,year-1971);
    
    % normalize the values
    a1 = a1/max(a1);
    a2 = a2/max(a2);
    a3 = a3/max(a3);
    a4 = a4/max(a4);
end