f = @(x, y) exp(-x^2);

y0 = 1; 
h = 0.1; 
x_range = [0, 10];  


[x_exp, y_exp] = explicit_euler(h, x_range, y0);


[x_imp, y_imp] = implicit_euler(h, x_range, y0);


[x_ode45, y_ode45] = ode45(f, x_range, y0);


figure;
hold on;
plot(x_exp, y_exp, 'r-', 'DisplayName', 'Explicit Euler');
plot(x_imp, y_imp, 'b-', 'DisplayName', 'Implicit Euler');
plot(x_ode45, y_ode45, 'k-', 'DisplayName', 'ode45');
legend;
xlabel('x');
ylabel('y');
title('Comparison of Euler Methods and ode45');
hold off;


error_exp = max(abs(y_exp - interp1(x_ode45, y_ode45, x_exp, 'linear')));
error_imp = max(abs(y_imp - interp1(x_ode45, y_ode45, x_imp, 'linear')));
disp(['Max error for Explicit Euler: ', num2str(error_exp)]);
disp(['Max error for Implicit Euler: ', num2str(error_imp)]);


y0_1 = 1.01;
y0_2 = 1.1;
[x_exp_1, y_exp_1] = explicit_euler(h, x_range, y0_1);
[x_exp_2, y_exp_2] = explicit_euler(h, x_range, y0_2);

% Compare at iteration 5
iteration = round(5 / h) + 1;
error_exp_1 = abs(y_exp_1(iteration) - interp1(x_ode45, y_ode45, x_exp_1(iteration), 'linear'));
error_exp_2 = abs(y_exp_2(iteration) - interp1(x_ode45, y_ode45, x_exp_2(iteration), 'linear'));
disp(['Error at iteration 5 for y0 = 1.01: ', num2str(error_exp_1)]);
disp(['Error at iteration 5 for y0 = 1.1: ', num2str(error_exp_2)]);


figure;
hold on;
plot(x_exp, abs(y_exp - interp1(x_ode45, y_ode45, x_exp, 'linear')), 'r-', 'DisplayName', 'Explicit Euler Error');
plot(x_imp, abs(y_imp - interp1(x_ode45, y_ode45, x_imp, 'linear')), 'b-', 'DisplayName', 'Implicit Euler Error');
legend;
xlabel('x');
ylabel('Absolute Error');
title('Absolute Error between Euler Methods and ode45');
hold off;





