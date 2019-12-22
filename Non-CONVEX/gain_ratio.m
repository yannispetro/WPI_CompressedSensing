function phi = gain_ratio( B,cB,A,x_hat,y )
    
    r = A*x_hat - y;
    A_sup = A(:,B);
    P_sup = A_sup*pinv(A_sup.'*A_sup)*A_sup.';
    
%     phi = norm(A(:,B).'*r,2)^2/cB;
    phi = norm(P_sup*r,2)^2/cB;

end

