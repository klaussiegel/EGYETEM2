% Oláh Tamás-Lajos
% otim1750
% 523 / 2

function [L,U,P] = LUPDecomp(A)
	n = length(A);
	L = zeros(n);
	U = zeros(n);
	P = eye(n);

	for k=1:(n-1)
		[m,io] = max(abs(A(k:n,k)));
		io = io + k - 1;
		aux = A(io,:);
		A(io,:) = A(k,:);
		A(k,:) = aux;
		P([k io],:) = P([io k],:);
		P
		
		if (m==0)
			return;
		end	
		
		for i=(k+1):n
			l = A(i,k) / A(k,k);
			A(i,k:n) = A(i,k:n) - l * A(k,k:n);
			A(i,k) = l;
		end
	end
	U=triu(A);
	L=tril(A,-1)+eye(n);
end
