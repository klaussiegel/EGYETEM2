% Oláh Tamás-Lajos
% otim1750
% 523 / 2

function [U,c] = GaussElim(A,b)
  n = length(A);
  bovitett_A = zeros(n,n+1);
  
  for i=1:n
    for j=1:(n+1)
      if (j<=n) 
        bovitett_A(i,j) = A(i,j);
      else
				bovitett_A(i,j) = b(i);
			end
    end
  end
	
	for k=1:(n-1)
		[m,io] = max(abs(bovitett_A(k:n,k)));
		io = io + k - 1;
		aux = bovitett_A(io,:);
		bovitett_A(io,:) = bovitett_A(k,:);
		bovitett_A(k,:) = aux;
		
		if (m==0)
			return;
		end	
		
		for i=(k+1):n
			l = bovitett_A(i,k) / bovitett_A(k,k);
			bovitett_A(i,:) = bovitett_A(i,:) - l * bovitett_A(k,:);
		end
		
		U = bovitett_A(1:n,1:n);
		c = bovitett_A(:,n+1);
	end
	
	U = bovitett_A(1:n,1:n);
	c = bovitett_A(:,n+1);
end
