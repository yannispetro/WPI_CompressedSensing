function [ x ] = pos( x0 )
    x = x0.*double(x0 > 0);
%     x = zeros(1,length(x0));
%     for i = 1:length(x0)
%         if x0(i) > 0
%             x(i) = x0(i);
%         end
%     end
end

