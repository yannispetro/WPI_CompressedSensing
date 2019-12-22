clc
clear all
close all

% col = [[0.0,0.0,0.0];[0.3,0.3,0.3];[0.7,0.7,0.7]];
% col = ['b';'r';'g'];


% col = [[1 0.5 0];[0 0.4 1];[0 0.8 0]];
col = [[1 0.5 0];[0 0.4 1];[0 0.8 0];[1 0.5 0];[0 0.4 1];[0 0.8 0]];

min_m = 25;
max_m = 130;

set(0,'defaulttextinterpreter','latex')
set(0,'defaultaxesfontname','courier')
figure;
load('errors100_3_3')
for i = 1:3
    plot((min_m:max_m)./210,errors(min_m:max_m,i),'-s','Color',col(i,:),'MarkerFaceColor',col(i,:)); hold on
end
load('errors_OMP_100_3_3')
for i = 1:3
    plot((min_m:max_m)./210,errors(min_m:max_m,i),'-.o','Color',col(i,:)); hold on
end
title(['Avg Reconstruction Error of three signals over 100 runs'])
xlabel('m/n')
ylabel('Avg Error')
legend('StructOMP 1','StructOMP 2','StructOMP 3','OMP 1','OMP 2','OMP 3')
ylim([0 6])
xlim([min_m/210,max_m/210])

% print ('Errors_StructOMP_3_3.jpeg', '-djpeg', '-r1200')

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

