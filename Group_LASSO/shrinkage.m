function z = shrinkage(x, kappa)
    z = pos(1 - kappa/norm(x))*x;
end