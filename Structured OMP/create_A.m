function A = create_A(n,m)
D = randn( n, n );
[phi, locations]=delete_rows(n, m);
A = phi*D;
end

