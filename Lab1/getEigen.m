% Proof that I tried to do Eigen and failed
function[eigenValues, eigenVectors]  =  getEigen( S )
    syms L
    x_1 = sym('x_1', [2 1]);
    x_2 = sym('x_2', [2 1]);
    
    eqn = det(S - L*eye(2));
    el = double(solve( eqn == 0 ));
    
    eval_1 = (S - el(1,1)*eye(2));
    eval_2 = (S - el(2,1)*eye(2));
    
    if det(eval_1) == 0
        v1 = [1 0];
    end
    
    if det(eval_2) == 0
        v2 = [1 0];
    end
    
    v1 = (eval_1*x_1);
    v2 = (eval_2*x_2);
    
    xa = 1;
    xb = solve(subs(v1(1,1), x_1(1,1), xa) == 0);
    v1 = [xa xb];
    v1 = double(v1/(norm(v1)));
    
    xc = 1;
    xd = solve(subs(v2(1,1), x_2(1,1), xc) == 0);
    v2 = [xc xd];
    v2 = double(v2/(norm(v2)));
    
    if el(1,1) > el(2,1)
       eigenValues = [el(1,1) 0; 0 el(2,1)];
       eigenVectors = double([v1' v2']);
    else
       eigenValues = [el(2,1) 0; 0 el(1,1)];
       eigenVectors = double([v2' v1']);
    end
end

