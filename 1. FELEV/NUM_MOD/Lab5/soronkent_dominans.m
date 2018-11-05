function b = soronkent_dominans(A)
    n = size(A);

    if n(1)==n(2)
        for i=1:n(1)
            if (abs(A(i,i))<sum(abs(A(i,:)))-abs(A(i,i)))
                % valasz=false;
                b = false;
                return
            end
        end

        % valasz=true;
        b = true;
        return
    else
        % valasz=false;
        b = false;
        return
    end
end