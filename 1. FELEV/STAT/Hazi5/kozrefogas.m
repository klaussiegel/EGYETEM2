%	Oláh Tamás-Lajos
%	otim1750
%	523 / 2

function X = kozrefogas(n)
	if (n<1)
		error("N must be >=1 !")
	end
	
	X = zeros(1,n);
	
	alfa = 1/exp(1/2);
	beta = 1/2;
	gamma = sqrt(2);
	counter = 0;
	cnt = 0;
	
	for i=1:n
		U = ULEcuyerRNG();
		V = ULEcuyerRNG();
		
		Y = tan(pi*V);
		S = beta * Y^2;
		W = (alfa*U)/(beta + S);
		
		if (abs(Y)>gamma)
			L = false;
		else
			L = (W<=1-S);
		end
		
		if (L==false)
			L = (W<=exp(-S));
			cnt = cnt+1;
  	end
		counter = counter+1;
	
		while (L==false)
			U = ULEcuyerRNG();
			V = ULEcuyerRNG();
			
			Y = tan(pi*V);
			S = beta * Y^2;
			W = (alfa*U)/(beta + S);
			
			if (abs(Y)>gamma)
				L = false;
			else
				L = (W<=1-S);
			end
			
			if (L==false)
				L = (W<=exp(-S));
				cnt = cnt + 1;
			end
			counter = counter+1;
		end
		X(i) = Y;
    end
	
    hist(X);
	avg_steps = counter / n;
	disp(avg_steps)
	act_call = cnt/n;
	disp(act_call)
end
