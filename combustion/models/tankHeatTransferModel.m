function [temperatureGradient_l, temperatureGradient_g, m_l, m_g, Q_w_conv_in_l, Q_w_conv_in_g, T_wl, T_wg] = tankHeatTransferModel(opts ,T_wl, T_wg, m, Vtank, r_i, r_o, ox, air, massFlow)
%% Masses and equivalent filling levels

m_l = (m - ox.rho_g * Vtank) / (1 - ox.rho_g/ox.rho_l);
m_g = m - m_l;
if abs(m_g) < 1e-6
    m_g = 0;
end

V_l = m_l/ox.rho_l;
V_g = m_g/ox.rho_g;
V_halfsphere = 2/3 *pi * r_i^3;

if (V_l > V_halfsphere) && (V_g < V_halfsphere)     % if liquid fills lower sphere but gas doesnt fill upper sphere
    if V_g > 0
        p = [-pi/3, pi*r_i, 0, -m_g/ox.rho_g];                    % define polynomial for calculation of gas filling height of half-sphere (shell)
        L_g = roots(p);                                           % get solutions for polynomial
        L_g = L_g(L_g<r_i & L_g > 0);                             % get solution which fulfills constraints for filling height 
    else
        L_g = 0;
    end
    L_l = r_i + (V_l - V_halfsphere - (V_halfsphere - V_g)) / (pi*r_i^2) + (r_i - L_g);  % equivalent level of filling height of liquid volume, assuming it to be a cylinder of length L (cylindrical part) + r_i: V/(pi*r^2) = (m/rho)/(pi*r^2)
elseif (V_l > V_halfsphere) && (V_g > V_halfsphere) % if liquid volume fills lower half-sphere and gas fills upper sphere
    L_g = r_i + (V_g - V_halfsphere) / (pi*r_i^2);
    L_l = r_i + (V_l - V_halfsphere) / (pi*r_i^2);
elseif (V_l < V_halfsphere)                         % if liquid doesnt fill lower sphere
    p = [-pi/3, pi*r_i, 0, -m_l/ox.rho_l];                          % define polynomial for calculation of liquid filling height of half-sphere (shell)
    L_l = roots(p);                                                 % get solutions for polynomial
    L_l = L_l(L_l<r_i & L_l > 0);                                   % get solution which fulfills constraints for filling height 
    L_g = r_i + (V_g - V_halfsphere - (V_halfsphere - V_l)) / (pi*r_i^2) + (r_i - L_l);
end
    
%% Convective heat transfer

% Liquid Node

% From wall to LN2O
Q_w_conv_out_l = tankConvectiveHeatTransfer(r_i, ox.cp_l, ox.rho_l, ox.T_l, T_wl, L_l, ox.mu_l, ox.k_l, 0.021, 0.4);
% From air to wall
Q_w_conv_in_l = tankConvectiveHeatTransfer(r_o, air.cp, air.rho, opts.AmbientTemperature, T_wl, L_l, air.mu, air.k, 0.59, 0.25);

% Gas node

Q_w_conv_out_g = tankConvectiveHeatTransfer(r_i, ox.cp_g, ox.rho_g, ox.T_g, T_wg, L_g, ox.mu_g, ox.k_g, 0.021, 0.4);
% From air to wall
Q_w_conv_in_g = tankConvectiveHeatTransfer(r_o, air.cp, air.rho, opts.AmbientTemperature, T_wg, L_g, air.mu, air.k, 0.59, 0.25);

%% Conductive heat transfer (from liquid wall part to gaseous wall part)

% Check whether the filling heights some up to the tank height
tol = 1E-2;
if abs((L_l + L_g) - (opts.tankLength + 2*r_i))  > tol
    disp(['error: filling heights of N2O phases dont sum up to tank height - difference: ' num2str((L_l + L_g) - (opts.tankLength + 2*r_i))])
end
% Calculate the distance between the center of the phases
L_w_cond = (L_l + L_g) / 2;
% Calculate the conductive heat transfer from the liquid to the gaseous
% phase
Q_w_cond_l2g = tankConductiveHeatTransfer(opts.tankThermalConductivity, T_wg, T_wl, r_o, r_i, L_w_cond);

%% Virtual heat transfer (from liquid to gas) due to the change of the filling level 
Q_fillinglvl = tankFillingLvlHeatTransfer(opts, r_o, r_i, ox.rho_l, massFlow, T_wl, T_wg);

% global tankTemperature
if (T_wg > opts.AmbientTemperature) %&& (T_wg > opts.AmbientTemperature) || ((T_wl < ox.T_l) && (T_wl < opts.AmbientTemperature))
    a =1;
end
%% Calculate RHS of the heat transfer equation (temperature gradient)

% Liquid Node

% tank mass of the node
m_w = pi * (r_o^2 - r_i^2) * L_l * opts.tankDensity;
% RHS
if m_w > 0
    temperatureGradient_l = (Q_w_conv_in_l + Q_w_conv_out_l - Q_w_cond_l2g - Q_fillinglvl) / (m_w * opts.tankSpecificHeat);
else
    temperatureGradient_l = 0;
end

% Gas Node

% tank mass of the node
m_w = pi * (r_o^2 - r_i^2) * L_g * opts.tankDensity;
% RHS
if m_w > 0
    temperatureGradient_g = (Q_w_conv_in_g + Q_w_conv_out_g + Q_w_cond_l2g + Q_fillinglvl) / (m_w * opts.tankSpecificHeat);
else
    temperatureGradient_g = 0;
end

end

function Q_conv = tankConvectiveHeatTransfer(r, cp, rho, T_fl, T_w, L, mu, k, c, n)
%{
    Args:
        cp ():      specific heat capacity of the fluid [J/(kgK)]
        rho ():     density of fluid [kg/m3]
        T_fl ():    fluid temperature [K]
        T_w ():     wall temperature [K]
        L ():       characterstic length for convection (filling hight of phase) [m]
        mu ():      dynamic viscosity [kg/(ms)]
        k ():       thermal conducitivity of fluid [W/(mK)]
        c ():       convective factor
        n ():       convective exponent

    Returns:
        Q_conv ():  convective heat flow [W], 
                    positive if fluid temperature greater than wall 
                    temperature
%}
if L > 0
    g = 9.81;   % change to global
    Ra = (cp * rho^2 * g * (1/T_fl) * abs(T_fl-T_w) * L^3) / (mu * k);
    Nu = c * Ra^n;
    h = Nu * (k/L);
    A = 2*pi*r*L;
    Q_conv = h*A*(T_fl-T_w); 
else
    Q_conv = 0;
end
end

function Q_cond = tankConductiveHeatTransfer(k_w,  T_wg, T_wl, r_o, r_i, L_w_cond)
%{
    Args:
        k_w (): thermal conductivity of wall (tank material)
        T_wg (): wall temperature (gas node) [K]
        T_wl (): wall temperature (liquid node) [K]
        r_o (): outer tank radius [m]
        r_i (): inner tank radius [m]
        L_w_cond (): distance between a) center of liquid volume b) center
        of gaseous volume [m]
    Returns:
        Q_cond ():  conductive heat flow in wall [W]
%}

Q_cond = (k_w * (T_wl - T_wg) * pi * (r_o^2 - r_i^2)) / L_w_cond;
end

function Q_fillinglvl = tankFillingLvlHeatTransfer(opts, r_o, r_i, rho_l, massFlow, T_wl, T_wg)
    m_dot_w = pi * (r_o^2 - r_i^2) * 1 / (rho_l * pi * r_i^2) * massFlow * opts.tankDensity;
    Q_fillinglvl = m_dot_w * opts.tankSpecificHeat * (T_wl - T_wg); % positive: from liquid to gas (+/- Q_fillinglvl for gas/liquid)
end