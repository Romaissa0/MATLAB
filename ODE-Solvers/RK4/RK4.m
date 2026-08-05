% RK4 Method to solve Van der Pol equation
clear; clc;

% Parameters
mu = 1;        % Nonlinearity parameter
t0 = 0;        % Initial time
T = 50;        % Final time
h = 0.01;      % Step size
y0 = 2;        % Initial displacement
v0 = 0;        % Initial velocity
Y0 = [y0; v0]; % Initial state vector


t = t0:h:T;
n = length(t);

c = zeros(2,n);
Y = zeros(2, n);
Y(:, 1) = Y0;

for i = 1:n-1
   
    Yi = Y(:, i);
    
    k1 = h * van_der_pol(t(i), Yi, mu);
    k2 = h * van_der_pol(t(i) + h/2, Yi + k1/2, mu);
    k3 = h * van_der_pol(t(i) + h/2, Yi + k2/2, mu);
    k4 = h * van_der_pol(t(i) + h, Yi + k3, mu);
    
    
    Y(:, i+1) = Yi + (1/6) * (k1 + 2*k2 + 2*k3 + k4);
   
    
end
for i = 1:n-1
    c(:,i) = van_der_pol(t(i), Y(:,i), mu);
end
% Extract position (y) and velocity (v)
y = Y(1, :);
v = Y(2, :);

% Plot the position y and velocity v over time
figure;
subplot(2, 2, 1)
plot(t, y, 'b-', 'LineWidth', 2)
xlabel('Time (s)')
ylabel('Position y(t)')
title('Position of Van der Pol Oscillator')
grid on;

subplot(2, 2, 2)
plot(t, v, 'r-', 'LineWidth', 2)
xlabel('Time (s)')
ylabel('Velocity v(t)')
title('Velocity of Van der Pol Oscillator')
grid on;

subplot(3, 2, 3:4);
plot(v, c(2,:), 'b-', 'LineWidth', 3)
xlabel('velocity v(t)')
ylabel('acceleration a(t)')
title('Velocity of Van der Pol Oscillator')
grid on;


figure;
%mashgrid
[A,B] = meshgrid(Y(1,:),Y(2,:));
Z =  mu *(1-A.*A).* B - A; 
%contour plot
contour(A,B,Z,20);

