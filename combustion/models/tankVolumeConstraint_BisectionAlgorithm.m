function T = tankVolumeConstraint_BisectionAlgorithm(m, U, Vtank, T_low, T_up, opts, tol)
    T_mid = (T_up + T_low) / 2;                 % initial fluid temperature
    ox = oxidizerPropertiesTemperature('interp',T_mid, {'u_l', 'u_g', 'rho_l', 'rho_g'},opts);
    x = ((U/m) - ox.u_l) / (ox.u_g - ox.u_l);
    V = m*((1 - x)/ox.rho_l + x/ox.rho_g);
    while abs(V - Vtank) > tol % 10 ml deviation allowed 
        T_mid = (T_up + T_low) / 2;
        ox = oxidizerPropertiesTemperature('interp',T_mid, {'u_l', 'u_g', 'rho_l', 'rho_g'},opts);
        x = ((U/m) - ox.u_l) / (ox.u_g - ox.u_l);
        V = m*((1 - x)/ox.rho_l + x/ox.rho_g);
        if V > Vtank        % if fluid volume is larger than tank volume: Temperature is too high
            T_low = T_mid;
        else                % if fluid volume is smaller than tank volume: Temperature is too low
            T_up = T_mid;                      
        end
    end
    T = T_mid;
end