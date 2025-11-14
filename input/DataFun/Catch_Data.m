function [C1,C2,C3,C4] = Catch_Data(year)

    % Data from 1999 to 2014
    d = load('data_catch');

    C1 = d.data_catch(:,year-1998,1);
    C2 = d.data_catch(:,year-1998,2);
    C3 = d.data_catch(:,year-1998,3);
    C4 = d.data_catch(:,year-1998,4);

    % Normalize the values, but only if the maximum value is not zero

    %if max(C1) ~= 0
        %C1 = C1 / max(C1);
    %end
    %if max(C2) ~= 0
        %C2 = C2 / max(C2);
    %end
    %if max(C3) ~= 0
        %C3 = C3 / max(C3);
    %end
    %if max(C4) ~= 0
        %C4 = C4 / max(C4);
    %end
 
end