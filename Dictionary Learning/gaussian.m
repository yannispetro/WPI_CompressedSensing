function B = gaussian(smin, smax, d, N, T)
    
    B = zeros(d, N);
    x = linspace(-T, T, d);
    sigmas = linspace(smin, smax, N);
    for i = 1:N
        B(:, i) = normpdf(x,0,sigmas(i));
    end

end