function Taylor(x,pontossag)
    x=(x-2*pi*(floor(x/(2*pi))));
    n=1;
    sin=0;
    db_sin=0;
    act=x;
    while abs(act)>=pontossag
            sin=sin+act;
            act=-act*((x^2)/(2*n*(2*n+1)));
            n=n+1;
            db_sin=db_sin+1;
    end

    cos=0;
    db_cos=0;
    n=1;
    act=1;

    while abs(act)>=pontossag
                cos=cos+act;
                act=-act*((x^2)/(2*n*(2*n-1)));
                n=n+1;
                db_cos=db_cos+1;
    end

    disp("sin = ")
    disp(sin)
    disp("Lepesek: ")
    disp(db_sin)

    disp("cos = ")
    disp(cos)
    disp("Lepesek: ")
    disp(db_cos)

end