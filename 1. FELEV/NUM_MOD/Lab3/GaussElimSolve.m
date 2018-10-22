% Oláh Tamás-Lajos
% otim1750
% 523 / 2

function X = GaussElimSolve(A,b)
	r = rank(A);
	n = length(b);
	
	[U,c] = GaussElim(A,b)
	
	if (r==n)
		printf("\nCompatible, defined\n")
		X = UTriangSolve(U,c);
	else
		for i=(r+1):n
			if (c(i)~=0)
				printf("\nIncompatible!\n")
				return;
			end
		end
		
		printf("\nCompatible, undefined!\n")
	end
end
