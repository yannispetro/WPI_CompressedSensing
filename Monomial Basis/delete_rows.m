function [phi, locations]=delete_rows(n, m)

    for i=1:m
        locations(i)=randi([1 n],1,1);
        g=isempty(find(abs(locations(1:i-1)-locations(i))<1e-12));
        while g==0;
            locations(i)=randi([1 n],1,1);
            g=isempty(find(abs(locations(1:i-1)-locations(i))<1e-12));
        end
    end
    locations=sort(locations);
    phi=zeros(m,n);
    for i=1:m    
        phi(i,locations(i))=1;
    end
    
end