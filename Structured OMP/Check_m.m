clc
clear all
close all

n = 210;
N_run = 100;

errors = zeros(n,3);
errALL = zeros(n,N_run);
for ex = 1:1
    load(['signals4/signal_' num2str(ex)])
    for m = 5:n
        err = 0;
        n_success = N_run;
        for r = 1:N_run
            Run_StructOMP_to_check_m;
            errALL(m,r) = norm(x0-x_hat,2);
            if succ
                err = err + norm(x0-x_hat,2);
            else
                n_success = n_success - 1;
            end
        end
        errors(m,ex) = err/n_success;
        disp(num2str([ex m n_success errors(m,ex)]))
    end
end

% save('errors100_3_4','errors')
save('errorsALL_StructOMP','errALL')