clc
clear all
close all

% col = [[0.0,0.0,0.0];[0.3,0.3,0.3];[0.7,0.7,0.7]];
% col = ['b';'r';'g'];


% col = [[1 0.5 0];[0 0.4 1];[0 0.8 0]];
col = [[1 0.5 0];[0 0.4 1];[0 0.8 0];[1 0.5 0];[0 0.4 1];[0 0.8 0]];

min_m = 23;
max_m = 100;

set(0,'defaulttextinterpreter','latex')
set(0,'defaultaxesfontname','courier')
figure;

load('errorsALL_StructOMP')
mns = mean(errALL(min_m:max_m,:),2);
line1 = max(mns - std(errALL(min_m:max_m,:),[],2),0);
line2 = max(mns + std(errALL(min_m:max_m,:),[],2),0);
plot((min_m:max_m)./210,line1,'-','Color',0.7*[1 1 1],'LineWidth',1.5); hold on
p1 = plot((min_m:max_m)./210,mns,'--','Color','k','LineWidth',3,'DisplayName','OMP'); hold on
plot((min_m:max_m)./210,line2,'-','Color',0.7*[1 1 1],'LineWidth',1.5); hold on

load('errorsALL_OMP')
mns = mean(errALL(min_m:max_m,:),2);
line1 = max(mns - std(errALL(min_m:max_m,:),[],2),0);
line2 = max(mns + std(errALL(min_m:max_m,:),[],2),0);

plot((min_m:max_m)./210,line1,'-','Color',0.7*[1 1 1],'LineWidth',1.5); hold on
p2 = plot((min_m:max_m)./210,mns,'-','Color','k','LineWidth',3); hold on
plot((min_m:max_m)./210,line2,'-','Color',0.7*[1 1 1],'LineWidth',1.5); hold on

legend([p1 p2],'StructOMP','OMP')


% ax = gca;
% set(ax,'YScale','log');

title(['Avg Reconstruction Error of three signals over 100 runs'])
xlabel('m/n')
ylabel('Avg Error')
% legend('StructOMP 1','StructOMP 2','StructOMP 3','OMP 1','OMP 2','OMP 3')
% ylim([0 0.5])
% xlim([25 max_m])

print ('Error_bounds.jpeg', '-djpeg', '-r1200')

% figure();
% for i = 1:6
%     plot(errors(:,i),'o'); hold on
% end
% legend('1','2','3','4','5','6')




% semilogy(m,avg_error_dense,'o',m,avg_error_sparse,'o', m, tol * ones(1, mn), 'Linewidth', 1.01)
% title(['Avg Reconstruction Error for d = ' num2str(d) ' over 1000 runs'])
% xlim([m(1), m(mn)])
% legend('Avg Error for dense', 'Avg Error for sparse', 'Tolerance')
% xlabel('m')
% ylabel('Avg Error')

