% Oláh Tamás-Lajos
% otim1750
% 523 / 2

function megold()
    % Eredeti egyenletrendszer
    A=[10,7,8,7;7,5,6,5;8,6,10,9;7,5,9,10];
    B = [32,23,33,31]';
    
    rendszer_inverze = inv(A)
    rendszer_determinansa = det(A)
    
    X = linsolve(A,B)
    
    % Perturbált egyenletrendszer
    Pert_A = [10,7,8.1,7.2; 7.08,5.04,6,5; 8,5.98,9.89,9; 6.99,4.99,9,9.89];
    Pert_B = [32.1,22.9,33.1,30.9]';
    
    Pert_X1 = linsolve(Pert_A,B)
    
    Bemeno_hiba1 = norm(A-Pert_A)/norm(A)
    Kimeno_hiba1 = norm(X-Pert_X1)/norm(X)
    
    Pert_X2 = linsolve(A,Pert_B)
    
    Bemeno_hiba2 = norm(B-Pert_B)/norm(B)
    Kimeno_hiba2 = norm(X-Pert_X2)/norm(X)
    
    kondicioszam = norm(A) * norm(inv(A))
    
