function x = APG( A,y,lambda,tol )
    n = length(A(1,:));
    x = zeros(n,1);
    p = x;
    t = 1;
    L = eigs(A.'*A,1);
    err = 100;
    while err > tol
        w = p - 1/L*A.'*(A*p - y);
        x_new = soft(w,lambda/L);
        t_new = (1 + sqrt(1+4*t^2))/2;
        p = x_new + (t - 1)/t_new*(x_new - x);
        
        err = norm(x-x_new,1);
        t = t_new;
        x = x_new;
    end
    x = x_new;
end

