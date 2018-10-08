function soronkent_dominans(A)
    n = size(A);
    
    if n(1)==n(2)
       for i=1:n(1)
           if abs(A(i,i))<sum(abs(A(i,:)))-abs(A(i,i))
               % valasz=false;
               disp("HAMIS")
               return
           end
       end

       % valasz=true;
       disp("IGAZ")
       return
    else
        % valasz=false;
        disp("NEM NEGYZETES")
        return
    end
end