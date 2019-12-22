function x = l1_2(z,B)

epco=1;
X=B;
y=z;

b_h=X'*(  (X*X')\y);
ep=epco./10.^(0:10);
k=1;
num=1;

% h = waitbar(0,'Please wait...');
while k<=length(ep)
%     fprintf('%d out of %d\n',k,length(ep));
%     k,num
%     waitbar(k / length(ep))
    b_old=b_h;
    wei=(abs(b_h).^2+ep(k)).^(0.75);
    Q=diag(wei);
    b=Q*X'*((X*Q*X')\y);
    b_h=b;
    if or( norm(b-b_old,2)<(ep(k)).^0.5/100, num>30)
        k=k+1;
        num=0;
    end
    num=num+1;
end
% close(h);

x=b;
end