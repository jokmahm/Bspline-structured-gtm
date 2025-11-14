function [a1,a2,a3,a4,C1,C2,C3,C4] = Initial_Data_new(year)

    % Data from 1999 to 2014
    s = load('data_N32.mat');

    a1 = s.data_N32(:,1,year-1971);
    a2 = s.data_N32(:,2,year-1971);
    a3 = s.data_N32(:,3,year-1971);
    a4 = s.data_N32(:,4,year-1971);
    
    % normalize the values

    max_a1 = max(a1);
    max_a2 = max(a2);
    max_a3 = max(a3);
    max_a4 = max(a4);

    a1 = a1/max(a1);
    a2 = a2/max(a2);
    a3 = a3/max(a3);
    a4 = a4/max(a4);

    % Data from 1999 to 2014
    d = load('data_C32');
    

    C1 = d.data_C32(:,1,year-1971);
    C2 = d.data_C32(:,2,year-1971);
    C3 = d.data_C32(:,3,year-1971);
    C4 = d.data_C32(:,4,year-1971);

    % Normalize the values, but only if the maximum value is not zero

    C1 = C1 / max_a1;
    C2 = C2 / max_a2;
    C3 = C3 / max_a3;
    C4 = C4 / max_a4;

end