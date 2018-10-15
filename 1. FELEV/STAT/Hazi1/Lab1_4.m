% Oláh Tamás-Lajos
% otim1750
% 523 / 2

function probability = Lab1_4()
    initialization_number = 0;
    event_sum = 0;
    
    % hold on;
    loop_value = 10000;
    
    for i = 1:loop_value
        [HLP] = URealRNG(initialization_number,3,0,1,10);
        
        good = 0;
        fixable = 0;
        bad = 0;
        sim_num = 10;
        
        for j = 1:sim_num
            nd_fixable = (10-fixable)/(30-j+1);
            nd_bad = (4-bad)/(30-j+1);
            
            if HLP(j) < nd_bad
               bad = bad + 1;
            else
                if HLP(j) < nd_fixable
                    fixable = fixable + 1;
                else
                   good = good + 1; 
                end
            end
            
            if good==7 && fixable==2 && bad==1
                event_sum = event_sum + 1;
            end
        end 
    end
    
    probability = event_sum / loop_value;
end