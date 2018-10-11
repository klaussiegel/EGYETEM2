% Oláh Tamás-Lajos
% otim1750
% 523 / 2

function prob = Lab1_3(d)
    initialization_number = 0;
    event_sum = 0;
    
    hold on;
    loop_value = 10000;
    
    for i = 1:loop_value
        [HLP] = URealRNG(initialization_number,3,0,d,2);
        length_angle1 = sqrt(HLP(1)^2 + (HLP(2) - d/2)^2 );
        length_angle2 = sqrt( (HLP(1)-d/2)^2 + HLP(2)^2 );
        
        if length_angle1 > d/2 && length_angle2 > d/2
            event_sum = event_sum + 1;
            plot(HLP(1),HLP(2),'.','color','blue');
        else
            plot(HLP(1),HLP(2),'.','color','green');
        end
    end
    
    prob = event_sum / loop_value;
end