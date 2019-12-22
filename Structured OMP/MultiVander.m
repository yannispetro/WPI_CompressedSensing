function S = MultiVander(e, A, grid)
% MULTIVANDER
% takes some grid, which is a matrix with m columns 
% (as many as the number of monomials) and n lines (as many as the number 
% of points we want) and using also e and A evaluates the monomials 
% using the values specified by the grid

    a = find(e==1);
    b = find(e~=1);

    S = zeros(size(grid, 1), size(e, 2));
    S(:, a) = 1;

    efun = matlabFunction(e(b), 'Vars', {A});
    S(:, b) = efun([grid]);
    
end