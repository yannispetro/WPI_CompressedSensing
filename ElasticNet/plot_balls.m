clc
clear all
close all


step = 0.005;
x = -1:step:1-step;
y = -1:step:1-step;

n = length(x);

k = 0;
l = 0;
m = 0;
p = 0;
q = 0;
r = 0;
for i = 1:n
    for j = 1:n/2
        if abs(norm([x(i),y(j)]) - 1) < 1e-3
            disp([k,i,j])
            k = k + 1;
            xm2(k) = x(i);
            ym2(k) = y(j);
        end
        if abs(norm([x(i),y(j)],1) - 1) < 1e-3
            disp([k,i,j])
            m = m + 1;
            xm1(m) = x(i);
            ym1(m) = y(j);
        end
        if abs(0.5*norm([x(i),y(j)],1) + 0.5*norm([x(i),y(j)],2) - 1) < 1e-3
            disp([k,i,j])
            q = q + 1;
            xm3(q) = x(i);
            ym3(q) = y(j);
        end
    end
    for j = n/2:n
        if abs(norm([x(i),y(j)]) - 1) < 1e-3
            l = l + 1;
            xp2(l) = x(i);
            yp2(l) = y(j);
        end
        if abs(norm([x(i),y(j)],1) - 1) < 1e-3
            p = p + 1;
            xp1(p) = x(i);
            yp1(p) = y(j);
        end
        if abs(0.5*norm([x(i),y(j)],1) + 0.5*norm([x(i),y(j)],2) - 1) < 1e-3
            disp([k,i,j])
            r = r + 1;
            xp3(r) = x(i);
            yp3(r) = y(j);
        end
    end
end

% [x_sorted, x_order] = sort(x_b);
% y_sorted = y_b(x_order);


plot(xp1,yp1,'--','color',0.8*[1 1 1],'Linewidth',2); hold on
plot(xm1,ym1,'--','color',0.8*[1 1 1],'Linewidth',2); hold on
plot(xp2,yp2,'color',0.8*[1 1 1],'Linewidth',2); hold on
plot(xm2,ym2,'color',0.8*[1 1 1],'Linewidth',2); hold on
plot(xp3,yp3,'k-','Linewidth',2); hold on
plot(xm3,ym3,'k-','Linewidth',2); hold on
plot([0 0],[-1.2,1.2],'k','Linewidth',2)
plot([-1.2,1.2],[0 0],'k','Linewidth',2)
axis equal