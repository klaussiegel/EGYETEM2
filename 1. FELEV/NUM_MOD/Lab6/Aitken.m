% Oláh Tamás-Lajos
% otim1750
% 523 / 2

function fx = Aitken(Xi , FXi, x, ep)
	m = length(Xi);
	n = m;
	
	if (m ~= length(FXi))
		error("Invalid input length!")
		return;
	end

	% BUBBLE SORT
	for i=1:n
		for j=i+1:n-i-1
			if (abs(Xi(i)-x)<abs(Xi(j)-x))
				seged = Xi(i);
				Xi(i) = Xi(j);
				Xi(j) = seged;
				
				seged = FXi(i);
				FXi(i) = FXi(j);
				FXi(j) = seged;
			end
		end
	end
	
	Q = zeros(m);
	Q(:,1) = FXi(:);
	
	i = 2;
	j = 2;
	Q(i,i) = ((Xi(i)-x)*Q(i-1,i-1) - (Xi(i-1) - x)*Q(i,i-1))/(Xi(i) - Xi(i-1));
	
	for i=2:n
		for j=2:i
			Q(i,j) = ((Xi(i)-x)*Q(j-1,j-1) - (Xi(j-1)-x)*Q(i,j-1)) / (Xi(i) - Xi(j-1));
		end
		if (abs(Q(i,i)-Q(i-1,i-1)) < ep)
			fx = Q(i,i);
			return;
		end
	end

		error("Not enough data!");

end
