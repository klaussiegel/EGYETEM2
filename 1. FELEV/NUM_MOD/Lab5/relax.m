function [X,out] = relax(A,b,eps,w)
	if (w==0)
		error("w != 0 !")
	end
	
	if (w>2)
		error("Hu de laza...")
	end
	
	% Nem dominans foatloju
	if (~soronkent_dominans(A))
		disp("Az iteracio nem konvergens!")
	end
	
	n = length(A);
	
	D = diag(diag(A)); U = D-triu(A); L = D-tril(A);
	
	P = D./w - L; Q = (1-w)/w * D + U;
	B = P^(-1)*Q;
	f = P^(-1) * b';
	x = zeros(n,1);
	out = 1;
	X = B*x+f;
	
	while (norm(X-x)>=(1-norm(B))*eps/norm(B))
		x = X;
		X = B*x+f;
		out = out + 1;
	end
end
