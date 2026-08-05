function dydx = myODEs(x, y, ode_id)
    switch ode_id
        case 1
            dydx = y * cos(x * y);
        case 2
            dydx = y * cos(x * y) + 1e-3 * sin(100 * x);
    end
end
