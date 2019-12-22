function [D, X, error] = K_SVD(B, n, k, tol, maxiter)

    [d, N] = size(B);
    D = randn(d, n);
    err = inf;
    err_b = 0;
    subseq = 0;
    iter = 0;
    
    while ((err > tol) | (subseq < 10)) & (iter < maxiter)
        iter = iter + 1
        for i = 1 : n
            D(:, i) = D(:, i) - mean(D(:, i));
            D(:, i) = D(:, i) / norm(D(:, i), 2);
        end
        parfor i = 1 : N
            X(:, i) = OMP(k, B(:, i).', D);
%             if i == N
%                 disp('OMP 100%')
%             end
        end
        for j = 1 : n
            R = zeros(d, N);
            for rr = 1 : N
                R(:, rr) = D(:, setxor(1 : n, j)) * X(setxor(1 : n, j), rr); 
            end
            E = B - R;
            Omega = find(abs(X(j, :)) > 10 ^ -3);
            if isempty(Omega)
                continue            
            else  
                E_hat = E(:, Omega);
                [U, S, V] = svds(E_hat, 1);
                D(:, j) = U;
                X(j, Omega) = S * V';                
            end
        end    
        err = 0;   
        for i = 1 : N
            err = err + norm(B(:, i) - D * X(:, i), 2) ^ 2;
        end
        err = err / (N * d);  
        dif = abs(err - err_b)/err_b;
        err_b = err;
        if dif <= 10^-5 & err <= tol
            subseq = subseq + 1
        else 
            subseq = 0;
        end
               
    end 
    error = [err, dif];
end