% Oláh Tamás-Lajos
% otim1750
% 523 / 2

function X = UTriangSolve(U,c)
	n = length(U);
	X = zeros(1,n);
	
	for i=n:-1:1
		t = 0;
		for j=n:-1:i
			t = t + U(i,j) * X(j);
		end
		
		X(i) = (c(i) - t) * (1 / U(i,i));
	end
end
