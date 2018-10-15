% Oláh Tamás-Lajos
% otim1750
% 523 / 2

function [kerek_a , prob1 , prob2] = Lab1_5()
    n = 0;
    pr1 = 0;
    pr2 = 0;
    ini = 0;
    e = 0;
    r = 0;
    loop_v = 10000;
    
    for i = 1:loop_v
        e = e + r;
        r = 0;
        bool_fine = 0;
        %t = 1; % D
        
        while ( bool_fine~=1 )
           r = r + 1;
           n = n + 1;
           
           [X] = URealRNG(ini,3,1,6,1);
           X(1) = round(X(1));
           
           if ( X(1)==3 || X(1)==5 )
                if ( mod(r,2)~=0 )
                   %if ( t<2 ) % D
                        %t = t + 1; % D
                   %else % D
                        pr1 = pr1 + 1;
                        bool_fine = 1;
                   %end % D
                else
                    pr2 = pr2 + 1;
                    r = r + 1;
                    bool_fine = 1;
                end
           end
        end
    end
    
    kerek_a = e / loop_v
    prob1 = pr1 / loop_v
    prob2 = pr2 / loop_v
end