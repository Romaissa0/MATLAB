function dYdt = van_der_pol(t, Y, mu)
   
    y = Y(1);
    v = Y(2);
    
   
    dy_dt = v;
    dv_dt = mu * (1 - y^2) * v - y;
    
    
    dYdt = [dy_dt; dv_dt];
end

