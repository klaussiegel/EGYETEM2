function z = fuggveny(x,y)
	if (x <= pi/2) && (x >= 0) && (y <= pi/2) && (y >= 0)
		z = sin(x+y)/2;
	else
		z = 0;
	end
end
