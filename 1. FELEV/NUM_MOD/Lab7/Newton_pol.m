function fx = Newton_pol(x,X,f_X)
	n = length(X);
	
	if (length(f_X)~=n)
		error("Lengths may not differ!")
	end
	
	Q = zeros(n);
	
	Q(:,1) = f_X;
	
	for j=2:n
		for i=1:(n-j+1)
			Q(i,j) = (Q(i+1,j-1) - Q(i,j-1))/(X(i+j-1) - X(i));
		end
    end
    
	
    sum = Q(1,1);
    
	for i=2:n
        seged = Q(1,i);
        for j=1:i-1
            seged = seged * (x-X(j));
        end
        sum = sum + seged;
    end
    
    fx = sum;
end
