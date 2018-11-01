% Oláh Tamás-Lajos
% otim1750
% 523 / 2

function L = CholeskyDecomp(A)
	n = length(A);
	L = zeros(n);
	
	if (A~=transpose(A))
		disp("Nem szimmetrikus!")
		return;
	end
	
	for i=1:n
		for j=1:i
			if (i==j)
				sum1 = 0;
				
				for k=1:(i-1)
					sum1 = sum1 + L(i,k)^2;
				end
				
				if (A(i,i) - sum1) < 0
					disp("Nem pozitiv definit")
					return;
				end
				
				L(i,i) = sqrt(A(i,i) - sum1);
			else
				sum2 = 0;
				
				for k=1:(j-1)
					sum2 = sum2 + L(j,k)*L(i,k);
				end
				
				L(i,j) = (1/L(j,j)) * (A(i,j) - sum2);
			end
		end
	end
end
