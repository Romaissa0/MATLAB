% Parameters
xspan = [0 2];
y0 = 1;
h = 0.01;

% ODE 1
[x1, y1] = ab3_am3_solver(@myODEs, y0, xspan, h, 1);
[x_ode, y_ode45_1] = ode45(@(x, y) myODEs(x, y, 1), x1, y0);
[~, y_ode113_1] = ode113(@(x, y) myODEs(x, y, 1), x1, y0);

% Interpolate ode results
y_ode45_interp1 = interp1(x_ode, y_ode45_1, x1);
y_ode113_interp1 = interp1(x1, y_ode113_1, x1);

% Plot ODE 1 solutions
figure;
plot(x1, y1, 'b', x1, y_ode45_interp1, '--r', x1, y_ode113_interp1, '--g');
legend('AB3-AM3', 'ode45', 'ode113');
xlabel('x'); ylabel('y');
title('ODE 1: Numerical Solutions');

% Plot absolute errors
figure;
plot(x1, abs(y1 - y_ode45_interp1), 'r', x1, abs(y1 - y_ode113_interp1), 'g');
legend('Error vs ode45', 'Error vs ode113');
xlabel('x'); ylabel('Absolute Error');
title('ODE 1: Error Analysis');

% Repeat for ODE 2
[x2, y2] = ab3_am3_solver(@myODEs, y0, xspan, h, 2);
[~, y_ode45_2] = ode45(@(x, y) myODEs(x, y, 2), x1, y0);
[~, y_ode113_2] = ode113(@(x, y) myODEs(x, y, 2), x1, y0);
y_ode45_interp2 = interp1(x1, y_ode45_2, x1);
y_ode113_interp2 = interp1(x1, y_ode113_2, x1);

% Plot ODE 2 solutions
figure;
plot(x1, y2, 'b', x1, y_ode45_interp2, '--r', x1, y_ode113_interp2, '--g');
legend('AB3-AM3', 'ode45', 'ode113');
xlabel('x'); ylabel('y');
title('ODE 2: Numerical Solutions');

% Plot errors for ODE 2
figure;
plot(x1, abs(y2 - y_ode45_interp2), 'r', x1, abs(y2 - y_ode113_interp2), 'g');
legend('Error vs ode45', 'Error vs ode113');
xlabel('x'); ylabel('Absolute Error');
title('ODE 2: Error Analysis');


