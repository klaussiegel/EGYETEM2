function [probability] =  Feladat5(ItNum, req)
    prob = [1:4 ; [50/200 , 65/200 , 70/200 , 15/200]];
    avg_steps = 0;

    for i=1:ItNum
        seged = req;
        ctrl = 0;
        
        while (1)
            blood_type = InversionBySequentialSearch( prob , 'LEcuyer' , 1 );
            ctrl = ctrl + 1;

            if (blood_type==2 || blood_type==3)
                if (seged==1)
                    break;
                else
                    seged = seged - 1;
                end
            end
        end
        avg_steps = avg_steps + ctrl;
    end

    probability = avg_steps / ItNum;
end