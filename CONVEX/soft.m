function x = soft(w,c)
    n = length(w);
    x = zeros(n,1);
    for i = 1:n
        x(i) = sign(w(i))*max(abs(w(i)) - c,0);
    end
end

