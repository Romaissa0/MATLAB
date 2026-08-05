function [x, y] = ab3_am3_solver(fhandle, y0, xspan, h, ode_id)
    N = floor((xspan(2) - xspan(1)) / h);
    x = xspan(1):h:xspan(2);
    y = zeros(1, N+1);
    y(1) = y0;
    f = @(x, y) fhandle(x, y, ode_id);
    
    % RK4 to get first 3 values
    for i = 1:2
        k1 = f(x(i), y(i));
        k2 = f(x(i)+h/2, y(i)+h/2*k1);
        k3 = f(x(i)+h/2, y(i)+h/2*k2);
        k4 = f(x(i)+h, y(i)+h*k3);
        y(i+1) = y(i) + (h/6)*(k1 + 2*k2 + 2*k3 + k4);
    end

    % AB3-AM3 loop
    for n = 3:N
        % Predictor (AB3)
        fp = f(x(n), y(n));
        fm1 = f(x(n-1), y(n-1));
        fm2 = f(x(n-2), y(n-2));
        yp = y(n) + h * (23/12*fp - 4/3*fm1 + 5/12*fm2);

        % Corrector (AM3)
        fpp = f(x(n+1), yp);
        yc = y(n) + h * (5/12*fpp + 8/12*fp - 1/12*fm1);
        y(n+1) = yc;
    end
end

