function [x, y] = implicit_euler(h, x_range, y0)
    x = x_range(1):h:x_range(2); % Create x points from x_range with step size h
    y = zeros(size(x));          % Initialize the solution array
    y(1) = y0;                   % Set initial condition
    
    for n = 1:length(x)-1
        % Implicit Euler Method: y(n+1) = y(n) + h * exp(-x(n+1)^2)
        y(n+1) = y(n) + h * exp(-x(n+1)^2); % Implicit method formula
    end
end