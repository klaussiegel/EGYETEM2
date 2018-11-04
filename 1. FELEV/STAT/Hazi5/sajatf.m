function y = sajatf(x)
    if (x>=-pi && x<=pi)
        y = (cos(x)+2)/(4*pi);
    else
        y = 0;
    end
end

