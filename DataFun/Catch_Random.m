function [CT,C2,C3,C4] = Catch_Random(year,N2,N3,N4,w)

% Data from 1972 to 2018
C = 10^6*[1591, 1337, 1148, 1441, 2587, 2986, 1916, 1782, 1648, 1986,...
    1760, 2357, 1477, 868, 123, 0, 0, 0, 0, 933, 1123, 586, 0, 0, 0, ...
    1, 3, 105, 410, 578, 659, 282, 0, 1, 0, 4, 12, 307, 323, 360, 296, ...
    177, 66, 115, 0 0, 195];          % Catch by tonna

mean_length = w'*(N2+N3+N4)/sum(N2+N3+N4);   % 0.03

CT = C(year-1972+1);
C = C/mean_length;                           % Catch by Number
CN = C(year-1972+1);

if CN>(sum(N2)+sum(N3)+sum(N4))
    error('Obs! Catch is larger than stock size !!!');
end

m = length(N2);
counter=1;
q = [.4, .6, 1];
%q = [1, 1, 1];
while true
    
    y2 = N2/max(N2);
    d2 = rnd_catch(y2);
    
    y3 = N3/max(N3);
    d3 = rnd_catch(y3);
    
    y4 = N4/max(N4);
    d4 = rnd_catch(y4);
    
    if CN==0
        p=[0.6,0.3,0.2];
    else
       b = [q(1)*sum(N2), q(2)*sum(N3), q(3)*sum(N4)]/CN;
       p =  b/sum(b);
    end
    
    C2 = p(1)*CN*d2;
    C3 = p(2)*CN*d3;
    C4 = p(3)*CN*d4;
    
    if (sum(N2>=C2)==m && sum(N3>=C3)==m && sum(N4>=C4)==m) 
        break;    
    end
    q = q+.1;
    if counter > 7
        error('Could not distribute the Catch numbers') 
       %keyboard;
    end
    counter = counter+1;
end