clear all
close all
u1_sw_vec = [1;3;5;7];
u2_sw_vec = [2;4;6];
tfinal = 8;
x0 = [1 1 1 1]';
forward = 1;
[t, x] = loop(u1_sw_vec,u2_sw_vec,tfinal,x0);
plot(t,x);
grid on;

%%
close all;
clear all;
x0 = [1 1 1 1]';
tf = 100;
h = 0.1;
u = [51; 100];
u = repmat(u, 1, tf / h);
[t_tmp, x_tmp] = rk4_s(x0,u,tf);
plot(t_tmp, x_tmp);