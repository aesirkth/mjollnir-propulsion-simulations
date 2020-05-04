function T = tankVolumeConstraint_BisectionAlgorithm(m, U, Vtank, T_low, T_up, tol)
    T_mid = (T_up + T_low) / 2;                 % initial fluid temperature
    u_l = py.CoolProp.CoolProp.PropsSI('U','T',T_mid,'Q',0,'N2O');
    u_g = py.CoolProp.CoolProp.PropsSI('U','T',T_mid,'Q',1,'N2O');
    rho_l = py.CoolProp.CoolProp.PropsSI('D','T',T_mid,'Q',0,'N2O');
    rho_g = py.CoolProp.CoolProp.PropsSI('D','T',T_mid,'Q',1,'N2O');
    x = ((U/m) - u_l) / (u_g - u_l);
    V = m*((1 - x)/rho_l + x/rho_g);
    while abs(V - Vtank) > tol % 1 ml deviation allowed 
        T_mid = (T_up + T_low) / 2;
        u_l = py.CoolProp.CoolProp.PropsSI('U','T',T_mid,'Q',0,'N2O');
        u_g = py.CoolProp.CoolProp.PropsSI('U','T',T_mid,'Q',1,'N2O');
        rho_l = py.CoolProp.CoolProp.PropsSI('D','T',T_mid,'Q',0,'N2O');
        rho_g = py.CoolProp.CoolProp.PropsSI('D','T',T_mid,'Q',1,'N2O');
        x = ((U/m) - u_l) / (u_g - u_l);
        V = m*((1 - x)/rho_l + x/rho_g);
        if V > Vtank        % if fluid volume is larger than tank volume: Temperature is too high
            T_low = T_mid;
        else                % if fluid volume is smaller than tank volume: Temperature is too low
            T_up = T_mid;                      
        end
    end
    T = T_mid;
end